-- SHODAN Stat Editor Offline: vehicle handling. Each vehicle's physics file (named as its entity), the exosuits'
-- state machine (their walk and turn speeds) and the enemies' (their animation speed) are read out of the game's
-- archives into memory, where the panel edits them like a table (SHODAN_PHYSICS: base address, files['<name hex>.<type hex>'] = { at, size }); Install puts the
-- changed ones into a patch archive (install.lua write_patch), which the game loads over its own files.
-- Archives: the slim edition packs them into data\bundles.NN.nxa (DSAR: 32-byte header, u32 chunk count at +8,
-- then 32 bytes a chunk: u64 offset unpacked, u64 offset in the file, u32 size unpacked, u32 size packed, u8 3 =
-- LZ4); data\bundles.nxa holds the list (DSAA: +12 u32 bundle count, +16 archive count, from +24 24 bytes an
-- archive: u64 size, u32 name offset, u32 entry count, u64 entries offset; an entry, 16 bytes: u32 offset in the
-- archive, +8 u32 offset unpacked in the bundle, +15 u8 bundle; after the archives a u32 name offset per bundle).
-- The full edition keeps each archive as its own file in data\.
-- An archive: 72-byte header (11 00 00 F0, u32 type count, u32 file count), 32 bytes a type, 80 bytes a file
-- (u64 name, u64 type, u64 offset of its data, ..., +56 u32 size).
local ffi = require('ffi')
local bit = require('bit')

local M = { files = {}, original = {} }

