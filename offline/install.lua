-- SHODAN Stat Editor Offline: finding the game, keeping its original data files and writing the changed ones.
-- Originals: every file the editor changes is kept once (the game's own, checked: it decrypts to a plain text
-- game.dll expects and nobody changed) in %LOCALAPPDATA%\SHODAN\StatEditor\originals.
-- installed.txt lists the files written into the game (name and a hash of the bytes written); a game file
-- matching neither is the game's own (a game update or a Steam check put it there) and is the new original.
-- Writing: every new file goes next to its target first and is read back; installed.txt then lists both the old
-- and the new bytes, the files are moved over the game's, and installed.txt lists the new ones only.
local ffi = require('ffi')
local G = require('gamedata')

for _, declaration in ipairs({
    'int MoveFileExA(const char *from, const char *to, uint32_t flags);',
    'int SetFileAttributesA(const char *path, uint32_t attributes);',
    'uint32_t GetLastError(void);',
    'int CreateDirectoryA(const char *path, void *security);',
    'int DeleteFileA(const char *path);',
    'uint32_t GetEnvironmentVariableA(const char *name, char *out, uint32_t size);',
    'uint32_t GetFileAttributesA(const char *path);',
    'typedef struct { uint32_t size, usage, pid; uintptr_t heap; uint32_t module, threads, parent; int32_t base;'
        .. ' uint32_t flags; uint16_t exe[260]; } host_process_entry;',
    'void *CreateToolhelp32Snapshot(uint32_t flags, uint32_t pid);',
    'int Process32FirstW(void *snapshot, host_process_entry *entry);',
    'int Process32NextW(void *snapshot, host_process_entry *entry);',
    'int CloseHandle(void *handle);',
    'void *OpenProcess(uint32_t access, int inherit, uint32_t pid);',
    'int TerminateProcess(void *process, uint32_t code);',
    'intptr_t ShellExecuteA(void *window, const char *verb, const char *file, const char *params, const char *folder, int show);',
    'typedef struct { uint32_t attributes, times[6], size_high, size_low, reserved[2]; char name[260], short_name[14]; } host_find_data;',
    'void *FindFirstFileA(const char *pattern, host_find_data *data);',
    'int FindNextFileA(void *find, host_find_data *data);',
    'int FindClose(void *find);',
    'int32_t RegGetValueA(void *key, const char *sub, const char *value, uint32_t flags, uint32_t *type, void *data, uint32_t *size);',
}) do pcall(ffi.cdef, declaration) end
local kernel = ffi.C

local M = {}

local function env(name)
    local out = ffi.new('char[1024]')
    local n = kernel.GetEnvironmentVariableA(name, out, 1024)
    return n > 0 and n < 1024 and ffi.string(out, n) or nil
end

local function exists(path) return kernel.GetFileAttributesA(path) ~= 0xFFFFFFFF end
M.exists = exists

local function mkdirs(path)
    local at = ''
    for part in path:gsub('\\', '/'):gmatch('[^/]+') do
        at = at == '' and part or at .. '/' .. part
        if not part:match(':$') then kernel.CreateDirectoryA(at, nil) end
    end
end

M.mkdirs = mkdirs

local function read(path)
    local f = io.open(path, 'rb')
    if not f then return nil end
    local s = f:read('*a'); f:close()
    return s
end
M.read = read

local function write(path, data)
    local f, why = io.open(path, 'wb')
    if not f then return nil, why end
    local ok, why2 = f:write(data)
    f:close()
    if not ok then return nil, why2 end
    if read(path) ~= data then return nil, 'read-back differs: ' .. path end
    return true
end

