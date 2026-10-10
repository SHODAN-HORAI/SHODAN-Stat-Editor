"""Run with: uv run --with lupa python -m unittest discover -s tests -v

Execute the real mod functions in LuaJIT, replacing only Windows memory and the
game's asynchronous package loader. No game process or installed files are changed.
"""
from pathlib import Path
import unittest

from lupa.luajit21 import LuaRuntime


SOURCE = Path(__file__).resolve().parents[1] / 'src' / 'stat_editor.lua'

HARNESS = r'''
return (function()
local memory, writes = {}, {}
local files = {}
local clock, ready, fail_at, unreadable = 0, true, nil, nil
api = {
    now = function() return clock end,
    read = function(at, n)
        if at == unreadable then return nil end
        local out = {}
        for k = 0, n - 1 do out[#out + 1] = string.char(memory[at + k] or 0) end
        return table.concat(out)
    end,
    write = function(at, bytes)
        writes[#writes + 1] = { at, bytes }
        for k = 1, #bytes do memory[at + k - 1] = bytes:byte(k) end
        if at == fail_at then
            memory[at + 7] = 255 -- simulate a partial/corrupt write on this copy
            fail_at = nil
            return false
        end
        return true
    end,
}
peek4 = function(at) local b = api.read(at, 4); return b and u32(b, 0) end
f32_bytes = function(value)
    local cell = ffi.new('float[1]', value)
    return ffi.string(cell, 4)
end
tables[T_FIRE] = { copies = { 10000, 20000 }, index = {} }
tables[TYPES.throwable] = { index = {} }
tables[TYPES.explosive] = { index = {} }
for _, w in ipairs(weapons) do
    if w.slot == 'Throwables' then
        tables[TYPES.throwable].index[w.key] = 0
        tables[TYPES.explosive].index[w.key] = 0
    end
end
local spec = KINDS[TYPES.throwable]
local launch_ready = true
spec.ensure_launch = function() return launch_ready, 'launch unavailable' end
spec.prepare_grenades()
local real_resident = packages.resident
packages.require_package = function(key) return key end
packages.resident = function() return ready end
local host = by_hash['02EECD0B1FA49630']
spec.grenade_row(host, 0)
local row, f = host.grenade_swap, host.by_id.grenade.field
ui.weapon = host
mark_config_dirty = function() end -- no user config writes
data_dir = function() return '/offline' end
MOD.write_text = function(path, text) files[path] = text; return true end
io.open = function(path)
    local text = files[path]
    if not text then return nil end
    return { read = function() return text end, close = function() end }
end
return {
    spec = spec, host = host, row = row, field = f, weapons = weapons,
    write = write_field, read = read_field, default = default_of, bytes = api.read,
    put = api.write, value = row_value, change = change, reset = reset_row,
    reset_all = reset_all, settings = settings, apply = function() return apply_config() end,
    pending = function() return #pending end,
    overrides = function() return overrides end,
    ready = function(value) ready = value end,
    launch_ready = function(value) launch_ready = value end,
    fail_at = function(at) fail_at = at end,
    unreadable = function(at) unreadable = at end,
    advance = function() clock = clock + 2 end,
    row_for = function(hash)
        local w = by_hash[hash]
        tables[T_FIRE].index[w.key] = 616
        resolve(w)
        return w.grenade_swap
    end,
    select = function(value) change(row, 0, false, value) end,
    save_preset = function() presets.save_weapon_preset(host, 1) end,
    load_preset = function() presets.load_weapon_preset(host, 1) end,
    save_config = save_config,
    replay_config = function()
        overrides = {}
        load_config()
        state.build_steps = {}
        state.build_some()
        apply_config()
    end,
    remove_donor = function(id)
        tables[TYPES.explosive].index[spec.by_id[id].key] = nil
        spec.prepare_grenades()
    end,
    residency = real_resident,
    residency_tree = function(part_state, count)
        packages.engine.base = 1000000
        local function ptr(at, value) api.write(at, u32_bytes(value) .. u32_bytes(0)) end
        ptr(1000000 + packages.engine.manager_rva, 100000)
        ptr(100000 + 1024, 200000)
        ptr(200000 + 520, 300000)
        api.write(300000 + 128, u32_bytes(count or 1))
        ptr(300000 + 136, 400000)
        ptr(400000, 500000)
        api.write(500000 + 16, 'package1')
        api.write(500000 + 24, u32_bytes(2))
        ptr(500000 + 32, 600000)
        ptr(600000, 700000)
        ptr(600008, 800000)
        api.write(700000 + 28, u32_bytes(4))
        api.write(800000 + 28, u32_bytes(part_state))
    end,
}
end)()
'''