local PHYSICS, STATE_MACHINE = '5F7203C8F280DAB8', 'A486D4045106165C'
-- '<name>.<type>' -> an archive holding the file (game build of 2026-10-22)
-- shortcut: fixed archive names; a game update that moves the files needs this list redone
-- (scratch\slim_archive.py find <name> <type>)
M.ARCHIVES = {
    ['CC21C7FFD3EBEFB9.' .. PHYSICS] = '0bdf199f7ac14f43',         -- M-102 Gunner FRV
    ['9B2140378640432E.' .. PHYSICS] = '149f685717737cae',         -- M-103 Supply FRV
    ['2D85BFE3D8717FE5.' .. PHYSICS] = '2cee40dfbd0b174d',         -- M-104 Incinerator FRV
    ['16474112801385B6.' .. PHYSICS] = '17ec2d364664c3e9',         -- TD-220 Bastion
    ['B0C9FAF4AF8903F9.' .. PHYSICS] = '65ee777b72347cb4',         -- TD-110 Maelstrom
    ['423FF97D57AB04F5.' .. PHYSICS] = '0dff5200594e867f',         -- GATER (its physics file is named after its second entity)
    ['79E4B3D2DA5E45E3.' .. STATE_MACHINE] = '0a4bd8a1833f11b2',   -- the exosuits (combat_walker, all four)
    -- the enemies' state machines (their animation speed; scratch\enemy_units.py writes these lines)
    ['00BCF8247A544CDC.' .. STATE_MACHINE] = '063a5b895ed482e6',   -- Shredder Tank
    ['01FE503DCD17847B.' .. STATE_MACHINE] = '009cb913478ad077',   -- Warp Gateway
    ['06D3C4720E642FC1.' .. STATE_MACHINE] = '02f0eeeeb0b86bc1',   -- Egg
    ['0883366204E1CCC5.' .. STATE_MACHINE] = '009cb913478ad077',   -- Gazer
    ['09872E66D1276E1F.' .. STATE_MACHINE] = '17cf954f6be50eb0',   -- Bile Warrior
    ['1448D494665D01A0.' .. STATE_MACHINE] = '8f146454b73b362a',   -- Gazer
    ['16023E554FEE830E.' .. STATE_MACHINE] = '62ec9c912c88c15d',   -- Fusion Repeater
    ['19E18B46EC55D94A.' .. STATE_MACHINE] = '046d4441a6dae0a9',   -- Stingray
    ['1A7FCDFF98C664B0.' .. STATE_MACHINE] = '218cf6382ed2058e',   -- Charger
    ['20B9C7734DAEAD65.' .. STATE_MACHINE] = '687d548654b91be6',   -- Veracitor
    ['282EB766C1FFA6A1.' .. STATE_MACHINE] = '27cb3df21f6599fd',   -- Gunship
    ['2C1A7790C435FD67.' .. STATE_MACHINE] = '063f7a0139d67745',   -- MG Emplacement
    ['36AA99CCE5E60146.' .. STATE_MACHINE] = '214f30944d4c4cd7',   -- Bile Spewer
    ['453FE22C634EB30F.' .. STATE_MACHINE] = 'b97df541a966620a',   -- Gatekeeper
    ['485C04E03CCC969E.' .. STATE_MACHINE] = '0c37e83a8d16b67a',   -- Command bunker
    ['49674794A165EDA8.' .. STATE_MACHINE] = '063a5b895ed482e6',   -- Fusion Autocannon
    ['4E342031A9D5C4F9.' .. STATE_MACHINE] = 'dd43ebba60a66968',   -- Leviathan cannon
    ['5D142C3A73EBC634.' .. STATE_MACHINE] = '1a3dc966179bd5a4',   -- Ballistic Missile
    ['604A794EC45BB820.' .. STATE_MACHINE] = '71b78f82c6d9fce5',   -- Elevated Overseer
    ['6293D7AB6E681855.' .. STATE_MACHINE] = '0692f83587540ae5',   -- Automaton Mortar Emplacement
    ['64090088502435DD.' .. STATE_MACHINE] = '58cc04e08a03076c',   -- Shrieker
    ['672F7DA17F3BA34A.' .. STATE_MACHINE] = '50c4a70c3174bc79',   -- Impaler
    ['67DC32DCA4F02D33.' .. STATE_MACHINE] = 'e7765eef5f60acea',   -- Fleshmob
    ['6F66D509FADE59D8.' .. STATE_MACHINE] = '7dc7024d6d4d56df',   -- Factory Strider
    ['74E2285C01DA4F71.' .. STATE_MACHINE] = '046d4441a6dae0a9',   -- Warp Ship
    ['78E1497571012C47.' .. STATE_MACHINE] = '6502c77f9595fbc2',   -- Voteless
    ['7A3637CD33A54E4C.' .. STATE_MACHINE] = '5092495166edc865',   -- SEAF Soldier
    ['843D18D4B5512B63.' .. STATE_MACHINE] = 'a2a2eb28bc511575',   -- Big walker cannon
    ['846BC06C6B213A06.' .. STATE_MACHINE] = '0626b9bae831783d',   -- Hulk Obliterator
    ['8FC2784308E9BA99.' .. STATE_MACHINE] = '086e54bc88865de2',   -- Hulk flag
    ['8FDA04D2D85E87AE.' .. STATE_MACHINE] = 'a92a332094ab700f',   -- Warp Ship (invasion)
    ['905809A4C28D8A45.' .. STATE_MACHINE] = '6a9745893ec68156',   -- Crusher
    ['960B48A421A3FAAA.' .. STATE_MACHINE] = '863dc0bbdb912c40',   -- Dragonroach
    ['965EAE5A51ACDD4A.' .. STATE_MACHINE] = '4a7ea58e8d4be432',   -- Harvester
    ['9821303BD499CD62.' .. STATE_MACHINE] = '387a99b22d643bb1',   -- Commissar
    ['99CB7F36F9A951F9.' .. STATE_MACHINE] = '48d2cc447bb442a5',   -- Fleet ship
    ['9D8827FED763650E.' .. STATE_MACHINE] = '5e47518596f8175d',   -- Agitator
    ['9E2E17F2CCCCAFDD.' .. STATE_MACHINE] = '5dc6001da22897e3',   -- Bile Titan
    ['9EA89CEEA6F8E766.' .. STATE_MACHINE] = '0a9651116d7d42b5',   -- Larva Container
    ['A2A86454F67FBC47.' .. STATE_MACHINE] = '01c1becaa12a1643',   -- Bulk Fabricator
    ['A478D36A62A861F4.' .. STATE_MACHINE] = '4a600305ecab1826',   -- Hunter
    ['A57AE2A703C02899.' .. STATE_MACHINE] = '318c6255be1254cd',   -- Fabricator
    ['A98F8B559C7993D8.' .. STATE_MACHINE] = '0a59c7429a608760',   -- HMG Emplacement
    ['AC60E78435098C9D.' .. STATE_MACHINE] = '046d4441a6dae0a9',   -- Watcher
    ['AE63E525853D7044.' .. STATE_MACHINE] = '1ff5cb1fc2fe055b',   -- Berserker
    ['B29AF893B9C188A9.' .. STATE_MACHINE] = 'a2a2eb28bc511575',   -- Stratagem Scrambler (convoy)
    ['B2B3056BDF28E57B.' .. STATE_MACHINE] = '079529fe7dd7c0cb',   -- Trooper
    ['BAF9DBD86B22270A.' .. STATE_MACHINE] = '70b4860e8169622e',   -- Overship
    ['BB2984B9B83EBFD1.' .. STATE_MACHINE] = '4d6a17be6ebfd4be',   -- Harvester objective
    ['BC242702FB46B7E7.' .. STATE_MACHINE] = 'b9a08b6ab841d83e',   -- Vox Engine
    ['C14E0E887E7D2106.' .. STATE_MACHINE] = '23725ae5eea97a53',   -- Scavenger
    ['C626D2BB495A202D.' .. STATE_MACHINE] = '1ff5cb1fc2fe055b',   -- Devastator
    ['CC188F0C80505C6C.' .. STATE_MACHINE] = '8cc398a6c1e8c051',   -- Wretch
    ['CD28A27A79BE53D5.' .. STATE_MACHINE] = '0c37e83a8d16b67a',   -- Bunker Turret
    ['CDB573E646581547.' .. STATE_MACHINE] = '05215ba2782a1a22',   -- Stratagem Jammer
    ['CECD6979CF7BB0F2.' .. STATE_MACHINE] = '2f762004cd12e6e1',   -- Tank turret
    ['D465D9C7F77A07CB.' .. STATE_MACHINE] = '0f9c1ccc845ab6f6',   -- Hive Lord
    ['D522FD4748D443A5.' .. STATE_MACHINE] = '647308cc007f32ae',   -- Brood Commander
    ['D7ABB6B791E48E16.' .. STATE_MACHINE] = '9e430d763af434c1',   -- Grinder
    ['DA40BB347C7447F2.' .. STATE_MACHINE] = '9230ae99f0ee6c03',   -- Overseer
    ['DB90077E76FAA025.' .. STATE_MACHINE] = 'fdf011daecf24312',   -- Dropship
    ['DCF8E74212FBEE3B.' .. STATE_MACHINE] = '987b77ea5a7e5d9e',   -- Impaler
    ['DF3C4F91E298BFA4.' .. STATE_MACHINE] = '08c6079cd49e5d74',   -- Hive Breaker Drill
    ['E8F19A0AA958E46D.' .. STATE_MACHINE] = '2defbee4485f3ce0',   -- Crescent Overseer
    ['EF570293245A17C2.' .. STATE_MACHINE] = '031c90406564341b',   -- War Strider
    ['F22D027B37BEF107.' .. STATE_MACHINE] = 'dd43ebba60a66968',   -- Leviathan
    ['F540CA9D9D4A422E.' .. STATE_MACHINE] = '46e418dd4a6542c4',   -- Stalker
    ['F8131632AA867107.' .. STATE_MACHINE] = '094394c2a2c22f36',   -- Scout Strider
}
-- the archive the patch goes over: one the game always loads (mod managers' too)
M.BASE = '9ba626afa44a3aa3'

local function u32(s, o) local a, b, c, d = s:byte(o + 1, o + 4); return a + b * 256 + c * 65536 + d * 16777216 end
local function u64(s, o) return u32(s, o) + u32(s, o + 4) * 4294967296 end

local function read_at(path, offset, n)
    local f = io.open(path, 'rb')
    if not f then return nil end
    f:seek('set', offset)
    local s = f:read(n)
    f:close()
    return s
end

-- an LZ4 block (no frame) of `size` bytes unpacked
local function lz4(src, size)
    local s, n = ffi.cast('const uint8_t *', src), #src
    local out = ffi.new('uint8_t[?]', size)
    local i, o = 0, 0
    while i < n do
        local token = s[i]; i = i + 1
        local lit = bit.rshift(token, 4)
        if lit == 15 then repeat local b = s[i]; i = i + 1; lit = lit + b until b ~= 255 end
        assert(i + lit <= n and o + lit <= size, 'LZ4: literals past the end')
        ffi.copy(out + o, s + i, lit)
        i, o = i + lit, o + lit
        if i >= n then break end
        local back = s[i] + s[i + 1] * 256; i = i + 2
        local len = token % 16
        if len == 15 then repeat local b = s[i]; i = i + 1; len = len + b until b ~= 255 end
        len = len + 4
        assert(back > 0 and back <= o and o + len <= size, 'LZ4: match out of range')
        if back >= len then ffi.copy(out + o, out + o - back, len)
        else for k = 0, len - 1 do out[o + k] = out[o - back + k] end end   -- overlapping: byte by byte
        o = o + len
    end
    assert(o == size, 'LZ4: wrong size')
    return ffi.string(out, size)
end

-- a DSAR file's chunks: { unpacked offset, file offset, unpacked size, packed size, packing }
local function dsar(path)
    local head = assert(read_at(path, 0, 32), 'cannot read ' .. path)
    assert(head:sub(1, 4) == 'DSAR', path .. ': not a DSAR file')
    local count = u32(head, 8)
    local raw = read_at(path, 32, count * 32)
    local out = {}
    for k = 0, count - 1 do
        local o = k * 32
        out[k + 1] = { u64(raw, o), u64(raw, o + 8), u32(raw, o + 16), u32(raw, o + 20), raw:byte(o + 25) }
    end
    return out
end

local function chunk(path, c)
    local packed = read_at(path, c[2], c[4])
    if c[5] == 0 then return packed end
    assert(c[5] == 3, 'unknown packing ' .. c[5])
    return lz4(packed, c[3])
end

-- ---------------------------------------------------------------- the slim edition
local Slim = {}
Slim.__index = Slim

local function slim(data)
    local list = data .. '/bundles.nxa'
    local parts = {}
    for _, c in ipairs(dsar(list)) do parts[#parts + 1] = chunk(list, c) end
    local d = table.concat(parts)
    assert(d:sub(1, 4) == 'DSAA', 'bundles.nxa: not a DSAA list')
    local bundles, count = u32(d, 12), u32(d, 16)
    local self = setmetatable({ data = data, archives = {}, bundles = {}, chunks = {} }, Slim)
    for k = 0, count - 1 do
        local at = 24 + 24 * k
        local name_at = u32(d, at + 8)
        local name = d:match('^[^%z]*', name_at + 1)
        self.archives[name] = { d = d, entries = u32(d, at + 12), entries_at = u64(d, at + 16) }
    end
    for k = 0, bundles - 1 do
        self.bundles[k] = d:match('^[^%z]*', u32(d, 24 + 24 * count + 4 * k) + 1)
    end
    return self
end

-- n bytes at `offset` in an archive
function Slim:read(name, offset, n)
    local a = assert(self.archives[name], 'archive ' .. name .. ' not in bundles.nxa')
    local pick
    for k = 0, a.entries - 1 do   -- the last entry starting at or before offset
        local e = a.entries_at + 16 * k
        if u32(a.d, e) > offset then break end
        pick = e
    end
    assert(pick, 'archive ' .. name .. ': no entry')
    local at, unpacked, b = u32(a.d, pick), u32(a.d, pick + 8), a.d:byte(pick + 16)
    local path = self.data .. '/' .. assert(self.bundles[b], 'bundle ' .. b)
    self.chunks[b] = self.chunks[b] or dsar(path)
    local cs, i = self.chunks[b], nil
    for k, c in ipairs(cs) do if c[1] == unpacked then i = k; break end end
    assert(i, 'archive ' .. name .. ': chunk not found')
    local out, have = {}, 0
    while at + have < offset + n do
        local s = chunk(path, assert(cs[i], 'archive ' .. name .. ': past the last chunk'))
        out[#out + 1], have, i = s, have + #s, i + 1
    end
    local s = table.concat(out)
    return s:sub(offset - at + 1, offset - at + n)
end

-- the full edition: archives are files
local Plain = {}
Plain.__index = Plain
function Plain:read(name, offset, n) return assert(read_at(self.data .. '/' .. name, offset, n), 'cannot read ' .. name) end

local function open_archives(data)
    local f = io.open(data .. '/bundles.nxa', 'rb')
    if f then f:close(); return slim(data) end
    return setmetatable({ data = data }, Plain)
end

-- a file's data out of an archive, by name and type (hex)
local function find(store, archive, name, typ)
    local head = store:read(archive, 0, 72)
    assert(u32(head, 0) == 0xF0000011, archive .. ': not an archive')
    local types, files = u32(head, 4), u32(head, 8)
    local list = store:read(archive, 72, 32 * types + 80 * files)
    local want_name, want_type = name:lower(), typ:lower()
    for k = 0, files - 1 do
        local o = 32 * types + 80 * k
        if string.format('%08x%08x', u32(list, o + 12), u32(list, o + 8)) == want_type
           and string.format('%08x%08x', u32(list, o + 4), u32(list, o)) == want_name then
            return store:read(archive, u64(list, o + 16), u32(list, o + 56))
        end
    end
    return nil
end

-- ---------------------------------------------------------------- loading
-- data: the game's data folder. Fills M.files and M.original, and the panel's SHODAN_PHYSICS.
function M.load(data, log)
    log = log or function() end
    local store = open_archives(data)
    M.store = store
    local found, total = {}, 0
    for id, archive in pairs(M.ARCHIVES) do
        local ok, bytes = pcall(find, store, archive, id:sub(1, 16), id:sub(18))
        if ok and bytes then found[#found + 1] = { entity = id, bytes = bytes }; total = total + #bytes + 16
        else log('vehicle file ' .. id .. ': not in ' .. archive .. (ok and '' or ' (' .. tostring(bytes) .. ')')) end
    end
    table.sort(found, function(a, b) return a.entity < b.entity end)
    M.buffer = ffi.new('uint8_t[?]', math.max(total, 16))
    local at = 0
    for _, f in ipairs(found) do
        ffi.copy(M.buffer + at, f.bytes, #f.bytes)
        M.files[f.entity] = { at = at, size = #f.bytes }
        M.original[f.entity] = f.bytes
        at = at + #f.bytes + (16 - #f.bytes % 16) % 16
    end
    M.shared = { base = tonumber(ffi.cast('uintptr_t', M.buffer)), files = M.files }
    local ok, why = pcall(M.load_strings, store)
    if ok then M.shared.texts = M.texts else log('game texts: ' .. tostring(why)) end
    log(string.format('vehicle files: %d of %d', #found, (function() local n = 0; for _ in pairs(M.ARCHIVES) do n = n + 1 end return n end)()))
    return #found
end

-- ---------------------------------------------------------------- the game's texts
-- The Name and Description boxes: every strings file of the base archive (one set per language): 'magic', version,
-- count, +12 language (thin hash), count u32 ids, count u32 offsets from the file's start, zero-ended UTF-8 texts.
-- M.texts: the English (US) ones by id, as the boxes show them; Install rewrites the files holding a renamed id.
local STRINGS, ENGLISH = '0D972BAB10B40FD3', 0x03F97B57
function M.load_strings(store)
    M.strings, M.texts = {}, {}
    local head = store:read(M.BASE, 0, 72)
    local types, files = u32(head, 4), u32(head, 8)
    local list = store:read(M.BASE, 72, 32 * types + 80 * files)
    for k = 0, files - 1 do
        local o = 32 * types + 80 * k
        if string.format('%08X%08X', u32(list, o + 12), u32(list, o + 8)) == STRINGS then
            local d = store:read(M.BASE, u64(list, o + 16), u32(list, o + 56))
            if #d >= 16 then
                M.strings[string.format('%08X%08X', u32(list, o + 4), u32(list, o))] = d
                if u32(d, 12) == ENGLISH then
                    local n = u32(d, 8)
                    for i = 0, n - 1 do
                        local at = u32(d, 16 + 4 * n + 4 * i)
                        M.texts[u32(d, 16 + 4 * i)] = d:match('^[^%z]*', at + 1)
                    end
                end
            end
        end
    end
end

-- a strings file with the texts of `new` (id -> text) in place of its own, nil when it holds none of them
function M.rewrite_strings(d, new)
    local n, hit = u32(d, 8), false
    local texts = {}
    for i = 0, n - 1 do
        local id = u32(d, 16 + 4 * i)
        texts[i + 1] = new[id] or d:match('^[^%z]*', u32(d, 16 + 4 * n + 4 * i) + 1)
        hit = hit or new[id] ~= nil
    end
    if not hit then return nil end
    local offsets, at = {}, 16 + 8 * n
    for i = 1, n do
        local v = at
        offsets[i] = string.char(v % 256, math.floor(v / 256) % 256, math.floor(v / 65536) % 256, math.floor(v / 16777216))
        at = at + #texts[i] + 1
    end
    return d:sub(1, 16 + 4 * n) .. table.concat(offsets) .. table.concat(texts, '\0') .. '\0'
end

-- ---------------------------------------------------------------- the patch
local function u64_hex(hex) return ffi.cast('uint64_t', tonumber(hex:sub(1, 8), 16)) * 0x100000000ULL + tonumber(hex:sub(9, 16), 16) end

-- the patch archive's bytes for the physics files the panel changed and the strings files holding a renamed text
-- (SHODAN_PHYSICS.renames(): id -> text, set by the panel), nil when there is nothing to patch
function M.patch()
    local changed, data = {}, {}
    for entity, f in pairs(M.files) do
        local bytes = ffi.string(M.buffer + f.at, f.size)
        if bytes ~= M.original[entity] then changed[#changed + 1] = entity; data[entity] = bytes end
    end
    local renames = M.shared and M.shared.renames and M.shared.renames()
    if renames and next(renames) and M.strings then
        for name, d in pairs(M.strings) do
            local bytes = M.rewrite_strings(d, renames)
            if bytes then local id = name .. '.' .. STRINGS; changed[#changed + 1] = id; data[id] = bytes end
        end
    end
    if #changed == 0 then return nil end
    -- by type, then name (an archive lists its files grouped by type)
    table.sort(changed, function(a, b) return a:sub(18) .. a:sub(1, 16) < b:sub(18) .. b:sub(1, 16) end)
    local types = {}
    for _, id in ipairs(changed) do
        local t = id:sub(18)
        if types[#types] ~= t then types[#types + 1] = t end
    end
    -- the header as the base archive's (the game read such patches in the 2026-10-28 tests), with its own counts
    local head = M.store:read(M.BASE, 0, 72)
    local size = 72 + 32 * #types + 80 * #changed
    local offsets = {}
    for k, id in ipairs(changed) do
        size = size + (16 - size % 16) % 16
        offsets[k] = size
        size = size + #data[id]
    end
    local out = ffi.new('uint8_t[?]', size)
    ffi.copy(out, head, 72)
    ffi.cast('uint32_t *', out + 4)[0], ffi.cast('uint32_t *', out + 8)[0] = #types, #changed
    for k, typ in ipairs(types) do   -- a type: 0, 0, type, count, 0, alignments 16 and 64
        local t, count = out + 72 + 32 * (k - 1), 0
        for _, id in ipairs(changed) do if id:sub(18) == typ then count = count + 1 end end
        ffi.cast('uint64_t *', t + 8)[0] = u64_hex(typ)
        ffi.cast('uint32_t *', t + 16)[0], ffi.cast('uint32_t *', t + 24)[0], ffi.cast('uint32_t *', t + 28)[0] = count, 16, 64
    end
    for k, id in ipairs(changed) do
        local e = out + 72 + 32 * #types + 80 * (k - 1)
        ffi.cast('uint64_t *', e)[0], ffi.cast('uint64_t *', e + 8)[0] = u64_hex(id:sub(1, 16)), u64_hex(id:sub(18))
        ffi.cast('uint64_t *', e + 16)[0] = offsets[k]
        local w = ffi.cast('uint32_t *', e + 56)
        w[0], w[3], w[4], w[5] = #data[id], 16, 64, k
        ffi.copy(out + offsets[k], data[id], #data[id])
    end
    return ffi.string(out, size), changed
end

return M