local function hash_of(data) return G.hex64(G.murmur64(ffi.cast('const uint8_t *', data), #data)) end

-- the names of the files in a folder matching a pattern (sorted)
function M.list_files(folder, pattern)
    local names, data = {}, ffi.new('host_find_data')
    local find = kernel.FindFirstFileA(folder .. '/' .. pattern, data)
    if find == nil or ffi.cast('intptr_t', find) == -1 then return names end
    repeat
        if data.attributes % 32 < 16 then names[#names + 1] = ffi.string(data.name) end   -- not a folder
    until kernel.FindNextFileA(find, data) == 0
    kernel.FindClose(find)
    table.sort(names)
    return names
end

-- ---------------------------------------------------------------- the old folder
-- Before 2026-10-22 everything was kept under the Bingus loader's folder (CowboyBingus\Helldivers2\StatEditor, the
-- offline files in its Offline folder). On the first start with the own folder: the values, presets, the list of
-- installed files and the originals are copied over (the old folder stays, for the in-game editor).
function M.migrate()
    if exists(M.home) then return nil end
    local old = (env('LOCALAPPDATA') or '.') .. '/CowboyBingus/Helldivers2/StatEditor'
    if not exists(old) then return nil end
    mkdirs(M.home)
    local copied = 0
    local function copy(from, to)
        local data = read(from)
        if data and write(to, data) then copied = copied + 1 end
    end
    for _, name in ipairs(M.list_files(old, '*.txt')) do
        if name == 'config.txt' or name:match('^preset_%d+%.txt$') or name == 'weapon_presets.txt' then
            copy(old .. '/' .. name, M.home .. '/' .. name)
        end
    end
    for _, name in ipairs({ 'installed.txt', 'game folder.txt' }) do
        if exists(old .. '/Offline/' .. name) then copy(old .. '/Offline/' .. name, M.home .. '/' .. name) end
    end
    local originals = M.list_files(old .. '/Offline/originals', '*.dl_bin')
    if #originals > 0 then mkdirs(M.originals_dir) end
    for _, name in ipairs(originals) do copy(old .. '/Offline/originals/' .. name, M.originals_dir .. '/' .. name) end
    return copied
end

-- ---------------------------------------------------------------- the game
M.home = (env('LOCALAPPDATA') or '.') .. '/SHODAN/StatEditor'
M.logs = M.home .. '/Logs'
M.originals_dir = M.home .. '/originals'
local LIST = M.home .. '/installed.txt'
local CHOSEN = M.home .. '/game folder.txt'

local function game_at(root)
    local folder = root:gsub('\\', '/'):gsub('/+$', '')
    for _, f in ipairs({ folder, folder .. '/data/game', folder .. '/steamapps/common/Helldivers 2/data/game' }) do
        if exists(f .. '/game.dll') and exists(f .. '/generated_entities.dl_bin') then return f end
    end
    return nil
end

-- data/game of the Steam install: game folder.txt (in the Offline folder or next to the program), else Steam's libraries
function M.find_game(beside)
    for _, path in ipairs({ CHOSEN, beside and (beside .. '/game folder.txt') }) do
        local text = path and read(path)
        local line = text and text:match('^%s*(.-)%s*$')
        if line and line ~= '' then
            local f = game_at(line)
            if f then return f end
        end
    end
    local roots = {}
    local buffer, size = ffi.new('char[1024]'), ffi.new('uint32_t[1]', 1024)
    local HKCU = ffi.cast('void *', ffi.cast('intptr_t', -2147483647))   -- 0x80000001
    if ffi.load('advapi32').RegGetValueA(HKCU, 'Software\\Valve\\Steam', 'SteamPath', 2, nil, buffer, size) == 0 then
        local steam = ffi.string(buffer)
        roots[#roots + 1] = steam
        local vdf = read(steam .. '/steamapps/libraryfolders.vdf') or ''
        for path in vdf:gmatch('"path"%s+"([^"]+)"') do roots[#roots + 1] = path:gsub('\\\\', '\\') end
    end
    roots[#roots + 1] = 'C:/Program Files (x86)/Steam'
    for _, r in ipairs(roots) do
        local f = game_at(r)
        if f then return f end
    end
    return nil
end

function M.remember_game(folder)
    mkdirs(M.home)
    write(CHOSEN, folder .. '\n')
end

local function game_processes()
    local pids = {}
    local snap = kernel.CreateToolhelp32Snapshot(2, 0)   -- TH32CS_SNAPPROCESS
    if snap == nil or ffi.cast('intptr_t', snap) == -1 then return pids end
    local e = ffi.new('host_process_entry')
    e.size = ffi.sizeof(e)
    local ok = kernel.Process32FirstW(snap, e)
    while ok ~= 0 do
        local name = {}
        for k = 0, 259 do
            local c = e.exe[k]
            if c == 0 then break end
            name[#name + 1] = c < 128 and string.char(c) or '?'
        end
        if table.concat(name):lower() == 'helldivers2.exe' then pids[#pids + 1] = e.pid end
        ok = kernel.Process32NextW(snap, e)
    end
    kernel.CloseHandle(snap)
    return pids
end

function M.game_running() return #game_processes() > 0 end

-- From Thodmcniujiao's fork. Asks Steam to start the game; Windows' answer above 32 means it took the request.
function M.launch_game()
    return ffi.load('shell32').ShellExecuteA(nil, 'open', 'steam://rungameid/553850', nil, nil, 1) > 32
end

-- Ends the game at once (it gets no chance to save). True when no process is left to end.
function M.close_game()
    local all = true
    for _, pid in ipairs(game_processes()) do
        local process = kernel.OpenProcess(1, 0, pid)   -- PROCESS_TERMINATE
        if process == nil or kernel.TerminateProcess(process, 1) == 0 then all = false end
        if process ~= nil then kernel.CloseHandle(process) end
    end
    return all
end

-- ---------------------------------------------------------------- installed.txt
local function load_list()
    local list = {}
    for line in (read(LIST) or ''):gmatch('[^\r\n]+') do
        local name, hash = line:match('^(%S+)%s+(%x+)$')
        if name then list[name] = list[name] or {}; list[name][hash] = true end
    end
    return list
end

local function save_list(list)
    mkdirs(M.home)
    local lines = {}
    for name, hashes in pairs(list) do
        for hash in pairs(hashes) do lines[#lines + 1] = name .. ' ' .. hash end
    end
    table.sort(lines)
    return write(LIST, table.concat(lines, '\n') .. (#lines > 0 and '\n' or ''))
end

-- ---------------------------------------------------------------- the originals
-- name -> sealed original for every generated_*.dl_bin, and which of them are ours now (written by an install).
-- A game file that is not ours is the original, and replaces a kept one that differs (the game was updated).
function M.originals(game)
    local list, out, ours, problems = load_list(), {}, {}, {}
    local names = M.list_files(game, 'generated_*.dl_bin')
    local changed = false
    for _, name in ipairs(names) do
        local current = read(game .. '/' .. name)
        local kept = read(M.originals_dir .. '/' .. name)
        if current and list[name] and list[name][hash_of(current)] then
            if kept then out[name], ours[name] = kept, true
            else problems[#problems + 1] = name .. ': written by an earlier install, and its original is gone' end
        elseif current then
            out[name] = current
            if list[name] then list[name], changed = nil, true end
            if kept and kept ~= current then os.remove(M.originals_dir .. '/' .. name) end
        end
    end
    if changed then save_list(list) end
    return out, ours, problems, #names
end

-- ---------------------------------------------------------------- writing
-- writes: name -> bytes (a changed file, or the original for one going back); originals: name -> original bytes.
-- A game file another tool changed after this editor read it (neither its original nor written by an install,
-- issue #90) is never written over: skip_changed (Restore) leaves it be and returns its name, Install stops.
function M.write_files(game, writes, originals, skip_changed)
    if M.game_running() then return nil, 'Helldivers 2 is running: close it first.' end
    local list, changed = load_list(), {}
    for name in pairs(writes) do
        local current = read(game .. '/' .. name)
        if current and current ~= originals[name] and not (list[name] and list[name][hash_of(current)]) then
            changed[#changed + 1] = name
        end
    end
    table.sort(changed)
    if #changed > 0 and not skip_changed then
        return nil, 'another tool changed ' .. table.concat(changed, ', ') .. ' after this editor opened. '
                    .. 'Close and reopen the editor, then Install.'
    end
    for _, name in ipairs(changed) do writes[name] = nil end
    if not next(writes) then return true, changed end
    mkdirs(M.originals_dir)
    for name in pairs(writes) do
        local path = M.originals_dir .. '/' .. name
        if read(path) ~= originals[name] then
            local ok, why = write(path, originals[name])
            if not ok then return nil, 'could not keep the original of ' .. name .. ': ' .. tostring(why) end
        end
    end
    local staged = {}
    for name, data in pairs(writes) do
        local tmp = game .. '/' .. name .. '.shodan-new'
        local ok, why = write(tmp, data)
        if not ok then
            for _, s in ipairs(staged) do os.remove(s.tmp) end
            return nil, 'could not write ' .. name .. ' (' .. tostring(why) .. ')'
        end
        staged[#staged + 1] = { name = name, tmp = tmp, data = data }
        if data ~= originals[name] then
            list[name] = list[name] or {}
            list[name][hash_of(data)] = true
        end
    end
    if not save_list(list) then
        for _, s in ipairs(staged) do os.remove(s.tmp) end
        return nil, 'could not write ' .. LIST
    end
    local failed = {}
    for _, s in ipairs(staged) do
        -- MOVEFILE_REPLACE_EXISTING | MOVEFILE_WRITE_THROUGH
        local target = game .. '/' .. s.name
        kernel.SetFileAttributesA(target, 0x80)   -- FILE_ATTRIBUTE_NORMAL: a read-only game file refuses the move (#114)
        local moved = kernel.MoveFileExA(s.tmp, target, 0x9) ~= 0
        local code = not moved and kernel.GetLastError()
        if not moved or read(target) ~= s.data then
            failed[#failed + 1] = s.name .. (code == 5 and ' (access denied)' or code == 32 and ' (in use by another program)'
                                             or code and ' (Windows error ' .. tostring(code) .. ')' or '')
            os.remove(s.tmp)
        elseif s.data == originals[s.name] then
            list[s.name] = nil
        else
            list[s.name] = { [hash_of(s.data)] = true }
        end
    end
    save_list(list)
    if #failed > 0 then return nil, 'could not replace ' .. table.concat(failed, ', ') end
    return true, changed
end

-- ---------------------------------------------------------------- the vehicle patch
-- The changed vehicle physics (vehicles.lua) go into a patch archive of this editor's own in data\ (one up from
-- data\game): <base>.patch_N at the lowest free N, with the empty .stream and .gpu_resources the game expects.
-- installed.txt lists it as ../<name>. Every Install takes the old one out first, so it moves down into a slot
-- another mod left free. data nil: only taken out. Returns the file name (nil when none).
local PATCH_PARTS = { '', '.stream', '.gpu_resources' }

function M.patch_installed(game)
    for name, hashes in pairs(load_list()) do
        local current = name:match('^%.%./.-%.patch_%d+$') and read(game .. '/' .. name)
        if current and hashes[hash_of(current)] then return name end
    end
    return nil
end

function M.write_patch(game, base, data)
    if M.game_running() then return nil, 'Helldivers 2 is running: close it first.' end
    local list = load_list()
    local old = M.patch_installed(game)
    if old then
        for _, part in ipairs(PATCH_PARTS) do os.remove(game .. '/' .. old .. part) end
        if exists(game .. '/' .. old) then return nil, 'could not remove ' .. old end
    end
    for name in pairs(list) do if name:match('^%.%./.-%.patch_%d+$') then list[name] = nil end end
    if not data then save_list(list); return true, nil end
    local n = 0
    while exists(game .. '/../' .. base .. '.patch_' .. n) do n = n + 1 end
    local name = '../' .. base .. '.patch_' .. n
    list[name] = { [hash_of(data)] = true }
    if not save_list(list) then return nil, 'could not write ' .. LIST end
    local ok, why = write(game .. '/' .. name, data)
    for k = 2, #PATCH_PARTS do ok = ok and write(game .. '/' .. name .. PATCH_PARTS[k], '') end
    if not ok then
        for _, part in ipairs(PATCH_PARTS) do os.remove(game .. '/' .. name .. part) end
        return nil, 'could not write ' .. name:sub(4) .. ' (' .. tostring(why) .. ')'
    end
    return true, name
end

-- the files written by an install (now in the game)
function M.installed(game)
    local list, out = load_list(), {}
    for name, hashes in pairs(list) do
        local current = read(game .. '/' .. name)
        if current and hashes[hash_of(current)] then out[#out + 1] = name end
    end
    table.sort(out)
    return out
end

return M
