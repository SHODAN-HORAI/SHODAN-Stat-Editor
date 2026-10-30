-- SHODAN Stat Editor Offline: Stat Editor's own panel (stat_editor.lua, the in-game mod) in a desktop window,
-- editing the game's data files instead of the running game. The files are decrypted into memory as the game
-- holds them, the panel finds and edits them there, and Install writes the changed ones into the game folder.
-- host.lua [stat_editor.lua]
local here = (debug.getinfo(1, 'S').source:match('^@(.*[/\\])') or './')
package.path = here .. '?.lua;' .. package.path

local ffi = require('ffi')
local shim = require('engine_shim')
local G = require('gamedata')
local D = require('hostdata')
local I = require('install')
local U = require('update')
local V = require('vehicles')

pcall(ffi.cdef, 'uint64_t GetTickCount64(void);')
local function clock() return tonumber(ffi.C.GetTickCount64()) / 1000 end
local log_file = nil
local function log(text)
    if not log_file then
        I.mkdirs(I.logs)
        log_file = io.open(I.logs .. '/SHODANStatEditorHost.log', 'w')
        if not log_file then log_file = false end
    end
    if log_file then log_file:write(os.date('%H:%M:%S '), text, '\n'); log_file:flush() end
end

local BACK = { 255, 12, 15, 19 }
local RED = { 255, 255, 72, 60 }   -- the Enemy Editor's (editor.lua's red)
local GOLD, WHITE, MUTED, WARN, GOOD = { 255, 255, 213, 0 }, { 255, 238, 242, 246 }, { 255, 153, 171, 184 },
                                        { 255, 255, 150, 60 }, { 255, 120, 220, 140 }

local function centred(text, y, size, c)
    shim.text(text, (shim.w - shim.text_width(text, size)) / 2, y, size, c)
end

-- a screen with a few lines of text (loading, problems)
local function screen(lines)
    shim.fill(0, 0, shim.w, shim.h, BACK)
    local s = shim.h / 1080
    local y = shim.h * 0.42
    for k, line in ipairs(lines) do
        local size = (k == 1 and 34 or 20) * s
        centred(line, y, size, k == 1 and GOLD or MUTED)
        y = y + size * 1.8
    end
    shim.present()
end

local function fatal(text)
    log('stopped: ' .. text)
    shim.message_box(text, 0x10)
    os.exit(1)
end

-- ---------------------------------------------------------------- start
-- where the window was when it last closed: its top left, and its height once the user resized it (window.txt: x y [h])
local PLACE = I.home .. '/window.txt'
local function saved_place()
    local f = io.open(PLACE, 'r')
    local text = f and f:read('*a') or ''
    if f then f:close() end
    local x, y, h = text:match('^(%-?%d+) (%-?%d+) ?(%d*)')
    return x and { tonumber(x), tonumber(y), tonumber(h) } or nil
end