class GrenadeSwapTests(unittest.TestCase):
    def setUp(self):
        self.lua = LuaRuntime(encoding=None)
        source = SOURCE.read_bytes().split(b'-- ---------------------------------------------------------------- startup')[0]
        self.mod = self.lua.execute(source + HARNESS.encode())
        self.spec = self.mod[b'spec']
        self.field = self.mod[b'field']

    def call(self, name, *args):
        return self.mod[name.encode()](*args)

    def test_full_mod_compiles_under_luajit_local_limit(self):
        self.lua.execute(b'assert(loadstring(...))', SOURCE.read_bytes())

    def test_every_explosive_throwable_except_shield_is_available(self):
        labels = {shot[b'label'] for _, shot in self.spec[b'by_id'].items()}
        expected = {w[b'name'] for _, w in self.mod[b'weapons'].items()
                    if w[b'slot'] == b'Throwables' and w[b'name'] not in
                    (b'K-2 Throwing Knife', b'G/SH-39 Shield')}
        self.assertEqual(labels, expected)
        self.assertEqual(len(labels), 21)
        self.assertEqual(self.spec[b'by_id'][4][b'label'], b'G-123 Thermite')

    def test_only_launcher_hosts_get_selector(self):
        for hash_value, _ in self.spec[b'grenade_hosts'].items():
            self.assertIsNotNone(self.call('row_for', hash_value))
        self.assertIsNone(self.call('row_for', b'968211C0033DCE64'))

    def test_64_bit_entity_round_trip_and_restore_all_copies(self):
        for grenade_id, shot in self.spec[b'by_id'].items():
            self.assertTrue(self.call('write', self.field, grenade_id))
            for address in (10064, 20064):
                self.assertEqual(self.call('bytes', address, 8), shot[b'key'])
                self.assertEqual(self.call('bytes', address + 8, 4), b'\0' * 4)
            self.assertEqual(self.call('read', self.field), grenade_id)
        self.assertEqual(self.call('default', self.field), 0)
        self.assertTrue(self.call('write', self.field, 0))
        for address in (10064, 20064):
            self.assertEqual(self.call('bytes', address, 8), b'\0' * 8)

    def test_unavailable_launch_service_blocks_selection_but_allows_reset(self):
        self.call('launch_ready', False)
        ok, why = self.call('write', self.field, 16)
        self.assertFalse(ok)
        self.assertEqual(why, b'launch unavailable')
        for address in (10064, 20064):
            self.assertEqual(self.call('bytes', address, 8), b'\0' * 8)
        self.assertTrue(self.call('write', self.field, 0))

    def test_invalid_ids_and_unknown_entity_are_refused(self):
        for value in (-1, 22, 1.5, 4294967295):
            ok, why = self.call('write', self.field, value)
            self.assertFalse(ok)
            self.assertEqual(why, b'unknown grenade selection')
        self.call('put', 10064, b'abcdefgh')
        self.assertIsNone(self.call('read', self.field))
        self.assertFalse(self.call('write', self.field, 1)[0])

    def test_failed_copy_rolls_back_entire_entity_including_failed_copy(self):
        self.call('write', self.field, 4)
        original = self.call('bytes', 10064, 8)
        self.call('fail_at', 20064)
        self.assertFalse(self.call('write', self.field, 14)[0])
        for address in (10064, 20064):
            self.assertEqual(self.call('bytes', address, 8), original)

    def test_unreadable_copy_rolls_back_prior_copies(self):
        self.call('unreadable', 20064)
        self.assertFalse(self.call('write', self.field, 4)[0])
        self.assertEqual(self.call('bytes', 10064, 8), b'\0' * 8)

    def test_asset_wait_keeps_original_reference_then_applies_and_persists(self):
        self.call('ready', False)
        self.call('select', 4)
        self.assertEqual(self.call('bytes', 10064, 8), b'\0' * 8)
        self.assertEqual(self.call('value', self.mod[b'row']), 4)
        self.assertEqual(self.call('pending'), 1)
        self.assertEqual(self.call('overrides')[1][b'id'], b'grenade')
        self.call('apply')
        self.assertEqual(self.call('pending'), 1)
        self.call('ready', True)
        self.call('apply')
        self.assertEqual(self.call('pending'), 0)
        self.assertEqual(self.call('read', self.field), 4)

    def test_new_selection_replaces_waiting_selection(self):
        self.call('ready', False)
        self.call('select', 4)
        self.call('select', 14)
        self.assertEqual(self.call('pending'), 1)
        self.call('ready', True)
        self.call('apply')
        self.assertEqual(self.call('read', self.field), 14)

    def test_reset_cancels_pending_and_removes_saved_override(self):
        self.call('ready', False)
        self.call('select', 4)
        self.call('reset', self.mod[b'host'], self.mod[b'row'])
        self.assertEqual(self.call('pending'), 0)
        self.assertEqual(len(self.call('overrides')), 0)
        self.call('ready', True)
        self.call('apply')
        self.assertEqual(self.call('read', self.field), 0)

    def test_changes_off_restores_and_on_reapplies_saved_grenade(self):
        self.call('select', 4)
        self.mod[b'settings'][b'set_changes'](False)
        self.assertEqual(self.call('read', self.field), 0)
        self.mod[b'settings'][b'set_changes'](True)
        self.call('apply')
        self.assertEqual(self.call('read', self.field), 4)

    def test_saved_config_replays_grenade_on_startup(self):
        self.call('select', 4)
        self.call('save_config')
        for address in (10064, 20064):
            self.call('put', address, b'\0' * 8)
        self.call('replay_config')
        self.assertEqual(self.call('read', self.field), 4)

    def test_choices_skip_missing_donors_without_renumbering_saved_ids(self):
        self.call('remove_donor', 3)
        self.assertEqual(self.spec[b'step'](2, 1), 4)
        self.assertIsNone(self.spec[b'entity_bytes'](3))
        self.assertEqual(self.spec[b'by_id'][4][b'label'], b'G-123 Thermite')

    def test_preset_load_waits_for_assets_and_reset_cancels_it(self):
        self.call('select', 4)
        self.call('save_preset')
        self.call('select', 0)
        self.call('ready', False)
        self.call('load_preset')
        self.assertEqual(self.call('pending'), 1)
        self.assertEqual(self.call('value', self.mod[b'row']), 4)
        self.call('reset_all')
        self.call('ready', True)
        self.call('apply')
        self.assertEqual(self.call('read', self.field), 0)
        self.call('load_preset')
        self.assertEqual(self.call('read', self.field), 4)

    def test_residency_waits_until_every_package_part_is_loaded(self):
        self.call('residency_tree', 2)
        self.assertFalse(self.call('residency', b'package1'))
        self.call('residency_tree', 4)
        self.assertTrue(self.call('residency', b'package1'))
        self.assertFalse(self.call('residency', b'absent12'))
        self.call('residency_tree', 4, 0)
        self.assertFalse(self.call('residency', b'package1'))

    def test_residency_rejects_changed_layout_bounds(self):
        self.call('residency_tree', 4, 8193)
        with self.assertRaisesRegex(Exception, 'package list bounds changed'):
            self.call('residency', b'package1')


if __name__ == '__main__':
    unittest.main()