local function main()
    shim.open('SHODAN Stat Editor Offline', saved_place())
    shim.pump()
    local migrated = I.migrate()
    if migrated then log('copied ' .. migrated .. ' files from the CowboyBingus folder') end
    screen({ 'SHODAN Stat Editor Offline', 'Looking for Helldivers 2...' })
    local exe_dir = here:gsub('[/\\]app[/\\]$', ''):gsub('[/\\]$', '')
    local game = I.find_game(exe_dir)
    if not game then
        fatal('Helldivers 2 was not found.\n\nWrite the path of its folder (the one holding "data") into\n'
              .. I.home:gsub('/', '\\') .. '\\game folder.txt\nand start again.')
    end
    log('game: ' .. game)
    screen({ 'SHODAN Stat Editor Offline', 'Reading the game\'s data files...' })
    shim.pump()
    local originals, ours, problems, count = I.originals(game)
    if count == 0 then fatal('No game data files in ' .. game) end
    for _, p in ipairs(D.load(game, originals)) do problems[#problems + 1] = p end
    for _, p in ipairs(problems) do log('problem: ' .. p) end
    local loaded = 0
    for _ in pairs(D.files) do loaded = loaded + 1 end
    log(string.format('%d of %d files loaded, %d installed by an earlier install', loaded, count,
        (function() local n = 0; for _ in pairs(ours) do n = n + 1 end return n end)()))
    if loaded == 0 then
        fatal('None of the game\'s data files could be read:\n\n' .. table.concat(problems, '\n', 1, math.min(#problems, 8))
              .. '\n\nVerify the game files in Steam and start again.')
    end
    if #problems > 0 then
        shim.message_box('Some of the game\'s data files are not as this editor expects; their stats cannot be edited:\n\n'
                         .. table.concat(problems, '\n', 1, math.min(#problems, 10))
                         .. '\n\nIf another tool changed them, verify the game files in Steam.', 0x30)
    end

    -- the vehicles' handling (their physics, out of the game's archives): the panel offers it when this works
    local physics_ok, physics_why = pcall(V.load, (game:gsub('[/\\]game$', '')), log)
    if physics_ok and physics_why > 0 then rawset(_G, 'SHODAN_PHYSICS', V.shared)
    elseif not physics_ok then log('vehicle physics: not offered: ' .. tostring(physics_why)) end
    local patch = I.patch_installed(game)   -- this editor's patch archive in the game (its name), or nil

    -- ------------------------------------------------------------ the editor
    screen({ 'SHODAN Stat Editor Offline', 'Finding the stats...' })
    rawset(_G, 'SHODAN_OFFLINE', true)
    -- the panel's first language (until one is chosen in Settings): Windows' display language, if translated
    pcall(ffi.cdef, 'uint16_t GetUserDefaultUILanguage(void);')
    local id = ffi.C.GetUserDefaultUILanguage()
    local primary, sub = id % 1024, math.floor(id / 1024)
    if rawget(_G, 'SHODAN_OFFLINE_LANG') == nil then rawset(_G, 'SHODAN_OFFLINE_LANG', primary == 0x04 and ((sub == 2 or sub == 4) and 'zh-Hans' or 'zh-Hant')
                                      or primary == 0x19 and 'ru' or primary == 0x0A and 'es-419' or primary == 0x16 and 'pt-BR' or nil) end
    stingray = shim.engine()
    function update(dt) end
    local editor = arg and arg[1] or here .. 'stat_editor.lua'
    local chunk, why = loadfile(editor)
    if not chunk then fatal('Could not load ' .. editor .. ':\n' .. tostring(why)) end
    local ok, err = pcall(chunk)
    if not ok then fatal('Stat Editor did not start:\n' .. tostring(err)) end
    local state = rawget(_G, 'ShodanStatEditor')
    if type(state) ~= 'table' then fatal('Stat Editor did not start (no state).') end
    local build = U.build(here)   -- app/build.txt: version, commit, channel
    shim.set_title('SHODAN Stat Editor Offline v' .. tostring(state.version)
                   .. (build.channel == 'dev' and build.commit and ' (dev ' .. build.commit:sub(1, 7) .. ')' or ''))
    -- the host's own text in the panel's language, drawn with its font
    local function tr(text) return type(state.tr) == 'function' and state.tr(text) or text end
    if type(state.lang) == 'function' then shim.lang = state.lang end

    -- ------------------------------------------------------------ the host's bar (below the panel)
    local bar = { hover = nil, message = nil, tone = MUTED, busy = nil, base = nil, buttons = {}, dropped = 0, banner = nil }
    local DROPPED = "Installed, but not everything fits. Some projectiles may show no trail, and some Always bring it stratagems stay out of missions."
    local function layout()
        local s = shim.h / 1080
        local y0, y1 = 1038 * s, 1072 * s
        bar.buttons = {
            { key = 'install', label = 'Install into the game', x0 = 30 * s, x1 = 210 * s, y0 = y0, y1 = y1 },
            { key = 'restore', label = 'Restore the game\'s files', x0 = 218 * s, x1 = 398 * s, y0 = y0, y1 = y1 },
            { key = 'start_game', label = 'Start game', x0 = 406 * s, x1 = 506 * s, y0 = y0, y1 = y1, tint = { 26, 54, 36 } },
            { key = 'close_game', label = 'Close game', x0 = 514 * s, x1 = 614 * s, y0 = y0, y1 = y1, tint = { 58, 30, 32 } },
        }
        if bar.release then
            local x1 = shim.w - 30 * s
            bar.buttons[#bar.buttons + 1] = { key = 'update', label = 'Update to ' .. bar.release.label, x0 = x1 - 170 * s, x1 = x1,
                               y0 = 9 * s, y1 = 41 * s, gold = true }   -- top right, in the tagline's place
        end
        -- the titles (paint_bar): Stat Editor, then Enemy Editor once the editor offers the switch
        local x = 30 * s
        bar.titles = {}
        for _, t in ipairs({ { 'title_stat', 'SHODAN Stat Editor', GOLD }, { 'title_enemy', 'SHODAN Enemy Editor', RED } }) do
            if t[1] == 'title_stat' or type(state.switch_editor) == 'function' then
                local w = shim.text_width(t[2], 22 * s, true) + 24 * s   -- a box: 12 px each side of the text
                bar.titles[#bar.titles + 1] = { key = t[1], label = t[2], color = t[3], x0 = x, x1 = x + w, y0 = 6 * s, y1 = 42 * s }
                x = x + w + 12 * s
            end
        end
        local last = bar.titles[#bar.titles]
        bar.sign = { x0 = last.x1 + 12 * s, x1 = last.x1 + 44 * s, y0 = 9 * s, y1 = 39 * s }   -- the free space after the titles
        bar.s, bar.h = s, shim.h
    end
    layout()

    local function installed_count()
        local n = patch and 1 or 0
        for _, v in pairs(ours) do if v then n = n + 1 end end
        return n
    end

    local function status()
        if bar.busy then return bar.busy, WARN end
        if bar.message then return bar.message, bar.tone end
        if state.phase ~= 'ready' then return 'Finding the stats...', MUTED end
        local n = installed_count()
        local dirty = bar.base and state.writes ~= bar.base
        if dirty and n == 0 then return 'Your values are not in the game yet: close the game, then Install.', WARN end
        if dirty then return 'Changed since the last install: Install to put it in the game.', WARN end
        if n > 0 then return 'Your values are installed (' .. n .. ' game files). Close the game before installing.', GOOD end
        return 'The game\'s own files are in place. Close the game, then Install to play with your values.', MUTED
    end

    local function paint_bar()
        local s = bar.s
        shim.fill(0, 1032 * s, shim.w, shim.h, BACK)
        shim.fill(0, 0, shim.w, 46 * s, BACK)
        -- the two editors' titles, as buttons: the one shown bright in a box of its colour, the other dimmed
        -- (brighter under the mouse); a click swaps
        local enemy = type(state.enemy_on) == 'function' and state.enemy_on()
        local function toward_back(c, k)
            return { 255, math.floor(BACK[2] + (c[2] - BACK[2]) * k), math.floor(BACK[3] + (c[3] - BACK[3]) * k),
                     math.floor(BACK[4] + (c[4] - BACK[4]) * k) }
        end
        for _, t in ipairs(bar.titles) do
            local on = (t.key == 'title_enemy') == (enemy and true or false)
            local hovered = bar.hover == t.key and not on
            local c = on and t.color or toward_back(t.color, hovered and 0.65 or 0.4)
            local fill = on and toward_back(t.color, 0.3) or hovered and { 255, 40, 48, 58 } or { 255, 24, 29, 36 }
            local edge = on and t.color or hovered and toward_back(t.color, 0.8) or { 255, 70, 82, 94 }
            local e = math.max(1, math.floor(2 * s + 0.5))
            shim.fill(t.x0, t.y0, t.x1, t.y1, fill)
            shim.fill(t.x0, t.y0, t.x1, t.y0 + e, edge); shim.fill(t.x0, t.y1 - e, t.x1, t.y1, edge)
            shim.fill(t.x0, t.y0, t.x0 + e, t.y1, edge); shim.fill(t.x1 - e, t.y0, t.x1, t.y1, edge)
            shim.flush()
            shim.text(t.label, t.x0 + 12 * s, (t.y0 + t.y1) / 2 + 22 * s * 0.35, 22 * s, c, true)
        end
        local t = tr('OFFLINE  -  edits the game\'s files; they apply when the game starts')
        if not bar.release then
            -- smaller where it would run into the titles (a longer translation)
            local last = bar.titles[#bar.titles]
            local room, size = shim.w - 30 * s - (bar.dropped > 0 and bar.sign.x1 + 12 * s or last and last.x1 + 16 * s or 0), 15 * s
            while size > 10 * s and shim.text_width(t, size) > room do size = size - 0.5 * s end
            shim.text(t, shim.w - 30 * s - shim.text_width(t, size), 31 * s, size, MUTED)
        end
        for _, b in ipairs(bar.buttons) do
            local hovered = bar.hover == b.key and not bar.busy
            local c = b.tint or { 28, 34, 42 }
            shim.fill(b.x0, b.y0, b.x1, b.y1, hovered and { 255, c[1] * 1.6, c[2] * 1.6, c[3] * 1.6 } or { 255, c[1], c[2], c[3] })
            local edge = hovered and GOLD or { 255, 70, 82, 94 }
            local e = math.max(1, math.floor(2 * s + 0.5))
            shim.fill(b.x0, b.y0, b.x1, b.y0 + e, edge); shim.fill(b.x0, b.y1 - e, b.x1, b.y1, edge)
            shim.fill(b.x0, b.y0, b.x0 + e, b.y1, edge); shim.fill(b.x1 - e, b.y0, b.x1, b.y1, edge)
            shim.flush()
            local size, label = 16 * s, tr(b.key == 'close_game' and bar.close_until and 'Click again' or b.label)
            while size > 10 * s and shim.text_width(label, size) > b.x1 - b.x0 - 12 * s do size = size - 0.5 end
            shim.text(label, (b.x0 + b.x1 - shim.text_width(label, size)) / 2, (b.y0 + b.y1) / 2 + size * 0.35, size,
                      b.gold and GOLD or WHITE)
        end
        local text, tone = status()
        text = tr(text)
        local x = 626 * s
        local size = 14 * s
        local limit = shim.w - 30 * s - x
        local first, second = text:match('^(.-%.) (.+)$')
        if first and shim.text_width(text, size) > limit then   -- two sentences: a line each, at full size
            while size > 9 * s and math.max(shim.text_width(first, size), shim.text_width(second, size)) > limit do size = size - 0.5 end
            shim.text(first, x, 1046 * s + size * 0.35, size, tone)
            shim.text(second, x, 1064 * s + size * 0.35, size, tone)
        else
            while size > 9 * s and shim.text_width(text, size) > limit do size = size - 0.5 end
            shim.text(text, x, 1055 * s + size * 0.35, size, tone)
        end
        -- the effects that did not fit: a warning sign for as long as that install stands (hover: the banner, gone when the mouse leaves)
        if bar.dropped > 0 then
            local sign = bar.sign
            local h, c = math.floor(sign.y1 - sign.y0), WARN
            for row = 0, h - 1 do
                local half = (row + 1) / h * (sign.x1 - sign.x0) / 2
                shim.fill((sign.x0 + sign.x1) / 2 - half, sign.y0 + row, (sign.x0 + sign.x1) / 2 + half, sign.y0 + row + 1, c)
            end
            shim.flush()
            local size = 20 * s
            shim.text('!', (sign.x0 + sign.x1 - shim.text_width('!', size, true)) / 2, sign.y1 - 4 * s, size, BACK, true)
        end
        -- over the top strip, so a click here never lands on the panel
        if bar.banner then
            -- what did not fit, under the warning: a line per kind, wrapped
            local lines, room = {}, shim.w - 60 * s
            local listed = state.dropped or {}
            for _, g in ipairs({ { 'Projectiles with no trail:', listed.shots }, { 'Stratagems left out of missions:', listed.stratagems } }) do
                local line = g[2] and g[2][1] and tr(g[1])
                for k, name in ipairs(g[2] or {}) do
                    local longer = line .. (k > 1 and ', ' or ' ') .. name
                    if shim.text_width(longer, 16 * s) > room then
                        lines[#lines + 1] = line .. ','
                        line = name
                    else line = longer end
                end
                if line then lines[#lines + 1] = line end
            end
            bar.banner_h = (46 + 24 * #lines + (#lines > 0 and 6 or 0)) * s
            shim.fill(0, 0, shim.w, bar.banner_h, { 255, 122, 60, 14 })
            shim.fill(0, bar.banner_h - math.max(1, math.floor(2 * s + 0.5)), shim.w, bar.banner_h, WARN)
            shim.flush()
            for k, line in ipairs(lines) do shim.text(line, 30 * s, (40 + 24 * k) * s, 16 * s, WHITE) end
            local warning, size = tr(DROPPED), 19 * s
            while size > 10 * s and shim.text_width(warning, size) > shim.w - 60 * s do size = size - 0.5 end
            -- the setting's name a shade darker: the text in three pieces, or whole when a language has no such piece
            local x, y = 30 * s, 23 * s + size * 0.35
            local name = tr('Always bring it')
            local at, stop = warning:find(name, 1, true)
            if at then
                local before = warning:sub(1, at - 1)
                shim.text(before, x, y, size, WHITE)
                x = x + shim.text_width(before, size)
                shim.text(name, x, y, size, { 255, 205, 195, 185 })
                x = x + shim.text_width(name, size)
                warning = warning:sub(stop + 1)
            end
            shim.text(warning, x, y, size, WHITE)
        end
    end

    local function paint()
        if state.phase == 'ready' then
            shim.paint_guis(BACK)
        else
            shim.fill(0, 0, shim.w, shim.h, BACK)
            centred(tr('Finding the stats...'), shim.h * 0.45, 30 * bar.s, GOLD)
            centred(tostring(state.status or ''), shim.h * 0.45 + 40 * bar.s, 18 * bar.s, MUTED)
        end
        paint_bar()
        shim.present()
    end

    local function say(text, tone) bar.message, bar.tone = text, tone or MUTED end
    local function start_game()
        if I.game_running() then say('Helldivers 2 is already running.', WARN)
        elseif I.launch_game() then say('Starting Helldivers 2 through Steam...', GOOD)
        else say('Could not ask Steam to start the game.', WARN) end
    end
    -- the second click within 4 seconds ends it (bar.close_until: the button says so)
    local function close_game()
        if not I.game_running() then bar.close_until = nil; say('Helldivers 2 is not running.'); return end
        if not bar.close_until then
            bar.close_until = clock() + 4
            say('Click again within 4 seconds to end the game. Unsaved progress is lost.', WARN)
            return
        end
        bar.close_until = nil
        if I.close_game() then say('Helldivers 2 was closed.', GOOD) else say('Could not close Helldivers 2.', WARN) end
    end

    local function busy(text)
        bar.busy = text
        paint()
        shim.pump()
    end

    -- ------------------------------------------------------------ install / restore
    local function install()
        if I.game_running() then say('Helldivers 2 is running: close it, then Install.', WARN); return end
        busy('Installing: finding what changed...')
        local dropped = state.load_donors and state.load_donors() or 0
        local changes = D.diff()
        local stacked, why_not = D.armor_passives(changes, state.armor_passives and state.armor_passives(), log, state.one_line and state.one_line())
        if not stacked then
            for _, c in ipairs(changes) do G.free(c.plain) end
            bar.busy = nil
            log('install stopped: passive stacking: ' .. tostring(why_not))
            say('Not installed: the armor passives could not be stacked (' .. tostring(why_not) .. '). Nothing was changed.', WARN)
            return
        end
        local coded
        coded, why_not = D.codes(changes, state.codes and state.codes(), log)
        if not coded then
            for _, c in ipairs(changes) do G.free(c.plain) end
            bar.busy = nil
            log('install stopped: stratagem codes: ' .. tostring(why_not))
            say('Not installed: the stratagem codes could not be set (' .. tostring(why_not) .. '). Nothing was changed.', WARN)
            return
        end
        local writes, made, back = {}, 0, 0
        for k, c in ipairs(changes) do
            busy(string.format('Installing: preparing %s (%d of %d)...', c.name, k, #changes))
            local sealed, why = D.build(c, function(text) log(c.name .. ': ' .. text); shim.pump() end)
            if not sealed then
                for j = k + 1, #changes do G.free(changes[j].plain) end
                bar.busy = nil
                log('install stopped: ' .. c.name .. ': ' .. tostring(why))
                say('Not installed: ' .. c.name .. ' could not be prepared (' .. tostring(why) .. '). Nothing was changed.', WARN)
                return
            end
            writes[c.name], made = sealed, made + 1
        end
        for name, mine in pairs(ours) do
            if mine and not writes[name] then writes[name], back = originals[name], back + 1 end
        end
        local physics, vehicles = nil, nil
        if rawget(_G, 'SHODAN_PHYSICS') then physics, vehicles = V.patch() end
        if not next(writes) and not physics and not patch then
            bar.busy, bar.base = nil, state.writes
            say('Nothing to install: your values are the game\'s own.', GOOD)
            return
        end
        busy('Installing: writing the files...')
        local done, why = true, nil
        if next(writes) then done, why = I.write_files(game, writes, originals) end
        if done then for name, data in pairs(writes) do ours[name] = data ~= originals[name] end end
        if done and (physics or patch) then
            local name
            done, name = I.write_patch(game, V.BASE, physics)
            if done then
                if physics then made = made + 1 elseif patch then back = back + 1 end
                patch = name
                log(physics and ('vehicle handling: ' .. name .. ' (' .. table.concat(vehicles, ', ') .. ')')
                    or 'vehicle handling: patch removed')
            else
                why = name
            end
        end
        bar.busy = nil
        if not done then
            log('install failed: ' .. tostring(why))
            say('Not installed: ' .. tostring(why), WARN)
            return
        end
        bar.base = state.writes
        bar.dropped = dropped
        if dropped > 0 then state.notify(DROPPED, 8, true) end
        log(string.format('installed: %d changed, %d back to the original', made, back))
        say(string.format('Installed (%d game files changed%s). Start the game to play with your values.', made,
            back > 0 and ', ' .. back .. ' back to the original' or ''), GOOD)
    end

    local function restore()
        if I.game_running() then say('Helldivers 2 is running: close it, then restore.', WARN); return end
        local writes = {}
        for name, mine in pairs(ours) do if mine then writes[name] = originals[name] end end
        if not next(writes) and not patch then say('The game\'s own files are already in place.', GOOD); return end
        busy('Restoring the game\'s files...')
        local names = {}
        for name in pairs(writes) do names[#names + 1] = name end
        local done, why = true, {}
        if next(writes) then done, why = I.write_files(game, writes, originals, true) end
        if done and patch then
            local removed, problem = I.write_patch(game, V.BASE, nil)
            if removed then patch = nil; log('vehicle handling: patch removed') else done, why = nil, problem end
        end
        bar.busy = nil
        if not done then say('Not restored: ' .. tostring(why), WARN); return end
        -- files another tool changed since: left as they are (theirs now); files another mod had changed before
        -- this editor: back to that mod's version, which Steam's file check replaces (issue #90)
        local modded = 0
        for _, name in ipairs(names) do
            ours[name] = false
            if writes[name] and D.modded[name] then modded = modded + 1 end
        end
        for _, name in ipairs(why) do log('restore skipped ' .. name .. ': another tool changed it since') end
        bar.base = nil
        bar.dropped, bar.banner = 0, nil
        log('restored the originals')
        say('The game\'s files are back as they were before this editor. Your values stay saved here (Install puts them in again).'
            .. (modded > 0 and string.format(' %d of them still hold another mod\'s changes: Steam\'s "Verify integrity of game files" puts back the game\'s own.', modded) or ''), GOOD)
    end

    -- ------------------------------------------------------------ updates (update.lua)
    local exe_dir = exe_dir
    local function update_program()
        local release = bar.release
        busy('Updating: downloading ' .. release.label .. '...')
        local zip = U.dir .. '/' .. release.name
        local job, why = U.fetch(release.url, zip)
        local done = nil
        if job then
            repeat
                if not shim.pump() then bar.busy = nil; return false end
                shim.sleep(20)
                done, why = U.poll(job)
            until done ~= nil
        end
        if not done then
            bar.busy = nil
            log('update: download failed: ' .. tostring(why))
            say('Update failed: ' .. tostring(why) .. '. The release page has it: ' .. U.PAGE, WARN)
            return false
        end
        busy('Updating: installing ' .. release.label .. '...')
        local exe, problem = U.install(zip, exe_dir, log)
        bar.busy = nil
        if not exe then
            log('update: not installed: ' .. tostring(problem))
            say('Update failed: ' .. tostring(problem) .. '. Nothing was changed.', WARN)
            return false
        end
        log('update: ' .. release.label .. ' installed, restarting: ' .. exe)
        U.note(release.label)
        bar.restart = exe
        return true
    end

    -- ------------------------------------------------------------ the frame loop
    local painted, was_down, armed, said_ready = nil, false, nil, false
    local last = clock()
    while shim.pump() do
        local now = clock()
        update(math.min(0.1, now - last))
        last = now
        if bar.h ~= shim.h then layout() end   -- moved onto another screen: sized for that one
        if state.phase == 'ready' and not said_ready then
            said_ready = true
            if installed_count() > 0 and state.load_donors then bar.dropped = state.load_donors() end
            bar.base = installed_count() > 0 and state.writes or nil
            log(string.format('ready: %s weapons, %s values applied, %s refused', tostring(state.weapons),
                tostring(state.applied), tostring(state.refused)))
            local armors = state.armor_passives and state.armor_passives() or {}
            if installed_count() == 0 and ((state.applied or 0) > 0 or next(armors)) then bar.base = -1 end
            if I.game_running() then say('Helldivers 2 is running: you can edit, but close it before you Install.', WARN) end
            local updated = U.cleanup()
            if updated then say('Updated to ' .. updated .. '.', GOOD) end
        end
        -- updates: asked at start, and again when Settings > Update channel changes
        local channel = type(state.update_channel) == 'function' and state.update_channel() or 'releases'
        if said_ready and U.available and channel ~= bar.channel and not U.checking and not bar.restart then
            bar.channel = channel
            if bar.release then bar.release = nil; layout() end
            U.check(channel)
        end
        if U.checking then
            local current = { version = state.version, commit = build.commit }
            local release = U.check_poll(current)
            if release and bar.channel ~= U.channel then release = nil end   -- the channel changed meanwhile
            if release then
                bar.release = release
                layout()
                log('update: ' .. release.label .. ' is available (' .. release.name .. ')')
                -- Settings > Updates: Automatic
                if type(state.updates) == 'function' and state.updates() == 'auto' and update_program() then break end
            elseif release == false then
                log('update: nothing newer on ' .. tostring(U.channel) .. ' than v' .. tostring(current.version)
                    .. (current.commit and ' (' .. current.commit:sub(1, 7) .. ')' or ''))
            end
        end
        -- the bar's buttons
        local x, y = nil, nil
        if shim.focused() then x, y = shim.cursor() end
        local hover = nil
        for _, b in ipairs(bar.buttons) do
            if x and x >= b.x0 and x < b.x1 and y >= b.y0 and y < b.y1 then hover = b.key end
        end
        if #bar.titles > 1 then
            for _, b in ipairs(bar.titles) do
                if x and x >= b.x0 and x < b.x1 and y >= b.y0 and y < b.y1 then hover = b.key end
            end
        end
        bar.banner = bar.dropped > 0 and x ~= nil and (bar.banner and y < (bar.banner_h or 46 * bar.s)
                     or x >= bar.sign.x0 and x < bar.sign.x1 and y >= bar.sign.y0 and y < bar.sign.y1)
        if bar.banner then hover = 'banner' end   -- it covers the titles and the Update button
        bar.hover = hover
        local down = shim.focused() and shim.key_down(0x01)
        if down and not was_down then armed = hover end
        if not down and was_down and armed and armed == hover and state.phase == 'ready' then
            bar.message = nil
            if hover == 'install' then install() elseif hover == 'restore' then restore()
            elseif hover == 'start_game' then start_game() elseif hover == 'close_game' then close_game()
            elseif hover == 'update' and update_program() then break
            elseif hover == 'title_stat' or hover == 'title_enemy' then state.switch_editor(hover == 'title_enemy') end
            armed = nil
        end
        was_down = down
        if bar.close_until and clock() >= bar.close_until then bar.close_until, bar.message = nil, nil end
        local text = status()
        local signature = table.concat({ shim.version, state.phase, tostring(state.status), tostring(hover), text,
                                         shim.lang(), bar.release and bar.release.label or '', bar.dropped, tostring(bar.banner) }, '|')
        if signature ~= painted then
            painted = signature
            paint()
        end
        -- while loading, no wait: Windows rounds Sleep(1) up to ~15 ms, which made the ~400 loading steps take ~6 s extra
        if state.phase == 'ready' then shim.sleep(10) end
    end
    if shim.place then
        I.mkdirs(I.home)
        local f = io.open(PLACE, 'w')
        if f then f:write(shim.place[1], ' ', shim.place[2], shim.place[3] and (' ' .. shim.place[3]) or '', '\n'); f:close() end
    end
    -- the editor saves its values a moment after a change
    local stop = clock() + 1.5
    while clock() < stop do update(0.05); shim.sleep(20) end
    if bar.restart then
        local go = true
        if go and not U.launch(bar.restart) then
            shim.message_box('Updated. Start ' .. bar.restart:gsub('/', '\\') .. ' again.', 0x40)
        end
    end
    log('closed')
end

local ok, err = xpcall(main, debug.traceback)
if not ok then
    log('error: ' .. tostring(err))
    shim.message_box('SHODAN Stat Editor Offline stopped:\n\n' .. tostring(err), 0x10)
end
