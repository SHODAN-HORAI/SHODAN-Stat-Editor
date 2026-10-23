-- HD2-Addon: mods/shodan/stat_editor
-- SHODAN Stat Editor v3.2.0 by SHODAN. Run by SHODAN Stat Editor Offline (offline/host.lua).
local MOD = { global = 'ShodanStatEditor', title = 'SHODAN Stat Editor', version = '3.2.0', author = 'SHODAN', log = 'SHODANStatEditor.log' }
-- magazines, heatsinks and ammunition types: the game's names, by the text id of the item (its English text)
MOD.item_names = {
    [0x046FF548] = '5.5x50mm Ripper',
    [0x06E60303] = '15x100mm Toxic',
    [0x0877EA60] = '15x100mm Plasma',
    [0x0CC46E7C] = '9x70mm Socom Assassin',
    [0x148220A3] = '13x40mm Ripper',
    [0x14AAD316] = '10g Fragmentation',
    [0x18164B61] = '12x25mm Plasma',
    [0x203BCD08] = '15x100mm Standard Rocket',
    [0x21C67371] = '10g Magnum',
    [0x224D7BB0] = '5.5x50mm Full Metal Jacket',
    [0x2314F53E] = '15x100mm High Velocity',
    [0x236506A1] = '9x20mm Hollow Point',
    [0x2602D227] = '15x100mm Fragmentation',
    [0x26A396C1] = '10g Magnum Triball',
    [0x2C1CE01E] = 'Drum Magazine',
    [0x3262E42D] = '5.5x50mm Explosive',
    [0x3A6AE678] = '8x60mm Penetrator',
    [0x3AF98635] = '15x100mm Emp-Rounds',
    [0x3C5AB61B] = 'Standard Drum',
    [0x3DD3FF6C] = '12g Buckshot',
    [0x40239E59] = '5.5x50mm Self Propelled',
    [0x46B0DA4A] = '12x25mm Explosive',
    [0x497E2D30] = '9x20mm Toxic',
    [0x4B0BCF20] = '10g Rifled Slugs',
    [0x4B4E4C71] = '8x60mm Subsonic',
    [0x4BEC715C] = '5.5x50mm Hollow-Point',
    [0x529F62D5] = '9x70mm Self Propelled',
    [0x58EAF117] = '12g Flechettes',
    [0x5A4CFA67] = '12x25mm Full Metal Jacket',
    [0x5B8C1CF6] = '5.5x50mm Penetrator',
    [0x650687E4] = '5.5x50mm Super Uranium Core',
    [0x66F92CE0] = '5.5x50mm Devastator',
    [0x6712AADE] = '5.5x50mm Double Power',
    [0x67984B7F] = '9x70mm Full Metal Jacket',
    [0x67D890B0] = '5.5x50mm Subsonic',
    [0x6A4F4733] = '9x70mm Super Uranium Core',
    [0x6A6A555F] = '9x20mm Plasma',
    [0x70157916] = '12g Magnum',
    [0x72349E32] = 'Standard Plasma Container',
    [0x7496CC66] = '10g Tri-Ball',
    [0x76321A6C] = '8x60mm High Velocity',
    [0x7AB0ACAD] = '8x60mm Devastator',
    [0x7D628230] = '12x25mm Hollow Point',
    [0x7DDF07F3] = '10g Dual Sabot',
    [0x7DF3409F] = '9x70mm Penetrator',
    [0x82820B4B] = '9x20mm Thermite',
    [0x8800F269] = '15x100mm High Explosive',
    [0x887E442D] = 'Extended Magazine',
    [0x8E597A62] = '15x100mm Thermite',
    [0x8E74AA13] = '12g Bugshot',
    [0x92D110A0] = '12x25mm Thermite',
    [0x9321CA5B] = '9x20mm Explosive',
    [0x94BE8BEA] = '10g Bugshot',
    [0xA2D4A5F4] = '10g Liberty Fire',
    [0xA35ECACF] = 'Standard Heatsink',
    [0xA4083CFB] = '8x60mm Liberty Fire',
    [0xA44CF329] = '9x70mm High Velocity',
    [0xA56C7CF7] = '13x40mm Full Metal Jacket',
    [0xAC5E247D] = 'High Dissipation Heatsink',
    [0xB0D2442D] = '5.5x50mm High Velocity',
    [0xB71928D4] = '12g Magnum Triball',
    [0xB923E3F9] = '8x60mm Sniper Armour Piercing',
    [0xBBF12281] = '12x25mm Toxic',
    [0xBF670968] = '13x40mm Penetrator',
    [0xC3A21061] = '10g Scatter Shot',
    [0xC3AF3F47] = 'High Capacity Heatsink',
    [0xC5C01BAE] = '8x60mm Airburst',
    [0xC5C1096B] = '12g Liberty Fire',
    [0xC6259AE0] = '8x60mm Super Uranium Core',
    [0xC711E6A8] = '8x60mm Full Metal Jacket',
    [0xC71D0E97] = 'Larger Plasma Container',
    [0xCDDF65D0] = '13x40mm Hollow Point',
    [0xCF73C4BE] = '12x25mm High Velocity',
    [0xCFD94DAD] = 'Short Magazine',
    [0xD01F84B4] = 'Rapid Heatsink',
    [0xD1FA60F1] = '9x70mm Sniper Armour Piercing',
    [0xD9499EE2] = '13x40mm Magnum',
    [0xDEFDAB88] = '10g Birdshot',
    [0xE1575512] = '10g High Velocity Sabot',
    [0xE164BFF6] = '9x20mm Ripper',
    [0xE6F9C309] = '10g Flechettes',
    [0xE913EE91] = '10g Sabot',
    [0xEE3125B7] = '8x60mm Explosive',
    [0xF5114BD7] = '12x25mm Ripper',
    [0xF5AE8259] = '9x20mm Full Metal Jacket',
    [0xF7917239] = '8x60mm Double Power',
    [0xF9B182A7] = '12g Birdshot',
    [0xFA10DBC2] = '12g Tri-Ball',
    [0xFA6A7DA3] = '12g Scatter Shot',
    [0xFB7A777E] = '9x20mm High Velocity',
}
-- reload times (s) of the weapons whose reload record says 0 (play the animation at its own length), by hash
MOD.reload_seconds = {
    ['02CD7321CD8445F5'] = 2.5,
    ['05D8D8C073B9D502'] = 2.5,
    ['0F83639AB8C86165'] = 3.5,
    ['14D5D4506056C7A4'] = 2.7,
    ['1A437158E1B8D2A1'] = 2.0,
    ['30061F91AF477F5E'] = 3.4,
    ['39AB99895147A3BF'] = 4.0,
    ['3C86E871923F3970'] = 2.9,
    ['3F92BA65EF65CCA9'] = 2.35,
    ['416D053372C4E433'] = 2.4,
    ['4D58C77087B774C5'] = 1.5,
    ['4DBD74F49C8FFC13'] = 3.15,
    ['4FB0F8C02F55C82B'] = 3.25,
    ['6CFCC7F8801A0266'] = 3.75,
    ['7B06196E90154C88'] = 2.0,
    ['84354339522C932D'] = 3.0,
    ['8645F167B3C813A2'] = 2.25,
    ['88F61AFFF48AC8A4'] = 4.0,
    ['94BD931B5FB4EE95'] = 3.55,
    ['A6A735ACCB4A327F'] = 5.9,
    ['A8A91EB54892B6B2'] = 3.75,
    ['A955C4EA6F6D4203'] = 3.33,
    ['AA69A60D74A3EC54'] = 1.9,
    ['B6AFF2195568767F'] = 4.67,
    ['BC29613666DF696B'] = 3.0,
    ['CC786F6491FE7E65'] = 4.9,
    ['CDF28BE026BB7D84'] = 4.2,
    ['CE063AA33D95A812'] = 3.33,
    ['CF8934FF6567A42D'] = 2.0,
    ['DBB6C961C59FADC1'] = 2.45,
    ['E8D5F49AD7780E54'] = 5.15,
    ['E91F569C2AD8AF01'] = 2.68,
    ['EEA5E3CEF1E12C14'] = 2.5,
    ['F49227A0630A3F7F'] = 3.33,
    ['F992CE97577C8A7F'] = 3.58,
    ['FB3A19078694708A'] = 2.5,
}
-- the game's names of the projectile records (rounds), by record id
MOD.round_names = {
    [1] = '10g Sabot',
    [3] = '12x25mm Full Metal Jacket',
    [4] = '9x20mm Plasma',
    [5] = 'Laser',
    [6] = '110mm Standard Rocket Mk2',
    [8] = '5.5x50mm Penetrator',
    [11] = 'SEAF Artillery: Smoke',
    [12] = 'Shrapnel',
    [13] = '15x100mm Thermite',
    [14] = '120mm HE Cannon Round',
    [15] = '10g Scatter Shot',
    [16] = '12x25mm Full Metal Jacket',
    [17] = '23mm HE Cannon',
    [18] = 'Large Plasma Bolt',
    [20] = '13x40mm Magnum',
    [21] = '15x100mm Toxic',
    [22] = '15x100mm Plasma',
    [25] = '40mm HE Mortar',
    [26] = 'Laser',
    [27] = '110mm Airburst Cannon Round Mk2',
    [28] = '23mm HE Cannon',
    [29] = '13x40mm Hollow Point',
    [30] = '110mm E.M.S. Cannon Round Mk2',
    [32] = '75mm HEAT Grenade',
    [36] = '9x70mm Socom Assassin',
    [37] = '85mm High-Explosive Grenade',
    [38] = '10g High Velocity Sabot',
    [39] = '12x25mm Full Metal Jacket',
    [41] = '15x100mm High Explosive',
    [43] = '23mm HE Cannon',
    [47] = '15x100mm High Velocity',
    [48] = '10g Tri-Ball',
    [50] = '8x60mm Full Metal Jacket',
    [57] = '12x25mm Plasma',
    [58] = 'Large Plasma Bolt',
    [60] = '5.5x50mm Ripper',
    [61] = 'Flames',
    [67] = 'Nuke',
    [71] = 'Flames Mk2',
    [72] = 'Small Plasma Bolt',
    [73] = 'SEAF Artillery: Explosive',
    [74] = '23mm HE Cannon',
    [75] = '10g Magnum Triball',
    [76] = '110mm E.M.S. Cannon Round',
    [77] = '23mm HE Cannon',
    [78] = '9x20mm High Velocity',
    [79] = '23mm HE Cannon',
    [80] = 'Cluster Bomb',
    [82] = '380mm HE Cannon Round',
    [84] = '110mm Standard Rocket',
    [85] = '12.5mm Standard Rifle Rounds',
    [86] = '380mm HE Cannon Round',
    [87] = '40mm HEAT Grenade',
    [93] = '12g Bugshot',
    [94] = 'SEAF Artillery: Static Field',
    [95] = '380mm HE Cannon Round',
    [97] = '8x60mm Explosive',
    [98] = 'CLUSTER BOMB',
    [99] = '13x40mm Ripper',
    [101] = 'SEAF Artillery: Mini Nuke',
    [102] = '380mm HE Cannon Round',
    [103] = '8x60mm Devastator',
    [106] = '9x70mm Super Uranium Core',
    [107] = '12x25mm Hollow Point',
    [110] = '8x60mm Liberty Fire',
    [111] = '12x25mm Ripper',
    [112] = '75mm HEAT Grenade',
    [113] = '12.5mm EIT Rounds',
    [114] = '380mm HE Cannon Round',
    [115] = '15x100mm Emp-Rounds',
    [116] = '13x40mm Penetrator',
    [117] = '20mm APHET Rounds',
    [118] = '100kg Bomb Mk3',
    [119] = 'Shrapnel',
    [120] = '8x60mm Airburst',
    [122] = '40mm APHE Cannon',
    [125] = '12x25mm Full Metal Jacket',
    [128] = '20mm HVAP Rounds',
    [130] = '70mm Laser-Guided Missile',
    [131] = 'Volatile Plasma Bolt',
    [132] = '100kg Bomb',
    [133] = 'Cluster Bomb',
    [134] = '75mm HEAT Grenade',
    [135] = 'Laser',
    [136] = '9x70mm Self Propelled',
    [137] = '8x60mm Full Metal Jacket',
    [139] = '120mm HE Cannon Round',
    [141] = '5.5x50mm Subsonic',
    [143] = 'Napalm Bomb Mk2',
    [144] = 'Medium Plasma Bolt',
    [145] = 'Volatile Plasma Bolt',
    [146] = 'Laser',
    [147] = 'SEAF Artillery: Napalm',
    [148] = '110mm Standard Rocket',
    [149] = 'Contact Mine',
    [150] = '8x60mm Full Metal Jacket',
    [151] = 'Laser',
    [152] = '12x25mm Full Metal Jacket',
    [153] = '500kg Bomb Mk2',
    [155] = '85mm HEAT Grenade',
    [157] = 'Medium Plasma Bolt',
    [158] = '9x20mm Toxic',
    [160] = '110mm Airburst Cannon Round',
    [162] = '12g Magnum',
    [163] = '40mm Proximity Grenade',
    [164] = 'Napalm Bomb Mk3',
    [165] = '8x60mm Super Uranium Core',
    [166] = '8x60mm Full Metal Jacket',
    [167] = '9x20mm Full Metal Jacket',
    [168] = 'Large Plasma Bolt',
    [171] = '12x25mm High Velocity',
    [173] = '100kg Bomb',
    [174] = 'Small Plasma Bolt',
    [176] = '9x20mm Explosive',
    [177] = '12g Birdshot',
    [178] = '20mm HE Cannon',
    [180] = '15x100mm Standard Rocket',
    [182] = 'Laser',
    [183] = '12g Buckshot',
    [187] = '10g Flechettes',
    [189] = 'Laser',
    [190] = 'Railgun Round',
    [191] = 'Shrapnel',
    [193] = '5.5x50mm Super Uranium Core',
    [195] = '10g STUN ROUNDS',
    [196] = 'Large Plasma Bolt',
    [197] = '120mm HE Cannon Round',
    [200] = '110mm Gas Cannon Round',
    [202] = '10g Bugshot',
    [203] = '9x70mm Penetrator',
    [204] = 'Shrapnel',
    [205] = '15x100mm Standard Rocket',
    [207] = '12x25mm Toxic',
    [208] = '5.5x50mm Hollow-Point',
    [209] = '15x100mm High Explosive',
    [210] = '9x70mm Full Metal Jacket',
    [211] = '110mm E.M.S. Cannon Round Mk3',
    [212] = '40mm HE Mortar',
    [213] = 'Cluster Bomb',
    [214] = '8x60mm High Velocity',
    [215] = '8x60mm Double Power',
    [218] = '9x20mm Full Metal Jacket',
    [219] = '380mm HE Cannon Round',
    [220] = '10g Magnum',
    [221] = 'Railgun Stun Round',
    [222] = 'Laser',
    [223] = 'Homing Ground Missile Mk2',
    [224] = 'Small Plasma Bolt',
    [226] = 'Cluster Bomb',
    [227] = '20mm Flak Rounds',
    [229] = 'Homing Ground Missile',
    [230] = '12.5mm EIT Rounds',
    [231] = '12g Tri-Ball',
    [232] = 'High-Velocity Shrapnel',
    [234] = '12x25mm Explosive',
    [235] = '85mm HEAT Grenade Mk2',
    [236] = '10g Birdshot',
    [237] = 'Cluster Bomb',
    [238] = '120mm HE Cannon Round',
    [240] = 'Laser',
    [241] = '15x100mm Standard Rocket',
    [242] = '120mm HE Cannon Round',
    [243] = '500kg Bomb',
    [244] = '10g Rifled Slugs',
    [245] = '9x70mm High Velocity',
    [248] = '9x20mm Ripper',
    [249] = '66mm Missile',
    [254] = 'Flames',
    [255] = '12.5mm BCHP Rifle Rounds',
    [256] = '12g Scatter Shot',
    [258] = '23mm HE Cannon',
    [259] = '5.5x50mm Double Power',
    [261] = '15x100mm Fragmentation',
    [262] = '8x60mm Sniper Armour Piercing',
    [265] = '30mm APHE Cannon',
    [267] = '40mm HEAT Grenade',
    [268] = '9x70mm Sniper Armour Piercing',
    [269] = '12g Flechettes',
    [270] = '380mm HE Cannon Round',
    [276] = '66mm Missile Mk2',
    [277] = '12.5mm EIT Rounds',
    [278] = 'Laser',
    [280] = '12.5mm BCHP Rifle Rounds',
    [281] = '5.5x50mm Full Metal Jacket',
    [282] = 'Rail Cannon Round',
    [283] = '5.5x50mm Devastator',
    [285] = '40mm HE Grenade',
    [288] = '9x20mm Thermite',
    [289] = '20mm Flak Rounds',
    [290] = 'Large Plasma Bolt',
    [291] = '100kg Cluster Bomb',
    [292] = '12x25mm Thermite',
    [296] = '9x20mm Full Metal Jacket',
    [297] = '10g Liberty Fire',
    [298] = '500kg Bomb Mk3',
    [299] = '40mm Flak Cannon',
    [301] = 'Large Plasma Bolt',
    [302] = '40mm HE Grenade',
    [303] = 'Anti-Air Missile',
    [308] = '40mm HE Mortar',
    [309] = '70mm Standard Rocket',
    [310] = '9x70mm Full Metal Jacket',
    [311] = '8x60mm High Velocity',
    [312] = '12g Magnum Triball',
    [314] = '13x40mm Full Metal Jacket',
    [315] = '5.5x50mm Explosive',
    [317] = '20mm Flak Rounds',
    [318] = 'Napalm Bomb',
    [319] = '12g Liberty Fire',
    [325] = '70mm Standard Rocket',
    [326] = '5.5x50mm Self Propelled',
    [327] = '10g Fragmentation',
    [330] = '8x60mm Subsonic',
    [336] = '5.5x50mm Penetrator',
    [337] = '10g Dual Sabot',
    [338] = '8x60mm Penetrator',
    [341] = 'Homing Anti-Air Missile',
    [342] = '9x20mm Hollow Point',
    [343] = '100kg Bomb Mk2',
    [344] = 'SEAF Artillery: HIGH-YIELD EXPLOSIVE',
    [346] = 'Small Plasma Bolt',
    [350] = '5.5x50mm High Velocity',
    [351] = '40mm HE Mortar',
    [354] = '70mm Laser-Guided Missile Mk2',
    [355] = '85mm High-Explosive Grenade Mk2',
}
-- vehicle parts (damage zones): their names, by hash
MOD.vehicle_parts = {
    [0x04361A85] = 'Left box 0',
    [0x0A3AD217] = 'Right side panel 1',
    [0x2374EAE2] = 'Back periscope side 8',
    [0x2739DFAC] = 'Front right cockpit',
    [0x28B43F0A] = 'Right front block',
    [0x2BE9516E] = 'Right front light',
    [0x30A051A9] = 'Left rear door',
    [0x3EB413D8] = 'Right top block',
    [0x3F367765] = 'Left front block',
    [0x474C6747] = 'Left track',
    [0x4AD0B30A] = 'Right box 2',
    [0x5518D31D] = 'Left front door',
    [0x5BB4504C] = 'Left side panel 1',
    [0x64A3FA1D] = 'Left leg',
    [0x657FFA09] = 'Left front light',
    [0x668F6A68] = 'Hips',
    [0x67943A63] = 'Top right hatch',
    [0x6C73E136] = 'Right rear door',
    [0x6EAA2901] = 'Right mirror',
    [0x87B05FF4] = 'Right leg',
    [0x88638E96] = 'Top left hatch',
    [0x8BBF3B21] = 'Left mirror',
    [0x900F8255] = 'Right track',
    [0x91F0B029] = 'Right box 0',
    [0x924D58A6] = 'Bonnet',
    [0x9966C78E] = 'Left side panel 0',
    [0xA7DE41F3] = 'Right front door',
    [0xB01597A3] = 'Left box 2',
    [0xB28AF559] = 'Right back panel',
    [0xB8AD4E86] = 'Back door block',
    [0xC5327761] = 'Left back panel',
    [0xC61CD7B0] = 'Right side panel 0',
    [0xCA47A7A9] = 'Front left cockpit',
    [0xD67B6D46] = 'Front hull',
    [0xD7533836] = 'Right box 1',
    [0xE1B844F5] = 'Rear cockpit',
    [0xECD09CBC] = 'Antenna',
    [0xEE2D8C68] = 'Left top block',
    [0xF72A6714] = 'Left box 1',
    [0xFA833708] = 'Back hatch',
    [0xFD477E17] = 'Radar',
}
-- translations of the panel, by its English text (built from lang/*.json and the game's own names)
-- and the fonts to draw them with: { font, its glyph texture } resource ids, the first one loaded wins
MOD.langs = {
  { id = 'zh-Hans', name = '简体中文', list = '、',
    fonts = { { font = '160f67c841834f8d', atlas = '808957ab8b672904' }, { font = 'e01b1c60bb279a7c', atlas = '1a87fa21dafbd90e' } },
    exact = {
      ['"+ New preset" (or Insert) saves your current changes as one; you name it next.'] = '“+ 新建预设”（或 Insert 键）会把当前修改存为一组，接着你可以为它命名。',
      ['(Not Used) Additional Strafing Runs'] = '（未使用）额外机枪扫射',
      ['(Not Used) Air-TO-Air Missles'] = '（未使用）空对空导弹',
      ['+ Add passive'] = '+ 添加被动',
      ['+ Armor rating'] = '护甲值',
      ['+ Ergonomics'] = '人机工效',
      ['+ New preset from current changes'] = '从当前修改新建预设',
      ['+ Stamina when hit'] = '受击时耐力',
      ['+ Stim duration (s)'] = '治疗剂持续时间（秒）',
      ['+ Stims (start, max)'] = '治疗剂数量（初始 / 上限）',
      ['+ Throwables (start, max)'] = '投掷物数量（初始 / 上限）',
      ['- / + steps through the stratagems by name (-- / ++: 10 at a time).'] = '- / + 按名称切换战略配备（-- / ++ 每次切换 10 项）。',
      ['0 = normal projectile; - / + selects a throwable grenade by name above.'] = '0 = 常规弹丸；- / + 按上方名称选择投掷手雷。',
      ['0: hits deal their normal damage, 1: their durable damage (the weapon\'s lower one)'] = '0：按普通伤害计算；1：按耐久伤害计算；中间值按两者比例计算。',
      ['100kg Bomb'] = '100KG炸弹',
      ['100kg Bomb Mk2'] = '100KG炸弹 MK2',
      ['100kg Bomb Mk3'] = '100KG炸弹 MK3',
      ['100kg Cluster Bomb'] = '100KG集束炸弹',
      ['10g Birdshot'] = '10 号鸟弹',
      ['10g Buckshot'] = '10 号鹿弹',
      ['10g Bugshot'] = '10 号虫弹',
      ['10g Dual Sabot'] = '10 号双发脱壳弹',
      ['10g Flechettes'] = '10 号箭形弹',
      ['10g Fragmentation'] = '10 号破片弹',
      ['10g High Velocity Sabot'] = '10 号高速脱壳弹',
      ['10g Liberty Fire'] = '10 号“解放之火”霰弹',
      ['10g Magnum'] = '10 号马格南霰弹',
      ['10g Magnum Triball'] = '10 号马格南三连弹',
      ['10g Rifled Slugs'] = '10 号线膛独头弹',
      ['10g STUN ROUNDS'] = '10 号眩晕弹',
      ['10g Sabot'] = '10 号脱壳弹',
      ['10g Scatter Shot'] = '10 号散射弹',
      ['10g Stun'] = '10 号眩晕弹',
      ['10g Tri-Ball'] = '10 号三连弹',
      ['10g. Duckbill'] = '10 号鸭嘴枪口',
      ['10g. Full Choke'] = '10 号全喉缩',
      ['10g. Half Choke'] = '10 号半喉缩',
      ['110mm Airburst Cannon Round'] = '110mm空爆炮弹',
      ['110mm Airburst Cannon Round Mk2'] = '110mm空爆炮弹 MK2',
      ['110mm E.M.S. Cannon Round'] = '110mm电磁冲击波炮弹',
      ['110mm E.M.S. Cannon Round Mk2'] = '110mm电磁冲击波炮弹 MK2',
      ['110mm E.M.S. Cannon Round Mk3'] = '110mm电磁冲击波炮弹 MK3',
      ['110mm Gas Cannon Round'] = '110mm毒气炮弹',
      ['110mm Standard Rocket'] = '110mm标准火箭弹',
      ['110mm Standard Rocket Mk2'] = '110mm标准火箭弹 MK2',
      ['12.5mm BCHP Rifle Rounds'] = '12.5mm粘合弹芯空尖弹',
      ['12.5mm EIT Rounds'] = '12.5mm爆炸燃烧曳光弹',
      ['12.5mm Standard Rifle Rounds'] = '12.5mm标准步枪子弹',
      ['120mm HE Cannon Round'] = '120mm高爆炮弹',
      ['12g Birdshot'] = '12 号鸟弹',
      ['12g Buckshot'] = '12 号鹿弹',
      ['12g Bugshot'] = '12 号虫弹',
      ['12g Flechettes'] = '12 号箭形弹',
      ['12g Liberty Fire'] = '12 号“解放之火”霰弹',
      ['12g Magnum'] = '12 号马格南霰弹',
      ['12g Magnum Triball'] = '12 号马格南三连弹',
      ['12g Scatter Shot'] = '12 号散射弹',
      ['12g Tri-Ball'] = '12 号三连弹',
      ['12g. Duckbill'] = '12 号鸭嘴枪口',
      ['12g. Full Choke'] = '12 号全喉缩',
      ['12g. Half Choke'] = '12 号半喉缩',
      ['12mm. Compensator'] = '12mm. 补偿器',
      ['12mm. Flash Hider'] = '12mm. 消焰器',
      ['12mm. Muzzle break'] = '12mm. 枪口制退器',
      ['12x25mm Explosive'] = '12x25mm爆炸子弹',
      ['12x25mm Full Metal Jacket'] = '12x25mm全金属被甲弹',
      ['12x25mm High Velocity'] = '12x25mm高速弹',
      ['12x25mm Hollow Point'] = '12x25mm空尖弹',
      ['12x25mm Plasma'] = '12x25mm等离子弹',
      ['12x25mm Ripper'] = '12x25mm撕裂弹',
      ['12x25mm Thermite'] = '12x25mm铝热弹',
      ['12x25mm Toxic'] = '12x25mm毒弹',
      ['13x40mm Full Metal Jacket'] = '13x40mm全金属被甲弹',
      ['13x40mm Hollow Point'] = '13x40mm空尖弹',
      ['13x40mm Magnum'] = '13x40mm马格南子弹',
      ['13x40mm Penetrator'] = '13x40mm穿甲弹',
      ['13x40mm Ripper'] = '13x40mm撕裂弹',
      ['15x100mm Emp-Rounds'] = '15x100mm电磁脉冲弹',
      ['15x100mm Fragmentation'] = '15x100mm破片弹',
      ['15x100mm High Explosive'] = '15x100mm高爆弹',
      ['15x100mm High Velocity'] = '15x100mm高速弹',
      ['15x100mm Plasma'] = '15x100mm等离子弹',
      ['15x100mm Standard Rocket'] = '15x100mm标准火箭弹',
      ['15x100mm Thermite'] = '15x100mm铝热弹',
      ['15x100mm Toxic'] = '15x100mm毒弹',
      ['20mm APHET Rounds'] = '20mm穿甲高爆曳光弹',
      ['20mm Flak Rounds'] = '20mm 空爆炮弹',
      ['20mm HE Cannon'] = '20mm高爆炮弹',
      ['20mm HVAP Rounds'] = '20mm高速穿甲弹',
      ['23mm HE Cannon'] = '23mm高爆炮弹',
      ['30mm APHE Cannon'] = '30mm穿甲高爆炮弹',
      ['380mm HE Cannon Round'] = '380mm高爆炮弹',
      ['40-K Meltagun'] = '40-K 热熔枪',
      ['40mm APHE Cannon'] = '40mm穿甲高爆炮弹',
      ['40mm Flak Cannon'] = '40mm 空爆炮弹',
      ['40mm HE Grenade'] = '40mm高爆榴弹',
      ['40mm HE Mortar'] = '40mm高爆迫击炮弹',
      ['40mm HEAT Grenade'] = '40mm高爆反坦克榴弹',
      ['40mm Proximity Grenade'] = '40mm感应榴弹',
      ['5,5mm. Compensator'] = '5,5mm. 补偿器',
      ['5,5mm. Flash Hider'] = '5,5mm. 消焰器',
      ['5,5mm. Muzzle break'] = '5,5mm. 枪口制退器',
      ['5.5x50mm Devastator'] = '5.5x50mm“毁灭者”子弹',
      ['5.5x50mm Double Power'] = '5.5x50mm双效子弹',
      ['5.5x50mm Explosive'] = '5.5x50mm爆炸子弹',
      ['5.5x50mm Full Metal Jacket'] = '5.5x50mm全金属被甲弹',
      ['5.5x50mm High Velocity'] = '5.5x50mm高速弹',
      ['5.5x50mm Hollow-Point'] = '5.5x50mm空尖弹',
      ['5.5x50mm Penetrator'] = '5.5x50mm穿甲弹',
      ['5.5x50mm Ripper'] = '5.5x50mm撕裂弹',
      ['5.5x50mm Self Propelled'] = '5.5x50mm 自推进弹',
      ['5.5x50mm Subsonic'] = '5.5x50mm亚音速弹',
      ['5.5x50mm Super Uranium Core'] = '5.5x50mm超铀芯弹',
      ['500kg Bomb'] = '500KG炸弹',
      ['500kg Bomb Mk2'] = '500KG炸弹 MK2',
      ['500kg Bomb Mk3'] = '500KG炸弹 MK3',
      ['66mm Missile'] = '66mm导弹',
      ['66mm Missile Mk2'] = '66mm导弹 MK2',
      ['70mm Laser-Guided Missile'] = '70mm激光制导导弹',
      ['70mm Laser-Guided Missile Mk2'] = '70mm激光制导导弹 MK2',
      ['70mm Standard Rocket'] = '70mm标准火箭弹',
      ['75mm HEAT Grenade'] = '75mm高爆反坦克榴弹',
      ['85mm HEAT Grenade'] = '85mm高爆反坦克榴弹',
      ['85mm HEAT Grenade Mk2'] = '85mm高爆反坦克榴弹 MK2',
      ['85mm High-Explosive Grenade'] = '85mm高爆榴弹',
      ['85mm High-Explosive Grenade Mk2'] = '85mm高爆榴弹 MK2',
      ['8mm. Compensator'] = '8mm. 补偿器',
      ['8mm. Flash Hider'] = '8mm. 消焰器',
      ['8mm. Muzzle break'] = '8mm. 枪口制退器',
      ['8x60mm Airburst'] = '8x60mm空爆弹',
      ['8x60mm Devastator'] = '8x60mm“毁灭者”子弹',
      ['8x60mm Double Power'] = '8x60mm双效子弹',
      ['8x60mm Explosive'] = '8x60mm爆炸子弹',
      ['8x60mm Full Metal Jacket'] = '8x60mm全金属被甲弹',
      ['8x60mm High Velocity'] = '8x60mm高速弹',
      ['8x60mm Liberty Fire'] = '8x60mm“解放之火”子弹',
      ['8x60mm Penetrator'] = '8x60mm穿甲弹',
      ['8x60mm Sniper Armour Piercing'] = '8x60mm穿甲狙击弹',
      ['8x60mm Subsonic'] = '8x60mm亚音速弹',
      ['8x60mm Super Uranium Core'] = '8x60mm超铀芯弹',
      ['9mm. Compensator'] = '9mm. 补偿器',
      ['9mm. Flash Hider'] = '9mm. 消焰器',
      ['9mm. Muzzle break'] = '9mm. 枪口制退器',
      ['9x20mm Explosive'] = '9x20mm爆炸子弹',
      ['9x20mm Full Metal Jacket'] = '9x20mm全金属被甲弹',
      ['9x20mm High Velocity'] = '9x20mm高速弹',
      ['9x20mm Hollow Point'] = '9x20mm空尖弹',
      ['9x20mm Plasma'] = '9x20mm等离子弹',
      ['9x20mm Ripper'] = '9x20mm撕裂弹',
      ['9x20mm Thermite'] = '9x20mm铝热弹',
      ['9x20mm Toxic'] = '9x20mm毒弹',
      ['9x70mm Full Metal Jacket'] = '9x70mm全金属被甲弹',
      ['9x70mm High Velocity'] = '9x70mm高速弹',
      ['9x70mm Penetrator'] = '9x70mm穿甲弹',
      ['9x70mm Self Propelled'] = '9x70mm 自推进弹',
      ['9x70mm Sniper Armour Piercing'] = '9x70mm穿甲狙击弹',
      ['9x70mm Socom Assassin'] = '9x70mm“刺客”特种作战弹',
      ['9x70mm Super Uranium Core'] = '9x70mm超铀芯弹',
      ['A hellpod lands this many seconds plus its 4.75 s fall after the beacon, so 0 is the fastest it gets.'] = '空投舱落地用时为此倒计时加 4.75 秒下落时间，因此设为 0 时最快。',
      ['A mounted cannon with a seat, dropped by hellpod. Not the one you carry.'] = '带座位的固定火炮，由空投舱投送。不是你携带的那把。',
      ['A mounted copy aimed by AI. Not the one you carry.'] = '由 AI 瞄准的固定版本。不是你携带的那把。',
      ['A mounted copy run by AI (emplacement-style). Not the one you carry.'] = '由 AI 操作的固定版本（炮台式）。不是你携带的那把。',
      ['A mounted copy. Not the one you carry.'] = '固定版本。不是你携带的那把。',
      ['A preset keeps every change you have made as one set, under a name you choose.'] = '预设会把你所有的修改作为一组保存，并取一个你指定的名字。',
      ['A/AC-8 Autocannon Sentry'] = 'A/AC-8 自动哨戒炮',
      ['A/ARC-3 Tesla Tower'] = 'A/ARC-3 特斯拉塔',
      ['A/FLAM-40 Flame Sentry'] = 'A/FLAM-40 火焰喷射哨戒炮',
      ['A/G-16 Gatling Sentry'] = 'A/G-16 加特林哨戒炮',
      ['A/GM-17 Gas Mortar Sentry'] = 'A/GM-17 毒气迫击哨戒炮',
      ['A/LAS-98 Laser Sentry'] = 'A/LAS-98 激光哨戒炮',
      ['A/M-12 Mortar Sentry'] = 'A/M-12 迫击哨戒炮',
      ['A/M-23 EMS Mortar Sentry'] = 'A/M-23 电磁冲击波迫击哨戒炮',
      ['A/MG-43 Machine Gun Sentry'] = 'A/MG-43 哨戒机枪',
      ['A/MLS-4X Rocket Sentry'] = 'A/MLS-4X 火箭哨戒炮',
      ['AC-8 Autocannon'] = 'AC-8 机炮',
      ['AMMO'] = '弹药',
      ['AMW-20 Apex'] = 'AMW-20 尖峰',
      ['APW-1 Anti-Materiel Rifle'] = 'APW-1 反器材步枪',
      ['AR-11 Arbitrator'] = 'AR-11 仲裁者',
      ['AR-11 Arbitrator (underbarrel shotgun)'] = 'AR-11 仲裁者（下挂霰弹枪）',
      ['AR-2 Coyote'] = 'AR-2 野狼',
      ['AR-23 Liberator'] = 'AR-23 解放者',
      ['AR-23A Liberator Carbine'] = 'AR-23A “解放者”卡宾枪',
      ['AR-23C Liberator Concussive'] = 'AR-23C 震荡“解放者”',
      ['AR-23L Liberator Legacy'] = 'AR-23L “解放者”传承',
      ['AR-23P Liberator Penetrator'] = 'AR-23P 穿甲“解放者”',
      ['AR-32 Pacifier'] = 'AR-32 安抚者',
      ['AR-59 Suppressor'] = 'AR-59 消音器',
      ['AR-61 Tenderizer'] = 'AR-61 肉锤',
      ['AR/GL-21 One-Two'] = 'AR/GL-21 幺二',
      ['AR/GL-21 One-Two (grenade launcher)'] = 'AR/GL-21 幺二（下挂榴弹发射器）',
      ['ARC'] = '电弧',
      ['ARC-12 Blitzer'] = 'ARC-12 雷霆',
      ['ARC-3 Arc Thrower'] = 'ARC-3 电弧发射器',
      ['AX/AR-23 "Guard Dog"'] = 'AX/AR-23 “护卫犬”',
      ['AX/ARC-3 "Guard Dog" K-9'] = 'AX/ARC-3 “护卫犬” K-9',
      ['AX/FLAM-75 "Guard Dog" Hot Dog'] = 'AX/FLAM-75 “护卫犬”热狗',
      ['AX/LAS-5 "Guard Dog" Rover'] = 'AX/LAS-5 “护卫犬”漫游者',
      ['AX/TX-13 "Guard Dog" Dog Breath'] = 'AX/TX-13 “护卫犬”腐息',
      ['Acceleration (m/s2)'] = '加速度(米/秒^2)',
      ['Accelerator Rifle'] = '加速步枪',
      ['Acclimated'] = '应变自如',
      ['Acid'] = '酸液',
      ['Adjudicator'] = '审判者',
      ['Adreno-Defibrillator'] = '肾上腺素除颤器',
      ['Advanced Filtration'] = '高级过滤能力',
      ['Aiming sway'] = '瞄准晃动',
      ['Airburst Rocket Launcher'] = '空爆火箭弹发射器',
      ['Also includes'] = '同时包含',
      ['Alternate ammunition'] = '另一种弹药',
      ['Amendment'] = '修正',
      ['Ammo'] = '弹药',
      ['Ammo Cache'] = '弹药储备箱',
      ['Ammo at the start'] = '初始弹药',
      ['Ammo capacity'] = '弹药容量',
      ['Ammo carried'] = '携带弹药',
      ['Ammo from resupply'] = '补给箱补充弹药',
      ['Ammunition'] = '弹药',
      ['Angled Foregrip'] = '倾斜前握把',
      ['Angled Foregrip Advanced'] = '高级倾斜前握把',
      ['Angled Foregrip With Laser'] = '激光瞄准器与倾斜前握把',
      ['Another copy of this weapon, not identified yet.'] = '该武器的另一份副本，尚未识别。',
      ['Antenna'] = '天线',
      ['Anti-Air Missile'] = '防空导弹',
      ['Anti-Materiel Rifle'] = '反器材步枪',
      ['Anti-Personnel Mine Deployer'] = '反步兵布雷器',
      ['Anti-Tank Emplacement'] = '反坦克炮台',
      ['Anti-Tank Mine Deployer'] = '反坦克布雷器',
      ['Anti-Tank Seeker'] = '反坦克追踪者',
      ['Apex'] = '尖峰',
      ['Apply my changes'] = '应用我的修改',
      ['Approach distance (m)'] = '进场距离（米）',
      ['Arbitrator'] = '仲裁者',
      ['Arc'] = '电弧',
      ['Arc Thrower'] = '电弧发射器',
      ['Arc chain edits in multiplayer'] = '多人模式下修改电弧连锁',
      ['Arc chains'] = '电弧连锁',
      ['Arc chains use the game\'s values while other players are in your game (see Settings).'] = '对局中有其他玩家时，电弧连锁使用游戏原值（详见设置）。',
      ['Arc damage taken'] = '受到的电弧伤害',
      ['Arc splits'] = '电弧分裂',
      ['Arming distance (m)'] = '解除保险距离（米）',
      ['Arming time (s)'] = '解除保险时间（秒）',
      ['Armor'] = '护甲',
      ['Armor pen. (direct)'] = '穿甲等级（正面命中）',
      ['Armor pen. (extreme angle)'] = '穿甲等级（极端角度）',
      ['Armor pen. (large angle)'] = '穿甲等级（大角度）',
      ['Armor pen. (slight angle)'] = '穿甲等级（小角度）',
      ['Armors'] = '护甲',
      ['Ask'] = '询问',
      ['Assault Rifle'] = '突击步枪',
      ['Attachment'] = '配件',
      ['Attachments'] = '配件',
      ['Autocannon'] = '机炮',
      ['Autocannon Sentry'] = '自动哨戒炮',
      ['Automatic'] = '自动',
      ['B-1 Supply Pack'] = 'B-1 补给背包',
      ['B-100 Portable Hellbomb'] = 'B-100 便携式地狱火炸弹',
      ['B/FLAM-80 Cremator'] = 'B/FLAM-80 焚燃者',
      ['B/MD C4 Pack'] = 'B/MD C4背包',
      ['BACKPACK'] = '背包',
      ['BARRAGE'] = '弹幕',
      ['BLAST'] = '爆炸',
      ['BLAST RADIUS'] = '爆炸半径',
      ['BODY PARTS'] = '身体部位',
      ['BR-14 Adjudicator'] = 'BR-14 审判者',
      ['BURST'] = '二次爆炸',
      ['BURST RADIUS'] = '二次爆炸半径',
      ['Back'] = '返回',
      ['Back door block'] = '后舱门块',
      ['Back hatch'] = '后舱盖',
      ['Back periscope side 8'] = '潜望镜后侧 8',
      ['Background opacity'] = '背景不透明度',
      ['Backpack'] = '背包',
      ['Ballistic Padding'] = '防弹内衬',
      ['Ballistic Shield Backpack'] = '防弹护盾背包',
      ['Ballistic shield'] = '防弹盾',
      ['Barrage'] = '弹幕',
      ['Bastion MK XVI'] = '堡垒Mk XVI',
      ['Belt-Fed Grenade Launcher'] = '弹链式榴弹发射器',
      ['Bingus Shared Loader by CowboyBingus'] = 'Bingus 共享加载器 · CowboyBingus',
      ['Blast'] = '爆炸',
      ['Blast angle (deg)'] = '爆炸角(度)',
      ['Blast delay (s)'] = '起爆延迟（秒）',
      ['Blast proximity (m)'] = '近炸触发距离（米）',
      ['Blast radius'] = '爆炸半径',
      ['Blitzer'] = '雷霆',
      ['Block game input while open'] = '打开时屏蔽游戏输入',
      ['Blunt-Force Mitigation'] = '钝击创伤缓和',
      ['Body'] = '躯干',
      ['Body health'] = '躯干生命值',
      ['Body parts'] = '身体部位',
      ['Bolt Pistol'] = '爆弹手枪',
      ['Bonnet'] = '引擎盖',
      ['Boost after the launch (s)'] = '起跳后的推进时间（秒）',
      ['Breacher'] = '爆破者',
      ['Breaching Hammer'] = '破门锤',
      ['Break-Action Shotgun'] = '中折式霰弹枪',
      ['Breaker'] = '破裂者',
      ['Breaker Incendiary'] = '高燃“破裂者”',
      ['Breaker Spray&Pray'] = '千发百中“破裂者”',
      ['Breakthrough Exosuit'] = '“突破”外骨骼装甲',
      ['Bug Plug'] = '虫穴封堵装置',
      ['Bug Thumper'] = '虫群震动诱饵',
      ['Bullet Storm'] = '子弹风暴',
      ['Burn time (s)'] = '燃烧时间(秒)',
      ['Burning'] = '燃烧',
      ['Burning applied to you'] = '对你施加的燃烧',
      ['Burst'] = '二次爆炸',
      ['Burst radius'] = '二次爆炸半径',
      ['Bushwhacker'] = '游击兵',
      ['CB-9 Exploding Crossbow'] = 'CB-9 爆燃弩',
      ['CHARGE'] = '充能',
      ['CLUSTER BOMB'] = '集束炸弹',
      ['CQC-1 One True Flag'] = 'CQC-1 唯一真旗',
      ['CQC-19 Stun Lance'] = 'CQC-19 眩晕长矛',
      ['CQC-2 Saber'] = 'CQC-2 军刀',
      ['CQC-20 Breaching Hammer'] = 'CQC-20 破门锤',
      ['CQC-30 Stun Baton'] = 'CQC-30 眩晕短棍',
      ['CQC-42 Machete'] = 'CQC-42 砍刀',
      ['CQC-5 Combat Hatchet'] = 'CQC-5 战斗短柄斧',
      ['CQC-72 Entrenchment Tool'] = 'CQC-72 堑壕工具',
      ['CQC-73 Entrenchment Tool'] = 'CQC-73 堑壕工具',
      ['CQC-9 Defoliation Tool'] = 'CQC-9 除叶工具',
      ['Calibre (mm)'] = '口径(毫米)',
      ['Call IN Destroyer'] = '呼叫驱逐舰',
      ['Caltrops'] = '铁蒺藜',
      ['Camera shake radius (m)'] = '镜头震动半径(米)',
      ['Cancel'] = '取消',
      ['Cargo Container'] = '货运集装箱',
      ['Carpet Bombing Run'] = '地毯式轰炸',
      ['Carry Data'] = '运送数据',
      ['Censor'] = '审查官',
      ['Chain length'] = '连锁长度',
      ['Chain reaction delay (s)'] = '连锁延迟(秒)',
      ['Chain split'] = '连锁分裂',
      ['Changed since the last install: Install to put it in the game.'] = '自上次写入后已有修改：点击“写入游戏”使其生效。',
      ['Charge'] = '充能',
      ['Charge when it comes back'] = '恢复后初始充能',
      ['Charged'] = '蓄力',
      ['Charged explosion'] = '蓄力爆炸',
      ['Charged shot'] = '蓄力射击',
      ['Charges'] = '使用次数',
      ['Charges from resupply'] = '补给箱补充的使用次数',
      ['Chest bleeding damage'] = '胸部流血伤害',
      ['Chest damage taken'] = '受到胸部伤害',
      ['Choose a weapon on the left.'] = '请在左侧选择武器。',
      ['Clear'] = '清除',
      ['Click again to overwrite'] = '再次点击以覆盖',
      ['Climb acceleration'] = '爬升加速度',
      ['Climb multiplier (horizontal)'] = '枪口上扬倍率（水平）',
      ['Climb multiplier (vertical)'] = '枪口上扬倍率（垂直）',
      ['Climb speed (m/s)'] = '爬升速度(米/秒)',
      ['Climb time limit (s)'] = '爬升时限(秒)',
      ['Cluster Bomb'] = '集束炸弹',
      ['Combat Hatchet'] = '战斗短柄斧',
      ['Combat Scope 4x'] = '4倍战斗瞄准镜',
      ['Combat Walker'] = '战斗步行机甲',
      ['Combat Walker Breacher'] = '爆破型战斗机甲',
      ['Commando'] = '突击兵',
      ['Concealment when still, crouched / prone'] = '静止蹲伏或卧倒时的隐蔽',
      ['Concussive Padding (Grenadier)'] = '防震内衬（掷弹兵型）',
      ['Concussive Padding (Hazmat)'] = '防震内衬（防化型）',
      ['Concussive Padding (Reinforced)'] = '防震内衬（强化型）',
      ['Cone angle (deg)'] = '锥角(度)',
      ['Constitution'] = '宪法',
      ['Consumables'] = '消耗品',
      ['Contact Mine'] = '接触式地雷',
      ['Cookout'] = '野炊',
      ['Cool-down time after overheat (s)'] = '过热后冷却时间（秒）',
      ['Cool-down time, full heat (s)'] = '满热量冷却时间（秒）',
      ['Cooldown (s)'] = '冷却时间(秒)',
      ['Cooling (% per s)'] = '散热(每秒%)',
      ['Copy'] = '复制',
      ['Countdown before delivery (s)'] = '投送前倒计时（秒）',
      ['Coyote'] = '野狼',
      ['Cremator'] = '焚燃者',
      ['Crisper'] = '迅击',
      ['Crouched jog speed (m/s)'] = '蹲伏慢跑速度(米/秒)',
      ['Crouched speed while aiming (m/s)'] = '蹲伏瞄准时速度(米/秒)',
      ['Crouched sprint speed (m/s)'] = '蹲伏冲刺速度(米/秒)',
      ['Crouched walk speed (m/s)'] = '蹲伏步行速度(米/秒)',
      ['Cruise speed (m/s)'] = '巡航速度(米/秒)',
      ['Cyborg Carry Data'] = '运送生化人数据',
      ['DAMAGE'] = '伤害',
      ['DBS-2 Double Freedom'] = 'DBS-2 双重自由',
      ['DEPLOYER'] = '部署舱',
      ['DIRECT HIT'] = '直击',
      ['Dagger'] = '匕首',
      ['Damage'] = '伤害',
      ['Damage tick (s)'] = '伤害间隔(秒)',
      ['Damage to you'] = '对你造成的伤害',
      ['Dark Fluid Backpack'] = '暗液背包',
      ['Data Jack'] = '数据接口',
      ['De-Escalator'] = '缓和使者',
      ['Deadeye'] = '鹰眼',
      ['Defender'] = '防卫者',
      ['Defoliation Tool'] = '除叶工具',
      ['Delete'] = '删除',
      ['Democracy Protects'] = '民主护佑',
      ['Demolition force'] = '破坏力',
      ['Deployer'] = '部署舱',
      ['Desert Stormer'] = '沙漠突击者',
      ['Diligence'] = '勤勉',
      ['Diligence Counter Sniper'] = '反狙击“勤勉”',
      ['Direct hit'] = '直击',
      ['Directional Energy Shield'] = '定向能量护盾',
      ['Directional Shield'] = '定向护盾',
      ['Displacement Backpack'] = '传送背包',
      ['Dive cost (share of stamina)'] = '飞扑消耗(体力占比)',
      ['Dominator'] = '主宰',
      ['Double Freedom'] = '双重自由',
      ['Double-Edge Sickle'] = '双刃镰刀',
      ['Down'] = '下移',
      ['Drag factor'] = '阻力系数',
      ['Drilling Charge'] = '钻探炸药',
      ['Driver gun'] = '驾驶员机枪',
      ['Drone'] = '无人机',
      ['Drum Magazine'] = '弹鼓',
      ['Dune Walker Sniper Scope 10x'] = '10倍狙击瞄准镜',
      ['Duo Sniper Scope 10x'] = '“杜奥”10倍狙击瞄准镜',
      ['Durable damage'] = '耐久伤害',
      ['Durable ratio (0-1)'] = '耐伤比例(0-1)',
      ['Duration (s)'] = '持续时间(秒)',
      ['Dynamite'] = '炸药',
      ['E/AT-12 Anti-Tank Emplacement'] = 'E/AT-12 反坦克炮台',
      ['E/GL-21 Grenadier Battlement'] = 'E/GL-21 掷弹兵防卫墙',
      ['E/MG-101 HMG Emplacement'] = 'E/MG-101 重机枪部署支架',
      ['EAGLE'] = '飞鹰',
      ['EAT-17 Expendable Anti-Tank'] = 'EAT-17 消耗性反坦克武器',
      ['EAT-17 Expendable Anti-Tank (SEAF)'] = 'EAT-17 消耗性反坦克武器（SEAF）',
      ['EAT-411 Leveller'] = 'EAT-411 荡平者',
      ['EAT-700 Expendable Napalm'] = 'EAT-700 消耗性凝固汽油弹',
      ['EMS Mortar Sentry'] = '电磁冲击波迫击哨戒炮',
      ['EXO-45 Patriot Exosuit'] = 'EXO-45 “爱国者”外骨骼装甲',
      ['EXO-49 Emancipator Exosuit'] = 'EXO-49 “解放者”外骨骼装甲',
      ['EXO-51 Lumberer Exosuit'] = 'EXO-51 “伐木者”外骨骼装甲',
      ['EXO-55 Breakthrough Exosuit'] = 'EXO-55 “突破”外骨骼装甲',
      ['Each arm'] = '每条手臂',
      ['Each leg'] = '每条腿',
      ['Eagle'] = '飞鹰',
      ['Eagle 110mm Rocket Pods'] = '“飞鹰”110mm火箭巢',
      ['Eagle 500kg Bomb'] = '“飞鹰”500kg炸弹',
      ['Eagle Airstrike'] = '“飞鹰”空袭',
      ['Eagle Cluster Bomb'] = '“飞鹰”集束炸弹',
      ['Eagle Fly BY'] = '飞鹰低空通场',
      ['Eagle Gas Airstrike'] = '“飞鹰”毒气空袭',
      ['Eagle Napalm Airstrike'] = '“飞鹰”凝固汽油弹空袭',
      ['Eagle Smoke Strike'] = '“飞鹰”烟雾攻击',
      ['Eagle Strafing Run'] = '“飞鹰”机枪扫射',
      ['Eagle rearm time (s)'] = '飞鹰重新武装时间（秒）',
      ['Eagle strike. The rearm time is shared by every Eagle.'] = '飞鹰打击。所有飞鹰共用重新武装时间。',
      ['Edit the grenade on Throwables to tune it. Assets load before selection applies.'] = '在“投掷物”页编辑该手雷即可调整。资源加载完成后选择才会生效。',
      ['Electrical Conduit'] = '电路导管',
      ['Emancipator Exosuit'] = '“解放者”外骨骼装甲',
      ['Emergency Extraction Beacon'] = '紧急撤离信标',
      ['Emplacement'] = '炮台',
      ['Emplacement: its cooldown, its body, then its weapon.'] = '炮台：依次为冷却时间、本体、武器。',
      ['Emplacements'] = '部署设施',
      ['Enemy detection range'] = '敌人侦测范围',
      ['Engineering Kit'] = '工程包',
      ['Entrenchment Tool'] = '堑壕工具',
      ['Epoch'] = '纪元',
      ['Ergonomics'] = '人机工效',
      ['Ergonomics bonus'] = '人机工效加成',
      ['Eruptor'] = '爆裂铳',
      ['Every armor with this passive gets their effects too (set on their own pages).'] = '拥有此被动的所有护甲也会获得它们的效果（在各自页面设置）。',
      ['Every change as soon as it is pushed, before testing: it may break.'] = '每项更改一经推送即更新，未经测试：可能出错。',
      ['Every commit'] = '每次提交',
      ['Every helldiver in your game. Restore the game\'s files before joining other players\' lobbies.'] = '你游戏中的所有绝地潜兵。加入其他玩家的大厅前，请先恢复游戏文件。',
      ['Every passive is in already.'] = '所有被动都已添加。',
      ['Evictor'] = '驱逐者',
      ['Expendable Anti-Tank'] = '消耗性反坦克武器',
      ['Expendable Anti-Tank (Booster)'] = '消耗性反坦克武器（增强配备）',
      ['Expendable Napalm'] = '消耗性凝固汽油弹',
      ['Expiry explosion (id)'] = '存续结束时爆炸（编号）',
      ['Explodes after death (s)'] = '死亡后爆炸（秒）',
      ['Exploding Crossbow'] = '爆燃弩',
      ['Explosion'] = '爆炸',
      ['Explosion (expiry)'] = '爆炸（存续结束）',
      ['Explosion id'] = '爆炸编号',
      ['Explosive damage taken'] = '受到爆炸伤害',
      ['Extended Magazine'] = '加长弹匣',
      ['Extra Padding'] = '额外垫料',
      ['Extra stratagem'] = '额外战略配备',
      ['Extra stratagem (choice)'] = '额外战略配备（选择）',
      ['Extraction'] = '撤离',
      ['Extraction Beacon'] = '撤离信标',
      ['FAF-14 Spear'] = 'FAF-14 飞矛',
      ['FIRE'] = '开火',
      ['FLAM-40 Flamethrower'] = 'FLAM-40 火焰喷射器',
      ['FLAM-66 Torcher'] = 'FLAM-66 火炬手',
      ['Feet First'] = '护腿为上',
      ['Field depth (m)'] = '雷区纵深（米）',
      ['Field width (m)'] = '雷区宽度（米）',
      ['Finding the stats...'] = '正在查找数值...',
      ['Fire'] = '开火',
      ['Fire damage taken'] = '受到火焰伤害',
      ['Fire duration (s)'] = '持续开火时间（秒）',
      ['Fire panic'] = '着火恐慌',
      ['Fire rate (RPM)'] = '射速（RPM）',
      ['Fire/gas/acid/arc damage taken'] = '受到火焰 / 毒气 / 酸液 / 电弧伤害',
      ['Flame Sentry'] = '火焰喷射哨戒炮',
      ['Flames'] = '喷射火焰',
      ['Flames Mk2'] = '喷射火焰 MK2',
      ['Flamethrower'] = '火焰喷射器',
      ['Flamethrower slow'] = '火焰喷射减速',
      ['Flashlight'] = '照明',
      ['Flinch'] = '受击瞄准抖动',
      ['Flinch (0 prevents it)'] = '受击瞄准抖动（0 为免疫）',
      ['Folder'] = '文件夹',
      ['Folder path copied.'] = '已复制文件夹路径。',
      ['Fortified'] = '强化',
      ['Forward share of the launch (0-1)'] = '起跳前冲占比(0-1)',
      ['Found in the game data (not in the built-in list).'] = '在游戏数据中找到（不在内置列表中）。',
      ['Frag'] = '破片弹',
      ['From supply'] = '来自补给',
      ['Front hull'] = '前车体',
      ['Front left cockpit'] = '左前驾驶舱',
      ['Front right cockpit'] = '右前驾驶舱',
      ['Full charge'] = '充满',
      ['Full charge explosion'] = '满蓄力爆炸',
      ['Full charge shot'] = '满蓄力射击',
      ['Fuse time (s)'] = '引信时间(秒)',
      ['G-10 Incendiary'] = 'G-10 燃烧弹',
      ['G-109 Urchin'] = 'G-109 海胆',
      ['G-11 Caltrops'] = 'G-11 铁蒺藜',
      ['G-12 High Explosive'] = 'G-12 高爆弹',
      ['G-123 Thermite'] = 'G-123 铝热弹',
      ['G-13 Incendiary Impact'] = 'G-13 燃烧冲击弹',
      ['G-142 Pyrotech'] = 'G-142 烟花术',
      ['G-16 Impact'] = 'G-16 冲击弹',
      ['G-23 Stun'] = 'G-23 眩晕弹',
      ['G-3 Smoke'] = 'G-3 烟雾弹',
      ['G-31 Arc'] = 'G-31 电弧',
      ['G-4 Gas'] = 'G-4 毒气榴弹',
      ['G-48 Giga Grenade'] = 'G-48 千兆级榴弹',
      ['G-50 Seeker'] = 'G-50 寻踪者',
      ['G-6 Frag'] = 'G-6 破片弹',
      ['G-60 Anti-Tank Seeker'] = 'G-60 反坦克追踪者',
      ['G-7 Pineapple'] = 'G-7 菠萝',
      ['G-8 Immolation'] = 'G-8 焚身',
      ['G-89 Smokescreen'] = 'G-89 烟幕',
      ['G/40-K Melta Mine'] = 'G/40-K 热熔地雷',
      ['G/SH-39 Shield'] = 'G/SH-39 盾雷',
      ['GATER'] = 'GATER',
      ['GL-15 Evictor'] = 'GL-15 驱逐者',
      ['GL-21 Grenade Launcher'] = 'GL-21 榴弹发射器',
      ['GL-28 Belt-Fed Grenade Launcher'] = 'GL-28 弹链式榴弹发射器',
      ['GL-52 De-Escalator'] = 'GL-52 缓和使者',
      ['GP-20 Ultimatum'] = 'GP-20 最后通牒',
      ['GP-31 Grenade Pistol'] = 'GP-31 榴弹手枪',
      ['GR-8 Recoilless Rifle'] = 'GR-8 无后坐力炮',
      ['GRENADE SWAP'] = '手雷交换',
      ['Gallant'] = '英勇无畏',
      ['Gas'] = '毒气',
      ['Gas (Sterilizer)'] = '毒气（灭菌器）',
      ['Gas Mine Deployer'] = '毒气布雷器',
      ['Gas Mortar Sentry'] = '毒气迫击哨戒炮',
      ['Gas confusion'] = '毒气混乱',
      ['Gas confusion (Sterilizer)'] = '毒气混乱（灭菌器）',
      ['Gas damage taken'] = '受到毒气伤害',
      ['Gatling Sentry'] = '加特林哨戒炮',
      ['Generator'] = '发电机',
      ['Generator Pack'] = '护盾生成背包',
      ['Giga Grenade'] = '千兆级榴弹',
      ['GitHub'] = 'GitHub',
      ['GitHub link copied.'] = '已复制 GitHub 链接。',
      ['Gravity factor'] = '重力系数',
      ['Grenade'] = '手雷',
      ['Grenade Launcher'] = '榴弹发射器',
      ['Grenade Pistol'] = '榴弹手枪',
      ['Grenade fired (choice)'] = '发射手雷(选择)',
      ['Grenade selection takes priority over Projectile swap. Fire rate, ammo and handling stay.'] = '手雷选择优先于弹种交换。射速、弹药与操控保持不变。',
      ['Grenade swap'] = '手雷交换',
      ['Grenade swap stopped (see the log); launchers fire their own projectiles again.'] = '已停止榴弹替换（详见日志）；发射器恢复使用自身弹丸。',
      ['Grenadier Battlement'] = '掷弹兵防卫墙',
      ['Ground All-Terrain Extraction Rig (GATER)'] = '地面全地形采集钻机（GATER）',
      ['Guard Dog (Drone)'] = '护卫犬无人机',
      ['Guard Dog (Drone) Stun'] = '电击护卫犬无人机',
      ['Guard Dog Flamethrower (Drone)'] = '火焰护卫犬无人机',
      ['Guard Dog Gas Projector (Drone)'] = '毒气护卫犬无人机',
      ['Guidance on after (s)'] = '导引启动延迟(秒)',
      ['Gun'] = '枪械',
      ['Gunner FRV'] = '炮手快速侦察载具',
      ['Gunslinger'] = '神枪手',
      ['HANDLING'] = '操控',
      ['HMG Emplacement'] = '重机枪部署支架',
      ['Halt'] = '止息',
      ['Handling'] = '操控',
      ['Head'] = '头部',
      ['Head health'] = '头部生命值',
      ['Health'] = '生命值',
      ['Health Pack Rack'] = '医疗包架',
      ['Heat'] = '热量',
      ['Heat per second firing'] = '射击时每秒积热',
      ['Heat per shot'] = '每发积热',
      ['Heat per warp (%)'] = '每次跃迁热量（%）',
      ['Heatsinks from supply'] = '补给获得的散热器数',
      ['Heavy Machine Gun'] = '重机枪',
      ['Heavy burning'] = '重度燃烧',
      ['Hellbomb'] = '地狱火炸弹',
      ['Helldiver'] = '绝地潜兵',
      ['Helldivers 2 is running: close it first.'] = '《绝地潜兵 2》正在运行：请先关闭游戏。',
      ['Helldivers 2 is running: close it, then Install.'] = '《绝地潜兵 2》正在运行：请先关闭游戏，再点击“写入游戏”。',
      ['Helldivers 2 is running: close it, then restore.'] = 'Helldivers 2 正在运行：请先关闭游戏，再恢复。',
      ['Helldivers 2 is running: you can edit, but close it before you Install.'] = '《绝地潜兵 2》正在运行：可以编辑，但写入前必须关闭游戏。',
      ['High Capacity Heatsink'] = '高容量散热器',
      ['High Dissipation Heatsink'] = '高功率散热器',
      ['High Explosive'] = '高爆弹',
      ['High-Velocity Shrapnel'] = '高速破片',
      ['Hips'] = '腰部',
      ['Homing Anti-Air Missile'] = '追踪式防空导弹',
      ['Homing Ground Missile'] = '追踪式地面导弹',
      ['Homing Ground Missile Mk2'] = '追踪式地面导弹 MK2',
      ['Hot-Shot Marksman Rifle'] = '高能精确射手步枪',
      ['Hover Pack'] = '悬浮背包',
      ['Hover agility (acceleration)'] = '悬停敏捷度(加速度)',
      ['Hover pack'] = '悬浮背包',
      ['Hover speed (m/s)'] = '悬停速度(米/秒)',
      ['Hover time, full-speed climb (s)'] = '悬停时间：全速爬升(秒)',
      ['Hover time, holding height (s)'] = '悬停时间：保持高度(秒)',
      ['Hoverpack Backpack'] = '悬浮背包',
      ['How far away the jet starts its run. With its speed, it sets how long the Eagle takes to arrive.'] = '飞鹰开始攻击航线时距目标的距离，与飞行速度共同决定抵达时间。',
      ['Hyena'] = '鬣狗',
      ['Immediate Extraction Beacon'] = '立即撤离信标',
      ['Immolation'] = '焚身',
      ['Impact'] = '冲击弹',
      ['Impact damage taken'] = '受到冲击伤害',
      ['Impact explosion (id)'] = '命中爆炸 (ID)',
      ['Incendiary'] = '燃烧弹',
      ['Incendiary Impact'] = '燃烧冲击弹',
      ['Incendiary Mine Deployer'] = '燃烧布雷器',
      ['Incinerator FRV'] = '炽灼型快速侦察载具',
      ['Inflammable'] = '阻燃',
      ['Injures you above heat (%)'] = '超过此热量会灼伤(%)',
      ['Inner radius (m)'] = '内半径(米)',
      ['Install into the game'] = '写入游戏',
      ['Installing: finding what changed...'] = '写入中：正在查找改动…',
      ['Installing: writing the files...'] = '写入中：正在写入文件…',
      ['Integrated Explosives'] = '集成炸药',
      ['Interface language'] = '界面语言',
      ['Ion Scope 4x'] = '4倍离子瞄准镜',
      ['Iron Sights'] = '机械瞄具',
      ['Iron Sights Long'] = '长型机械瞄具',
      ['It doesn\'t take a loadout slot, but the HUD\'s stratagem list can fill up.'] = '不占配装栏位，但可能占满屏幕上的战略配备列表。',
      ['Its effects are added to every armor with this passive.'] = '其效果会添加到拥有此被动的所有护甲上。',
      ['Its stats above apply.'] = '上方的数值生效。',
      ['JAR-5 Dominator'] = 'JAR-5 主宰',
      ['Jammed Pinata'] = '受干扰的彩罐',
      ['Jog speed (m/s)'] = '慢跑速度(米/秒)',
      ['Jogging empties it in (s)'] = '慢跑耗尽用时(秒)',
      ['Jump Pack'] = '喷射背包',
      ['Jump cost (share of stamina)'] = '跳跃消耗(体力占比)',
      ['Jump pack'] = '喷射背包',
      ['Jumppack Backpack'] = '喷射背包',
      ['K-2 Throwing Knife'] = 'K-2 飞刀',
      ['Kinetic Displacement Mitigation'] = '动能位移减缓',
      ['Knight'] = '骑士',
      ['Knockdown chance'] = '击倒几率',
      ['LAS-12 Sai'] = 'LAS-12 钗',
      ['LAS-13 Trident'] = 'LAS-13“三叉戟”',
      ['LAS-16 Sickle'] = 'LAS-16 镰刀',
      ['LAS-17 Double-Edge Sickle'] = 'LAS-17 双刃镰刀',
      ['LAS-22 Shear'] = 'LAS-22 切变',
      ['LAS-44 Nova'] = 'LAS-44 新星',
      ['LAS-5 Scythe'] = 'LAS-5 长柄镰',
      ['LAS-58 Talon'] = 'LAS-58 猛爪',
      ['LAS-7 Dagger'] = 'LAS-7 匕首',
      ['LAS-98 Laser Cannon'] = 'LAS-98 激光大炮',
      ['LAS-98 Laser Cannon (crewed mount)'] = 'LAS-98 激光大炮（乘员炮座）',
      ['LAS-99 Quasar Cannon'] = 'LAS-99 类星体加农炮',
      ['LASER DAMAGE'] = '激光伤害',
      ['LIFT-182 Warp Pack'] = 'LIFT-182 传送背包',
      ['LIFT-850 Jump Pack'] = 'LIFT-850 喷射背包',
      ['LIFT-860 Hover Pack'] = 'LIFT-860 悬浮背包',
      ['Language'] = '语言',
      ['Large Plasma Bolt'] = '大型等离子弹',
      ['Larger Plasma Container'] = '扩容等离子弹药匣',
      ['Laser'] = '激光',
      ['Laser Cannon'] = '激光大炮',
      ['Laser Rifle (Drone)'] = '激光步枪无人机',
      ['Laser Sentry'] = '激光哨戒炮',
      ['Laser Sight'] = '激光瞄准器',
      ['Laser Sight Flashlight'] = '激光瞄准器带照明',
      ['Laser damage'] = '激光伤害',
      ['Laser. Blaster Focus'] = '激光：爆能聚焦',
      ['Laser. Charge Standard'] = '激光：标准充能',
      ['Laser. Standard Prism'] = '标准棱镜',
      ['Launch duration (s)'] = '起跳推进时间（秒）',
      ['Launch force'] = '起跳推力',
      ['Launch speed (m/s)'] = '发射速度（米/秒）',
      ['Left'] = '左',
      ['Left arm'] = '左臂',
      ['Left arm health'] = '左臂生命值',
      ['Left back panel'] = '左后板',
      ['Left box 0'] = '左储物箱 0',
      ['Left box 1'] = '左储物箱 1',
      ['Left box 2'] = '左储物箱 2',
      ['Left front block'] = '左前块',
      ['Left front door'] = '左前门',
      ['Left front light'] = '左前灯',
      ['Left leg'] = '左腿',
      ['Left leg health'] = '左腿生命值',
      ['Left mirror'] = '左后视镜',
      ['Left rear door'] = '左后门',
      ['Left side panel 0'] = '左侧板 0',
      ['Left side panel 1'] = '左侧板 1',
      ['Left top block'] = '左上块',
      ['Left track'] = '左履带',
      ['Leg injury immunity (1 on)'] = '免疫腿部受伤（1 为开启）',
      ['Leveller'] = '荡平者',
      ['Liberator'] = '解放者',
      ['Liberator Carbine'] = '“解放者”卡宾枪',
      ['Liberator Concussive'] = '震荡“解放者”',
      ['Liberator Legacy'] = '“解放者”传承',
      ['Liberator Penetrator'] = '穿甲“解放者”',
      ['Lifetime (s)'] = '存续时间(秒)',
      ['Limb health'] = '四肢生命值',
      ['Limb injury avoidance'] = '避免肢体受伤的几率',
      ['Load'] = '读取',
      ['Log file'] = '日志文件',
      ['Log file path copied.'] = '已复制日志文件路径。',
      ['Logs'] = '日志',
      ['Logs and Presets'] = '日志与预设',
      ['Loses its target past (deg)'] = '超出此角度丢失目标(度)',
      ['Loyalist'] = '忠诚者',
      ['Lumberer Exosuit'] = '“伐木者”外骨骼装甲',
      ['Lure Mine'] = '诱饵地雷',
      ['M-1000 Maxigun'] = 'M-1000 重装机枪',
      ['M-102 Gunner FRV'] = 'M-102 炮手快速侦察载具',
      ['M-103 Supply FRV'] = 'M-103 补给型快速侦察载具',
      ['M-104 Incinerator FRV'] = 'M-104 炽灼型快速侦察载具',
      ['M-105 Stalwart'] = 'M-105 盟友',
      ['M-105 Stalwart (mounted)'] = 'M-105 盟友（固定式）',
      ['M-105 Stalwart (mounted, AI-aimed 1)'] = 'M-105 盟友（固定式·AI 瞄准 1）',
      ['M-105 Stalwart (mounted, AI-aimed 2)'] = 'M-105 盟友（固定式·AI 瞄准 2）',
      ['M6C/SOCOM Pistol'] = 'M6C/SOCOM 手枪',
      ['M7S SMG'] = 'M7S 冲锋枪',
      ['M90A Shotgun'] = 'M90A 霰弹枪',
      ['MA5C Assault Rifle'] = 'MA5C 突击步枪',
      ['MG-206 Heavy Machine Gun'] = 'MG-206 重机枪',
      ['MG-206 Heavy Machine Gun (mounted B)'] = 'MG-206 重机枪（固定式 B）',
      ['MG-43 Machine Gun'] = 'MG-43 机枪',
      ['MG-43 Machine Gun (SEAF)'] = 'MG-43 机枪（SEAF）',
      ['MGX-42 Bullet Storm'] = 'MGX-42 子弹风暴',
      ['MINEFIELD'] = '雷区',
      ['MISSILE FLIGHT'] = '导弹飞行',
      ['MLS-4X Commando'] = 'MLS-4X 突击兵',
      ['MP-98 Knight'] = 'MP-98 骑士',
      ['MS-11 Solo Silo'] = 'MS-11 单兵导弹发射井',
      ['Machete'] = '砍刀',
      ['Machine Gun'] = '机枪',
      ['Machine Gun Sentry'] = '哨戒机枪',
      ['Machinegun'] = '机枪',
      ['Made by SHODAN'] = '作者 SHODAN',
      ['Maelstrom'] = '风暴漩涡',
      ['Magazine size'] = '弹匣容量',
      ['Magazines from supply'] = '补给获得的弹匣数',
      ['Main gun'] = '主炮',
      ['Marker radar scan every (s)'] = '标记雷达扫描间隔（秒）',
      ['Mass (kg)'] = '质量(千克)',
      ['Max carried'] = '最大携带',
      ['Max flight time (s)'] = '最大飞行时间(秒)',
      ['Max spare heatsinks'] = '备用散热器上限',
      ['Max spare magazines'] = '备用弹匣上限',
      ['Max spare rounds'] = '备用弹数上限',
      ['Max throw distance (m)'] = '最大投掷距离(米)',
      ['Maxigun'] = '重装机枪',
      ['Mechas'] = '载具',
      ['Med-Kit'] = '急救包',
      ['Medic Backpack'] = '医疗背包',
      ['Medium Plasma Bolt'] = '中型等离子弹',
      ['Melee damage'] = '近战伤害',
      ['Melta Mine'] = '热熔地雷',
      ['Meltagun'] = '热熔枪',
      ['Mid-air steering force'] = '空中转向力',
      ['Mine'] = '地雷',
      ['Mine explosion'] = '地雷爆炸',
      ['Minefield'] = '雷区',
      ['Mines deep'] = '纵向地雷排数',
      ['Mines per panel'] = '每批地雷数',
      ['Mines wide'] = '每行地雷数',
      ['Minimum speed (m/s)'] = '最低速度(米/秒)',
      ['Missile'] = '导弹',
      ['Missile Pistol'] = '制导手枪',
      ['Missile flight'] = '导弹飞行',
      ['Missions'] = '任务',
      ['Missions clan station'] = '空间站任务',
      ['Mist'] = '迷雾',
      ['Mobile Comms Relay'] = '移动通信中继器',
      ['Mortar Sentry'] = '迫击哨戒炮',
      ['Move while reloading'] = '换弹时可移动',
      ['Movement'] = '移动',
      ['Muzzle'] = '枪口',
      ['Muzzle brake'] = '枪口制退器',
      ['Napalm Bomb'] = '凝固汽油弹',
      ['Napalm Bomb Mk2'] = '凝固汽油弹 MK2',
      ['Napalm Bomb Mk3'] = '凝固汽油弹 MK3',
      ['No changes: loading it puts every value back to the game\'s.'] = '没有修改：读取它会把所有数值恢复为游戏原值。',
      ['No presets yet.'] = '还没有预设。',
      ['Noise'] = '噪音',
      ['None'] = '无',
      ['Normal projectile'] = '常规弹丸',
      ['Not offered by the game: a laser built on the Scythe. Settings: Unlock LAS-22 Shear.'] = '游戏本身未提供：基于“长柄镰”改造的激光武器。设置项：解锁 LAS-22 切变。',
      ['Not used by any weapon or stratagem in this list.'] = '本列表中的武器与战备都没有用到它。',
      ['Nothing matches.'] = '没有匹配项。',
      ['Nothing to install: your values are the game\'s own.'] = '无需写入：所有数值均为游戏原值。',
      ['Nova'] = '新星',
      ['Nuke'] = '核弹',
      ['OFFLINE  -  edits the game\'s files; they apply when the game starts'] = '离线  -  编辑游戏文件；游戏启动时生效',
      ['OK'] = '确定',
      ['ORBITAL BEAM'] = '轨道光束',
      ['Off'] = '关',
      ['Off: its stats above are left out; only the passives below apply.'] = '关闭：上方的数值不生效；只有下方的被动生效。',
      ['Off: the game\'s values everywhere; your '] = '关闭：全局使用游戏数值，你的',
      ['Off: with other players, arc chain length / split use the game\'s values (else arcs can stay on screen).'] = '关闭：多人对局时电弧连锁长度 / 分裂使用游戏数值（否则电弧可留在屏幕上）。',
      ['Oil Rig Extract'] = '石油钻井采集装置',
      ['Ombudsman'] = '巡察者',
      ['On'] = '开',
      ['On: a loadout can take more than one exosuit, FRV or tank.'] = '开启：单次配装可携带多台 外骨骼装甲、FRV 或坦克。',
      ['On: in your armory / stratagem list.'] = '开启：出现在你的军械库 / 战略配备列表中。',
      ['On: your '] = '开启：你的',
      ['On: your arc chain length / split apply with other players too (arcs can stay on screen).'] = '开启：你的电弧连锁长度 / 分裂对其他玩家同样生效（电弧可留在屏幕上）。',
      ['One True Flag'] = '唯一真旗',
      ['One-Two'] = '幺二',
      ['Open'] = '打开',
      ['Open / close key'] = '打开 / 关闭热键',
      ['Opened the GitHub page in your browser.'] = '已在浏览器中打开 GitHub 页面。',
      ['Opened the folder.'] = '已打开文件夹。',
      ['Opened the log folder.'] = '已打开日志文件夹。',
      ['Optic'] = '瞄具',
      ['Or type the number shown after a stratagem\'s name in the list; 0 = none.'] = '也可输入列表中战略配备名称后的编号；0 表示无。',
      ['Orbital'] = '轨道',
      ['Orbital 120mm HE Barrage'] = '轨道120mm高爆弹火力网',
      ['Orbital 380mm HE Barrage'] = '轨道380mm高爆弹火力网',
      ['Orbital Airburst Strike'] = '轨道空爆攻击',
      ['Orbital Confetti'] = '轨道彩纸礼花',
      ['Orbital EMS Strike'] = '轨道电磁冲击波攻击',
      ['Orbital Gas Strike'] = '轨道毒气攻击',
      ['Orbital Gatling Barrage'] = '轨道加特林火力网',
      ['Orbital Illumination Flare'] = '轨道照明弹',
      ['Orbital Laser'] = '轨道激光炮',
      ['Orbital Napalm Barrage'] = '轨道凝固汽油弹火力网',
      ['Orbital Precision Strike'] = '轨道精准攻击',
      ['Orbital Railcannon Strike'] = '轨道炮攻击',
      ['Orbital Smoke Strike'] = '轨道烟雾攻击',
      ['Orbital Walking Barrage'] = '轨道游走火力网',
      ['Orbital beam'] = '轨道光束',
      ['Orbital strike.'] = '轨道打击。',
      ['Other'] = '其他',
      ['Other players are in your game: arc chain length / split use the game\'s values.'] = '你的对局中存在其他玩家：电弧连锁长度 / 分裂将使用游戏数值。',
      ['Outer radius (m)'] = '外半径(米)',
      ['Overcharge limit (s)'] = '过载上限(秒)',
      ['Overheat threshold'] = '过热阈值',
      ['Own effects'] = '自身效果',
      ['Oxygenator'] = '供氧器',
      ['P-11 Stim Pistol'] = 'P-11 治疗剂手枪',
      ['P-113 Verdict'] = 'P-113 裁决',
      ['P-19 Redeemer'] = 'P-19 救世主',
      ['P-2 Peacemaker'] = 'P-2 和平制造者',
      ['P-33 Missile Pistol'] = 'P-33 制导手枪',
      ['P-34 Breacher'] = 'P-34 爆破者',
      ['P-35 Re-Educator'] = 'P-35 思想改造',
      ['P-4 Senator'] = 'P-4 参议员',
      ['P-41 Ombudsman'] = 'P-41 巡察者',
      ['P-41 Ombudsman (variant 2)'] = 'P-41 巡察者（变体 2）',
      ['P-44 Mist'] = 'P-44 迷雾',
      ['P-69 Veto'] = 'P-69 否决者',
      ['P-72 Crisper'] = 'P-72 迅击',
      ['P-92 Warrant'] = 'P-92 法令',
      ['P/40-K Bolt Pistol'] = 'P/40-K 爆弹手枪',
      ['PASSIVE'] = '被动',
      ['PLAS-1 Scorcher'] = 'PLAS-1 焦土',
      ['PLAS-101 Purifier'] = 'PLAS-101 净化者',
      ['PLAS-15 Loyalist'] = 'PLAS-15 忠诚者',
      ['PLAS-39 Accelerator Rifle'] = 'PLAS-39 加速步枪',
      ['PLAS-45 Epoch'] = 'PLAS-45 纪元',
      ['PRESETS'] = '预设',
      ['PROJECTILE'] = '弹丸',
      ['PROJECTILE SWAP'] = '弹种交换',
      ['Pacifier'] = '安抚者',
      ['Panel side'] = '面板位置',
      ['Panel size'] = '面板大小',
      ['Panels'] = '布雷批次数',
      ['Partial charge'] = '部分蓄力',
      ['Partial charge explosion'] = '部分蓄力爆炸',
      ['Partial charge shot'] = '部分蓄力射击',
      ['Passive'] = '被动',
      ['Patriot Exosuit'] = '“爱国者”外骨骼装甲',
      ['Peacemaker'] = '和平制造者',
      ['Peak Physique'] = '健壮体格',
      ['Pen.'] = '穿甲',
      ['Penetration slowdown'] = '穿透后速度衰减',
      ['Pineapple'] = '菠萝',
      ['Plasma Pistol. Canister Extended'] = '等离子手枪：扩容弹药罐',
      ['Plasma Pistol. Canister Pistol'] = '等离子手枪：标准弹药罐',
      ['Point of interest range'] = '兴趣点探测范围',
      ['Poison Drill'] = '毒剂钻探装置',
      ['Portable Hellbomb'] = '便携式地狱火炸弹',
      ['Position scatter (m)'] = '布雷位置随机偏移（米）',
      ['Presets'] = '预设',
      ['President rewards'] = '总统奖励',
      ['Press a key (Esc cancels)'] = '请按一个键(Esc 取消)',
      ['Press the key that should open and close the panel: F1-F12, Insert, Home, End, Pause or Scroll Lock. Esc cancels.'] = '请按下用于打开 / 关闭面板的按键：F1-F12、Insert、Home、End、Pause 或 Scroll Lock。Esc 取消。',
      ['Primary'] = '主武器',
      ['Primary reload speed'] = '主武器装填速度',
      ['Projectile'] = '弹丸',
      ['Projectile explosion id'] = '弹丸爆炸编号',
      ['Projectile fired (id)'] = '发射的弹丸(编号)',
      ['Projectile swap'] = '弹种交换',
      ['Projectiles per shot'] = '每次射击弹丸数',
      ['Prone speed (m/s)'] = '匍匐速度(米/秒)',
      ['Prospecting Drill'] = '勘探钻机',
      ['Punisher'] = '制裁者',
      ['Punisher Plasma'] = '等离子“制裁者”',
      ['Purifier'] = '净化者',
      ['Push force'] = '击退力',
      ['Pyrotech'] = '烟花术',
      ['Quasar Cannon'] = '类星体加农炮',
      ['R-2 Amendment'] = 'R-2 修正',
      ['R-2124 Constitution'] = 'R-2124 宪法',
      ['R-36 Eruptor'] = 'R-36 爆裂铳',
      ['R-4 Hyena'] = 'R-4 鬣狗',
      ['R-40 Sightliner'] = 'R-40 视界者',
      ['R-6 Deadeye'] = 'R-6 鹰眼',
      ['R-63 Diligence'] = 'R-63 勤勉',
      ['R-63CS Diligence Counter Sniper'] = 'R-63CS 反狙击“勤勉”',
      ['R-72 Censor'] = 'R-72 审查官',
      ['R/40-K Hot-Shot Marksman Rifle'] = 'R/40-K 高能精确射手步枪',
      ['RL-77 Airburst Rocket Launcher'] = 'RL-77 空爆火箭弹发射器',
      ['ROUND 1 BLAST'] = '第 1 发爆炸',
      ['ROUND 1 BLAST RADIUS'] = '第 1 发爆炸半径',
      ['ROUND 1 PROJECTILE'] = '第 1 发弹丸',
      ['ROUNDS 2, 3 BLAST RADIUS'] = '第 2、3 发爆炸半径',
      ['ROUNDS 2, 3 PROJECTILE'] = '第 2、3 发弹丸',
      ['ROUNDS 2, 3, 4 PROJECTILE'] = '第 2、3、4 发弹丸',
      ['RS-422 Railgun'] = 'RS-422 磁轨炮',
      ['Rack'] = '挂架',
      ['Radar'] = '雷达',
      ['Radius'] = '半径',
      ['Radius (m)'] = '半径(米)',
      ['Rail Cannon Round'] = '轨道炮弹',
      ['Railgun'] = '磁轨炮',
      ['Railgun Round'] = '磁轨炮弹',
      ['Railgun Stun Round'] = '磁轨炮眩晕弹',
      ['Raise Flag'] = '升旗',
      ['Raise Flag NO Clear Area'] = '升旗（无需清理区域）',
      ['Range'] = '射程',
      ['Range (m)'] = '射程(米)',
      ['Rapid Heatsink'] = '快速散热器',
      ['Re-Educator'] = '思想改造',
      ['Reach downward (m)'] = '向下触及(米)',
      ['Reach upward (m)'] = '向上触及(米)',
      ['Reading the game\'s weapon tables... ('] = '正在读取游戏武器表…（',
      ['Rear cockpit'] = '后驾驶舱',
      ['Recharge delay (s)'] = '重新充能延迟(秒)',
      ['Recharge delay once broken (s)'] = '破损后的充能延迟(秒)',
      ['Recharge rate (per s)'] = '充能速率(每秒)',
      ['Recharge time (s)'] = '充能时间(秒)',
      ['Recoil (horizontal)'] = '后坐力(水平)',
      ['Recoil (vertical)'] = '后坐力(垂直)',
      ['Recoil crouching / prone'] = '蹲姿 / 卧姿后坐力',
      ['Recoil multiplier (horizontal)'] = '后坐倍率(水平)',
      ['Recoil multiplier (vertical)'] = '后坐倍率(垂直)',
      ['Recoilless Rifle'] = '无后坐力炮',
      ['Records'] = '记录',
      ['Redeemer'] = '救世主',
      ['Reduced Signature'] = '隐迹潜踪',
      ['Refill starts after (s)'] = '开始恢复前延迟(秒)',
      ['Refills crouched in (s)'] = '蹲伏恢复用时(秒)',
      ['Refills prone in (s)'] = '卧倒恢复用时(秒)',
      ['Refills standing in (s)'] = '站立恢复用时(秒)',
      ['Regeneration (health/s)'] = '再生(生命/秒)',
      ['Regeneration delay after damage (s)'] = '受伤后再生延迟（秒）',
      ['Reinforced Epaulettes'] = '强化肩章',
      ['Reinforcement Beacon'] = '增援信标',
      ['Releases'] = '正式版',
      ['Reload allowed below (rounds)'] = '允许装填的剩余弹数上限',
      ['Reload time (s)'] = '装填时间（秒）',
      ['Reload time (s; 0 = animation length)'] = '装填时间（秒；0 = 动画时长）',
      ['Remember last tab and weapon'] = '记住上次的页签与武器',
      ['Remote Explosives'] = '遥控炸药',
      ['Remove'] = '移除',
      ['Rename'] = '重命名',
      ['Reprimand'] = '训斥',
      ['Reset all values'] = '重置全部数值',
      ['Reset helldiver'] = '重置潜兵',
      ['Reset passive'] = '重置被动',
      ['Reset record'] = '重置记录',
      ['Reset weapon'] = '重置武器',
      ['Resets all values from the current preset to default.'] = '将当前预设的全部数值恢复为默认值。',
      ['Restore the game\'s files'] = '恢复游戏原始文件',
      ['Restoring the game\'s files...'] = '正在恢复游戏原始文件...',
      ['Resupply'] = '重新补给',
      ['Rifle Justice. Short '] = '“正义”步枪：短弹匣',
      ['Right'] = '右',
      ['Right arm'] = '右臂',
      ['Right arm health'] = '右臂生命值',
      ['Right back panel'] = '右后板',
      ['Right box 0'] = '右储物箱 0',
      ['Right box 1'] = '右储物箱 1',
      ['Right box 2'] = '右储物箱 2',
      ['Right front block'] = '右前块',
      ['Right front door'] = '右前门',
      ['Right front light'] = '右前灯',
      ['Right leg'] = '右腿',
      ['Right leg health'] = '右腿生命值',
      ['Right mirror'] = '右后视镜',
      ['Right rear door'] = '右后门',
      ['Right side panel 0'] = '右侧板 0',
      ['Right side panel 1'] = '右侧板 1',
      ['Right top block'] = '右上块',
      ['Right track'] = '右履带',
      ['Rock Solid'] = '坚如磐石',
      ['Rocket Sentry'] = '火箭哨戒炮',
      ['Round 1 blast'] = '第 1 发爆炸',
      ['Round 1 blast radius'] = '第 1 发爆炸半径',
      ['Round 1 projectile'] = '第 1 发弹丸',
      ['Rounds 2, 3 blast radius'] = '第 2、3 发爆炸半径',
      ['Rounds 2, 3 projectile'] = '第 2、3 发弹丸',
      ['Rounds 2, 3, 4 projectile'] = '第 2、3、4 发弹丸',
      ['Rounds from supply'] = '补给获得的弹数',
      ['Rounds loaded'] = '已装填弹数',
      ['Rounds per reload'] = '每次装填弹数',
      ['Run length (m)'] = '攻击航线长度（米）',
      ['S-11 Speargun'] = 'S-11 矛枪',
      ['SEAF Artillery: Explosive'] = 'SEAF 火炮：高爆弹',
      ['SEAF Artillery: HIGH-YIELD EXPLOSIVE'] = 'SEAF 火炮：高当量爆炸弹',
      ['SEAF Artillery: Mini Nuke'] = 'SEAF 火炮：微型核弹',
      ['SEAF Artillery: Napalm'] = 'SEAF 火炮：凝固汽油弹',
      ['SEAF Artillery: Smoke'] = 'SEAF 火炮：烟雾弹',
      ['SEAF Artillery: Static Field'] = 'SEAF 火炮：静电场',
      ['SECOND MODE'] = '第二模式',
      ['SG-20 Halt'] = 'SG-20 止息',
      ['SG-22 Bushwhacker'] = 'SG-22 游击兵',
      ['SG-225 Breaker'] = 'SG-225 破裂者',
      ['SG-225IE Breaker Incendiary'] = 'SG-225IE 高燃“破裂者”',
      ['SG-225SP Breaker Spray&Pray'] = 'SG-225SP 千发百中“破裂者”',
      ['SG-451 Cookout'] = 'SG-451 野炊',
      ['SG-8 Punisher'] = 'SG-8 制裁者',
      ['SG-88 Break-Action Shotgun'] = 'SG-88 中折式霰弹枪',
      ['SG-8P Punisher Plasma'] = 'SG-8P 等离子“制裁者”',
      ['SG-8S Slugger'] = 'SG-8S 重炮手',
      ['SG-97 Sweeper'] = 'SG-97 扫荡者',
      ['SH-20 Ballistic Shield Backpack'] = 'SH-20 防弹护盾背包',
      ['SH-32 Shield Generator Pack'] = 'SH-32 防护罩生成包',
      ['SH-51 Directional Shield'] = 'SH-51 定向护盾',
      ['SHARED WITH'] = '共用',
      ['SHIELD'] = '护盾',
      ['SHODAN STAT EDITOR'] = 'SHODAN 数值编辑器',
      ['SHODAN weapon mods are running too: they put their own values back every 5 s'] = '检测到 SHODAN 武器 mod 同时运行：它们每 5 秒会把数值改回自己的设定',
      ['SHRAPNEL'] = '破片',
      ['SHRAPNEL BLAST RADIUS'] = '破片爆炸半径',
      ['SHRAPNEL DIRECT HIT'] = '破片直击',
      ['SHRAPNEL PROJECTILE'] = '破片弹丸',
      ['SILO'] = '发射井',
      ['SMG'] = '冲锋枪',
      ['SMG-203 Gallant'] = 'SMG-203 英勇无畏',
      ['SMG-32 Reprimand'] = 'SMG-32 训斥',
      ['SMG-37 Defender'] = 'SMG-37 防卫者',
      ['SMG-37 Defender (SEAF)'] = 'SMG-37 防卫者（SEAF）',
      ['SMG-72 Pummeler'] = 'SMG-72 暴击斗士',
      ['SMG/FLAM-34 Stoker'] = 'SMG/FLAM-34 司炉者',
      ['SMG/FLAM-34 Stoker (underbarrel flamer)'] = 'SMG/FLAM-34 司炉者（下挂喷火器）',
      ['STRATAGEM'] = '战略配备',
      ['Safe below heat (%)'] = '安全热量(%)',
      ['Sai'] = '钗',
      ['Salvos'] = '齐射次数',
      ['Save'] = '保存',
      ['Save current changes here'] = '在此保存当前修改',
      ['Scorcher'] = '焦土',
      ['Scout'] = '侦察',
      ['Scrambler'] = '扰频器',
      ['Scythe'] = '长柄镰',
      ['Seaf Gun'] = 'SEAF 火炮',
      ['Seaf Squad'] = 'SEAF 小队',
      ['Search radius (m)'] = '搜索半径(米)',
      ['Search weapons and stratagems'] = '搜索武器与战略配备',
      ['Second ammo'] = '第二弹种',
      ['Second mode'] = '第二模式',
      ['Second mode explosion'] = '第二模式爆炸',
      ['Second mode fires (id)'] = '第二模式发射的弹丸(编号)',
      ['Secondary'] = '副武器',
      ['Secondary draw speed'] = '副武器拔出速度',
      ['Secondary recoil'] = '副武器后坐力',
      ['Secondary reload speed'] = '副武器装填速度',
      ['Seeker'] = '寻踪者',
      ['Seismic Probe'] = '地震探针',
      ['Senator'] = '参议员',
      ['Sentry'] = '哨戒炮',
      ['Sentry: its cooldown, its body, then its weapon.'] = '哨戒炮：依次为冷却时间、本体、武器。',
      ['Servo-Assisted'] = '伺服辅助',
      ['Settings'] = '设置',
      ['Settings are saved at once, in config.txt with your changes.'] = '设置会与你的修改一并即时保存到 config.txt。',
      ['Several vehicles of a kind'] = '同类载具数量',
      ['Shape'] = '形状',
      ['Shared by every armor with this passive. Multipliers: 1 = no change.'] = '所有带此被动的护甲共用。倍率：1 = 不变。',
      ['Shear'] = '切变',
      ['Shells per salvo'] = '每次齐射弹数',
      ['Shield'] = '盾雷',
      ['Shield Generator Pack'] = '防护罩生成包',
      ['Shield Generator Relay'] = '防护罩生成中继器',
      ['Shield capacity'] = '护盾容量',
      ['Shield emitter'] = '护盾发生器',
      ['Ship upgrades that make support weapons and sentries launch at once skip it (tested).'] = '让支援武器和哨戒炮立即发射的舰船升级会跳过此倒计时（已由作者测试）。',
      ['Shockwave radius (m)'] = '冲击波半径(米)',
      ['Short Magazine'] = '短弹匣',
      ['Shoulder Mounted Camera'] = '肩载摄像机',
      ['Shrapnel'] = '破片',
      ['Shrapnel blast radius'] = '破片爆炸半径',
      ['Shrapnel direct hit'] = '破片直击',
      ['Shrapnel explosion'] = '破片爆炸',
      ['Shrapnel pieces'] = '破片数量',
      ['Shrapnel projectile'] = '破片弹丸',
      ['Shrapnel projectile (id)'] = '破片弹丸（编号）',
      ['Sickle'] = '镰刀',
      ['Siege-Ready'] = '蓄势出击',
      ['Sightliner'] = '视界者',
      ['Silo'] = '发射井',
      ['Simo Iron Sights'] = '“西莫”机械瞄具',
      ['Slide speed / duration'] = '滑行速度 / 持续时间',
      ['Slugger'] = '重炮手',
      ['Small Plasma Bolt'] = '小型等离子弹',
      ['Smoke'] = '烟雾弹',
      ['Smokescreen'] = '烟幕',
      ['Sniper Scope 10x'] = '10倍狙击瞄准镜',
      ['Sniper Scope 10x Helghast'] = '10倍狙击瞄准镜',
      ['Solo Silo'] = '单兵导弹发射井',
      ['Sos Beacon'] = '求救信标',
      ['Spear'] = '飞矛',
      ['Speargun'] = '矛枪',
      ['Speed until it has fired (m/s)'] = '开火前飞行速度（米/秒）',
      ['Speed while aiming (m/s)'] = '瞄准时速度(米/秒)',
      ['Spire Sterilizer'] = '尖塔灭菌器',
      ['Spotting range (m)'] = '索敌距离(米)',
      ['Spread (horizontal)'] = '散布(水平)',
      ['Spread (vertical)'] = '散布(垂直)',
      ['Spread area (m)'] = '散布范围(米)',
      ['Spread multiplier (horizontal)'] = '散布倍率(水平)',
      ['Spread multiplier (vertical)'] = '散布倍率(垂直)',
      ['Sprint speed (m/s)'] = '冲刺速度(米/秒)',
      ['Sprint speed, out of stamina (m/s)'] = '体力耗尽时的冲刺速度(米/秒)',
      ['Sprinting empties it in (s)'] = '冲刺耗尽用时(秒)',
      ['StA-11 SMG'] = 'StA-11 冲锋枪',
      ['StA-52 Assault Rifle'] = 'StA-52 突击步枪',
      ['StA-X3 W.A.S.P. Launcher'] = 'StA-X3 W.A.S.P.发射器',
      ['Stage '] = '阶段 ',
      ['Stagger force'] = '硬直力',
      ['Stalwart'] = '盟友',
      ['Stamina'] = '体力',
      ['Standard Drum'] = '标准弹鼓',
      ['Standard Heatsink'] = '标准散热器',
      ['Standard Plasma Container'] = '标准等离子弹药匣',
      ['Starting charges'] = '初始使用次数',
      ['Starting count'] = '初始数量',
      ['Starting heatsinks'] = '初始备用散热器数',
      ['Starting magazines'] = '初始备用弹匣数',
      ['Starting rounds'] = '初始备用弹数',
      ['Starts at heat'] = '初始热量',
      ['Stationary Shroud'] = '静止隐匿',
      ['Status'] = '状态',
      ['Status effects'] = '状态效果',
      ['Stim Pistol'] = '治疗剂手枪',
      ['Stoker'] = '司炉者',
      ['Stops you while firing'] = '开火时锁定移动',
      ['Stratagem'] = '战略配备',
      ['Stratagems'] = '战略配备',
      ['Stun'] = '眩晕',
      ['Stun (large)'] = '眩晕（大）',
      ['Stun (massive)'] = '眩晕（极大）',
      ['Stun (medium)'] = '眩晕（中）',
      ['Stun (small)'] = '眩晕（小）',
      ['Stun Baton'] = '眩晕短棍',
      ['Stun Lance'] = '眩晕长矛',
      ['Stun rounds'] = '眩晕弹',
      ['Stun rounds fire (id)'] = '眩晕弹发射的弹丸（编号）',
      ['Supplementary Adrenaline'] = '肾上腺素补充剂',
      ['Supply Backpack'] = '补给背包',
      ['Supply FRV'] = '补给型快速侦察载具',
      ['Supply Pack'] = '补给背包',
      ['Support'] = '支援武器',
      ['Support reload speed'] = '支援武器装填速度',
      ['Support weapon drop; the weapon itself is under Support.'] = '支援武器空投；武器本身列在“支援武器”分类下。',
      ['Suppressor'] = '消音器',
      ['Sure?'] = '确定？',
      ['Surviving lethal damage'] = '致命伤害存活几率',
      ['Swapping makes the shot the chosen weapon\'s, your edits to it included: damage,'] = '替换后使用所选武器的弹丸，包含你对其伤害、',
      ['Sway multiplier'] = '晃动系数',
      ['Sweeper'] = '扫荡者',
      ['Swim speed (m/s)'] = '游泳速度(米/秒)',
      ['TCS 03 Thumper'] = 'TCS 03 震动装置',
      ['TD-110 Maelstrom'] = 'TD-110 风暴漩涡',
      ['TD-220 Bastion MK XVI'] = 'TD-220 堡垒MK XVI',
      ['TED-63 Dynamite'] = 'TED-63 炸药',
      ['THROWABLE'] = '投掷物',
      ['TM-1 Lure Mine'] = 'TM-1 诱饵地雷',
      ['TX-41 Sterilizer'] = 'TX-41 灭菌器',
      ['Tabs shown'] = '显示的标签页',
      ['Talon'] = '猛爪',
      ['Tank'] = '坦克',
      ['Tank Reload AT'] = '坦克反坦克弹补给',
      ['Tank Reload Canister'] = '坦克霰弹补给',
      ['Tank Reload HE'] = '坦克高爆弹补给',
      ['Target search interval, max (s)'] = '索敌间隔，最大（秒）',
      ['Target search interval, min (s)'] = '索敌间隔，最小（秒）',
      ['Team weapons'] = '小队武器',
      ['Tenderizer'] = '肉锤',
      ['Tesla Tower'] = '特斯拉塔',
      ['Tested releases only.'] = '仅限经过测试的正式版。',
      ['That did not work; see the log.'] = '操作失败，请查看日志。',
      ['That would make a loop of extra stratagems.'] = '此选择会使额外战略配备形成循环。',
      ['The Arbitrator\'s underbarrel shotgun, not the rifle itself.'] = '“仲裁者”的下挂霰弹枪，不是步枪本身。',
      ['The Defender SEAF soldiers carry. Not yours.'] = 'SEAF 士兵携带的“防卫者”。不是你的那把。',
      ['The EAT-17 SEAF soldiers carry. Not yours.'] = 'SEAF 士兵携带的 EAT-17。不是你的那把。',
      ['The MG-43 SEAF soldiers carry. Not yours.'] = 'SEAF 士兵携带的 MG-43。不是你的那把。',
      ['The One-Two\'s underbarrel launcher, not the rifle. Fires the GP-31\'s grenade.'] = '“幺二”的下挂发射器，不是步枪本身。发射 GP-31 的榴弹。',
      ['The SMG you carry. Its underbarrel flamer is listed separately.'] = '你携带的冲锋枪。其下挂火焰喷射器单独列出。',
      ['The Scythe you carry.'] = '你携带的“长柄镰”。',
      ['The Stoker\'s underbarrel flamer, not the SMG itself.'] = '“司炉者”的下挂火焰喷射器，不是冲锋枪本身。',
      ['The armor passives could not be stacked'] = '无法叠加护甲被动',
      ['The beacon\'s countdown before the delivery is sent.'] = '信标启动后、开始投送前的倒计时。',
      ['The beacon\'s timer still counts down the usual time (tested).'] = '信标仍显示原本的倒计时（已由作者测试）。',
      ['The charge backpack, the charge and its blast. Cooldown: Stratagems tab.'] = '炸药背包、炸药包及其爆炸。冷却时间见“战略配备”页。',
      ['The flamethrower you carry.'] = '你携带的火焰喷射器。',
      ['The game holds at most 2048 rounds in a magazine.'] = '游戏中一个弹匣最多容纳 2048 发。',
      ['The game\'s own files are already in place.'] = '当前已是游戏原始文件。',
      ['The game\'s own files are back. Your values stay saved here (Install puts them in again).'] = '已恢复游戏原始文件。你的数值仍保存在此，点击“写入游戏”可再次写入。',
      ['The game\'s own files are in place. Close the game, then Install to play with your values.'] = '当前为游戏原始文件。关闭游戏后点击“写入游戏”，即可使用修改后的数值。',
      ['The one you carry.'] = '你携带的那一把。',
      ['The one you carry. The CQC-20 Breaching Hammer is listed under Support.'] = '你携带的那一把。CQC-20 破拆锤列在“支援武器”下。',
      ['The one you carry. The CQC-72 support version is listed under Support.'] = '你携带的那一把。CQC-72 支援版本列在“支援武器”下。',
      ['The pistol you carry. The One-Two\'s launcher is listed under the One-Two.'] = '你携带的手枪。“幺二”的发射器列在“幺二”下。',
      ['The recharge time is 0: set it above 0 first.'] = '充能时间为 0：请先设为大于 0 的值。',
      ['The rifle you carry. The grenade launcher is listed separately.'] = '你携带的步枪。榴弹发射器单独列出。',
      ['The rifle you carry. The underbarrel shotgun is listed separately.'] = '你携带的步枪。下挂霰弹枪单独列出。',
      ['The support hammer delivered by hellpod. The game data files it next to the Machete.'] = '由空投舱投送的支援锤。游戏数据将它列在砍刀旁边。',
      ['The support weapon. The CQC-73 is listed under Secondary.'] = '支援武器。CQC-73 列在“副武器”下。',
      ['Thermite'] = '铝热弹',
      ['Throw range'] = '投掷距离',
      ['Throw spread (degrees)'] = '投掷散布(度)',
      ['Throw velocity, max (m/s)'] = '投掷速度上限(米/秒)',
      ['Throw velocity, min (m/s)'] = '投掷速度下限(米/秒)',
      ['Throwable'] = '投掷物',
      ['Throwable launching is supported in solo missions only.'] = '发射投掷物仅支持单人任务。',
      ['Throwables'] = '投掷物',
      ['Throwing Knife'] = '飞刀',
      ['Time between bombs (s)'] = '投弹间隔(秒)',
      ['Time between salvos (s)'] = '齐射间隔(秒)',
      ['Time between shells (s)'] = '炮弹发射间隔（秒）',
      ['Top left hatch'] = '左上舱盖',
      ['Top right hatch'] = '右上舱盖',
      ['Torcher'] = '火炬手',
      ['Tracer rounds'] = '曳光弹',
      ['Tracking speed'] = '跟踪速度',
      ['Trigger delay (s)'] = '触发延迟(秒)',
      ['True Grit'] = '坚韧不拔',
      ['Tube Reddot 2x'] = '2倍红点瞄准镜',
      ['Tube Reddot 2x Legacy'] = '旧式2倍管状红点瞄准镜',
      ['Turn speed at cruise'] = '巡航转向速率',
      ['Turn speed at slowest'] = '最慢转向速率',
      ['Turn speed, horizontal (deg/s)'] = '转向速度，水平（度/秒）',
      ['Turn speed, vertical (deg/s)'] = '转向速度，垂直（度/秒）',
      ['Turret'] = '炮塔',
      ['Tutorial Reinforcement Beacon'] = '教学增援信标',
      ['Type the name: Enter keeps it, Esc cancels. The game sees these keys too, so name presets from a menu.'] = '输入预设名称：Enter 确认，Esc 取消。',
      ['Type the percent (%d-%d): Enter sets it, Esc cancels.'] = '输入百分比(%d-%d)：回车确认，Esc 取消。',
      ['Type the value: Enter sets it, Esc cancels. Values out of range are set to the nearest allowed one.'] = '输入数值：回车确认，Esc 取消。超出范围的数值会取最接近的合法值。',
      ['Type to search: Enter keeps the results, Esc clears the search. The game sees these keys too.'] = '输入搜索内容：Enter 保留结果，Esc 清空搜索。',
      ['Ultimatum'] = '最后通牒',
      ['Uncharged'] = '未蓄力',
      ['Uncharged explosion'] = '未蓄力爆炸',
      ['Uncharged shot'] = '未蓄力射击',
      ['Underbarrel'] = '下挂',
      ['Unflinching'] = '毫不畏缩',
      ['Unlock unused items'] = '解锁未使用物品',
      ['Unnamed explosion'] = '未命名爆炸',
      ['Unnamed projectile'] = '未命名弹丸',
      ['Unnamed status effect'] = '未命名状态效果',
      ['Unsafe warp: damage to you'] = '不安全跃迁：对你造成的伤害',
      ['Unsafe warp: explosion'] = '不安全跃迁：爆炸',
      ['Up'] = '上移',
      ['Up/Down choose a stat, Left/Right change it (Shift: bigger steps), click a value or press Enter to type it,'] = '上下键选择数值项，左右键调整（Shift 为大步长），点击数值或按回车直接输入，',
      ['Up/Down choose, Enter loads, Insert makes a new one, Shift+Insert saves into it, F2 renames, Del deletes.'] = '上下键选择，回车读取，Insert 新建，Shift+Insert 存入当前预设，F2 重命名，Del 删除。',
      ['Update channel'] = '更新渠道',
      ['Updates'] = '更新',
      ['Upload Discovery'] = '上传发现',
      ['Urchin'] = '海胆',
      ['Uses per mission'] = '每次任务使用次数',
      ['Uses per rearm'] = '每次重新武装后的可用次数',
      ['VEHICLE'] = '载具',
      ['VG-70 Variable'] = 'VG-70 变数',
      ['Variable'] = '变数',
      ['Vehicle'] = '载具',
      ['Vehicle. The weapons it carries are listed under it.'] = '载具。其搭载的武器列在它下方。',
      ['Velocity'] = '初速',
      ['Velocity (m/s)'] = '初速(米/秒)',
      ['Verdict'] = '裁决',
      ['Vertical Grip'] = '垂直前握把',
      ['Vertical Grip 45 Degree'] = '45度垂直前握把',
      ['Vertical Grip Advanced'] = '高级垂直前握把',
      ['Vertical Grip Flashlight'] = '垂直前握把带照明',
      ['Veto'] = '否决者',
      ['Volatile Plasma Bolt'] = '不稳定等离子弹',
      ['W.A.S.P. Launcher'] = 'W.A.S.P.发射器',
      ['WEAPON STATS'] = '武器数值',
      ['WIND-UP'] = '转管加速',
      ['Walk / run speed'] = '行走 / 奔跑速度',
      ['Walk speed (m/s)'] = '步行速度(米/秒)',
      ['Walking Barrage Smoke'] = '移动弹幕烟雾',
      ['Walking backwards (multiplier)'] = '后退行走(倍率)',
      ['Walking speed (m/s)'] = '弹幕推进速度（米/秒）',
      ['Warp Pack'] = '传送背包',
      ['Warp distance (m)'] = '跃迁距离(米)',
      ['Warp pack'] = '传送背包',
      ['Warrant'] = '法令',
      ['Weapon stats'] = '武器数值',
      ['Wind-down time (s)'] = '转管减速时间（秒）',
      ['Wind-down time, released (s)'] = '松开扳机后减速时间（秒）',
      ['Wind-up'] = '转管加速',
      ['Wind-up time (s)'] = '转管加速时间（秒）',
      ['Your changes are off: turn them on in Settings to edit.'] = '你的改动当前处于关闭状态：请在设置里开启后再编辑。',
      ['Your changes are off: turn them on in Settings to load a preset'] = '你的修改已关闭：请在设置中开启后再读取预设',
      ['Your values are not in the game yet: close the game, then Install.'] = '修改尚未写入游戏：请先关闭游戏，再点击“写入游戏”。',
      ['[Tutorial] Extraction'] = '【教学】撤离',
      ['a settings table moved; scanning again'] = '设置数据表已移动，正在重新扫描',
      ['a table moved; scanning again'] = '数据表已移动，正在重新扫描',
      ['also in your loadout when you bring this one'] = '携带此战略配备时也会一并获得',
      ['also the second firing mode\'s shot (the same projectile)'] = '同样适用于第二种射击模式的弹丸（同一投射物）',
      ['arc weapon'] = '电弧武器',
      ['armor passive'] = '护甲被动',
      ['armor penetration, forces, velocity, drag, gravity, pellets and explosions. Kept: this'] = '穿甲、作用力、速度、阻力、重力、弹丸数及爆炸的修改。当前武器的',
      ['attachment deltas'] = '配件修正量',
      ['attachment items'] = '配件物品',
      ['backpack charges'] = '背包使用次数',
      ['beam weapon'] = '光束武器',
      ['clip'] = '弹夹',
      ['could not start the download'] = '无法开始下载',
      ['current value implausible'] = '当前数值异常',
      ['damage: the same as the other rounds (Damage above)'] = '伤害：与其他弹种相同（见上方“伤害”）',
      ['damaged parts heal; destroyed parts stay destroyed'] = '受损部件会恢复生命值；已摧毁的部件不会复原',
      ['destruction map'] = '破坏数据映射',
      ['destruction tiers'] = '破坏等级',
      ['direct hit: the same as the first mode\'s (Damage above)'] = '直击：与第一种模式相同（见上方“伤害”）',
      ['fire mode'] = '射击模式',
      ['goes off on impact, but not before this'] = '撞击时引爆，但不能早于此时间',
      ['grenade assets loading'] = '正在加载投掷物资源',
      ['hash correction did not verify'] = '校验值校正未通过验证',
      ['hellpod rack'] = '空投舱挂架',
      ['its own. - / + : fire another weapon\'s'] = '自身弹丸。- / +：改为发射其他武器的弹丸',
      ['laser designator'] = '激光指示器',
      ['listing stratagems, attachments and armor passives'] = '正在列出战略配备、配件和护甲被动',
      ['loaded into an empty weapon, from your spare rounds'] = '装入空枪时，从备用弹药中补充',
      ['loadout package'] = '配装包',
      ['melee weapon'] = '近战武器',
      ['min charge'] = '最少充能',
      ['mine spawner'] = '地雷生成器',
      ['mine thrower'] = '布雷器',
      ['no demolition tier there'] = '没有对应的破坏等级',
      ['no shrapnel'] = '无破片',
      ['none (no explosion)'] = '无（不爆炸）',
      ['none (no projectile)'] = '无（没有弹丸）',
      ['normal projectile'] = '常规弹丸',
      ['not a finite number'] = '不是有限数值',
      ['nothing to vary for the hash (edit a value with decimals in this file)'] = '没有可用于校正校验值的数据（请修改此文件中的一个小数值）',
      ['overcharge'] = '过充',
      ['panels, mines per panel: lower only (more than the default crashes the game)'] = '布雷批次数、每批地雷数：只能调低（高于默认值会使游戏崩溃）',
      ['read-back check failed'] = '写入后读回校验失败',
      ['read-back differs'] = '读回内容不一致',
      ['resolving weapons and applying saved values'] = '正在解析武器并应用已保存的数值',
      ['seeking missile'] = '制导导弹',
      ['shared with'] = '共用',
      ['speedloader'] = '快速装填器',
      ['spray weapon'] = '喷射武器',
      ['stage 1: partial charge shot, stages 2-3: full charge shot'] = '第 1 阶段：部分蓄力射击；第 2-3 阶段：满蓄力射击',
      ['stage 1: uncharged shot, stages 2-3: charged shot'] = '第 1 阶段：未蓄力射击；第 2-3 阶段：蓄力射击',
      ['status effect'] = '状态效果',
      ['the armor passive file is not loaded'] = '未加载护甲被动数据文件',
      ['the download helper (shodan_hash.dll) is missing'] = '缺少下载辅助库（shodan_hash.dll）',
      ['the game\'s tiers: 10 small arms, 20 HMG, 30 autocannon, 40 Strider, 50 orbital, 60 Hellbomb, 250 never'] = '游戏的分级：10 轻武器、20 重机枪、30 机炮、40 蹂躏者、50 轨道、60 地狱炸弹、250 不可摧毁',
      ['the shot fired from this heat on, and what it does to you'] = '从该热量值起发射的弹丸，以及它对你自己造成的效果',
      ['the spare ammo in its backpack; read when the backpack is called in'] = '背包里的备用弹药；在被投放时读取',
      ['the update helper (shodan_hash.dll) is missing'] = '缺少更新辅助库（shodan_hash.dll）',
      ['waiting for the scan'] = '正在等待扫描',
      ['weapon charge'] = '武器蓄力',
      ['weapon customization'] = '武器定制',
      ['weapon heat'] = '武器热量',
      ['weapon\'s fire rate, ammo, handling and heat. To tune the shot, edit the chosen weapon.'] = '射速、弹药、操控和热量保持不变。要调整弹丸，请编辑所选武器。',
      ['what each hit applies; the slots go in order'] = '每次命中施加的状态；状态槽需按顺序填写',
    },
    lower = {
      ['"+ new preset" (or insert) saves your current changes as one; you name it next.'] = '“+ 新建预设”（或 Insert 键）会把当前修改存为一组，接着你可以为它命名。',
      ['+ armor rating'] = '护甲值',
      ['+ ergonomics'] = '人机工效',
      ['+ new preset from current changes'] = '从当前修改新建预设',
      ['+ stamina when hit'] = '受击时耐力',
      ['+ stim duration (s)'] = '治疗剂持续时间（秒）',
      ['+ stims (start, max)'] = '治疗剂数量（初始 / 上限）',
      ['+ throwables (start, max)'] = '投掷物数量（初始 / 上限）',
      ['100kg bomb'] = '100KG炸弹',
      ['100kg bomb mk2'] = '100KG炸弹 MK2',
      ['100kg bomb mk3'] = '100KG炸弹 MK3',
      ['100kg cluster bomb'] = '100KG集束炸弹',
      ['10g birdshot'] = '10 号鸟弹',
      ['10g bugshot'] = '10 号虫弹',
      ['10g dual sabot'] = '10 号双发脱壳弹',
      ['10g flechettes'] = '10 号箭形弹',
      ['10g fragmentation'] = '10 号破片弹',
      ['10g high velocity sabot'] = '10 号高速脱壳弹',
      ['10g liberty fire'] = '10 号“解放之火”霰弹',
      ['10g magnum'] = '10 号马格南霰弹',
      ['10g magnum triball'] = '10 号马格南三连弹',
      ['10g rifled slugs'] = '10 号线膛独头弹',
      ['10g sabot'] = '10 号脱壳弹',
      ['10g scatter shot'] = '10 号散射弹',
      ['10g stun rounds'] = '10 号眩晕弹',
      ['10g tri-ball'] = '10 号三连弹',
      ['10g. duckbill'] = '10 号鸭嘴枪口',
      ['10g. full choke'] = '10 号全喉缩',
      ['10g. half choke'] = '10 号半喉缩',
      ['110mm airburst cannon round'] = '110mm空爆炮弹',
      ['110mm airburst cannon round mk2'] = '110mm空爆炮弹 MK2',
      ['110mm e.m.s. cannon round'] = '110mm电磁冲击波炮弹',
      ['110mm e.m.s. cannon round mk2'] = '110mm电磁冲击波炮弹 MK2',
      ['110mm e.m.s. cannon round mk3'] = '110mm电磁冲击波炮弹 MK3',
      ['110mm gas cannon round'] = '110mm毒气炮弹',
      ['110mm standard rocket'] = '110mm标准火箭弹',
      ['110mm standard rocket mk2'] = '110mm标准火箭弹 MK2',
      ['12.5mm bchp rifle rounds'] = '12.5mm粘合弹芯空尖弹',
      ['12.5mm eit rounds'] = '12.5mm爆炸燃烧曳光弹',
      ['12.5mm standard rifle rounds'] = '12.5mm标准步枪子弹',
      ['120mm he cannon round'] = '120mm高爆炮弹',
      ['12g birdshot'] = '12 号鸟弹',
      ['12g buckshot'] = '12 号鹿弹',
      ['12g bugshot'] = '12 号虫弹',
      ['12g flechettes'] = '12 号箭形弹',
      ['12g liberty fire'] = '12 号“解放之火”霰弹',
      ['12g magnum'] = '12 号马格南霰弹',
      ['12g magnum triball'] = '12 号马格南三连弹',
      ['12g scatter shot'] = '12 号散射弹',
      ['12g tri-ball'] = '12 号三连弹',
      ['12g. duckbill'] = '12 号鸭嘴枪口',
      ['12g. full choke'] = '12 号全喉缩',
      ['12g. half choke'] = '12 号半喉缩',
      ['12mm. compensator'] = '12mm. 补偿器',
      ['12mm. flash hider'] = '12mm. 消焰器',
      ['12mm. muzzle break'] = '12mm. 枪口制退器',
      ['12x25mm explosive'] = '12x25mm爆炸子弹',
      ['12x25mm full metal jacket'] = '12x25mm全金属被甲弹',
      ['12x25mm high velocity'] = '12x25mm高速弹',
      ['12x25mm hollow point'] = '12x25mm空尖弹',
      ['12x25mm plasma'] = '12x25mm等离子弹',
      ['12x25mm ripper'] = '12x25mm撕裂弹',
      ['12x25mm thermite'] = '12x25mm铝热弹',
      ['12x25mm toxic'] = '12x25mm毒弹',
      ['13x40mm full metal jacket'] = '13x40mm全金属被甲弹',
      ['13x40mm hollow point'] = '13x40mm空尖弹',
      ['13x40mm magnum'] = '13x40mm马格南子弹',
      ['13x40mm penetrator'] = '13x40mm穿甲弹',
      ['13x40mm ripper'] = '13x40mm撕裂弹',
      ['15x100mm emp-rounds'] = '15x100mm电磁脉冲弹',
      ['15x100mm fragmentation'] = '15x100mm破片弹',
      ['15x100mm high explosive'] = '15x100mm高爆弹',
      ['15x100mm high velocity'] = '15x100mm高速弹',
      ['15x100mm plasma'] = '15x100mm等离子弹',
      ['15x100mm standard rocket'] = '15x100mm标准火箭弹',
      ['15x100mm thermite'] = '15x100mm铝热弹',
      ['15x100mm toxic'] = '15x100mm毒弹',
      ['20mm aphet rounds'] = '20mm穿甲高爆曳光弹',
      ['20mm flak rounds'] = '20mm 空爆炮弹',
      ['20mm he cannon'] = '20mm高爆炮弹',
      ['20mm hvap rounds'] = '20mm高速穿甲弹',
      ['23mm he cannon'] = '23mm高爆炮弹',
      ['30mm aphe cannon'] = '30mm穿甲高爆炮弹',
      ['380mm he cannon round'] = '380mm高爆炮弹',
      ['40-k meltagun'] = '40-K 热熔枪',
      ['40mm aphe cannon'] = '40mm穿甲高爆炮弹',
      ['40mm flak cannon'] = '40mm 空爆炮弹',
      ['40mm he grenade'] = '40mm高爆榴弹',
      ['40mm he mortar'] = '40mm高爆迫击炮弹',
      ['40mm heat grenade'] = '40mm高爆反坦克榴弹',
      ['40mm proximity grenade'] = '40mm感应榴弹',
      ['5,5mm. compensator'] = '5,5mm. 补偿器',
      ['5,5mm. flash hider'] = '5,5mm. 消焰器',
      ['5,5mm. muzzle break'] = '5,5mm. 枪口制退器',
      ['5.5x50mm devastator'] = '5.5x50mm“毁灭者”子弹',
      ['5.5x50mm double power'] = '5.5x50mm双效子弹',
      ['5.5x50mm explosive'] = '5.5x50mm爆炸子弹',
      ['5.5x50mm full metal jacket'] = '5.5x50mm全金属被甲弹',
      ['5.5x50mm high velocity'] = '5.5x50mm高速弹',
      ['5.5x50mm hollow-point'] = '5.5x50mm空尖弹',
      ['5.5x50mm penetrator'] = '5.5x50mm穿甲弹',
      ['5.5x50mm ripper'] = '5.5x50mm撕裂弹',
      ['5.5x50mm self propelled'] = '5.5x50mm 自推进弹',
      ['5.5x50mm subsonic'] = '5.5x50mm亚音速弹',
      ['5.5x50mm super uranium core'] = '5.5x50mm超铀芯弹',
      ['500kg bomb'] = '500KG炸弹',
      ['500kg bomb mk2'] = '500KG炸弹 MK2',
      ['500kg bomb mk3'] = '500KG炸弹 MK3',
      ['66mm missile'] = '66mm导弹',
      ['66mm missile mk2'] = '66mm导弹 MK2',
      ['70mm laser-guided missile'] = '70mm激光制导导弹',
      ['70mm laser-guided missile mk2'] = '70mm激光制导导弹 MK2',
      ['70mm standard rocket'] = '70mm标准火箭弹',
      ['75mm heat grenade'] = '75mm高爆反坦克榴弹',
      ['85mm heat grenade'] = '85mm高爆反坦克榴弹',
      ['85mm heat grenade mk2'] = '85mm高爆反坦克榴弹 MK2',
      ['85mm high-explosive grenade'] = '85mm高爆榴弹',
      ['85mm high-explosive grenade mk2'] = '85mm高爆榴弹 MK2',
      ['8mm. compensator'] = '8mm. 补偿器',
      ['8mm. flash hider'] = '8mm. 消焰器',
      ['8mm. muzzle break'] = '8mm. 枪口制退器',
      ['8x60mm airburst'] = '8x60mm空爆弹',
      ['8x60mm devastator'] = '8x60mm“毁灭者”子弹',
      ['8x60mm double power'] = '8x60mm双效子弹',
      ['8x60mm explosive'] = '8x60mm爆炸子弹',
      ['8x60mm full metal jacket'] = '8x60mm全金属被甲弹',
      ['8x60mm high velocity'] = '8x60mm高速弹',
      ['8x60mm liberty fire'] = '8x60mm“解放之火”子弹',
      ['8x60mm penetrator'] = '8x60mm穿甲弹',
      ['8x60mm sniper armour piercing'] = '8x60mm穿甲狙击弹',
      ['8x60mm subsonic'] = '8x60mm亚音速弹',
      ['8x60mm super uranium core'] = '8x60mm超铀芯弹',
      ['9mm. compensator'] = '9mm. 补偿器',
      ['9mm. flash hider'] = '9mm. 消焰器',
      ['9mm. muzzle break'] = '9mm. 枪口制退器',
      ['9x20mm explosive'] = '9x20mm爆炸子弹',
      ['9x20mm full metal jacket'] = '9x20mm全金属被甲弹',
      ['9x20mm high velocity'] = '9x20mm高速弹',
      ['9x20mm hollow point'] = '9x20mm空尖弹',
      ['9x20mm plasma'] = '9x20mm等离子弹',
      ['9x20mm ripper'] = '9x20mm撕裂弹',
      ['9x20mm thermite'] = '9x20mm铝热弹',
      ['9x20mm toxic'] = '9x20mm毒弹',
      ['9x70mm full metal jacket'] = '9x70mm全金属被甲弹',
      ['9x70mm high velocity'] = '9x70mm高速弹',
      ['9x70mm penetrator'] = '9x70mm穿甲弹',
      ['9x70mm self propelled'] = '9x70mm 自推进弹',
      ['9x70mm sniper armour piercing'] = '9x70mm穿甲狙击弹',
      ['9x70mm socom assassin'] = '9x70mm“刺客”特种作战弹',
      ['9x70mm super uranium core'] = '9x70mm超铀芯弹',
      ['a mounted cannon with a seat, dropped by hellpod. not the one you carry.'] = '带座位的固定火炮，由空投舱投送。不是你携带的那把。',
      ['a mounted copy aimed by ai. not the one you carry.'] = '由 AI 瞄准的固定版本。不是你携带的那把。',
      ['a mounted copy run by ai (emplacement-style). not the one you carry.'] = '由 AI 操作的固定版本（炮台式）。不是你携带的那把。',
      ['a mounted copy. not the one you carry.'] = '固定版本。不是你携带的那把。',
      ['a preset keeps every change you have made as one set, under a name you choose.'] = '预设会把你所有的修改作为一组保存，并取一个你指定的名字。',
      ['a/ac-8 autocannon sentry'] = 'A/AC-8 自动哨戒炮',
      ['a/arc-3 tesla tower'] = 'A/ARC-3 特斯拉塔',
      ['a/flam-40 flame sentry'] = 'A/FLAM-40 火焰喷射哨戒炮',
      ['a/g-16 gatling sentry'] = 'A/G-16 加特林哨戒炮',
      ['a/gm-17 gas mortar sentry'] = 'A/GM-17 毒气迫击哨戒炮',
      ['a/las-98 laser sentry'] = 'A/LAS-98 激光哨戒炮',
      ['a/m-12 mortar sentry'] = 'A/M-12 迫击哨戒炮',
      ['a/m-23 ems mortar sentry'] = 'A/M-23 电磁冲击波迫击哨戒炮',
      ['a/mg-43 machine gun sentry'] = 'A/MG-43 哨戒机枪',
      ['a/mls-4x rocket sentry'] = 'A/MLS-4X 火箭哨戒炮',
      ['ac-8 autocannon'] = 'AC-8 机炮',
      ['acceleration (m/s2)'] = '加速度(米/秒^2)',
      ['accelerator rifle'] = '加速步枪',
      ['acclimated'] = '应变自如',
      ['acid'] = '酸液',
      ['adjudicator'] = '审判者',
      ['adreno-defibrillator'] = '肾上腺素除颤器',
      ['advanced filtration'] = '高级过滤能力',
      ['airburst rocket launcher'] = '空爆火箭弹发射器',
      ['alternate ammunition'] = '另一种弹药',
      ['amendment'] = '修正',
      ['ammo'] = '弹药',
      ['ammo at the start'] = '初始弹药',
      ['ammo capacity'] = '弹药容量',
      ['ammo carried'] = '携带弹药',
      ['ammo from resupply'] = '补给箱补充弹药',
      ['ammunition'] = '弹药',
      ['amw-20 apex'] = 'AMW-20 尖峰',
      ['angled foregrip'] = '倾斜前握把',
      ['angled foregrip advanced'] = '高级倾斜前握把',
      ['angled foregrip with laser'] = '激光瞄准器与倾斜前握把',
      ['another copy of this weapon, not identified yet.'] = '该武器的另一份副本，尚未识别。',
      ['antenna'] = '天线',
      ['anti-air missile'] = '防空导弹',
      ['anti-materiel rifle'] = '反器材步枪',
      ['anti-tank emplacement'] = '反坦克炮台',
      ['anti-tank seeker'] = '反坦克追踪者',
      ['apex'] = '尖峰',
      ['apply my changes'] = '应用我的修改',
      ['apw-1 anti-materiel rifle'] = 'APW-1 反器材步枪',
      ['ar-11 arbitrator'] = 'AR-11 仲裁者',
      ['ar-11 arbitrator (underbarrel shotgun)'] = 'AR-11 仲裁者（下挂霰弹枪）',
      ['ar-2 coyote'] = 'AR-2 野狼',
      ['ar-23 liberator'] = 'AR-23 解放者',
      ['ar-23a liberator carbine'] = 'AR-23A “解放者”卡宾枪',
      ['ar-23c liberator concussive'] = 'AR-23C 震荡“解放者”',
      ['ar-23l liberator legacy'] = 'AR-23L “解放者”传承',
      ['ar-23p liberator penetrator'] = 'AR-23P 穿甲“解放者”',
      ['ar-32 pacifier'] = 'AR-32 安抚者',
      ['ar-59 suppressor'] = 'AR-59 消音器',
      ['ar-61 tenderizer'] = 'AR-61 肉锤',
      ['ar/gl-21 one-two'] = 'AR/GL-21 幺二',
      ['ar/gl-21 one-two (grenade launcher)'] = 'AR/GL-21 幺二（下挂榴弹发射器）',
      ['arbitrator'] = '仲裁者',
      ['arc'] = '电弧',
      ['arc chain edits in multiplayer'] = '多人模式下修改电弧连锁',
      ['arc chains'] = '电弧连锁',
      ['arc chains use the game\'s values while other players are in your game (see settings).'] = '对局中有其他玩家时，电弧连锁使用游戏原值（详见设置）。',
      ['arc damage taken'] = '受到的电弧伤害',
      ['arc splits'] = '电弧分裂',
      ['arc thrower'] = '电弧发射器',
      ['arc-12 blitzer'] = 'ARC-12 雷霆',
      ['arc-3 arc thrower'] = 'ARC-3 电弧发射器',
      ['arming time (s)'] = '解除保险时间（秒）',
      ['armor'] = '护甲',
      ['armor pen. (direct)'] = '穿甲等级（正面命中）',
      ['armor pen. (extreme angle)'] = '穿甲等级（极端角度）',
      ['armor pen. (large angle)'] = '穿甲等级（大角度）',
      ['armor pen. (slight angle)'] = '穿甲等级（小角度）',
      ['armors'] = '护甲',
      ['assault rifle'] = '突击步枪',
      ['attachment'] = '配件',
      ['attachments'] = '配件',
      ['autocannon'] = '机炮',
      ['autocannon sentry'] = '自动哨戒炮',
      ['b-1 supply pack'] = 'B-1 补给背包',
      ['b-100 portable hellbomb'] = 'B-100 便携式地狱火炸弹',
      ['b/flam-80 cremator'] = 'B/FLAM-80 焚燃者',
      ['b/md c4 pack'] = 'B/MD C4背包',
      ['back'] = '返回',
      ['back door block'] = '后舱门块',
      ['back hatch'] = '后舱盖',
      ['back periscope side 8'] = '潜望镜后侧 8',
      ['background opacity'] = '背景不透明度',
      ['backpack'] = '背包',
      ['ballistic padding'] = '防弹内衬',
      ['ballistic shield'] = '防弹盾',
      ['ballistic shield backpack'] = '防弹护盾背包',
      ['barrage'] = '弹幕',
      ['bastion mk xvi'] = '堡垒Mk XVI',
      ['belt-fed grenade launcher'] = '弹链式榴弹发射器',
      ['bingus shared loader by cowboybingus'] = 'Bingus 共享加载器 · CowboyBingus',
      ['blast'] = '爆炸',
      ['blast radius'] = '爆炸半径',
      ['blitzer'] = '雷霆',
      ['block game input while open'] = '打开时屏蔽游戏输入',
      ['blunt-force mitigation'] = '钝击创伤缓和',
      ['body parts'] = '身体部位',
      ['bolt pistol'] = '爆弹手枪',
      ['bonnet'] = '引擎盖',
      ['boost after the launch (s)'] = '起跳后的推进时间（秒）',
      ['br-14 adjudicator'] = 'BR-14 审判者',
      ['breacher'] = '爆破者',
      ['breaching hammer'] = '破门锤',
      ['break-action shotgun'] = '中折式霰弹枪',
      ['breaker'] = '破裂者',
      ['breaker incendiary'] = '高燃“破裂者”',
      ['breaker spray&pray'] = '千发百中“破裂者”',
      ['breakthrough exosuit'] = '“突破”外骨骼装甲',
      ['bullet storm'] = '子弹风暴',
      ['burn time (s)'] = '燃烧时间(秒)',
      ['burning'] = '燃烧',
      ['burning applied to you'] = '对你施加的燃烧',
      ['burst'] = '二次爆炸',
      ['burst radius'] = '二次爆炸半径',
      ['bushwhacker'] = '游击兵',
      ['caltrops'] = '铁蒺藜',
      ['cancel'] = '取消',
      ['cb-9 exploding crossbow'] = 'CB-9 爆燃弩',
      ['censor'] = '审查官',
      ['chain length'] = '连锁长度',
      ['chain reaction delay (s)'] = '连锁延迟(秒)',
      ['chain split'] = '连锁分裂',
      ['charge'] = '充能',
      ['charge when it comes back'] = '恢复后初始充能',
      ['charged'] = '已充能',
      ['charges'] = '使用次数',
      ['charges from resupply'] = '补给箱补充的使用次数',
      ['chest bleeding damage'] = '胸部流血伤害',
      ['chest damage taken'] = '受到胸部伤害',
      ['choose a weapon on the left.'] = '请在左侧选择武器。',
      ['clear'] = '清除',
      ['click again to overwrite'] = '再次点击以覆盖',
      ['climb acceleration'] = '爬升加速度',
      ['climb multiplier (horizontal)'] = '枪口上扬倍率（水平）',
      ['climb multiplier (vertical)'] = '枪口上扬倍率（垂直）',
      ['climb speed (m/s)'] = '爬升速度(米/秒)',
      ['climb time limit (s)'] = '爬升时限(秒)',
      ['cluster bomb'] = '集束炸弹',
      ['combat hatchet'] = '战斗短柄斧',
      ['combat scope 4x'] = '4倍战斗瞄准镜',
      ['commando'] = '突击兵',
      ['concussive padding (grenadier)'] = '防震内衬（掷弹兵型）',
      ['concussive padding (hazmat)'] = '防震内衬（防化型）',
      ['concussive padding (reinforced)'] = '防震内衬（强化型）',
      ['constitution'] = '宪法',
      ['contact mine'] = '接触式地雷',
      ['cookout'] = '野炊',
      ['cooldown (s)'] = '冷却时间(秒)',
      ['cooling (% per s)'] = '散热(每秒%)',
      ['copy'] = '复制',
      ['coyote'] = '野狼',
      ['cqc-1 one true flag'] = 'CQC-1 唯一真旗',
      ['cqc-19 stun lance'] = 'CQC-19 眩晕长矛',
      ['cqc-2 saber'] = 'CQC-2 军刀',
      ['cqc-20 breaching hammer'] = 'CQC-20 破门锤',
      ['cqc-30 stun baton'] = 'CQC-30 眩晕短棍',
      ['cqc-42 machete'] = 'CQC-42 砍刀',
      ['cqc-5 combat hatchet'] = 'CQC-5 战斗短柄斧',
      ['cqc-72 entrenchment tool'] = 'CQC-72 堑壕工具',
      ['cqc-73 entrenchment tool'] = 'CQC-73 堑壕工具',
      ['cqc-9 defoliation tool'] = 'CQC-9 除叶工具',
      ['cremator'] = '焚燃者',
      ['crisper'] = '迅击',
      ['cruise speed (m/s)'] = '巡航速度(米/秒)',
      ['dagger'] = '匕首',
      ['damage'] = '伤害',
      ['damage tick (s)'] = '伤害间隔(秒)',
      ['damage to you'] = '对你造成的伤害',
      ['damage: the same as the other rounds (damage above)'] = '伤害：与其他弹种相同（见上方“伤害”）',
      ['dbs-2 double freedom'] = 'DBS-2 双重自由',
      ['de-escalator'] = '缓和使者',
      ['deadeye'] = '鹰眼',
      ['defender'] = '防卫者',
      ['defoliation tool'] = '除叶工具',
      ['delete'] = '删除',
      ['democracy protects'] = '民主护佑',
      ['demolition force'] = '破坏力',
      ['deployer'] = '部署舱',
      ['desert stormer'] = '沙漠突击者',
      ['diligence'] = '勤勉',
      ['diligence counter sniper'] = '反狙击“勤勉”',
      ['direct hit'] = '直击',
      ['direct hit: the same as the first mode\'s (damage above)'] = '直击：与第一种模式相同（见上方“伤害”）',
      ['directional shield'] = '定向护盾',
      ['dominator'] = '主宰',
      ['double freedom'] = '双重自由',
      ['double-edge sickle'] = '双刃镰刀',
      ['down'] = '下移',
      ['drag factor'] = '阻力系数',
      ['driver gun'] = '驾驶员机枪',
      ['drone'] = '无人机',
      ['drum magazine'] = '弹鼓',
      ['dune walker sniper scope 10x'] = '10倍狙击瞄准镜',
      ['durable damage'] = '耐久伤害',
      ['durable ratio (0-1)'] = '耐伤比例(0-1)',
      ['duration (s)'] = '持续时间(秒)',
      ['dynamite'] = '炸药',
      ['e/at-12 anti-tank emplacement'] = 'E/AT-12 反坦克炮台',
      ['e/gl-21 grenadier battlement'] = 'E/GL-21 掷弹兵防卫墙',
      ['e/mg-101 hmg emplacement'] = 'E/MG-101 重机枪部署支架',
      ['each arm'] = '每条手臂',
      ['each leg'] = '每条腿',
      ['eagle'] = '飞鹰',
      ['eagle 110mm rocket pods'] = '“飞鹰”110mm火箭巢',
      ['eagle 500kg bomb'] = '“飞鹰”500kg炸弹',
      ['eagle airstrike'] = '“飞鹰”空袭',
      ['eagle cluster bomb'] = '“飞鹰”集束炸弹',
      ['eagle gas airstrike'] = '“飞鹰”毒气空袭',
      ['eagle napalm airstrike'] = '“飞鹰”凝固汽油弹空袭',
      ['eagle rearm time (s)'] = '飞鹰重新武装时间（秒）',
      ['eagle smoke strike'] = '“飞鹰”烟雾攻击',
      ['eagle strafing run'] = '“飞鹰”机枪扫射',
      ['eagle strike. the rearm time is shared by every eagle.'] = '飞鹰打击。所有飞鹰共用重新武装时间。',
      ['eat-17 expendable anti-tank'] = 'EAT-17 消耗性反坦克武器',
      ['eat-17 expendable anti-tank (seaf)'] = 'EAT-17 消耗性反坦克武器（SEAF）',
      ['eat-411 leveller'] = 'EAT-411 荡平者',
      ['eat-700 expendable napalm'] = 'EAT-700 消耗性凝固汽油弹',
      ['electrical conduit'] = '电路导管',
      ['emancipator exosuit'] = '“解放者”外骨骼装甲',
      ['emplacement: its cooldown, its body, then its weapon.'] = '炮台：依次为冷却时间、本体、武器。',
      ['ems mortar sentry'] = '电磁冲击波迫击哨戒炮',
      ['enemy detection range'] = '敌人侦测范围',
      ['engineering kit'] = '工程包',
      ['entrenchment tool'] = '堑壕工具',
      ['epoch'] = '纪元',
      ['ergonomics'] = '人机工效',
      ['ergonomics bonus'] = '人机工效加成',
      ['eruptor'] = '爆裂铳',
      ['evictor'] = '驱逐者',
      ['exo-45 patriot exosuit'] = 'EXO-45 “爱国者”外骨骼装甲',
      ['exo-49 emancipator exosuit'] = 'EXO-49 “解放者”外骨骼装甲',
      ['exo-51 lumberer exosuit'] = 'EXO-51 “伐木者”外骨骼装甲',
      ['exo-55 breakthrough exosuit'] = 'EXO-55 “突破”外骨骼装甲',
      ['expendable anti-tank'] = '消耗性反坦克武器',
      ['expendable napalm'] = '消耗性凝固汽油弹',
      ['explodes after death (s)'] = '死亡后爆炸（秒）',
      ['exploding crossbow'] = '爆燃弩',
      ['explosion'] = '爆炸',
      ['explosive damage taken'] = '受到爆炸伤害',
      ['extended magazine'] = '加长弹匣',
      ['extra padding'] = '额外垫料',
      ['faf-14 spear'] = 'FAF-14 飞矛',
      ['feet first'] = '护腿为上',
      ['field depth (m)'] = '雷区纵深（米）',
      ['field width (m)'] = '雷区宽度（米）',
      ['fire'] = '开火',
      ['fire damage taken'] = '受到火焰伤害',
      ['fire duration (s)'] = '持续开火时间（秒）',
      ['fire rate (rpm)'] = '射速(RPM)',
      ['fire/gas/acid/arc damage taken'] = '受到火焰 / 毒气 / 酸液 / 电弧伤害',
      ['flam-40 flamethrower'] = 'FLAM-40 火焰喷射器',
      ['flam-66 torcher'] = 'FLAM-66 火炬手',
      ['flame sentry'] = '火焰喷射哨戒炮',
      ['flames'] = '喷射火焰',
      ['flames mk2'] = '喷射火焰 MK2',
      ['flamethrower'] = '火焰喷射器',
      ['flashlight'] = '照明',
      ['flinch'] = '受击瞄准抖动',
      ['flinch (0 prevents it)'] = '受击瞄准抖动（0 为免疫）',
      ['folder'] = '文件夹',
      ['fortified'] = '强化',
      ['forward share of the launch (0-1)'] = '起跳前冲占比(0-1)',
      ['frag'] = '破片弹',
      ['from supply'] = '来自补给',
      ['front hull'] = '前车体',
      ['front left cockpit'] = '左前驾驶舱',
      ['front right cockpit'] = '右前驾驶舱',
      ['full charge'] = '充满',
      ['fuse time (s)'] = '引信时间(秒)',
      ['g-10 incendiary'] = 'G-10 燃烧弹',
      ['g-109 urchin'] = 'G-109 海胆',
      ['g-11 caltrops'] = 'G-11 铁蒺藜',
      ['g-12 high explosive'] = 'G-12 高爆弹',
      ['g-123 thermite'] = 'G-123 铝热弹',
      ['g-13 incendiary impact'] = 'G-13 燃烧冲击弹',
      ['g-142 pyrotech'] = 'G-142 烟花术',
      ['g-16 impact'] = 'G-16 冲击弹',
      ['g-23 stun'] = 'G-23 眩晕弹',
      ['g-3 smoke'] = 'G-3 烟雾弹',
      ['g-31 arc'] = 'G-31 电弧',
      ['g-4 gas'] = 'G-4 毒气榴弹',
      ['g-48 giga grenade'] = 'G-48 千兆级榴弹',
      ['g-50 seeker'] = 'G-50 寻踪者',
      ['g-6 frag'] = 'G-6 破片弹',
      ['g-60 anti-tank seeker'] = 'G-60 反坦克追踪者',
      ['g-7 pineapple'] = 'G-7 菠萝',
      ['g-8 immolation'] = 'G-8 焚身',
      ['g-89 smokescreen'] = 'G-89 烟幕',
      ['g/40-k melta mine'] = 'G/40-K 热熔地雷',
      ['g/sh-39 shield'] = 'G/SH-39 盾雷',
      ['gallant'] = '英勇无畏',
      ['gas'] = '毒气',
      ['gas damage taken'] = '受到毒气伤害',
      ['gas mortar sentry'] = '毒气迫击哨戒炮',
      ['gatling sentry'] = '加特林哨戒炮',
      ['generator'] = '发电机',
      ['giga grenade'] = '千兆级榴弹',
      ['github'] = 'GitHub',
      ['gl-15 evictor'] = 'GL-15 驱逐者',
      ['gl-21 grenade launcher'] = 'GL-21 榴弹发射器',
      ['gl-28 belt-fed grenade launcher'] = 'GL-28 弹链式榴弹发射器',
      ['gl-52 de-escalator'] = 'GL-52 缓和使者',
      ['gp-20 ultimatum'] = 'GP-20 最后通牒',
      ['gp-31 grenade pistol'] = 'GP-31 榴弹手枪',
      ['gr-8 recoilless rifle'] = 'GR-8 无后坐力炮',
      ['gravity factor'] = '重力系数',
      ['grenade'] = '手雷',
      ['grenade fired (choice)'] = '发射手雷(选择)',
      ['grenade launcher'] = '榴弹发射器',
      ['grenade pistol'] = '榴弹手枪',
      ['grenade selection takes priority over projectile swap. fire rate, ammo and handling stay.'] = '手雷选择优先于弹种交换。射速、弹药与操控保持不变。',
      ['grenade swap'] = '手雷交换',
      ['grenade swap stopped (see the log); launchers fire their own projectiles again.'] = '已停止榴弹替换（详见日志）；发射器恢复使用自身弹丸。',
      ['grenadier battlement'] = '掷弹兵防卫墙',
      ['guidance on after (s)'] = '导引启动延迟(秒)',
      ['gun'] = '枪械',
      ['gunner frv'] = '炮手快速侦察载具',
      ['gunslinger'] = '神枪手',
      ['halt'] = '止息',
      ['handling'] = '操控',
      ['head'] = '头部',
      ['health'] = '生命值',
      ['heat per second firing'] = '射击时每秒积热',
      ['heat per shot'] = '每发积热',
      ['heatsinks from supply'] = '补给获得的散热器数',
      ['heavy burning'] = '重度燃烧',
      ['heavy machine gun'] = '重机枪',
      ['high capacity heatsink'] = '高容量散热器',
      ['high dissipation heatsink'] = '高功率散热器',
      ['high explosive'] = '高爆弹',
      ['high-velocity shrapnel'] = '高速破片',
      ['hips'] = '腰部',
      ['hmg emplacement'] = '重机枪部署支架',
      ['homing anti-air missile'] = '追踪式防空导弹',
      ['homing ground missile'] = '追踪式地面导弹',
      ['homing ground missile mk2'] = '追踪式地面导弹 MK2',
      ['hot-shot marksman rifle'] = '高能精确射手步枪',
      ['hover agility (acceleration)'] = '悬停敏捷度(加速度)',
      ['hover pack'] = '悬浮背包',
      ['hover speed (m/s)'] = '悬停速度(米/秒)',
      ['hover time, full-speed climb (s)'] = '悬停时间：全速爬升(秒)',
      ['hover time, holding height (s)'] = '悬停时间：保持高度(秒)',
      ['hyena'] = '鬣狗',
      ['immolation'] = '焚身',
      ['impact'] = '冲击弹',
      ['impact damage taken'] = '受到冲击伤害',
      ['incendiary'] = '燃烧弹',
      ['incendiary impact'] = '燃烧冲击弹',
      ['incinerator frv'] = '炽灼型快速侦察载具',
      ['inflammable'] = '阻燃',
      ['injures you above heat (%)'] = '超过此热量会灼伤(%)',
      ['inner radius (m)'] = '内半径(米)',
      ['integrated explosives'] = '集成炸药',
      ['interface language'] = '界面语言',
      ['iron sights'] = '机械瞄具',
      ['jar-5 dominator'] = 'JAR-5 主宰',
      ['jump pack'] = '喷射背包',
      ['k-2 throwing knife'] = 'K-2 飞刀',
      ['kinetic displacement mitigation'] = '动能位移减缓',
      ['knight'] = '骑士',
      ['knockdown chance'] = '击倒几率',
      ['large plasma bolt'] = '大型等离子弹',
      ['larger plasma container'] = '扩容等离子弹药匣',
      ['las-12 sai'] = 'LAS-12 钗',
      ['las-13 trident'] = 'LAS-13“三叉戟”',
      ['las-16 sickle'] = 'LAS-16 镰刀',
      ['las-17 double-edge sickle'] = 'LAS-17 双刃镰刀',
      ['las-22 shear'] = 'LAS-22 切变',
      ['las-44 nova'] = 'LAS-44 新星',
      ['las-5 scythe'] = 'LAS-5 长柄镰',
      ['las-58 talon'] = 'LAS-58 猛爪',
      ['las-7 dagger'] = 'LAS-7 匕首',
      ['las-98 laser cannon'] = 'LAS-98 激光大炮',
      ['las-98 laser cannon (crewed mount)'] = 'LAS-98 激光大炮（乘员炮座）',
      ['las-99 quasar cannon'] = 'LAS-99 类星体加农炮',
      ['laser'] = '激光',
      ['laser cannon'] = '激光大炮',
      ['laser damage'] = '激光伤害',
      ['laser sentry'] = '激光哨戒炮',
      ['laser sight'] = '激光瞄准器',
      ['laser sight flashlight'] = '激光瞄准器带照明',
      ['laser. standard prism'] = '标准棱镜',
      ['launch duration (s)'] = '起跳推进时间（秒）',
      ['launch force'] = '起跳推力',
      ['launch speed (m/s)'] = '发射速度（米/秒）',
      ['left'] = '左',
      ['left arm'] = '左臂',
      ['left back panel'] = '左后板',
      ['left box 0'] = '左储物箱 0',
      ['left box 1'] = '左储物箱 1',
      ['left box 2'] = '左储物箱 2',
      ['left front block'] = '左前块',
      ['left front door'] = '左前门',
      ['left front light'] = '左前灯',
      ['left leg'] = '左腿',
      ['left mirror'] = '左后视镜',
      ['left rear door'] = '左后门',
      ['left side panel 0'] = '左侧板 0',
      ['left side panel 1'] = '左侧板 1',
      ['left top block'] = '左上块',
      ['left track'] = '左履带',
      ['leg injury immunity (1 on)'] = '免疫腿部受伤（1 为开启）',
      ['leveller'] = '荡平者',
      ['liberator'] = '解放者',
      ['liberator carbine'] = '“解放者”卡宾枪',
      ['liberator concussive'] = '震荡“解放者”',
      ['liberator legacy'] = '“解放者”传承',
      ['liberator penetrator'] = '穿甲“解放者”',
      ['lift-182 warp pack'] = 'LIFT-182 传送背包',
      ['lift-850 jump pack'] = 'LIFT-850 喷射背包',
      ['lift-860 hover pack'] = 'LIFT-860 悬浮背包',
      ['limb health'] = '四肢生命值',
      ['limb injury avoidance'] = '避免肢体受伤的几率',
      ['load'] = '读取',
      ['log file'] = '日志文件',
      ['logs'] = '日志',
      ['loses its target past (deg)'] = '超出此角度丢失目标(度)',
      ['loyalist'] = '忠诚者',
      ['lumberer exosuit'] = '“伐木者”外骨骼装甲',
      ['lure mine'] = '诱饵地雷',
      ['m-1000 maxigun'] = 'M-1000 重装机枪',
      ['m-102 gunner frv'] = 'M-102 炮手快速侦察载具',
      ['m-103 supply frv'] = 'M-103 补给型快速侦察载具',
      ['m-104 incinerator frv'] = 'M-104 炽灼型快速侦察载具',
      ['m-105 stalwart'] = 'M-105 盟友',
      ['m-105 stalwart (mounted)'] = 'M-105 盟友（固定式）',
      ['m-105 stalwart (mounted, ai-aimed 1)'] = 'M-105 盟友（固定式·AI 瞄准 1）',
      ['m-105 stalwart (mounted, ai-aimed 2)'] = 'M-105 盟友（固定式·AI 瞄准 2）',
      ['m6c/socom pistol'] = 'M6C/特种作战 手枪',
      ['m7s smg'] = 'M7S 冲锋枪',
      ['m90a shotgun'] = 'M90A 霰弹枪',
      ['ma5c assault rifle'] = 'MA5C 突击步枪',
      ['machete'] = '砍刀',
      ['machine gun'] = '机枪',
      ['machine gun sentry'] = '哨戒机枪',
      ['made by shodan'] = '作者 SHODAN',
      ['maelstrom'] = '风暴漩涡',
      ['magazine size'] = '弹匣容量',
      ['magazines from supply'] = '补给获得的弹匣数',
      ['main gun'] = '主炮',
      ['marker radar scan every (s)'] = '标记雷达扫描间隔（秒）',
      ['max carried'] = '最大携带',
      ['max flight time (s)'] = '最大飞行时间(秒)',
      ['max spare heatsinks'] = '备用散热器上限',
      ['max spare magazines'] = '备用弹匣上限',
      ['max spare rounds'] = '备用弹数上限',
      ['max throw distance (m)'] = '最大投掷距离(米)',
      ['maxigun'] = '重装机枪',
      ['mechas'] = '载具',
      ['med-kit'] = '急救包',
      ['medium plasma bolt'] = '中型等离子弹',
      ['melee damage'] = '近战伤害',
      ['melta mine'] = '热熔地雷',
      ['meltagun'] = '热熔枪',
      ['mg-206 heavy machine gun'] = 'MG-206 重机枪',
      ['mg-206 heavy machine gun (mounted b)'] = 'MG-206 重机枪（固定式 B）',
      ['mg-43 machine gun'] = 'MG-43 机枪',
      ['mg-43 machine gun (seaf)'] = 'MG-43 机枪（SEAF）',
      ['mgx-42 bullet storm'] = 'MGX-42 子弹风暴',
      ['mid-air steering force'] = '空中转向力',
      ['mine'] = '地雷',
      ['minefield'] = '雷区',
      ['mines deep'] = '纵向地雷排数',
      ['mines per panel'] = '每批地雷数',
      ['mines wide'] = '每行地雷数',
      ['minimum speed (m/s)'] = '最低速度(米/秒)',
      ['missile'] = '导弹',
      ['missile flight'] = '导弹飞行',
      ['missile pistol'] = '制导手枪',
      ['mist'] = '迷雾',
      ['mls-4x commando'] = 'MLS-4X 突击兵',
      ['mortar sentry'] = '迫击哨戒炮',
      ['move while reloading'] = '换弹时可移动',
      ['mp-98 knight'] = 'MP-98 骑士',
      ['ms-11 solo silo'] = 'MS-11 单兵导弹发射井',
      ['muzzle'] = '枪口',
      ['muzzle brake'] = '枪口制退器',
      ['napalm bomb'] = '凝固汽油弹',
      ['napalm bomb mk2'] = '凝固汽油弹 MK2',
      ['napalm bomb mk3'] = '凝固汽油弹 MK3',
      ['no changes: loading it puts every value back to the game\'s.'] = '没有修改：读取它会把所有数值恢复为游戏原值。',
      ['no presets yet.'] = '还没有预设。',
      ['noise'] = '噪音',
      ['not offered by the game: a laser built on the scythe. settings: unlock las-22 shear.'] = '游戏本身未提供：基于“长柄镰”改造的激光武器。设置项：解锁 LAS-22 切变。',
      ['nothing matches.'] = '没有匹配项。',
      ['nova'] = '新星',
      ['nuke'] = '核弹',
      ['off'] = '关',
      ['off: the game\'s values everywhere; your '] = '关闭：全局使用游戏数值，你的',
      ['off: with other players, arc chain length / split use the game\'s values (else arcs can stay on screen).'] = '关闭：多人对局时电弧连锁长度 / 分裂使用游戏数值（否则电弧可留在屏幕上）。',
      ['ok'] = '确定',
      ['ombudsman'] = '巡察者',
      ['on'] = '开',
      ['on: a loadout can take more than one exosuit, frv or tank.'] = '开启：单次配装可携带多台 外骨骼装甲、FRV 或坦克。',
      ['on: in your armory / stratagem list.'] = '开启：出现在你的军械库 / 战略配备列表中。',
      ['on: your '] = '开启：你的',
      ['on: your arc chain length / split apply with other players too (arcs can stay on screen).'] = '开启：你的电弧连锁长度 / 分裂对其他玩家同样生效（电弧可留在屏幕上）。',
      ['one true flag'] = '唯一真旗',
      ['one-two'] = '幺二',
      ['open'] = '打开',
      ['open / close key'] = '打开 / 关闭热键',
      ['optic'] = '瞄具',
      ['orbital'] = '轨道',
      ['orbital 120mm he barrage'] = '轨道120mm高爆弹火力网',
      ['orbital 380mm he barrage'] = '轨道380mm高爆弹火力网',
      ['orbital airburst strike'] = '轨道空爆攻击',
      ['orbital beam'] = '轨道光束',
      ['orbital ems strike'] = '轨道电磁冲击波攻击',
      ['orbital gas strike'] = '轨道毒气攻击',
      ['orbital gatling barrage'] = '轨道加特林火力网',
      ['orbital laser'] = '轨道激光炮',
      ['orbital napalm barrage'] = '轨道凝固汽油弹火力网',
      ['orbital precision strike'] = '轨道精准攻击',
      ['orbital railcannon strike'] = '轨道炮攻击',
      ['orbital smoke strike'] = '轨道烟雾攻击',
      ['orbital strike.'] = '轨道打击。',
      ['orbital walking barrage'] = '轨道游走火力网',
      ['other players are in your game: arc chain length / split use the game\'s values.'] = '你的对局中存在其他玩家：电弧连锁长度 / 分裂将使用游戏数值。',
      ['outer radius (m)'] = '外半径(米)',
      ['overcharge limit (s)'] = '过载上限(秒)',
      ['overheat threshold'] = '过热阈值',
      ['oxygenator'] = '供氧器',
      ['p-11 stim pistol'] = 'P-11 治疗剂手枪',
      ['p-113 verdict'] = 'P-113 裁决',
      ['p-19 redeemer'] = 'P-19 救世主',
      ['p-2 peacemaker'] = 'P-2 和平制造者',
      ['p-33 missile pistol'] = 'P-33 制导手枪',
      ['p-34 breacher'] = 'P-34 爆破者',
      ['p-35 re-educator'] = 'P-35 思想改造',
      ['p-4 senator'] = 'P-4 参议员',
      ['p-41 ombudsman'] = 'P-41 巡察者',
      ['p-41 ombudsman (variant 2)'] = 'P-41 巡察者（变体 2）',
      ['p-44 mist'] = 'P-44 迷雾',
      ['p-69 veto'] = 'P-69 否决者',
      ['p-72 crisper'] = 'P-72 迅击',
      ['p-92 warrant'] = 'P-92 法令',
      ['p/40-k bolt pistol'] = 'P/40-K 爆弹手枪',
      ['pacifier'] = '安抚者',
      ['panel side'] = '面板位置',
      ['panel size'] = '面板大小',
      ['panels'] = '布雷批次数',
      ['passive'] = '被动',
      ['patriot exosuit'] = '“爱国者”外骨骼装甲',
      ['peacemaker'] = '和平制造者',
      ['peak physique'] = '健壮体格',
      ['pen.'] = '穿甲',
      ['penetration slowdown'] = '穿透后速度衰减',
      ['pineapple'] = '菠萝',
      ['plas-1 scorcher'] = 'PLAS-1 焦土',
      ['plas-101 purifier'] = 'PLAS-101 净化者',
      ['plas-15 loyalist'] = 'PLAS-15 忠诚者',
      ['plas-39 accelerator rifle'] = 'PLAS-39 加速步枪',
      ['plas-45 epoch'] = 'PLAS-45 纪元',
      ['point of interest range'] = '兴趣点探测范围',
      ['portable hellbomb'] = '便携式地狱火炸弹',
      ['position scatter (m)'] = '布雷位置随机偏移（米）',
      ['presets'] = '预设',
      ['press a key (esc cancels)'] = '请按一个键(Esc 取消)',
      ['press the key that should open and close the panel: f1-f12, insert, home, end, pause or scroll lock. esc cancels.'] = '请按下用于打开 / 关闭面板的按键：F1-F12、Insert、Home、End、Pause 或 Scroll Lock。Esc 取消。',
      ['primary'] = '主武器',
      ['primary reload speed'] = '主武器装填速度',
      ['projectile'] = '弹丸',
      ['projectile fired (id)'] = '发射的弹丸(编号)',
      ['projectile swap'] = '弹种交换',
      ['projectiles per shot'] = '每次射击弹丸数',
      ['punisher'] = '制裁者',
      ['punisher plasma'] = '等离子“制裁者”',
      ['purifier'] = '净化者',
      ['push force'] = '击退力',
      ['pyrotech'] = '烟花术',
      ['quasar cannon'] = '类星体加农炮',
      ['r-2 amendment'] = 'R-2 修正',
      ['r-2124 constitution'] = 'R-2124 宪法',
      ['r-36 eruptor'] = 'R-36 爆裂铳',
      ['r-4 hyena'] = 'R-4 鬣狗',
      ['r-40 sightliner'] = 'R-40 视界者',
      ['r-6 deadeye'] = 'R-6 鹰眼',
      ['r-63 diligence'] = 'R-63 勤勉',
      ['r-63cs diligence counter sniper'] = 'R-63CS 反狙击“勤勉”',
      ['r-72 censor'] = 'R-72 审查官',
      ['r/40-k hot-shot marksman rifle'] = 'R/40-K 高能精确射手步枪',
      ['rack'] = '挂架',
      ['radar'] = '雷达',
      ['radius (m)'] = '半径(米)',
      ['rail cannon round'] = '轨道炮弹',
      ['railgun'] = '磁轨炮',
      ['railgun round'] = '磁轨炮弹',
      ['railgun stun round'] = '磁轨炮眩晕弹',
      ['range'] = '射程',
      ['range (m)'] = '射程(米)',
      ['rapid heatsink'] = '快速散热器',
      ['re-educator'] = '思想改造',
      ['reach downward (m)'] = '向下触及(米)',
      ['reach upward (m)'] = '向上触及(米)',
      ['reading the game\'s weapon tables... ('] = '正在读取游戏武器表…（',
      ['rear cockpit'] = '后驾驶舱',
      ['recharge delay (s)'] = '重新充能延迟(秒)',
      ['recharge delay once broken (s)'] = '破损后的充能延迟(秒)',
      ['recharge rate (per s)'] = '充能速率(每秒)',
      ['recharge time (s)'] = '充能时间(秒)',
      ['recoil (horizontal)'] = '后坐力(水平)',
      ['recoil (vertical)'] = '后坐力(垂直)',
      ['recoil crouching / prone'] = '蹲姿 / 卧姿后坐力',
      ['recoil multiplier (horizontal)'] = '后坐倍率(水平)',
      ['recoil multiplier (vertical)'] = '后坐倍率(垂直)',
      ['recoilless rifle'] = '无后坐力炮',
      ['redeemer'] = '救世主',
      ['reduced signature'] = '隐迹潜踪',
      ['regeneration (health/s)'] = '再生(生命/秒)',
      ['reinforced epaulettes'] = '强化肩章',
      ['reload allowed below (rounds)'] = '允许装填的剩余弹数上限',
      ['reload time (s)'] = '装填时间（秒）',
      ['remember last tab and weapon'] = '记住上次的页签与武器',
      ['rename'] = '重命名',
      ['reprimand'] = '训斥',
      ['reset all values'] = '重置全部数值',
      ['reset passive'] = '重置被动',
      ['reset weapon'] = '重置武器',
      ['resets all values from the current preset to default.'] = '将当前预设的全部数值恢复为默认值。',
      ['right'] = '右',
      ['right arm'] = '右臂',
      ['right back panel'] = '右后板',
      ['right box 0'] = '右储物箱 0',
      ['right box 1'] = '右储物箱 1',
      ['right box 2'] = '右储物箱 2',
      ['right front block'] = '右前块',
      ['right front door'] = '右前门',
      ['right front light'] = '右前灯',
      ['right leg'] = '右腿',
      ['right mirror'] = '右后视镜',
      ['right rear door'] = '右后门',
      ['right side panel 0'] = '右侧板 0',
      ['right side panel 1'] = '右侧板 1',
      ['right top block'] = '右上块',
      ['right track'] = '右履带',
      ['rl-77 airburst rocket launcher'] = 'RL-77 空爆火箭弹发射器',
      ['rock solid'] = '坚如磐石',
      ['rocket sentry'] = '火箭哨戒炮',
      ['round 1 blast'] = '第 1 发爆炸',
      ['round 1 blast radius'] = '第 1 发爆炸半径',
      ['round 1 projectile'] = '第 1 发弹丸',
      ['rounds 2, 3 blast radius'] = '第 2、3 发爆炸半径',
      ['rounds 2, 3 projectile'] = '第 2、3 发弹丸',
      ['rounds 2, 3, 4 projectile'] = '第 2、3、4 发弹丸',
      ['rounds from supply'] = '补给获得的弹数',
      ['rounds loaded'] = '已装填弹数',
      ['rounds per reload'] = '每次装填弹数',
      ['rs-422 railgun'] = 'RS-422 磁轨炮',
      ['run length (m)'] = '攻击航线长度（米）',
      ['s-11 speargun'] = 'S-11 矛枪',
      ['safe below heat (%)'] = '安全热量(%)',
      ['sai'] = '钗',
      ['salvos'] = '齐射次数',
      ['save'] = '保存',
      ['save current changes here'] = '在此保存当前修改',
      ['scorcher'] = '焦土',
      ['scout'] = '侦察',
      ['scythe'] = '长柄镰',
      ['search radius (m)'] = '搜索半径(米)',
      ['search weapons and stratagems'] = '搜索武器与战略配备',
      ['second mode'] = '第二模式',
      ['second mode fires (id)'] = '第二模式发射的弹丸(编号)',
      ['secondary'] = '副武器',
      ['secondary draw speed'] = '副武器拔出速度',
      ['secondary recoil'] = '副武器后坐力',
      ['secondary reload speed'] = '副武器装填速度',
      ['seeker'] = '寻踪者',
      ['senator'] = '参议员',
      ['sentry: its cooldown, its body, then its weapon.'] = '哨戒炮：依次为冷却时间、本体、武器。',
      ['servo-assisted'] = '伺服辅助',
      ['settings'] = '设置',
      ['settings are saved at once, in config.txt with your changes.'] = '设置会与你的修改一并即时保存到 config.txt。',
      ['several vehicles of a kind'] = '同类载具数量',
      ['sg-20 halt'] = 'SG-20 止息',
      ['sg-22 bushwhacker'] = 'SG-22 游击兵',
      ['sg-225 breaker'] = 'SG-225 破裂者',
      ['sg-225ie breaker incendiary'] = 'SG-225IE 高燃“破裂者”',
      ['sg-225sp breaker spray&pray'] = 'SG-225SP 千发百中“破裂者”',
      ['sg-451 cookout'] = 'SG-451 野炊',
      ['sg-8 punisher'] = 'SG-8 制裁者',
      ['sg-88 break-action shotgun'] = 'SG-88 中折式霰弹枪',
      ['sg-8p punisher plasma'] = 'SG-8P 等离子“制裁者”',
      ['sg-8s slugger'] = 'SG-8S 重炮手',
      ['sg-97 sweeper'] = 'SG-97 扫荡者',
      ['sh-20 ballistic shield backpack'] = 'SH-20 防弹护盾背包',
      ['sh-32 shield generator pack'] = 'SH-32 防护罩生成包',
      ['sh-51 directional shield'] = 'SH-51 定向护盾',
      ['shear'] = '切变',
      ['shells per salvo'] = '每次齐射弹数',
      ['shield'] = '盾雷',
      ['shield capacity'] = '护盾容量',
      ['shield emitter'] = '护盾发生器',
      ['shield generator pack'] = '防护罩生成包',
      ['shockwave radius (m)'] = '冲击波半径(米)',
      ['shodan stat editor'] = 'SHODAN 数值编辑器',
      ['shodan weapon mods are running too: they put their own values back every 5 s'] = '检测到 SHODAN 武器 mod 同时运行：它们每 5 秒会把数值改回自己的设定',
      ['short magazine'] = '短弹匣',
      ['shrapnel'] = '破片',
      ['shrapnel blast radius'] = '破片爆炸半径',
      ['shrapnel direct hit'] = '破片直击',
      ['shrapnel pieces'] = '破片数量',
      ['shrapnel projectile'] = '破片弹丸',
      ['sickle'] = '镰刀',
      ['siege-ready'] = '蓄势出击',
      ['sightliner'] = '视界者',
      ['silo'] = '发射井',
      ['slide speed / duration'] = '滑行速度 / 持续时间',
      ['slugger'] = '重炮手',
      ['small plasma bolt'] = '小型等离子弹',
      ['smg'] = '冲锋枪',
      ['smg-203 gallant'] = 'SMG-203 英勇无畏',
      ['smg-32 reprimand'] = 'SMG-32 训斥',
      ['smg-37 defender'] = 'SMG-37 防卫者',
      ['smg-37 defender (seaf)'] = 'SMG-37 防卫者（SEAF）',
      ['smg-72 pummeler'] = 'SMG-72 暴击斗士',
      ['smg/flam-34 stoker'] = 'SMG/FLAM-34 司炉者',
      ['smg/flam-34 stoker (underbarrel flamer)'] = 'SMG/FLAM-34 司炉者（下挂喷火器）',
      ['smoke'] = '烟雾弹',
      ['smokescreen'] = '烟幕',
      ['sniper scope 10x'] = '10倍狙击瞄准镜',
      ['sniper scope 10x helghast'] = '10倍狙击瞄准镜',
      ['solo silo'] = '单兵导弹发射井',
      ['spear'] = '飞矛',
      ['speargun'] = '矛枪',
      ['spotting range (m)'] = '索敌距离(米)',
      ['spread (horizontal)'] = '散布(水平)',
      ['spread (vertical)'] = '散布(垂直)',
      ['spread area (m)'] = '散布范围(米)',
      ['spread multiplier (horizontal)'] = '散布倍率(水平)',
      ['spread multiplier (vertical)'] = '散布倍率(垂直)',
      ['sta-11 smg'] = 'StA-11 冲锋枪',
      ['sta-52 assault rifle'] = 'StA-52 突击步枪',
      ['sta-x3 w.a.s.p. launcher'] = 'StA-X3 W.A.S.P.发射器',
      ['stage '] = '阶段 ',
      ['stagger force'] = '硬直力',
      ['stalwart'] = '盟友',
      ['standard drum'] = '标准弹鼓',
      ['standard heatsink'] = '标准散热器',
      ['standard plasma container'] = '标准等离子弹药匣',
      ['starting charges'] = '初始使用次数',
      ['starting count'] = '初始数量',
      ['starting heatsinks'] = '初始备用散热器数',
      ['starting magazines'] = '初始备用弹匣数',
      ['starting rounds'] = '初始备用弹数',
      ['starts at heat'] = '初始热量',
      ['stationary shroud'] = '静止隐匿',
      ['stim pistol'] = '治疗剂手枪',
      ['stoker'] = '司炉者',
      ['stops you while firing'] = '开火时锁定移动',
      ['stratagem'] = '战略配备',
      ['stratagems'] = '战略配备',
      ['stun'] = '眩晕',
      ['stun (large)'] = '眩晕（大）',
      ['stun (massive)'] = '眩晕（极大）',
      ['stun (medium)'] = '眩晕（中）',
      ['stun (small)'] = '眩晕（小）',
      ['stun baton'] = '眩晕短棍',
      ['stun lance'] = '眩晕长矛',
      ['supplementary adrenaline'] = '肾上腺素补充剂',
      ['supply frv'] = '补给型快速侦察载具',
      ['supply pack'] = '补给背包',
      ['support'] = '支援武器',
      ['support reload speed'] = '支援武器装填速度',
      ['support weapon drop; the weapon itself is under support.'] = '支援武器空投；武器本身列在“支援武器”分类下。',
      ['suppressor'] = '消音器',
      ['sure?'] = '确定？',
      ['surviving lethal damage'] = '致命伤害存活几率',
      ['sway multiplier'] = '晃动系数',
      ['sweeper'] = '扫荡者',
      ['talon'] = '猛爪',
      ['td-110 maelstrom'] = 'TD-110 风暴漩涡',
      ['td-220 bastion mk xvi'] = 'TD-220 堡垒MK XVI',
      ['ted-63 dynamite'] = 'TED-63 炸药',
      ['tenderizer'] = '肉锤',
      ['tesla tower'] = '特斯拉塔',
      ['the arbitrator\'s underbarrel shotgun, not the rifle itself.'] = '“仲裁者”的下挂霰弹枪，不是步枪本身。',
      ['the charge backpack, the charge and its blast. cooldown: stratagems tab.'] = '炸药背包、炸药包及其爆炸。冷却时间见“战略配备”页。',
      ['the defender seaf soldiers carry. not yours.'] = 'SEAF 士兵携带的“防卫者”。不是你的那把。',
      ['the eat-17 seaf soldiers carry. not yours.'] = 'SEAF 士兵携带的 EAT-17。不是你的那把。',
      ['the flamethrower you carry.'] = '你携带的火焰喷射器。',
      ['the game\'s tiers: 10 small arms, 20 hmg, 30 autocannon, 40 strider, 50 orbital, 60 hellbomb, 250 never'] = '游戏的分级：10 轻武器、20 重机枪、30 机炮、40 蹂躏者、50 轨道、60 地狱炸弹、250 不可摧毁',
      ['the mg-43 seaf soldiers carry. not yours.'] = 'SEAF 士兵携带的 MG-43。不是你的那把。',
      ['the one you carry.'] = '你携带的那一把。',
      ['the one you carry. the cqc-20 breaching hammer is listed under support.'] = '你携带的那一把。CQC-20 破拆锤列在“支援武器”下。',
      ['the one you carry. the cqc-72 support version is listed under support.'] = '你携带的那一把。CQC-72 支援版本列在“支援武器”下。',
      ['the one-two\'s underbarrel launcher, not the rifle. fires the gp-31\'s grenade.'] = '“幺二”的下挂发射器，不是步枪本身。发射 GP-31 的榴弹。',
      ['the pistol you carry. the one-two\'s launcher is listed under the one-two.'] = '你携带的手枪。“幺二”的发射器列在“幺二”下。',
      ['the recharge time is 0: set it above 0 first.'] = '充能时间为 0：请先设为大于 0 的值。',
      ['the rifle you carry. the grenade launcher is listed separately.'] = '你携带的步枪。榴弹发射器单独列出。',
      ['the rifle you carry. the underbarrel shotgun is listed separately.'] = '你携带的步枪。下挂霰弹枪单独列出。',
      ['the scythe you carry.'] = '你携带的“长柄镰”。',
      ['the smg you carry. its underbarrel flamer is listed separately.'] = '你携带的冲锋枪。其下挂火焰喷射器单独列出。',
      ['the stoker\'s underbarrel flamer, not the smg itself.'] = '“司炉者”的下挂火焰喷射器，不是冲锋枪本身。',
      ['the support hammer delivered by hellpod. the game data files it next to the machete.'] = '由空投舱投送的支援锤。游戏数据将它列在砍刀旁边。',
      ['the support weapon. the cqc-73 is listed under secondary.'] = '支援武器。CQC-73 列在“副武器”下。',
      ['thermite'] = '铝热弹',
      ['throw range'] = '投掷距离',
      ['throw spread (degrees)'] = '投掷散布(度)',
      ['throw velocity, max (m/s)'] = '投掷速度上限(米/秒)',
      ['throw velocity, min (m/s)'] = '投掷速度下限(米/秒)',
      ['throwable'] = '投掷物',
      ['throwables'] = '投掷物',
      ['throwing knife'] = '飞刀',
      ['time between bombs (s)'] = '投弹间隔(秒)',
      ['time between salvos (s)'] = '齐射间隔(秒)',
      ['time between shells (s)'] = '炮弹发射间隔（秒）',
      ['tm-1 lure mine'] = 'TM-1 诱饵地雷',
      ['top left hatch'] = '左上舱盖',
      ['top right hatch'] = '右上舱盖',
      ['torcher'] = '火炬手',
      ['tracking speed'] = '跟踪速度',
      ['trigger delay (s)'] = '触发延迟(秒)',
      ['true grit'] = '坚韧不拔',
      ['tube reddot 2x'] = '2倍红点瞄准镜',
      ['turn speed at cruise'] = '巡航转向速率',
      ['turn speed at slowest'] = '最慢转向速率',
      ['tx-41 sterilizer'] = 'TX-41 灭菌器',
      ['type the name: enter keeps it, esc cancels. the game sees these keys too, so name presets from a menu.'] = '输入预设名称：Enter 确认，Esc 取消。',
      ['type the percent (%d-%d): enter sets it, esc cancels.'] = '输入百分比(%d-%d)：回车确认，Esc 取消。',
      ['type the value: enter sets it, esc cancels. values out of range are set to the nearest allowed one.'] = '输入数值：回车确认，Esc 取消。超出范围的数值会取最接近的合法值。',
      ['type to search: enter keeps the results, esc clears the search. the game sees these keys too.'] = '输入搜索内容：Enter 保留结果，Esc 清空搜索。',
      ['ultimatum'] = '最后通牒',
      ['underbarrel'] = '下挂',
      ['unflinching'] = '毫不畏缩',
      ['unlock unused items'] = '解锁未使用物品',
      ['unsafe warp: damage to you'] = '不安全跃迁：对你造成的伤害',
      ['up'] = '上移',
      ['up/down choose a stat, left/right change it (shift: bigger steps), click a value or press enter to type it,'] = '上下键选择数值项，左右键调整（Shift 为大步长），点击数值或按回车直接输入，',
      ['up/down choose, enter loads, insert makes a new one, shift+insert saves into it, f2 renames, del deletes.'] = '上下键选择，回车读取，Insert 新建，Shift+Insert 存入当前预设，F2 重命名，Del 删除。',
      ['urchin'] = '海胆',
      ['uses per rearm'] = '每次重新武装后的可用次数',
      ['variable'] = '变数',
      ['vehicle'] = '载具',
      ['velocity'] = '初速',
      ['velocity (m/s)'] = '初速(米/秒)',
      ['verdict'] = '裁决',
      ['vertical grip'] = '垂直前握把',
      ['vertical grip 45 degree'] = '45度垂直前握把',
      ['vertical grip advanced'] = '高级垂直前握把',
      ['veto'] = '否决者',
      ['vg-70 variable'] = 'VG-70 变数',
      ['volatile plasma bolt'] = '不稳定等离子弹',
      ['w.a.s.p. launcher'] = 'W.A.S.P.发射器',
      ['walk / run speed'] = '行走 / 奔跑速度',
      ['walking speed (m/s)'] = '弹幕推进速度（米/秒）',
      ['warp distance (m)'] = '跃迁距离(米)',
      ['warp pack'] = '传送背包',
      ['warrant'] = '法令',
      ['weapon stats'] = '武器数值',
      ['wind-down time (s)'] = '转管减速时间（秒）',
      ['wind-up'] = '转管加速',
      ['wind-up time (s)'] = '转管加速时间（秒）',
      ['your changes are off: turn them on in settings to edit.'] = '你的改动当前处于关闭状态：请在设置里开启后再编辑。',
    },
    patterns = {
      { '^Unnamed: (.-)mm; (.-)/(.-) damage$', '未命名：%1毫米，伤害%2/%3' },
      { '^Unnamed: (.-)m blast$', '未命名：半径%1米' },
      { '^Unnamed: (.-)s effect$', '未命名：持续%1秒' },
      { '^(.-) SHRAPNEL$', '%1破片' },
      { '^(.-) EXPLOSION ID$', '%1爆炸编号' },
      { '^projectile (%d+) %(not in this game build%)$', '弹丸 %1（当前游戏版本中不存在）' },
      { '^explosion (%d+) %(not in this game build%)$', '爆炸 %1（当前游戏版本中不存在）' },
      { '^No explosion (.+) in the game%.$', '游戏里没有编号为 %1 的爆炸。' },
      { '^each piece is (.+)$', '每片破片使用：%1' },
      { '^sets off: (.+)$', '引爆：%1' },
      { '^Set off by: (.+)$', '触发来源：%L1' },
      { '^Fired by: (.+)$', '发射来源：%L1' },
      { '^(%*? ?)Status #(%d+)$', '%1状态 #%2' },
      { '^(%*? ?)Status #(%d+) · (.+)$', '%1状态 #%2 · %3' },
      { '^(%*? ?)Explosion #(%d+)$', '%1爆炸 #%2' },
      { '^(%*? ?)Explosion #(%d+) · (.+)$', '%1爆炸 #%2 · %3' },
      { '^(%*? ?)Projectile #(%d+)$', '%1弹丸 #%2' },
      { '^(%*? ?)Projectile #(%d+) · (.+)$', '%1弹丸 #%2 · %3' },
      { '^Your values are installed %((%d+) game files%)%. Close the game before installing%.$', '修改已写入 %1 个游戏文件。再次写入前请先关闭游戏。' },
      { '^Installing: preparing (.+) %((%d+) of (%d+)%)%.%.%.$', '写入中：正在准备 %1（%2 / %3）…' },
      { '^Not installed: (.+) could not be prepared %((.+)%)%. Nothing was changed%.$', '未写入：无法准备 %1（%2）。未做任何更改。' },
      { '^Not installed: the armor passives could not be stacked %((.+)%)%. Nothing was changed%.$', '未写入：无法叠加护甲被动（%1）。未做任何更改。' },
      { '^Not installed: (.+)$', '未写入：%1' },
      { '^Installed %((%d+) game files changed%)%. Start the game to play with your values%.$', '写入完成：修改了 %1 个游戏文件。启动游戏即可使用修改后的数值。' },
      { '^Installed %((%d+) game files changed, (%d+) back to the original%)%. Start the game to play with your values%.$', '写入完成：修改了 %1 个游戏文件，%2 个恢复原值。启动游戏即可使用修改后的数值。' },
      { '^Not restored: (.+)$', '未恢复：%1' },
      { '^Update failed: (.+)%. The release page has it: (.+)$', '更新失败：%1。可在发布页面下载：%2' },
      { '^Update failed: (.+)%. Nothing was changed%.$', '更新失败：%1。未做任何更改。' },
      { '^Update to (.+)$', '更新到 %1' },
      { '^Updating: downloading (.+)%.%.%.$', '正在更新：下载 %1...' },
      { '^Updating: installing (.+)%.%.%.$', '正在更新：安装 %1...' },
      { '^Updated to (.+)%.$', '已更新到 %1。' },
      { '^Add a passive to (.+)$', '为 %1 添加被动' },
      { '^Heat level (%d+)$', '热量等级 %1' },
      { '^(.+); ammo type shared with (.+)$', '%1；弹种与以下共用：%L2' },
      { '^fires: (.+)%. The rows above stay its own$', '发射：%1。上方各行仍为其自身数值' },
      { '^fires: (.+)$', '发射：%1' },
      { '^loading: (.+)$', '加载中：%1' },
      { '^projectile (%d+)$', '弹丸 %1' },
      { '^Preset (%d+)$', '预设 %1' },
      { '^Saved (.+) preset (%d+) %((%d+) changed value%(s%)%)$', '已保存%1的预设 %2（%3 项改动）' },
      { '^(.+) preset (%d+) is empty$', '%1的预设 %2 为空' },
      { '^Loaded (.+) preset (%d+) %((%d+) value%(s%) not applied%)$', '已读取%1的预设 %2（%3 项未应用）' },
      { '^Loaded (.+) preset (%d+)$', '已读取%1的预设 %2' },
      { '^Cleared (.+) preset (%d+)$', '已清除%1的预设 %2' },
      { '^Empty name: kept "(.+)"$', '名称为空：保留“%1”' },
      { '^Named it "(.+)"$', '已命名为“%1”' },
      { '^All (%d+) presets are in use: delete one first$', '全部 %1 个预设均已使用：请先删除一个' },
      { '^Saved (%d+) changed value%(s%) as a new preset%. Type its name, Enter keeps it%.$', '已将 %1 项改动保存为新预设。输入名称，按 Enter 确认。' },
      { '^Saved (%d+) changed value%(s%) into "(.+)"$', '已将 %1 项改动保存到“%2”' },
      { '^Loaded "(.+)" %((%d+) value%(s%) not applied%)$', '已读取“%1”（%2 项未应用）' },
      { '^Loaded "(.+)"$', '已读取“%1”' },
      { '^Deleted "(.+)"$', '已删除“%1”' },
      { '^Again to overwrite "(.+)"$', '再次点击以覆盖“%1”' },
      { '^Again to delete "(.+)"$', '再次点击以删除“%1”' },
      { '^rows (%d+)%-(%d+) of (%d+)$', '第 %1-%2 行 / 共 %3 行' },
      { '^Above (%d+)%% heat$', '热量高于 %1%' },
      { '^ABOVE (%d+)%% HEAT$', '热量高于 %1%' },
      { '^Fire rate (%d+) %(RPM%)$', '射速 %1（RPM）' },
      { '^Modifier (%x+)$', '修正项 %1' },
      { '^(.+) %(SEAF%)$', '%1（SEAF）' },
      { '^The (.+) SEAF soldiers carry%. Not yours%.$', 'SEAF 士兵携带的%1。不是你的。' },
      { '^(.+): in the game files, not offered by it%.$', '%L1：存在于游戏文件中，但游戏本身并未提供。' },
      { '^shared with (.+) %+(%d+)$', '与以下共用：%L1 等 %2 项' },
      { '^shared with (.+)$', '与以下共用：%L1' },
      { '^Reading the game\'s weapon tables%.%.%. %((%d+) of (%d+) found%)$', '正在读取游戏的武器数据表…（已找到 %1 / %2）' },
      { '^(%d+)%-(%d+) of (%d+) found$', '第 %1-%2 项 / 共 %3 项（搜索命中）' },
      { '^(%d+) found$', '共 %1 项命中' },
      { '^(%d+)%-(%d+) of (%d+) listed$', '第 %1-%2 项 / 共 %3 项' },
      { '^(%d+) listed$', '共 %1 项' },
      { '^(%d+)%-(%d+) of (%d+) %(max (%d+)%)$', '第 %1-%2 项 / 共 %3 项（上限 %4）' },
      { '^(%d+) %(max (%d+)%)$', '共 %1 项（上限 %2）' },
      { '^(%d+) value%(s%) for (%d+) weapon%(s%) / stratagem%(s%):$', '%1 项改动，涉及 %2 个武器 / 战略配备：' },
      { '^(%d+) value%(s%)$', '%1 项' },
      { '^On: your (%d+) change%(s%) are applied%.$', '开启：你的 %1 项改动已生效。' },
      { '^Off: the game\'s values everywhere; your (%d+) change%(s%) are kept for when you turn them on%.$', '关闭：使用游戏原值；你的 %1 项修改已保留，重新开启后生效。' },
      { '^%(untested%) Other players are in your game: arc chain length / split use the game\'s values%.$', '（未测试）你的对局中存在其他玩家：电弧连锁长度 / 分裂使用游戏数值。' },
      { '^%(untested%) On: your arc chain length / split apply with other players too %(arcs can stay on screen%)%.$', '（未测试）开启：你的电弧连锁长度 / 分裂对其他玩家同样生效（电弧可能留在屏幕上）。' },
      { '^%(untested%) Off: with other players, arc chain length / split use the game\'s values %(else arcs can stay on screen%)%.$', '（未测试）关闭：多人对局时电弧连锁长度 / 分裂使用游戏数值（否则电弧可能留在屏幕上）。' },
      { '^%(untested%) Arc chains: player count unavailable: .+; your values stay%.$', '（未测试）电弧连锁：暂时读不到玩家人数；你的数值仍会保留。' },
      { '^Also changes %((%d+)%):$', '同时影响 %1 项：' },
      { '^%+ (%d+) more$', '另有 %1 项' },
      { '^%+(%d+) more$', '另有 %1 项' },
      { '^(.+) applied per hit$', '%1：每次命中施加' },
      { '^(.+) applied per blast$', '%1：每次爆炸施加' },
      { '^(.+) duration %(s%)$', '%1持续时间（秒）' },
      { '^every (.+) source shares these %(other weapons, strikes, hazards, enemies%)$', '所有%1来源共用这组数值（其他武器、轨道打击、环境危害、敌人）' },
      { '^every (.+) source shares this %(other weapons, grenades, strikes%)$', '所有%1来源共用这组数值（其他武器、投掷物、轨道打击）' },
      { '^explosion: also the (.+)\'s$', '爆炸：同样适用于%1' },
      { '^damage: the same as the (.+)\'s %(above%)$', '伤害：同上方%1' },
      { '^also the (.+)\'s damage$', '伤害同样取自%1' },
      { '^direct hit: also the (.+) shot\'s$', '直击：同样适用于%1弹丸' },
      { '^direct hit: see the (.+) shot$', '直击：见%1弹丸' },
      { '^Stage (%d+) charge time %(s%)$', '第 %1 阶段充能时间（秒）' },
      { '^(.+) multiplier, min charge$', '%1倍率（最少充能）' },
      { '^(.+) multiplier, overcharge$', '%1倍率（过充）' },
      { '^(.+) durable$', '%1耐久比例' },
      { '^(.+) health$', '%1生命值' },
      { '^(.+) armor$', '%1护甲值' },
      { '^(.+) damage$', '%1伤害' },
      { '^Guard Dog backpack: the drone and the gun it carries%. (.+)$', '护卫犬背包：无人机与它携带的枪械。%1' },
      { '^(.+) stratagem %((.+)%)%.$', '%1战略配备（%2）。' },
      { '^Mounted on the (.+), (.+)%.$', '安装在%1、%2上。' },
      { '^Mounted on the (.+)%.$', '安装在%1上。' },
      { '^(.+): Left arm$', '%1：左臂' },
      { '^(.+): Right arm$', '%1：右臂' },
      { '^(.+): Main gun$', '%1：主炮' },
      { '^(.+): Driver gun$', '%1：驾驶员机枪' },
      { '^(.+): Turret$', '%1：炮塔' },
      { '^(.+): Gun$', '%1：枪械' },
      { '^(.+): Rack$', '%1：挂架' },
      { '^(.+): Weapon (%d+)$', '%1：武器 %2' },
      { '^(.+), ([A-Z][^%.,;:]+)%.$', '%1，%2。' },
      { '^Muzzle brake %((.+)%)$', '枪口制退器（%1）' },
      { '^Muzzle%. Only the (.+) comes with it%.$', '枪口：仅%1自带此枪口。' },
      { '^(.+)%. Its modifiers apply to every weapon fitted with it%.$', '%1：其修正项对每一件装配它的武器生效。' },
      { '^(.+)%. Its modifiers apply to every weapon loaded with it%.$', '%1：其修正项对每一件装载它的武器生效。' },
      { '^(.+) %(alternate%)$', '%1（另一弹种）' },
      { '^Rounds per (.+) %(empty%)$', '空枪时每个%1的装填弹数' },
      { '^Demolition force, stage (%d+)$', '破坏力：第 %1 阶段' },
      { '^Demolition force to destroy it %(direct hits%)$', '摧毁所需破坏力（直击）' },
      { '^Demolition force to destroy it$', '摧毁所需破坏力' },
      { '^Status (%d+)$', '状态 %1' },
      { '^Passive (%d+)$', '护甲被动 %1' },
      { '^Stat (%d+)$', '数值项 %1' },
      { '^Part (%d+)$', '部件 %1' },
      { '^Weapon (%d+)$', '武器 %1' },
      { '^Status effects %((.+)%)$', '状态效果（%1）' },
      { '^Status effect (%d+) %(choice%)$', '状态效果 %1（选择）' },
      { '^Status effect (%d+) strength per hit$', '状态效果 %1：每次命中强度' },
      { '^Status effect (%d+) strength per blast$', '状态效果 %1：每次爆炸强度' },
      { '^Applies: (.+)$', '施加：%1' },
      { '^Status effect (%d+) is not one player weapons apply%.$', '状态效果 %1 不属于玩家武器可施加的状态。' },
      { '^Give status effect (%d+) first %(the game reads them in order%)%.$', '请先设置状态槽 %1（游戏按顺序读取）。' },
      { '^Clear status effect (%d+) first %(the game reads them in order%)%.$', '请先清除状态槽 %1（游戏按顺序读取）。' },
      { '^No stratagem (%d+) to choose%.$', '没有编号为 %1 的可选战略配备。' },
      { '^Stratagem (%d+)$', '战略配备 %1' },
      { '^(.+) %(second mode%)$', '%1（第二模式）' },
      { '^(.+) explosion id$', '%1爆炸编号' },
      { '^(.+) fire %(id%)$', '%1发射的弹丸（编号）' },
      { '^(.+) shrapnel$', '%1破片' },
      { '^(.+) arc$', '%1电弧' },
      { '^(.+) shot$', '%1弹丸' },
      { '^(.+) explosion$', '%1爆炸' },
      { '^(.+) %(expiry%)$', '%1（存续结束）' },
      { '^(.+) %(not in this game build%)$', '%1（当前游戏版本中不存在）' },
      { '^explosion (%d+)$', '爆炸 %1' },
      { '^(.+) can be (.-) to (.-): set to (.-)%.$', '%1的范围为 %2 至 %3，已设为 %4。' },
      { '^(.+) Set to (.-)%.$', '%1 已设为 %2。' },
      { '^(.+) back to the original$', '%1 个恢复原值' },
      { '^could not replace (.+)$', '无法替换 %1' },
      { '^could not keep the original of (.+)$', '无法保留 %1 的原始文件' },
      { '^read%-back differs: (.+)$', '读回内容不一致：%1' },
      { '^the server answered (%d+)$', '服务器返回状态码 %1' },
      { '^no connection %((.-)%)$', '无法连接（%1）' },
      { '^(.+): written by an earlier install, and its original is gone$', '%1：由先前的写入操作生成，但原始文件已丢失' },
      { '^game%.dll not found in (.+)$', '在 %1 中未找到 game.dll' },
      { '^out of memory for (.+)$', '分配 %1 所需的内存不足' },
      { '^%((%d+) value%(s%) waiting for the scan%)$', '（%1 项数值等待扫描）' },
      { '^(%d+) weapons, (%d+) throwables, (%d+) stratagems, (%d+) vehicles, (%d+) attachments and (%d+) armor passives editable; (%d+) saved value%(s%) applied(.*)$', '可编辑：%1 件武器、%2 种投掷物、%3 项战略配备、%4 辆载具、%5 件配件、%6 种护甲被动；已应用 %7 项保存的数值%8' },
      { '^, (%d+) waiting(.*)$', '，%1 项等待处理%2' },
      { '^; tables not found: (.+)$', '；未找到的数据表：%L1' },
      { '^(.+), (%d+) waiting$', '%1，%2 项等待处理' },
      { '^(.+) multiplier$', '%1倍率' },
      { '^stages (.+)$', '阶段 %1' },
      { '^status (%d+)$', '状态 %1' },
      { '^BACKPACK%.%s*(.+)$', '背包：%1' },
      { '^CONSUMABLES%.%s*(.+)$', '消耗品：%1' },
      { '^EMPLACEMENTS%.%s*(.+)$', '部署设施：%1' },
      { '^MISSIONS%.%s*(.+)$', '任务：%1' },
      { '^MISSIONS CLAN STATION%.%s*(.+)$', '空间站任务：%1' },
      { '^PRESIDENT REWARDS%.%s*(.+)$', '总统奖励：%1' },
      { '^TEAM WEAPONS%.%s*(.+)$', '小队武器：%1' },
      { '^TANK%.%s*(.+)$', '坦克：%1' },
      { '^ORBITAL%.%s*(.+)$', '轨道：%1' },
      { '^EAGLE%.%s*(.+)$', '飞鹰：%1' },
      { '^STATUS EFFECTS %((.+)%)$', '状态效果（%1）' },
      { '^STATUS (%d+)$', '状态 %1' },
      { '^SHODAN Stat Editor v([%d%.]+)$', 'SHODAN 数值编辑器 v%1' },
    },
    prefix = {
      { 'PgUp/PgDn change weapon, Del resets, Ctrl+1-5 loads a weapon preset, Ctrl+Shift+1-5 saves one; ', 'PgUp/PgDn 切换武器，Del 重置，Ctrl+1-5 读取武器预设，Ctrl+Shift+1-5 保存预设；' },
      { 'Overwriting and deleting ask twice. Changes apply at once and are saved; ', '覆盖保存与删除需二次确认。修改会立即生效并保存；' },
      { 'The panel now opens and closes with ', '面板现在通过 ' },
      { 'Saved as StatEditor\\preset_', '已保存为 StatEditor\\preset_' },
      { 'Arc chains: player count ', '电弧连锁：玩家人数 ' },
      { 'No grenade choice ', '未选择投掷物：' },
      { 'No projectile ', '未选择弹丸：' },
      { 'Also changes (', '同时改动（' },
      { 'value(s) for ', '项改动，涉及 ' },
      { 'Now changed: ', '当前已修改：' },
      { '(untested) ', '（未测试）' },
      { 'unknown ', '未知 ' },
      { 'was ', '原为 ' },
    },
    suffix = {
      { ' value(s). Loading a preset replaces every current change with it.', ' 项改动。读取预设会覆盖当前所有修改。' },
      { ' change(s) are kept for when you turn them on.', ' 项改动将在你开启时保留。' },
      { ': in the game files, not offered by it.', '：存在于游戏文件中，但游戏本身并未提供。' },
      { '.txt (copy it to share the set).', '.txt（复制它即可分享该配置）。' },
      { ' weapon(s) / stratagem(s):', ' 个武器 / 战略配备：' },
      { ' change(s) are applied.', ' 项改动已应用。' },
      { '; your values stay.', '；你的数值仍会保留。' },
      { ' value(s) changed.', ' 项已修改。' },
      { ' charge time (s)', ' 充能时间(秒)' },
      { ' to open/close', ' 打开 / 关闭面板' },
      { ', min charge', '，最少充能' },
      { ', overcharge', '，过充' },
      { ' value(s)', ' 项' },
      { ' found)', ' 已找到)' },
      { ' listed', ' 项' },
      { ' found', ' 已找到' },
      { ' more', ' 更多' },
    },
  },
  { id = 'zh-Hant', name = '繁體中文', list = '、',
    fonts = { { font = '8a030b00915bbb37', atlas = '4f7e02a3f5a824ec' }, { font = '3da89f2c15b53d65', atlas = '86667f650dca00f9' } },
    exact = {
      ['"+ New preset" (or Insert) saves your current changes as one; you name it next.'] = '「+ 新建預設」（或 Insert 鍵）會把當前修改存為一組，接著你可以為它命名。',
      ['+ Add passive'] = '+ 新增被動',
      ['+ Armor rating'] = '護甲值',
      ['+ Ergonomics'] = '人機工效',
      ['+ New preset from current changes'] = '從當前修改新建預設',
      ['+ Stamina when hit'] = '受擊時耐力',
      ['+ Stim duration (s)'] = '治療劑持續時間（秒）',
      ['+ Stims (start, max)'] = '治療劑數量（初始 / 上限）',
      ['+ Throwables (start, max)'] = '手雷數量（初始 / 上限）',
      ['0 = normal projectile; - / + selects a throwable grenade by name above.'] = '0 = 常規射彈；- / + 按上方名稱選擇投擲手雷。',
      ['0: hits deal their normal damage, 1: their durable damage (the weapon\'s lower one)'] = '0：命中造成常規傷害；1：造成耐久傷害（取武器兩者中較低的一項）',
      ['100kg Bomb'] = '100KG炸彈',
      ['100kg Bomb Mk2'] = '100KG炸彈MK2',
      ['100kg Bomb Mk3'] = '100KG炸彈MK3',
      ['100kg Cluster Bomb'] = '100KG集束炸彈',
      ['10g Birdshot'] = '10g鳥彈',
      ['10g Buckshot'] = '10g鹿彈',
      ['10g Bugshot'] = '10g蟲彈',
      ['10g Dual Sabot'] = '10g雙脫殼彈',
      ['10g Flechettes'] = '10g飛鏢彈',
      ['10g Fragmentation'] = '10g破片彈',
      ['10g High Velocity Sabot'] = '10g高速脫殼彈',
      ['10g Liberty Fire'] = '10g自由之火散彈',
      ['10g Magnum'] = '10g麥格農散彈',
      ['10g Magnum Triball'] = '10g麥格農三式彈',
      ['10g Rifled Slugs'] = '10g線膛加重彈',
      ['10g STUN ROUNDS'] = '10g眩暈彈',
      ['10g Sabot'] = '10g脫殼彈',
      ['10g Scatter Shot'] = '10g散彈',
      ['10g Stun'] = '10g眩暈彈',
      ['10g Tri-Ball'] = '10g三式彈',
      ['10g. Duckbill'] = '10g. 扁平槍口',
      ['10g. Full Choke'] = '10g. 全收束器',
      ['10g. Half Choke'] = '10g. 半收束器',
      ['110mm Airburst Cannon Round'] = '110mm空爆炮彈',
      ['110mm Airburst Cannon Round Mk2'] = '110mm空爆炮彈MK2',
      ['110mm E.M.S. Cannon Round'] = '110mm電擊波炮彈',
      ['110mm E.M.S. Cannon Round Mk2'] = '110mm電擊波炮彈MK2',
      ['110mm E.M.S. Cannon Round Mk3'] = '110mm電擊波炮彈MK3',
      ['110mm Gas Cannon Round'] = '110mm毒氣炮彈',
      ['110mm Standard Rocket'] = '110mm標準火箭彈',
      ['110mm Standard Rocket Mk2'] = '110mm標準火箭彈MK2',
      ['12.5mm BCHP Rifle Rounds'] = '12.5mm鍵合中空步槍彈藥',
      ['12.5mm EIT Rounds'] = '12.5mm爆燃曳光彈',
      ['12.5mm Standard Rifle Rounds'] = '12.5mm標準步槍彈藥',
      ['120mm HE Cannon Round'] = '120mm高爆炮彈',
      ['12g Birdshot'] = '12g鳥彈',
      ['12g Buckshot'] = '12g鹿彈',
      ['12g Bugshot'] = '12g蟲彈',
      ['12g Flechettes'] = '12g飛鏢彈',
      ['12g Liberty Fire'] = '12g自由之火散彈',
      ['12g Magnum'] = '12g麥格農散彈',
      ['12g Magnum Triball'] = '12g麥格農三式彈',
      ['12g Scatter Shot'] = '12g散彈',
      ['12g Tri-Ball'] = '12g三式彈',
      ['12g. Duckbill'] = '12g. 扁平槍口',
      ['12g. Full Choke'] = '12g. 全收束器',
      ['12g. Half Choke'] = '12g. 半收束器',
      ['12mm. Compensator'] = '12mm. 補償器',
      ['12mm. Flash Hider'] = '12mm. 消焰器',
      ['12mm. Muzzle break'] = '12mm. 槍口制動器',
      ['12x25mm Explosive'] = '12x25mm炸彈',
      ['12x25mm Full Metal Jacket'] = '12x25mm全金屬被甲彈',
      ['12x25mm High Velocity'] = '12x25mm高速彈',
      ['12x25mm Hollow Point'] = '12x25mm中空彈',
      ['12x25mm Plasma'] = '12x25mm電漿彈',
      ['12x25mm Ripper'] = '12x25mm撕裂彈',
      ['12x25mm Thermite'] = '12x25mm鋁熱彈',
      ['12x25mm Toxic'] = '12x25mm毒氣彈',
      ['13x40mm Full Metal Jacket'] = '13x40mm全金屬被甲彈',
      ['13x40mm Hollow Point'] = '13x40mm中空彈',
      ['13x40mm Magnum'] = '13x40mm麥格農子彈',
      ['13x40mm Penetrator'] = '13x40mm穿甲彈',
      ['13x40mm Ripper'] = '13x40mm撕裂彈',
      ['15x100mm Emp-Rounds'] = '15x100mm電磁脈衝彈',
      ['15x100mm Fragmentation'] = '15x100mm破片彈',
      ['15x100mm High Explosive'] = '15x100mm高爆彈',
      ['15x100mm High Velocity'] = '15x100mm高速彈',
      ['15x100mm Plasma'] = '15x100mm電漿彈',
      ['15x100mm Standard Rocket'] = '15x100mm標準火箭彈',
      ['15x100mm Thermite'] = '15x100mm鋁熱彈',
      ['15x100mm Toxic'] = '15x100mm毒氣彈',
      ['20mm APHET Rounds'] = '20mm穿甲高爆彈',
      ['20mm Flak Rounds'] = '20mm高射炮彈',
      ['20mm HE Cannon'] = '20mm高爆炮彈',
      ['20mm HVAP Rounds'] = '20mm高速穿甲彈',
      ['23mm HE Cannon'] = '23mm高爆炮彈',
      ['30mm APHE Cannon'] = '30mm穿甲高爆炮彈',
      ['380mm HE Cannon Round'] = '380mm高爆炮彈',
      ['40-K Meltagun'] = '40-K 熱熔槍',
      ['40mm APHE Cannon'] = '40mm穿甲高爆炮彈',
      ['40mm Flak Cannon'] = '40mm高射炮彈',
      ['40mm HE Grenade'] = '40mm高爆手榴彈',
      ['40mm HE Mortar'] = '40mm高爆迫擊炮彈',
      ['40mm HEAT Grenade'] = '40mm反戰車高爆彈',
      ['40mm Proximity Grenade'] = '40mm感應式手榴彈',
      ['5,5mm. Compensator'] = '5,5mm. 補償器',
      ['5,5mm. Flash Hider'] = '5,5mm. 消焰器',
      ['5,5mm. Muzzle break'] = '5,5mm. 槍口制動器',
      ['5.5x50mm Devastator'] = '5.5x50mm毀滅者彈',
      ['5.5x50mm Double Power'] = '5.5x50mm雙效彈',
      ['5.5x50mm Explosive'] = '5.5x50mm炸彈',
      ['5.5x50mm Full Metal Jacket'] = '5.5x50mm全金屬被甲彈',
      ['5.5x50mm High Velocity'] = '5.5x50mm高速彈',
      ['5.5x50mm Hollow-Point'] = '5.5x50mm中空彈',
      ['5.5x50mm Penetrator'] = '5.5x50mm穿甲彈',
      ['5.5x50mm Ripper'] = '5.5x50mm撕裂彈',
      ['5.5x50mm Self Propelled'] = '5.5x50mm自走彈',
      ['5.5x50mm Subsonic'] = '5.5x50mm次音速彈',
      ['5.5x50mm Super Uranium Core'] = '5.5x50mm超鈾核心彈',
      ['500kg Bomb'] = '500kg炸彈',
      ['500kg Bomb Mk2'] = '500kg炸彈MK2',
      ['500kg Bomb Mk3'] = '500kg炸彈MK3',
      ['66mm Missile'] = '66mm飛彈',
      ['66mm Missile Mk2'] = '66mm飛彈MK2',
      ['70mm Laser-Guided Missile'] = '70mm雷射導引飛彈',
      ['70mm Laser-Guided Missile Mk2'] = '70mm雷射導引飛彈MK2',
      ['70mm Standard Rocket'] = '70mm標準火箭彈',
      ['75mm HEAT Grenade'] = '75mm反戰車高爆彈',
      ['85mm HEAT Grenade'] = '85mm反戰車高爆彈',
      ['85mm HEAT Grenade Mk2'] = '85mm反戰車高爆彈MK2',
      ['85mm High-Explosive Grenade'] = '85mm高爆手榴彈',
      ['85mm High-Explosive Grenade Mk2'] = '85mm高爆手榴彈MK2',
      ['8mm. Compensator'] = '8mm. 補償器',
      ['8mm. Flash Hider'] = '8mm. 消焰器',
      ['8mm. Muzzle break'] = '8mm. 槍口制動器',
      ['8x60mm Airburst'] = '8x60mm空爆彈',
      ['8x60mm Devastator'] = '8x60mm毀滅者彈',
      ['8x60mm Double Power'] = '8x60mm雙效彈',
      ['8x60mm Explosive'] = '8x60mm炸彈',
      ['8x60mm Full Metal Jacket'] = '8x60mm全金屬被甲彈',
      ['8x60mm High Velocity'] = '8x60mm高速彈',
      ['8x60mm Liberty Fire'] = '8x60mm自由之火子彈',
      ['8x60mm Penetrator'] = '8x60mm穿甲彈',
      ['8x60mm Sniper Armour Piercing'] = '8x60mm狙擊穿甲彈',
      ['8x60mm Subsonic'] = '8x60mm次音速彈',
      ['8x60mm Super Uranium Core'] = '8x60mm超鈾核心彈',
      ['9mm. Compensator'] = '9mm. 補償器',
      ['9mm. Flash Hider'] = '9mm. 消焰器',
      ['9mm. Muzzle break'] = '9mm. 槍口制動器',
      ['9x20mm Explosive'] = '9x20mm炸彈',
      ['9x20mm Full Metal Jacket'] = '9x20mm全金屬被甲彈',
      ['9x20mm High Velocity'] = '9x20mm高速彈',
      ['9x20mm Hollow Point'] = '9x20mm中空彈',
      ['9x20mm Plasma'] = '9x20mm電漿彈',
      ['9x20mm Ripper'] = '9x20mm撕裂彈',
      ['9x20mm Thermite'] = '9x20mm鋁熱彈',
      ['9x20mm Toxic'] = '9x20mm毒氣彈',
      ['9x70mm Full Metal Jacket'] = '9x70mm全金屬被甲彈',
      ['9x70mm High Velocity'] = '9x70mm高速彈',
      ['9x70mm Penetrator'] = '9x70mm穿甲彈',
      ['9x70mm Self Propelled'] = '9x70mm自走彈',
      ['9x70mm Sniper Armour Piercing'] = '9x70mm狙擊穿甲彈',
      ['9x70mm Socom Assassin'] = '9x70mm特種暗殺彈',
      ['9x70mm Super Uranium Core'] = '9x70mm超鈾核心彈',
      ['A mounted cannon with a seat, dropped by hellpod. Not the one you carry.'] = '帶座位的固定火炮，由空投艙投送。不是你攜帶的那把。',
      ['A mounted copy aimed by AI. Not the one you carry.'] = '由 AI 瞄準的固定版本。不是你攜帶的那把。',
      ['A mounted copy run by AI (emplacement-style). Not the one you carry.'] = '由 AI 操作的固定版本（炮台式）。不是你攜帶的那把。',
      ['A mounted copy. Not the one you carry.'] = '固定版本。不是你攜帶的那把。',
      ['A preset keeps every change you have made as one set, under a name you choose.'] = '預設會把你所有的修改作為一組儲存，並取一個你指定的名字。',
      ['A/AC-8 Autocannon Sentry'] = 'A/AC-8 哨戒機炮',
      ['A/ARC-3 Tesla Tower'] = 'A/ARC-3 特斯拉塔',
      ['A/FLAM-40 Flame Sentry'] = 'A/FLAM-40 火焰火箭炮',
      ['A/G-16 Gatling Sentry'] = 'A/G-16 哨戒格林炮',
      ['A/GM-17 Gas Mortar Sentry'] = 'A/GM-17 毒氣彈哨戒迫擊炮',
      ['A/LAS-98 Laser Sentry'] = 'A/LAS-98 雷射哨戒炮',
      ['A/M-12 Mortar Sentry'] = 'A/M-12 哨戒迫擊炮',
      ['A/M-23 EMS Mortar Sentry'] = 'A/M-23 電磁干擾哨戒迫擊炮',
      ['A/MG-43 Machine Gun Sentry'] = 'A/MG-43 哨戒機槍',
      ['A/MLS-4X Rocket Sentry'] = 'A/MLS-4X 哨戒火箭炮',
      ['AC-8 Autocannon'] = 'AC-8 機炮',
      ['AMMO'] = '彈藥',
      ['AMW-20 Apex'] = 'AMW-20 巔峰',
      ['APW-1 Anti-Materiel Rifle'] = 'APW-1 反器材步槍',
      ['AR-11 Arbitrator'] = 'AR-11 仲裁者',
      ['AR-11 Arbitrator (underbarrel shotgun)'] = 'AR-11 仲裁者（下掛霰彈槍）',
      ['AR-2 Coyote'] = 'AR-2 郊狼',
      ['AR-23 Liberator'] = 'AR-23 解放者',
      ['AR-23A Liberator Carbine'] = 'AR-23A 卡賓槍解放者',
      ['AR-23C Liberator Concussive'] = 'AR-23C 震盪解放者',
      ['AR-23L Liberator Legacy'] = 'AR-23L 解放者「榮光」',
      ['AR-23P Liberator Penetrator'] = 'AR-23P 穿甲解放者',
      ['AR-32 Pacifier'] = 'AR-32 安撫者',
      ['AR-59 Suppressor'] = 'AR-59 消音器',
      ['AR-61 Tenderizer'] = 'AR-61 肉錘',
      ['AR/GL-21 One-Two'] = 'AR/GL-21 雙響',
      ['AR/GL-21 One-Two (grenade launcher)'] = 'AR/GL-21 雙響（下掛榴彈發射器）',
      ['ARC'] = '電弧',
      ['ARC-12 Blitzer'] = 'ARC-12 閃擊者',
      ['ARC-3 Arc Thrower'] = 'ARC-3 電弧發射器',
      ['AX/AR-23 "Guard Dog"'] = 'AX/AR-23 護衛犬',
      ['AX/ARC-3 "Guard Dog" K-9'] = 'AX/ARC-3 護衛犬 K-9',
      ['AX/FLAM-75 "Guard Dog" Hot Dog'] = 'AX/FLAM-75 護衛犬熱狗',
      ['AX/LAS-5 "Guard Dog" Rover'] = 'AX/LAS-5 護衛犬漫遊者',
      ['AX/TX-13 "Guard Dog" Dog Breath'] = 'AX/TX-13 護衛犬腐氣',
      ['Acceleration (m/s2)'] = '加速度(米/秒^2)',
      ['Accelerator Rifle'] = '加速步槍',
      ['Acclimated'] = '適應自如',
      ['Acid'] = '酸液',
      ['Adjudicator'] = '審判者',
      ['Adreno-Defibrillator'] = '腎上腺素除顫器',
      ['Advanced Filtration'] = '進階過濾',
      ['Aiming sway'] = '瞄準晃動',
      ['Airburst Rocket Launcher'] = '空爆火箭發射器',
      ['Also includes'] = '同時包含',
      ['Alternate ammunition'] = '備用彈藥',
      ['Amendment'] = '修正',
      ['Ammo'] = '彈藥',
      ['Ammo at the start'] = '初始彈藥',
      ['Ammo capacity'] = '彈藥容量',
      ['Ammo carried'] = '攜帶彈藥',
      ['Ammo from resupply'] = '補給箱補充彈藥',
      ['Ammunition'] = '彈藥',
      ['Angled Foregrip'] = '斜角前握把',
      ['Angled Foregrip Advanced'] = '進階斜角前握把',
      ['Angled Foregrip With Laser'] = '雷射斜角前握把',
      ['Another copy of this weapon, not identified yet.'] = '該武器的另一份副本，尚未識別。',
      ['Antenna'] = '天線',
      ['Anti-Air Missile'] = '防空飛彈',
      ['Anti-Materiel Rifle'] = '反器材步槍',
      ['Anti-Tank Emplacement'] = '反坦克炮台',
      ['Anti-Tank Seeker'] = '反坦克追擊者',
      ['Apex'] = '巔峰',
      ['Apply my changes'] = '應用我的修改',
      ['Arbitrator'] = '仲裁者',
      ['Arc'] = '電弧',
      ['Arc Thrower'] = '電弧發射器',
      ['Arc chain edits in multiplayer'] = '多人模式下修改電弧連鎖',
      ['Arc chains'] = '電弧連鎖',
      ['Arc chains use the game\'s values while other players are in your game (see Settings).'] = '對局中有其他玩家時，電弧連鎖使用遊戲原值（詳見設定）。',
      ['Arc damage taken'] = '受到的電弧傷害',
      ['Arc splits'] = '電弧分裂',
      ['Arming distance (m)'] = '起爆距離(米)',
      ['Arming time (s)'] = '佈防時間(秒)',
      ['Armor'] = '護甲',
      ['Armor pen. (direct)'] = '穿甲(直射)',
      ['Armor pen. (extreme angle)'] = '穿甲(極端角度)',
      ['Armor pen. (large angle)'] = '穿甲(大角度)',
      ['Armor pen. (slight angle)'] = '穿甲(小角度)',
      ['Armors'] = '護甲',
      ['Ask'] = '詢問',
      ['Assault Rifle'] = '突擊步槍',
      ['Attachment'] = '配件',
      ['Attachments'] = '配件',
      ['Autocannon'] = '機炮',
      ['Autocannon Sentry'] = '哨戒機炮',
      ['Automatic'] = '自動',
      ['B-1 Supply Pack'] = 'B-1 補給背包',
      ['B-100 Portable Hellbomb'] = 'B-100 可攜式絕地彈',
      ['B/FLAM-80 Cremator'] = 'B/FLAM-80 火葬者',
      ['B/MD C4 Pack'] = 'B/MD C4背包',
      ['BACKPACK'] = '背包',
      ['BARRAGE'] = '彈幕',
      ['BLAST'] = '爆炸',
      ['BLAST RADIUS'] = '爆炸半徑',
      ['BODY PARTS'] = '身體部位',
      ['BR-14 Adjudicator'] = 'BR-14 審判者',
      ['BURST'] = '爆風',
      ['BURST RADIUS'] = '爆風半徑',
      ['Back'] = '返回',
      ['Back door block'] = '後艙門塊',
      ['Back hatch'] = '後艙蓋',
      ['Back periscope side 8'] = '潛望鏡後側 8',
      ['Background opacity'] = '背景不透明度',
      ['Backpack'] = '背包',
      ['Ballistic Padding'] = '防彈襯墊',
      ['Ballistic Shield Backpack'] = '彈道防護罩背包',
      ['Ballistic shield'] = '防彈盾',
      ['Barrage'] = '彈幕',
      ['Bastion MK XVI'] = '堡壘Mk XVI',
      ['Belt-Fed Grenade Launcher'] = '彈鏈式榴彈發射器',
      ['Bingus Shared Loader by CowboyBingus'] = 'Bingus 共享載入器 · CowboyBingus',
      ['Blast'] = '爆炸',
      ['Blast angle (deg)'] = '爆炸角(度)',
      ['Blast delay (s)'] = '爆炸延遲(秒)',
      ['Blast proximity (m)'] = '爆炸接近度(米)',
      ['Blast radius'] = '爆炸半徑',
      ['Blitzer'] = '閃擊者',
      ['Block game input while open'] = '開啟時遮蔽遊戲輸入',
      ['Blunt-Force Mitigation'] = '鈍擊緩解',
      ['Body health'] = '軀幹生命值',
      ['Body parts'] = '身體部位',
      ['Bolt Pistol'] = '爆彈手槍',
      ['Bonnet'] = '引擎蓋',
      ['Boost after the launch (s)'] = '發射後加速(秒)',
      ['Breacher'] = '突破者',
      ['Breaching Hammer'] = '破門戰錘',
      ['Break-Action Shotgun'] = '中折式散彈槍',
      ['Breaker'] = '破裂者',
      ['Breaker Incendiary'] = '燃燒破裂者',
      ['Breaker Spray&Pray'] = '掃射破裂者',
      ['Breakthrough Exosuit'] = '突破外骨骼裝甲',
      ['Bullet Storm'] = '子彈風暴',
      ['Burn time (s)'] = '燃燒時間(秒)',
      ['Burning'] = '燃燒',
      ['Burning applied to you'] = '對你施加的燃燒',
      ['Burst'] = '爆風',
      ['Burst radius'] = '爆風半徑',
      ['Bushwhacker'] = '游擊者',
      ['CB-9 Exploding Crossbow'] = 'CB-9 猛爆十字弓',
      ['CHARGE'] = '充能',
      ['CLUSTER BOMB'] = '集束炸彈',
      ['CQC-1 One True Flag'] = 'CQC-1 唯一真旗',
      ['CQC-19 Stun Lance'] = 'CQC-19 暈眩長槍',
      ['CQC-2 Saber'] = 'CQC-2 軍刀',
      ['CQC-20 Breaching Hammer'] = 'CQC-20 破門戰錘',
      ['CQC-30 Stun Baton'] = 'CQC-30 暈眩棍',
      ['CQC-42 Machete'] = 'CQC-42 彎刀',
      ['CQC-5 Combat Hatchet'] = 'CQC-5 戰鬥斧',
      ['CQC-72 Entrenchment Tool'] = 'CQC-72 挖掘工具',
      ['CQC-73 Entrenchment Tool'] = 'CQC-73 挖掘工具',
      ['CQC-9 Defoliation Tool'] = 'CQC-9 除草器',
      ['Calibre (mm)'] = '口徑(毫米)',
      ['Caltrops'] = '蒺藜',
      ['Camera shake radius (m)'] = '鏡頭震動半徑(米)',
      ['Cancel'] = '取消',
      ['Censor'] = '審查官',
      ['Chain length'] = '連鎖長度',
      ['Chain reaction delay (s)'] = '連鎖延遲(秒)',
      ['Chain split'] = '連鎖分裂',
      ['Changed since the last install: Install to put it in the game.'] = '自上次安裝後已有修改：點選安裝以寫入遊戲。',
      ['Charge'] = '充能',
      ['Charge when it comes back'] = '恢復後初始充能',
      ['Charged'] = '蓄力',
      ['Charged explosion'] = '蓄力爆炸',
      ['Charged shot'] = '蓄力射擊',
      ['Charges'] = '使用次數',
      ['Charges from resupply'] = '補給箱補充的使用次數',
      ['Chest bleeding damage'] = '胸部流血傷害',
      ['Chest damage taken'] = '受到胸部傷害',
      ['Choose a weapon on the left.'] = '請在左側選擇武器。',
      ['Clear'] = '清除',
      ['Click again to overwrite'] = '再次點選以覆蓋',
      ['Climb acceleration'] = '爬升加速度',
      ['Climb multiplier (horizontal)'] = '攀爬倍率(水平)',
      ['Climb multiplier (vertical)'] = '攀爬倍率(垂直)',
      ['Climb speed (m/s)'] = '爬升速度(米/秒)',
      ['Climb time limit (s)'] = '爬升時限(秒)',
      ['Cluster Bomb'] = '集束炸彈',
      ['Combat Hatchet'] = '戰鬥斧',
      ['Combat Scope 4x'] = '4倍戰鬥瞄具',
      ['Commando'] = '突擊兵',
      ['Concealment when still, crouched / prone'] = '靜止蹲伏或臥倒時的隱蔽',
      ['Concussive Padding (Grenadier)'] = '擲彈兵防震盪襯墊',
      ['Concussive Padding (Hazmat)'] = '危害物質防震盪襯墊',
      ['Concussive Padding (Reinforced)'] = '強化防震盪襯墊',
      ['Cone angle (deg)'] = '錐角(度)',
      ['Constitution'] = '憲法',
      ['Consumables'] = '消耗品',
      ['Contact Mine'] = '水雷',
      ['Cookout'] = '燎原',
      ['Cool-down time after overheat (s)'] = '過熱後冷卻時間（秒）',
      ['Cool-down time, full heat (s)'] = '滿熱量冷卻時間（秒）',
      ['Cooldown (s)'] = '冷卻時間(秒)',
      ['Cooling (% per s)'] = '散熱(每秒%)',
      ['Copy'] = '複製',
      ['Coyote'] = '郊狼',
      ['Cremator'] = '火葬者',
      ['Crisper'] = '火舌',
      ['Crouched jog speed (m/s)'] = '蹲伏慢跑速度(米/秒)',
      ['Crouched speed while aiming (m/s)'] = '蹲伏瞄準時速度(米/秒)',
      ['Crouched sprint speed (m/s)'] = '蹲伏衝刺速度(米/秒)',
      ['Crouched walk speed (m/s)'] = '蹲伏步行速度(米/秒)',
      ['Cruise speed (m/s)'] = '巡航速度(米/秒)',
      ['DAMAGE'] = '傷害',
      ['DBS-2 Double Freedom'] = 'DBS-2 雙重自由',
      ['DEPLOYER'] = '部署艙',
      ['DIRECT HIT'] = '直擊',
      ['Dagger'] = '匕首',
      ['Damage'] = '傷害',
      ['Damage tick (s)'] = '傷害間隔(秒)',
      ['Damage to you'] = '對你造成的傷害',
      ['De-Escalator'] = '緩和使者',
      ['Deadeye'] = '鷹眼',
      ['Defender'] = '防衛者',
      ['Defoliation Tool'] = '除草器',
      ['Delete'] = '刪除',
      ['Democracy Protects'] = '民主守護者',
      ['Demolition force'] = '拆毀力',
      ['Deployer'] = '部署艙',
      ['Desert Stormer'] = '沙塵暴之王',
      ['Diligence'] = '勤勉',
      ['Diligence Counter Sniper'] = '反狙擊勤勉',
      ['Direct hit'] = '直擊',
      ['Directional Shield'] = '定向護盾',
      ['Dive cost (share of stamina)'] = '飛撲消耗(體力佔比)',
      ['Dominator'] = '主導者',
      ['Double Freedom'] = '雙重自由',
      ['Double-Edge Sickle'] = '雙刃鐮刀',
      ['Down'] = '下移',
      ['Drag factor'] = '阻力系數',
      ['Driver gun'] = '駕駛員機槍',
      ['Drone'] = '無人機',
      ['Drum Magazine'] = '彈鼓',
      ['Dune Walker Sniper Scope 10x'] = '10倍狙擊鏡',
      ['Durable damage'] = '耐傷傷害',
      ['Durable ratio (0-1)'] = '耐傷比例(0-1)',
      ['Duration (s)'] = '持續時間(秒)',
      ['Dynamite'] = '炸藥',
      ['E/AT-12 Anti-Tank Emplacement'] = 'E/AT-12 反坦克炮台',
      ['E/GL-21 Grenadier Battlement'] = 'E/GL-21 擲彈兵掩體',
      ['E/MG-101 HMG Emplacement'] = 'E/MG-101 重機槍炮台',
      ['EAGLE'] = '飛鷹',
      ['EAT-17 Expendable Anti-Tank'] = 'EAT-17 反坦克消耗品',
      ['EAT-17 Expendable Anti-Tank (SEAF)'] = 'EAT-17 反坦克消耗品（SEAF）',
      ['EAT-411 Leveller'] = 'EAT-411 夷平者',
      ['EAT-700 Expendable Napalm'] = 'EAT-700 消耗型凝固汽油彈',
      ['EMS Mortar Sentry'] = '電磁干擾哨戒迫擊炮',
      ['EXO-45 Patriot Exosuit'] = 'EXO-45 愛國者外骨骼裝甲',
      ['EXO-49 Emancipator Exosuit'] = 'EXO-49 解放者外骨骼裝甲',
      ['EXO-51 Lumberer Exosuit'] = 'EXO-51 伐木工外骨骼裝甲',
      ['EXO-55 Breakthrough Exosuit'] = 'EXO-55 突破外骨骼裝甲',
      ['Each arm'] = '每條手臂',
      ['Each leg'] = '每條腿',
      ['Eagle'] = '飛鷹',
      ['Eagle 110mm Rocket Pods'] = '飛鷹110mm火箭莢艙',
      ['Eagle 500kg Bomb'] = '飛鷹500kg炸彈',
      ['Eagle Airstrike'] = '飛鷹空襲',
      ['Eagle Cluster Bomb'] = '飛鷹集束炸彈',
      ['Eagle Gas Airstrike'] = '飛鷹毒氣空襲',
      ['Eagle Napalm Airstrike'] = '飛鷹凝固汽油彈空襲',
      ['Eagle Smoke Strike'] = '飛鷹煙霧突襲',
      ['Eagle Strafing Run'] = '飛鷹機槍掃射',
      ['Eagle rearm time (s)'] = '飛鷹補充時間(秒)',
      ['Eagle strike. The rearm time is shared by every Eagle.'] = '飛鷹打擊。所有飛鷹共用同一重新整備時間。',
      ['Edit the grenade on Throwables to tune it. Assets load before selection applies.'] = '在「投擲物」頁編輯該手雷即可調整。資源載入完成後選擇才會生效。',
      ['Electrical Conduit'] = '電氣管線',
      ['Emancipator Exosuit'] = '解放者外骨骼裝甲',
      ['Emplacement'] = '炮台',
      ['Emplacement: its cooldown, its body, then its weapon.'] = '炮台：依次為冷卻時間、本體、武器。',
      ['Enemy detection range'] = '敵人偵測範圍',
      ['Engineering Kit'] = '工程套組',
      ['Entrenchment Tool'] = '挖掘工具',
      ['Epoch'] = '紀元',
      ['Ergonomics'] = '人機工效',
      ['Ergonomics bonus'] = '人機工效加成',
      ['Eruptor'] = '噴發者',
      ['Every armor with this passive gets their effects too (set on their own pages).'] = '擁有此被動的所有護甲也會獲得它們的效果（在各自頁面設定）。',
      ['Every change as soon as it is pushed, before testing: it may break.'] = '每項更改一經推送即更新，未經測試：可能出錯。',
      ['Every commit'] = '每次提交',
      ['Every helldiver in your game. Restore the game\'s files before joining other players\' lobbies.'] = '你遊戲中的所有絕地潛兵。加入其他玩家的大廳前，請先恢復遊戲檔案。',
      ['Every passive is in already.'] = '所有被動都已新增。',
      ['Evictor'] = '驅離者',
      ['Expendable Anti-Tank'] = '反坦克消耗品',
      ['Expendable Napalm'] = '消耗型凝固汽油彈',
      ['Expiry explosion (id)'] = '到期爆炸 (ID)',
      ['Explodes after death (s)'] = '死亡後爆炸（秒）',
      ['Exploding Crossbow'] = '猛爆十字弓',
      ['Explosion'] = '爆炸',
      ['Explosion (expiry)'] = '爆炸（時效結束）',
      ['Explosion id'] = '爆炸 ID',
      ['Explosive damage taken'] = '受到爆炸傷害',
      ['Extended Magazine'] = '擴充彈匣',
      ['Extra Padding'] = '額外填充',
      ['FAF-14 Spear'] = 'FAF-14 長矛',
      ['FIRE'] = '開火',
      ['FLAM-40 Flamethrower'] = 'FLAM-40 火焰噴射器',
      ['FLAM-66 Torcher'] = 'FLAM-66 噴火者',
      ['Feet First'] = '護腿優先',
      ['Field depth (m)'] = '佈設縱深(米)',
      ['Field width (m)'] = '佈設寬度(米)',
      ['Finding the stats...'] = '正在查詢數值...',
      ['Fire'] = '開火',
      ['Fire damage taken'] = '受到火焰傷害',
      ['Fire duration (s)'] = '持續燃燒時間(秒)',
      ['Fire rate (RPM)'] = '射速（RPM）',
      ['Fire/gas/acid/arc damage taken'] = '受到火焰 / 毒氣 / 酸液 / 電弧傷害',
      ['Flame Sentry'] = '火焰火箭炮',
      ['Flames'] = '火焰噴射器',
      ['Flames Mk2'] = '火焰噴射器MK2',
      ['Flamethrower'] = '火焰噴射器',
      ['Flashlight'] = '手電筒',
      ['Flinch'] = '僵直',
      ['Flinch (0 prevents it)'] = '僵直（0 為免疫）',
      ['Folder'] = '資料夾',
      ['Folder path copied.'] = '已複製資料夾路徑。',
      ['Fortified'] = '強化',
      ['Forward share of the launch (0-1)'] = '起跳前衝佔比(0-1)',
      ['Found in the game data (not in the built-in list).'] = '在遊戲資料中找到（不在內建列表中）。',
      ['Frag'] = '破片彈',
      ['From supply'] = '來自補給',
      ['Front hull'] = '前車體',
      ['Front left cockpit'] = '左前駕駛艙',
      ['Front right cockpit'] = '右前駕駛艙',
      ['Full charge'] = '充滿',
      ['Full charge explosion'] = '滿蓄力爆炸',
      ['Full charge shot'] = '滿蓄力射擊',
      ['Fuse time (s)'] = '引信時間(秒)',
      ['G-10 Incendiary'] = 'G-10 燃燒彈',
      ['G-109 Urchin'] = 'G-109 海膽',
      ['G-11 Caltrops'] = 'G-11 蒺藜',
      ['G-12 High Explosive'] = 'G-12 高爆彈',
      ['G-123 Thermite'] = 'G-123 鋁熱彈',
      ['G-13 Incendiary Impact'] = 'G-13 衝擊燃燒彈',
      ['G-142 Pyrotech'] = 'G-142 煙火表演',
      ['G-16 Impact'] = 'G-16 衝擊彈',
      ['G-23 Stun'] = 'G-23 暈眩彈',
      ['G-3 Smoke'] = 'G-3 煙霧彈',
      ['G-31 Arc'] = 'G-31 電弧',
      ['G-4 Gas'] = 'G-4 毒氣彈',
      ['G-48 Giga Grenade'] = 'G-48 巨型手榴彈',
      ['G-50 Seeker'] = 'G-50 追擊者',
      ['G-6 Frag'] = 'G-6 破片彈',
      ['G-60 Anti-Tank Seeker'] = 'G-60 反坦克追擊者',
      ['G-7 Pineapple'] = 'G-7 鳳梨',
      ['G-8 Immolation'] = 'G-8 焚毀',
      ['G-89 Smokescreen'] = 'G-89 煙幕',
      ['G/40-K Melta Mine'] = 'G/40-K 熱熔地雷',
      ['G/SH-39 Shield'] = 'G/SH-39 防護罩',
      ['GATER'] = 'GATER',
      ['GL-15 Evictor'] = 'GL-15 驅離者',
      ['GL-21 Grenade Launcher'] = 'GL-21 榴彈發射器',
      ['GL-28 Belt-Fed Grenade Launcher'] = 'GL-28 彈鏈式榴彈發射器',
      ['GL-52 De-Escalator'] = 'GL-52 緩和使者',
      ['GP-20 Ultimatum'] = 'GP-20 最後通牒',
      ['GP-31 Grenade Pistol'] = 'GP-31 榴彈槍',
      ['GR-8 Recoilless Rifle'] = 'GR-8 無後座力炮',
      ['GRENADE SWAP'] = '手雷交換',
      ['Gallant'] = '英勇',
      ['Gas'] = '毒氣彈',
      ['Gas Mortar Sentry'] = '毒氣彈哨戒迫擊炮',
      ['Gas damage taken'] = '受到毒氣傷害',
      ['Gatling Sentry'] = '哨戒格林炮',
      ['Generator'] = '發電機',
      ['Giga Grenade'] = '巨型手榴彈',
      ['GitHub'] = 'GitHub',
      ['GitHub link copied.'] = '已複製 GitHub 連結。',
      ['Gravity factor'] = '重力系數',
      ['Grenade'] = '手雷',
      ['Grenade Launcher'] = '榴彈發射器',
      ['Grenade Pistol'] = '榴彈槍',
      ['Grenade fired (choice)'] = '發射手雷(選擇)',
      ['Grenade selection takes priority over Projectile swap. Fire rate, ammo and handling stay.'] = '手雷選擇優先於彈種交換。射速、彈藥與操控保持不變。',
      ['Grenade swap'] = '手雷交換',
      ['Grenade swap stopped (see the log); launchers fire their own projectiles again.'] = '已停止榴彈替換（詳見日誌）；發射器恢復使用自身射彈。',
      ['Grenadier Battlement'] = '擲彈兵掩體',
      ['Ground All-Terrain Extraction Rig (GATER)'] = '全地形越野鑽機（GATER）',
      ['Guidance on after (s)'] = '導引啟動延遲(秒)',
      ['Gun'] = '槍械',
      ['Gunner FRV'] = '炮手FRV',
      ['Gunslinger'] = '神槍手',
      ['HANDLING'] = '操控',
      ['HMG Emplacement'] = '重機槍炮台',
      ['Halt'] = '制止者',
      ['Handling'] = '操控',
      ['Head'] = '頭部',
      ['Head health'] = '頭部生命值',
      ['Health'] = '生命值',
      ['Health Pack Rack'] = '醫療包架',
      ['Heat'] = '熱量',
      ['Heat per second firing'] = '射擊時每秒積熱',
      ['Heat per shot'] = '每發積熱',
      ['Heat per warp (%)'] = '每次躍遷熱量（%）',
      ['Heatsinks from supply'] = '補給散熱片',
      ['Heavy Machine Gun'] = '重機槍',
      ['Heavy burning'] = '重度燃燒',
      ['Helldiver'] = '絕地潛兵',
      ['Helldivers 2 is running: close it, then Install.'] = 'Helldivers 2 正在執行：請先關閉遊戲，再點選安裝。',
      ['Helldivers 2 is running: close it, then restore.'] = 'Helldivers 2 正在執行：請先關閉遊戲，再恢復。',
      ['Helldivers 2 is running: you can edit, but close it before you Install.'] = 'Helldivers 2 正在執行：可以繼續編輯，但安裝前請先關閉遊戲。',
      ['High Capacity Heatsink'] = '大容量散熱器',
      ['High Dissipation Heatsink'] = '高效能散熱器',
      ['High Explosive'] = '高爆彈',
      ['High-Velocity Shrapnel'] = '高速榴散彈',
      ['Hips'] = '腰部',
      ['Homing Anti-Air Missile'] = '地對地飛彈',
      ['Homing Ground Missile'] = '地對地飛彈',
      ['Homing Ground Missile Mk2'] = '地對地飛彈MK2',
      ['Hot-Shot Marksman Rifle'] = '火燙神射手步槍',
      ['Hover Pack'] = '懸浮背包',
      ['Hover agility (acceleration)'] = '懸停敏捷度(加速度)',
      ['Hover pack'] = '懸浮背包',
      ['Hover speed (m/s)'] = '懸停速度(米/秒)',
      ['Hover time, full-speed climb (s)'] = '懸停時間：全速爬升(秒)',
      ['Hover time, holding height (s)'] = '懸停時間：保持高度(秒)',
      ['Hyena'] = '土狼',
      ['Immolation'] = '焚毀',
      ['Impact'] = '衝擊彈',
      ['Impact damage taken'] = '受到衝擊傷害',
      ['Impact explosion (id)'] = '命中爆炸 (ID)',
      ['Incendiary'] = '燃燒彈',
      ['Incendiary Impact'] = '衝擊燃燒彈',
      ['Incinerator FRV'] = '焚燒者FRV',
      ['Inflammable'] = '易燃物',
      ['Injures you above heat (%)'] = '超過此熱量會灼傷(%)',
      ['Inner radius (m)'] = '內半徑(米)',
      ['Install into the game'] = '安裝到遊戲',
      ['Installing: finding what changed...'] = '安裝中：正在查詢改動...',
      ['Installing: writing the files...'] = '安裝中：正在寫入檔案...',
      ['Integrated Explosives'] = '整合型炸藥',
      ['Interface language'] = '介面語言',
      ['Iron Sights'] = '金屬瞄具',
      ['Its effects are added to every armor with this passive.'] = '其效果會新增到擁有此被動的所有護甲上。',
      ['Its stats above apply.'] = '上方的數值生效。',
      ['JAR-5 Dominator'] = 'JAR-5 主導者',
      ['Jog speed (m/s)'] = '慢跑速度(米/秒)',
      ['Jogging empties it in (s)'] = '慢跑耗盡用時(秒)',
      ['Jump Pack'] = '彈跳背包',
      ['Jump cost (share of stamina)'] = '跳躍消耗(體力佔比)',
      ['Jump pack'] = '跳躍背包',
      ['K-2 Throwing Knife'] = 'K-2 飛刀',
      ['Kinetic Displacement Mitigation'] = '動能緩衝',
      ['Knight'] = '騎士',
      ['Knockdown chance'] = '擊倒機率',
      ['LAS-12 Sai'] = 'LAS-12 釵',
      ['LAS-13 Trident'] = 'LAS-13 三叉戟',
      ['LAS-16 Sickle'] = 'LAS-16 鐮刀',
      ['LAS-17 Double-Edge Sickle'] = 'LAS-17 雙刃鐮刀',
      ['LAS-22 Shear'] = 'LAS-22 雷射剪',
      ['LAS-44 Nova'] = 'LAS-44 新星',
      ['LAS-5 Scythe'] = 'LAS-5 長柄鐮',
      ['LAS-58 Talon'] = 'LAS-58 利爪',
      ['LAS-7 Dagger'] = 'LAS-7 匕首',
      ['LAS-98 Laser Cannon'] = 'LAS-98 雷射大炮',
      ['LAS-98 Laser Cannon (crewed mount)'] = 'LAS-98 雷射大炮（乘員炮座）',
      ['LAS-99 Quasar Cannon'] = 'LAS-99 類星體大砲',
      ['LASER DAMAGE'] = '雷射傷害',
      ['LIFT-182 Warp Pack'] = 'LIFT-182 傳送背包',
      ['LIFT-850 Jump Pack'] = 'LIFT-850 彈跳背包',
      ['LIFT-860 Hover Pack'] = 'LIFT-860 懸浮背包',
      ['Language'] = '語言',
      ['Large Plasma Bolt'] = '大型電漿彈',
      ['Larger Plasma Container'] = '加大電漿匣',
      ['Laser'] = '雷射',
      ['Laser Cannon'] = '雷射大炮',
      ['Laser Sentry'] = '雷射哨戒炮',
      ['Laser Sight'] = '雷射瞄準器',
      ['Laser Sight Flashlight'] = '附手電筒的雷射瞄準器',
      ['Laser damage'] = '雷射傷害',
      ['Laser. Blaster Focus'] = '雷射：爆能聚焦',
      ['Laser. Charge Standard'] = '雷射：標準充能',
      ['Laser. Standard Prism'] = '標準稜鏡',
      ['Launch duration (s)'] = '發射持續(秒)',
      ['Launch force'] = '投擲力度',
      ['Launch speed (m/s)'] = '投擲速度(米/秒)',
      ['Left'] = '左',
      ['Left arm'] = '左臂',
      ['Left arm health'] = '左臂生命值',
      ['Left back panel'] = '左後板',
      ['Left box 0'] = '左儲物箱 0',
      ['Left box 1'] = '左儲物箱 1',
      ['Left box 2'] = '左儲物箱 2',
      ['Left front block'] = '左前塊',
      ['Left front door'] = '左前門',
      ['Left front light'] = '左前燈',
      ['Left leg'] = '左腿',
      ['Left leg health'] = '左腿生命值',
      ['Left mirror'] = '左後視鏡',
      ['Left rear door'] = '左後門',
      ['Left side panel 0'] = '左側板 0',
      ['Left side panel 1'] = '左側板 1',
      ['Left top block'] = '左上塊',
      ['Left track'] = '左履帶',
      ['Leg injury immunity (1 on)'] = '免疫腿部受傷（1 為開啟）',
      ['Leveller'] = '夷平者',
      ['Liberator'] = '解放者',
      ['Liberator Carbine'] = '卡賓槍解放者',
      ['Liberator Concussive'] = '震盪解放者',
      ['Liberator Legacy'] = '解放者「榮光」',
      ['Liberator Penetrator'] = '穿甲解放者',
      ['Lifetime (s)'] = '存續時間(秒)',
      ['Limb health'] = '四肢生命值',
      ['Limb injury avoidance'] = '免疫肢體受傷',
      ['Load'] = '讀取',
      ['Log file'] = '日誌檔案',
      ['Log file path copied.'] = '已複製日誌檔案路徑。',
      ['Logs'] = '日誌',
      ['Logs and Presets'] = '日誌與預設',
      ['Loses its target past (deg)'] = '超出此角度丟失目標(度)',
      ['Loyalist'] = '忠誠者',
      ['Lumberer Exosuit'] = '伐木工外骨骼裝甲',
      ['Lure Mine'] = '誘餌地雷',
      ['M-1000 Maxigun'] = 'M-1000 麥西極槍',
      ['M-102 Gunner FRV'] = 'M-102 炮手FRV',
      ['M-103 Supply FRV'] = 'M-103 補給FRV',
      ['M-104 Incinerator FRV'] = 'M-104 焚燒者FRV',
      ['M-105 Stalwart'] = 'M-105 盟友',
      ['M-105 Stalwart (mounted)'] = 'M-105 盟友（固定式）',
      ['M-105 Stalwart (mounted, AI-aimed 1)'] = 'M-105 盟友（固定式·AI 瞄準 1）',
      ['M-105 Stalwart (mounted, AI-aimed 2)'] = 'M-105 盟友（固定式·AI 瞄準 2）',
      ['M6C/SOCOM Pistol'] = 'M6C/SOCOM 手槍',
      ['M7S SMG'] = 'M7S 衝鋒槍',
      ['M90A Shotgun'] = 'M90A 霰彈槍',
      ['MA5C Assault Rifle'] = 'MA5C 突擊步槍',
      ['MG-206 Heavy Machine Gun'] = 'MG-206 重機槍',
      ['MG-206 Heavy Machine Gun (mounted B)'] = 'MG-206 重機槍（固定式 B）',
      ['MG-43 Machine Gun'] = 'MG-43 機槍',
      ['MG-43 Machine Gun (SEAF)'] = 'MG-43 機槍（SEAF）',
      ['MGX-42 Bullet Storm'] = 'MGX-42 子彈風暴',
      ['MINEFIELD'] = '雷區',
      ['MISSILE FLIGHT'] = '導彈飛行',
      ['MLS-4X Commando'] = 'MLS-4X 突擊兵',
      ['MP-98 Knight'] = 'MP-98 騎士',
      ['MS-11 Solo Silo'] = 'MS-11 單發導彈筒',
      ['Machete'] = '彎刀',
      ['Machine Gun'] = '機槍',
      ['Machine Gun Sentry'] = '哨戒機槍',
      ['Made by SHODAN'] = '作者 SHODAN',
      ['Maelstrom'] = '風暴渦旋',
      ['Magazine size'] = '彈匣容量',
      ['Magazines from supply'] = '補給彈匣',
      ['Main gun'] = '主炮',
      ['Marker radar scan every (s)'] = '標記雷達掃描間隔（秒）',
      ['Mass (kg)'] = '質量(千克)',
      ['Max carried'] = '最大攜帶',
      ['Max flight time (s)'] = '最大飛行時間(秒)',
      ['Max spare heatsinks'] = '最多備用散熱片',
      ['Max spare magazines'] = '最多備用彈匣',
      ['Max spare rounds'] = '最多備用彈藥',
      ['Max throw distance (m)'] = '最大投擲距離(米)',
      ['Maxigun'] = '麥西極槍',
      ['Mechas'] = '機甲',
      ['Med-Kit'] = '醫療套組',
      ['Medium Plasma Bolt'] = '中型電漿彈',
      ['Melee damage'] = '近戰傷害',
      ['Melta Mine'] = '熱熔地雷',
      ['Meltagun'] = '熱熔槍',
      ['Mid-air steering force'] = '空中轉向力',
      ['Mine'] = '地雷',
      ['Mine explosion'] = '地雷爆炸',
      ['Minefield'] = '雷區',
      ['Mines deep'] = '縱深地雷',
      ['Mines per panel'] = '每面板地雷數',
      ['Mines wide'] = '橫向地雷',
      ['Minimum speed (m/s)'] = '最低速度(米/秒)',
      ['Missile'] = '導彈',
      ['Missile Pistol'] = '飛彈手槍',
      ['Missile flight'] = '導彈飛行',
      ['Mist'] = '迷霧',
      ['Mortar Sentry'] = '哨戒迫擊炮',
      ['Move while reloading'] = '換彈時可移動',
      ['Movement'] = '移動',
      ['Muzzle'] = '槍口',
      ['Muzzle brake'] = '槍口制退器',
      ['Napalm Bomb'] = '凝固汽油彈',
      ['Napalm Bomb Mk2'] = '凝固汽油彈MK2',
      ['Napalm Bomb Mk3'] = '凝固汽油彈MK3',
      ['No changes: loading it puts every value back to the game\'s.'] = '沒有修改：讀取它會把所有數值恢復為遊戲原值。',
      ['No presets yet.'] = '還沒有預設。',
      ['Noise'] = '噪音',
      ['Normal projectile'] = '常規射彈',
      ['Not offered by the game: a laser built on the Scythe. Settings: Unlock LAS-22 Shear.'] = '遊戲本身未提供：基於「收割者」改造的雷射武器。設定項：解鎖 LAS-22 剪刀。',
      ['Not used by any weapon or stratagem in this list.'] = '本列表中的武器與戰備都沒有用到它。',
      ['Nothing matches.'] = '沒有符合項。',
      ['Nothing to install: your values are the game\'s own.'] = '無需安裝：你的數值與遊戲原始數值相同。',
      ['Nova'] = '新星',
      ['Nuke'] = '核彈',
      ['OFFLINE  -  edits the game\'s files; they apply when the game starts'] = '離線  -  編輯遊戲檔案；遊戲啟動時生效',
      ['OK'] = '確定',
      ['ORBITAL BEAM'] = '軌道光束',
      ['Off'] = '關',
      ['Off: its stats above are left out; only the passives below apply.'] = '關閉：上方的數值不生效；只有下方的被動生效。',
      ['Off: the game\'s values everywhere; your '] = '關閉：全域性使用遊戲數值，你的',
      ['Off: with other players, arc chain length / split use the game\'s values (else arcs can stay on screen).'] = '關閉：多人對局時電弧連鎖長度 / 分裂使用遊戲數值（否則電弧可留在螢幕上）。',
      ['Ombudsman'] = '監察官',
      ['On'] = '開',
      ['On: a loadout can take more than one exosuit, FRV or tank.'] = '開啟：單次配裝可攜帶多台 外骨骼裝甲、FRV 或坦克。',
      ['On: in your armory / stratagem list.'] = '開啟：出現在你的軍械庫 / 戰略配備列表中。',
      ['On: your '] = '開啟：你的',
      ['On: your arc chain length / split apply with other players too (arcs can stay on screen).'] = '開啟：你的電弧連鎖長度 / 分裂對其他玩家同樣生效（電弧可留在螢幕上）。',
      ['One True Flag'] = '唯一真旗',
      ['One-Two'] = '雙響',
      ['Open'] = '開啟',
      ['Open / close key'] = '開啟 / 關閉熱鍵',
      ['Opened the GitHub page in your browser.'] = '已在瀏覽器中開啟 GitHub 頁面。',
      ['Opened the folder.'] = '已開啟資料夾。',
      ['Opened the log folder.'] = '已開啟日誌資料夾。',
      ['Optic'] = '瞄具',
      ['Orbital'] = '軌道',
      ['Orbital 120mm HE Barrage'] = '軌道120mm高爆彈彈幕',
      ['Orbital 380mm HE Barrage'] = '軌道380mm高爆彈彈幕',
      ['Orbital Airburst Strike'] = '軌道空爆打擊',
      ['Orbital EMS Strike'] = '軌道電磁干擾打擊',
      ['Orbital Gas Strike'] = '軌道毒氣攻擊',
      ['Orbital Gatling Barrage'] = '軌道格林機槍彈幕',
      ['Orbital Laser'] = '軌道雷射',
      ['Orbital Napalm Barrage'] = '軌道汽油彈彈幕',
      ['Orbital Precision Strike'] = '軌道精準攻擊',
      ['Orbital Railcannon Strike'] = '軌道電磁炮攻擊',
      ['Orbital Smoke Strike'] = '軌道煙霧突襲',
      ['Orbital Walking Barrage'] = '軌道步行者彈幕',
      ['Orbital beam'] = '軌道光束',
      ['Orbital strike.'] = '軌道打擊。',
      ['Other players are in your game: arc chain length / split use the game\'s values.'] = '你的對局中存在其他玩家：電弧連鎖長度 / 分裂將使用遊戲數值。',
      ['Outer radius (m)'] = '外半徑(米)',
      ['Overcharge limit (s)'] = '過載上限(秒)',
      ['Overheat threshold'] = '過熱閾值',
      ['Own effects'] = '自身效果',
      ['Oxygenator'] = '氧合器',
      ['P-11 Stim Pistol'] = 'P-11 治療槍',
      ['P-113 Verdict'] = 'P-113 判官',
      ['P-19 Redeemer'] = 'P-19 救世主',
      ['P-2 Peacemaker'] = 'P-2 和平製造者',
      ['P-33 Missile Pistol'] = 'P-33 飛彈手槍',
      ['P-34 Breacher'] = 'P-34 突破者',
      ['P-35 Re-Educator'] = 'P-35 思想改造',
      ['P-4 Senator'] = 'P-4 參議員',
      ['P-41 Ombudsman'] = 'P-41 監察官',
      ['P-41 Ombudsman (variant 2)'] = 'P-41 監察官（變體 2）',
      ['P-44 Mist'] = 'P-44 迷霧',
      ['P-69 Veto'] = 'P-69 否決者',
      ['P-72 Crisper'] = 'P-72 火舌',
      ['P-92 Warrant'] = 'P-92 搜查令',
      ['P/40-K Bolt Pistol'] = 'P/40-K 爆彈手槍',
      ['PASSIVE'] = '被動',
      ['PLAS-1 Scorcher'] = 'PLAS-1 焦土',
      ['PLAS-101 Purifier'] = 'PLAS-101 淨化者',
      ['PLAS-15 Loyalist'] = 'PLAS-15 忠誠者',
      ['PLAS-39 Accelerator Rifle'] = 'PLAS-39 加速步槍',
      ['PLAS-45 Epoch'] = 'PLAS-45 紀元',
      ['PRESETS'] = '預設',
      ['PROJECTILE'] = '射彈',
      ['PROJECTILE SWAP'] = '彈種交換',
      ['Pacifier'] = '安撫者',
      ['Panel side'] = '面板位置',
      ['Panel size'] = '面板大小',
      ['Panels'] = '面板',
      ['Partial charge'] = '部分蓄力',
      ['Partial charge explosion'] = '部分蓄力爆炸',
      ['Partial charge shot'] = '部分蓄力射擊',
      ['Passive'] = '被動',
      ['Patriot Exosuit'] = '愛國者外骨骼裝甲',
      ['Peacemaker'] = '和平製造者',
      ['Peak Physique'] = '巔峰體態',
      ['Pen.'] = '穿甲',
      ['Penetration slowdown'] = '穿透衰減',
      ['Pineapple'] = '鳳梨',
      ['Plasma Pistol. Canister Extended'] = '等離子手槍：擴容彈藥罐',
      ['Plasma Pistol. Canister Pistol'] = '等離子手槍：標準彈藥罐',
      ['Point of interest range'] = '興趣點探測範圍',
      ['Portable Hellbomb'] = '可攜式絕地彈',
      ['Position scatter (m)'] = '散佈半徑(米)',
      ['Presets'] = '預設',
      ['Press a key (Esc cancels)'] = '請按一個鍵(Esc 取消)',
      ['Press the key that should open and close the panel: F1-F12, Insert, Home, End, Pause or Scroll Lock. Esc cancels.'] = '請按下用於開啟 / 關閉面板的按鍵：F1-F12、Insert、Home、End、Pause 或 Scroll Lock。Esc 取消。',
      ['Primary'] = '主武器',
      ['Primary reload speed'] = '主武器裝填速度',
      ['Projectile'] = '射彈',
      ['Projectile explosion id'] = '射彈爆炸 ID',
      ['Projectile fired (id)'] = '發射的射彈(編號)',
      ['Projectile swap'] = '彈種交換',
      ['Projectiles per shot'] = '每次射擊射彈數',
      ['Prone speed (m/s)'] = '匍匐速度(米/秒)',
      ['Punisher'] = '制裁者',
      ['Punisher Plasma'] = '電漿制裁者',
      ['Purifier'] = '淨化者',
      ['Push force'] = '推力',
      ['Pyrotech'] = '煙火表演',
      ['Quasar Cannon'] = '類星體大砲',
      ['R-2 Amendment'] = 'R-2 修正',
      ['R-2124 Constitution'] = 'R-2124 憲法',
      ['R-36 Eruptor'] = 'R-36 噴發者',
      ['R-4 Hyena'] = 'R-4 土狼',
      ['R-40 Sightliner'] = 'R-40 視界者',
      ['R-6 Deadeye'] = 'R-6 鷹眼',
      ['R-63 Diligence'] = 'R-63 勤勉',
      ['R-63CS Diligence Counter Sniper'] = 'R-63CS 反狙擊勤勉',
      ['R-72 Censor'] = 'R-72 審查官',
      ['R/40-K Hot-Shot Marksman Rifle'] = 'R/40-K 火燙神射手步槍',
      ['RL-77 Airburst Rocket Launcher'] = 'RL-77 空爆火箭發射器',
      ['ROUND 1 BLAST'] = '第 1 發爆炸',
      ['ROUND 1 BLAST RADIUS'] = '第 1 發爆炸半徑',
      ['ROUND 1 PROJECTILE'] = '第 1 發射彈',
      ['ROUNDS 2, 3 BLAST RADIUS'] = '第 2、3 發爆炸半徑',
      ['ROUNDS 2, 3 PROJECTILE'] = '第 2、3 發射彈',
      ['ROUNDS 2, 3, 4 PROJECTILE'] = '第 2、3、4 發射彈',
      ['RS-422 Railgun'] = 'RS-422 磁軌炮',
      ['Rack'] = '掛架',
      ['Radar'] = '雷達',
      ['Radius'] = '半徑',
      ['Radius (m)'] = '半徑(米)',
      ['Rail Cannon Round'] = '軌道炮彈',
      ['Railgun'] = '磁軌炮',
      ['Railgun Round'] = '磁軌炮彈',
      ['Railgun Stun Round'] = '磁軌炮暈眩彈',
      ['Range'] = '射程',
      ['Range (m)'] = '射程(米)',
      ['Rapid Heatsink'] = '快速散熱器',
      ['Re-Educator'] = '思想改造',
      ['Reach downward (m)'] = '向下觸及(米)',
      ['Reach upward (m)'] = '向上觸及(米)',
      ['Reading the game\'s weapon tables... ('] = '正在讀取遊戲武器表…（',
      ['Rear cockpit'] = '後駕駛艙',
      ['Recharge delay (s)'] = '重新充能延遲(秒)',
      ['Recharge delay once broken (s)'] = '破損後的充能延遲(秒)',
      ['Recharge rate (per s)'] = '充能速率(每秒)',
      ['Recharge time (s)'] = '充能時間(秒)',
      ['Recoil (horizontal)'] = '後坐力(水平)',
      ['Recoil (vertical)'] = '後坐力(垂直)',
      ['Recoil crouching / prone'] = '蹲姿 / 臥姿後坐力',
      ['Recoil multiplier (horizontal)'] = '後坐倍率(水平)',
      ['Recoil multiplier (vertical)'] = '後坐倍率(垂直)',
      ['Recoilless Rifle'] = '無後座力炮',
      ['Records'] = '記錄',
      ['Redeemer'] = '救世主',
      ['Reduced Signature'] = '隱跡',
      ['Refill starts after (s)'] = '開始恢復前延遲(秒)',
      ['Refills crouched in (s)'] = '蹲伏恢復用時(秒)',
      ['Refills prone in (s)'] = '臥倒恢復用時(秒)',
      ['Refills standing in (s)'] = '站立恢復用時(秒)',
      ['Regeneration (health/s)'] = '再生(生命/秒)',
      ['Reinforced Epaulettes'] = '強化護肩',
      ['Releases'] = '正式版',
      ['Reload allowed below (rounds)'] = '允許換彈下限(發)',
      ['Reload time (s)'] = '換彈時間(秒)',
      ['Reload time (s; 0 = animation length)'] = '裝填時間（秒；0 = 動畫時長）',
      ['Remember last tab and weapon'] = '記住上次的分頁與武器',
      ['Remove'] = '移除',
      ['Rename'] = '重新命名',
      ['Reprimand'] = '懲戒',
      ['Reset all values'] = '重置全部數值',
      ['Reset helldiver'] = '重置潛兵',
      ['Reset passive'] = '重置被動',
      ['Reset record'] = '重置記錄',
      ['Reset weapon'] = '重置武器',
      ['Resets all values from the current preset to default.'] = '將當前預設的全部數值恢復為預設值。',
      ['Restore the game\'s files'] = '恢復遊戲原始檔案',
      ['Restoring the game\'s files...'] = '正在恢復遊戲原始檔案...',
      ['Resupply'] = '重新補給',
      ['Rifle Justice. Short '] = '「正義」步槍：短彈匣',
      ['Right'] = '右',
      ['Right arm'] = '右臂',
      ['Right arm health'] = '右臂生命值',
      ['Right back panel'] = '右後板',
      ['Right box 0'] = '右儲物箱 0',
      ['Right box 1'] = '右儲物箱 1',
      ['Right box 2'] = '右儲物箱 2',
      ['Right front block'] = '右前塊',
      ['Right front door'] = '右前門',
      ['Right front light'] = '右前燈',
      ['Right leg'] = '右腿',
      ['Right leg health'] = '右腿生命值',
      ['Right mirror'] = '右後視鏡',
      ['Right rear door'] = '右後門',
      ['Right side panel 0'] = '右側板 0',
      ['Right side panel 1'] = '右側板 1',
      ['Right top block'] = '右上塊',
      ['Right track'] = '右履帶',
      ['Rock Solid'] = '堅如磐石',
      ['Rocket Sentry'] = '哨戒火箭炮',
      ['Round 1 blast'] = '第 1 發爆炸',
      ['Round 1 blast radius'] = '第 1 發爆炸半徑',
      ['Round 1 projectile'] = '第 1 發射彈',
      ['Rounds 2, 3 blast radius'] = '第 2、3 發爆炸半徑',
      ['Rounds 2, 3 projectile'] = '第 2、3 發射彈',
      ['Rounds 2, 3, 4 projectile'] = '第 2、3、4 發射彈',
      ['Rounds from supply'] = '補給彈藥',
      ['Rounds loaded'] = '裝填彈數',
      ['Rounds per reload'] = '每次裝填彈數',
      ['Run length (m)'] = '推進距離(米)',
      ['S-11 Speargun'] = 'S-11 矛槍',
      ['SECOND MODE'] = '第二模式',
      ['SG-20 Halt'] = 'SG-20 制止者',
      ['SG-22 Bushwhacker'] = 'SG-22 游擊者',
      ['SG-225 Breaker'] = 'SG-225 破裂者',
      ['SG-225IE Breaker Incendiary'] = 'SG-225IE 燃燒破裂者',
      ['SG-225SP Breaker Spray&Pray'] = 'SG-225SP 掃射破裂者',
      ['SG-451 Cookout'] = 'SG-451 燎原',
      ['SG-8 Punisher'] = 'SG-8 制裁者',
      ['SG-88 Break-Action Shotgun'] = 'SG-88 中折式散彈槍',
      ['SG-8P Punisher Plasma'] = 'SG-8P 電漿制裁者',
      ['SG-8S Slugger'] = 'SG-8S 制裁者散彈槍',
      ['SG-97 Sweeper'] = 'SG-97 掃蕩者',
      ['SH-20 Ballistic Shield Backpack'] = 'SH-20 彈道防護罩背包',
      ['SH-32 Shield Generator Pack'] = 'SH-32 防護罩生成背包',
      ['SH-51 Directional Shield'] = 'SH-51 定向護盾',
      ['SHARED WITH'] = '共用',
      ['SHIELD'] = '護盾',
      ['SHODAN STAT EDITOR'] = 'SHODAN 數值編輯器',
      ['SHODAN weapon mods are running too: they put their own values back every 5 s'] = '檢測到 SHODAN 武器 mod 同時執行：它們每 5 秒會把數值改回自己的設定',
      ['SHRAPNEL'] = '破片',
      ['SHRAPNEL BLAST RADIUS'] = '破片爆炸半徑',
      ['SHRAPNEL DIRECT HIT'] = '破片直擊',
      ['SHRAPNEL PROJECTILE'] = '破片射彈',
      ['SILO'] = '發射井',
      ['SMG'] = '衝鋒槍',
      ['SMG-203 Gallant'] = 'SMG-203 英勇',
      ['SMG-32 Reprimand'] = 'SMG-32 懲戒',
      ['SMG-37 Defender'] = 'SMG-37 防衛者',
      ['SMG-37 Defender (SEAF)'] = 'SMG-37 防衛者（SEAF）',
      ['SMG-72 Pummeler'] = 'SMG-72 猛擊者',
      ['SMG/FLAM-34 Stoker'] = 'SMG/FLAM-34 爆燃者',
      ['SMG/FLAM-34 Stoker (underbarrel flamer)'] = 'SMG/FLAM-34 爆燃者（下掛噴火器）',
      ['STRATAGEM'] = '戰略配備',
      ['Safe below heat (%)'] = '安全熱量(%)',
      ['Sai'] = '釵',
      ['Salvos'] = '齊射次數',
      ['Save'] = '儲存',
      ['Save current changes here'] = '在此儲存當前修改',
      ['Scorcher'] = '焦土',
      ['Scout'] = '偵察兵',
      ['Scythe'] = '長柄鐮',
      ['Search radius (m)'] = '搜尋半徑(米)',
      ['Search weapons and stratagems'] = '搜尋武器與戰略配備',
      ['Second ammo'] = '第二彈種',
      ['Second mode'] = '第二模式',
      ['Second mode explosion'] = '第二模式爆炸',
      ['Second mode fires (id)'] = '第二模式發射的射彈(編號)',
      ['Secondary'] = '副武器',
      ['Secondary draw speed'] = '副武器拔出速度',
      ['Secondary recoil'] = '副武器後坐力',
      ['Secondary reload speed'] = '副武器裝填速度',
      ['Seeker'] = '追擊者',
      ['Senator'] = '參議員',
      ['Sentry'] = '哨戒炮',
      ['Sentry: its cooldown, its body, then its weapon.'] = '哨戒炮：依次為冷卻時間、本體、武器。',
      ['Servo-Assisted'] = '伺服輔助',
      ['Settings'] = '設定',
      ['Settings are saved at once, in config.txt with your changes.'] = '設定會與你的修改一併即時儲存到 config.txt。',
      ['Several vehicles of a kind'] = '同類載具數量',
      ['Shape'] = '形狀',
      ['Shared by every armor with this passive. Multipliers: 1 = no change.'] = '所有帶此被動的護甲共用。倍率：1 = 不變。',
      ['Shear'] = '雷射剪',
      ['Shells per salvo'] = '每次齊射彈數',
      ['Shield'] = '防護罩',
      ['Shield Generator Pack'] = '防護罩生成背包',
      ['Shield capacity'] = '護盾容量',
      ['Shield emitter'] = '護盾發生器',
      ['Shockwave radius (m)'] = '衝擊波半徑(米)',
      ['Short Magazine'] = '短型彈匣',
      ['Shrapnel'] = '榴散彈',
      ['Shrapnel blast radius'] = '破片爆炸半徑',
      ['Shrapnel direct hit'] = '破片直擊',
      ['Shrapnel explosion'] = '破片爆炸',
      ['Shrapnel pieces'] = '破片數量',
      ['Shrapnel projectile'] = '破片射彈',
      ['Shrapnel projectile (id)'] = '破片射彈 (ID)',
      ['Sickle'] = '鐮刀',
      ['Siege-Ready'] = '圍攻準備完畢',
      ['Sightliner'] = '視界者',
      ['Silo'] = '發射井',
      ['Slide speed / duration'] = '滑行速度 / 持續時間',
      ['Slugger'] = '制裁者散彈槍',
      ['Small Plasma Bolt'] = '小型電漿彈',
      ['Smoke'] = '煙霧彈',
      ['Smokescreen'] = '煙幕',
      ['Sniper Scope 10x'] = '10倍狙擊鏡',
      ['Sniper Scope 10x Helghast'] = '10倍狙擊鏡',
      ['Solo Silo'] = '單發導彈筒',
      ['Spear'] = '長矛',
      ['Speargun'] = '矛槍',
      ['Speed while aiming (m/s)'] = '瞄準時速度(米/秒)',
      ['Spotting range (m)'] = '索敵距離(米)',
      ['Spread (horizontal)'] = '散佈(水平)',
      ['Spread (vertical)'] = '散佈(垂直)',
      ['Spread area (m)'] = '散佈範圍(米)',
      ['Spread multiplier (horizontal)'] = '散佈倍率(水平)',
      ['Spread multiplier (vertical)'] = '散佈倍率(垂直)',
      ['Sprint speed (m/s)'] = '衝刺速度(米/秒)',
      ['Sprint speed, out of stamina (m/s)'] = '體力耗盡時的衝刺速度(米/秒)',
      ['Sprinting empties it in (s)'] = '衝刺耗盡用時(秒)',
      ['StA-11 SMG'] = 'StA-11 衝鋒槍',
      ['StA-52 Assault Rifle'] = 'StA-52 突擊步槍',
      ['StA-X3 W.A.S.P. Launcher'] = 'StA-X3 W.A.S.P.火箭發射器',
      ['Stage '] = '階段 ',
      ['Stagger force'] = '硬直力',
      ['Stalwart'] = '盟友',
      ['Stamina'] = '體力',
      ['Standard Drum'] = '標準彈鼓',
      ['Standard Heatsink'] = '標準散熱器',
      ['Standard Plasma Container'] = '標準電漿匣',
      ['Starting charges'] = '初始使用次數',
      ['Starting count'] = '初始數量',
      ['Starting heatsinks'] = '初始散熱片',
      ['Starting magazines'] = '初始彈匣',
      ['Starting rounds'] = '初始彈藥',
      ['Starts at heat'] = '初始熱量',
      ['Stationary Shroud'] = '定點匿蹤',
      ['Stim Pistol'] = '治療槍',
      ['Stoker'] = '爆燃者',
      ['Stops you while firing'] = '開火時鎖定移動',
      ['Stratagem'] = '戰略配備',
      ['Stratagems'] = '戰略配備',
      ['Stun'] = '暈眩彈',
      ['Stun (large)'] = '暈眩彈（大）',
      ['Stun (massive)'] = '暈眩彈（極大）',
      ['Stun (medium)'] = '暈眩彈（中）',
      ['Stun (small)'] = '暈眩彈（小）',
      ['Stun Baton'] = '暈眩棍',
      ['Stun Lance'] = '暈眩長槍',
      ['Stun rounds'] = '眩暈彈',
      ['Stun rounds fire (id)'] = '眩暈彈射擊（id）',
      ['Supplementary Adrenaline'] = '腎上腺素補劑',
      ['Supply FRV'] = '補給FRV',
      ['Supply Pack'] = '補給背包',
      ['Support'] = '支援武器',
      ['Support reload speed'] = '支援武器裝填速度',
      ['Support weapon drop; the weapon itself is under Support.'] = '支援武器空投；武器本身列在「支援武器」分類下。',
      ['Suppressor'] = '消音器',
      ['Sure?'] = '確定？',
      ['Surviving lethal damage'] = '致命傷害存活',
      ['Sway multiplier'] = '晃動係數',
      ['Sweeper'] = '掃蕩者',
      ['Swim speed (m/s)'] = '游泳速度(米/秒)',
      ['TD-110 Maelstrom'] = 'TD-110 風暴渦旋',
      ['TD-220 Bastion MK XVI'] = 'TD-220 堡壘MK XVI',
      ['TED-63 Dynamite'] = 'TED-63 炸藥',
      ['THROWABLE'] = '投擲物',
      ['TM-1 Lure Mine'] = 'TM-1 誘餌地雷',
      ['TX-41 Sterilizer'] = 'TX-41 滅菌者',
      ['Tabs shown'] = '顯示的標籤頁',
      ['Talon'] = '利爪',
      ['Target search interval, max (s)'] = '索敵間隔，最大（秒）',
      ['Target search interval, min (s)'] = '索敵間隔，最小（秒）',
      ['Tenderizer'] = '肉錘',
      ['Tesla Tower'] = '特斯拉塔',
      ['Tested releases only.'] = '僅限經過測試的正式版。',
      ['That did not work; see the log.'] = '操作失敗，請檢視日誌。',
      ['The Arbitrator\'s underbarrel shotgun, not the rifle itself.'] = '「仲裁者」的下掛霰彈槍，不是步槍本身。',
      ['The Defender SEAF soldiers carry. Not yours.'] = 'SEAF 士兵攜帶的「防衛者」。不是你的那把。',
      ['The EAT-17 SEAF soldiers carry. Not yours.'] = 'SEAF 士兵攜帶的 EAT-17。不是你的那把。',
      ['The MG-43 SEAF soldiers carry. Not yours.'] = 'SEAF 士兵攜帶的 MG-43。不是你的那把。',
      ['The One-Two\'s underbarrel launcher, not the rifle. Fires the GP-31\'s grenade.'] = '「么二」的下掛發射器，不是步槍本身。發射 GP-31 的榴彈。',
      ['The SMG you carry. Its underbarrel flamer is listed separately.'] = '你攜帶的衝鋒槍。其下掛火焰噴射器單獨列出。',
      ['The Scythe you carry.'] = '你攜帶的「收割者」。',
      ['The Stoker\'s underbarrel flamer, not the SMG itself.'] = '「司爐者」的下掛火焰噴射器，不是衝鋒槍本身。',
      ['The armor passives could not be stacked'] = '無法疊加護甲被動',
      ['The charge backpack, the charge and its blast. Cooldown: Stratagems tab.'] = '充能背包、充能及其爆炸。冷卻時間見「戰略配備」頁。',
      ['The flamethrower you carry.'] = '你攜帶的火焰噴射器。',
      ['The game holds at most 2048 rounds in a magazine.'] = '遊戲中一個彈匣最多容納 2048 發。',
      ['The game\'s own files are already in place.'] = '當前已是遊戲原始檔案。',
      ['The game\'s own files are back. Your values stay saved here (Install puts them in again).'] = '已恢復遊戲原始檔案。你的數值仍儲存在此（點選安裝可再次寫入）。',
      ['The game\'s own files are in place. Close the game, then Install to play with your values.'] = '當前為遊戲原始檔案。關閉遊戲後點選安裝，即可使用你的數值。',
      ['The one you carry.'] = '你攜帶的那一把。',
      ['The one you carry. The CQC-20 Breaching Hammer is listed under Support.'] = '你攜帶的那一把。CQC-20 破拆錘列在「支援武器」下。',
      ['The one you carry. The CQC-72 support version is listed under Support.'] = '你攜帶的那一把。CQC-72 支援版本列在「支援武器」下。',
      ['The pistol you carry. The One-Two\'s launcher is listed under the One-Two.'] = '你攜帶的手槍。「么二」的發射器列在「么二」下。',
      ['The recharge time is 0: set it above 0 first.'] = '重新裝填時間為 0：請先設為大於 0 的值。',
      ['The rifle you carry. The grenade launcher is listed separately.'] = '你攜帶的步槍。榴彈發射器單獨列出。',
      ['The rifle you carry. The underbarrel shotgun is listed separately.'] = '你攜帶的步槍。下掛霰彈槍單獨列出。',
      ['The support hammer delivered by hellpod. The game data files it next to the Machete.'] = '由空投艙投送的支援錘。遊戲資料將它列在砍刀旁邊。',
      ['The support weapon. The CQC-73 is listed under Secondary.'] = '支援武器。CQC-73 列在「副武器」下。',
      ['Thermite'] = '鋁熱彈',
      ['Throw range'] = '投擲距離',
      ['Throw spread (degrees)'] = '投擲散佈(度)',
      ['Throw velocity, max (m/s)'] = '投擲速度上限(米/秒)',
      ['Throw velocity, min (m/s)'] = '投擲速度下限(米/秒)',
      ['Throwable'] = '投擲物',
      ['Throwable launching is supported in solo missions only.'] = '發射投擲物僅支援單人任務。',
      ['Throwables'] = '投擲物',
      ['Throwing Knife'] = '飛刀',
      ['Time between bombs (s)'] = '投彈間隔(秒)',
      ['Time between salvos (s)'] = '齊射間隔(秒)',
      ['Time between shells (s)'] = '彈藥間隔(秒)',
      ['Top left hatch'] = '左上艙蓋',
      ['Top right hatch'] = '右上艙蓋',
      ['Torcher'] = '噴火者',
      ['Tracer rounds'] = '曳光彈',
      ['Tracking speed'] = '跟蹤速度',
      ['Trigger delay (s)'] = '觸發延遲(秒)',
      ['True Grit'] = '堅毅不屈',
      ['Tube Reddot 2x'] = '2倍紅點瞄具',
      ['Turn speed at cruise'] = '巡航轉向速率',
      ['Turn speed at slowest'] = '最慢轉向速率',
      ['Turn speed, horizontal (deg/s)'] = '轉向速度，水平（度/秒）',
      ['Turn speed, vertical (deg/s)'] = '轉向速度，垂直（度/秒）',
      ['Turret'] = '炮塔',
      ['Type the name: Enter keeps it, Esc cancels. The game sees these keys too, so name presets from a menu.'] = '輸入名稱：回車確認，Esc 取消。遊戲同樣會收到這些按鍵，建議在選單介面命名。',
      ['Type the percent (%d-%d): Enter sets it, Esc cancels.'] = '輸入百分比(%d-%d)：回車確認，Esc 取消。',
      ['Type the value: Enter sets it, Esc cancels. Values out of range are set to the nearest allowed one.'] = '輸入數值：回車確認，Esc 取消。超出範圍的數值會取最接近的合法值。',
      ['Type to search: Enter keeps the results, Esc clears the search. The game sees these keys too.'] = '輸入以搜尋：回車確認結果，Esc 清空搜尋。遊戲同樣會收到這些按鍵。',
      ['Ultimatum'] = '最後通牒',
      ['Uncharged'] = '未蓄力',
      ['Uncharged explosion'] = '未蓄力爆炸',
      ['Uncharged shot'] = '未蓄力射擊',
      ['Underbarrel'] = '下掛',
      ['Unflinching'] = '無懼',
      ['Unlock unused items'] = '解鎖未使用物品',
      ['Unsafe warp: damage to you'] = '不安全躍遷：對你造成的傷害',
      ['Unsafe warp: explosion'] = '不安全躍遷：爆炸',
      ['Up'] = '上移',
      ['Up/Down choose a stat, Left/Right change it (Shift: bigger steps), click a value or press Enter to type it,'] = '上下鍵選擇數值項，左右鍵調整（Shift 為大步長），點選數值或按回車直接輸入，',
      ['Up/Down choose, Enter loads, Insert makes a new one, Shift+Insert saves into it, F2 renames, Del deletes.'] = '上下鍵選擇，回車讀取，Insert 新建，Shift+Insert 存入當前預設，F2 重新命名，Del 刪除。',
      ['Update channel'] = '更新渠道',
      ['Updates'] = '更新',
      ['Urchin'] = '海膽',
      ['Uses per mission'] = '每次任務使用次數',
      ['Uses per rearm'] = '每次補充可用次數',
      ['VEHICLE'] = '載具',
      ['VG-70 Variable'] = 'VG-70 變數',
      ['Variable'] = '變數',
      ['Vehicle'] = '載具',
      ['Vehicle. The weapons it carries are listed under it.'] = '載具。其搭載的武器列在它下方。',
      ['Velocity'] = '初速',
      ['Velocity (m/s)'] = '初速(米/秒)',
      ['Verdict'] = '判官',
      ['Vertical Grip'] = '直立前握把',
      ['Vertical Grip 45 Degree'] = '45度角直立前握把',
      ['Vertical Grip Advanced'] = '進階直立前握把',
      ['Vertical Grip Flashlight'] = '垂直前握把帶照明',
      ['Veto'] = '否決者',
      ['Volatile Plasma Bolt'] = '揮發性電漿彈',
      ['W.A.S.P. Launcher'] = 'W.A.S.P.火箭發射器',
      ['WEAPON STATS'] = '武器數值',
      ['WIND-UP'] = '預熱',
      ['Walk / run speed'] = '行走 / 奔跑速度',
      ['Walk speed (m/s)'] = '步行速度(米/秒)',
      ['Walking backwards (multiplier)'] = '後退行走(倍率)',
      ['Walking speed (m/s)'] = '遊走速度(米/秒)',
      ['Warp Pack'] = '傳送背包',
      ['Warp distance (m)'] = '躍遷距離(米)',
      ['Warp pack'] = '躍遷背包',
      ['Warrant'] = '搜查令',
      ['Weapon stats'] = '武器數值',
      ['Wind-down time (s)'] = '洩壓時間(秒)',
      ['Wind-down time, released (s)'] = '鬆開後減速時間（秒）',
      ['Wind-up'] = '預熱',
      ['Wind-up time (s)'] = '預熱時間(秒)',
      ['Your changes are off: turn them on in Settings to edit.'] = '你的改動當前處於關閉狀態：請在設定裡開啟後再編輯。',
      ['Your changes are off: turn them on in Settings to load a preset'] = '你的修改已關閉：請在設定中開啟後再讀取預設',
      ['Your values are not in the game yet: close the game, then Install.'] = '你的數值尚未寫入遊戲：請關閉遊戲，然後點選安裝。',
      ['also the second firing mode\'s shot (the same projectile)'] = '同樣適用於第二種射擊模式的射彈（同一投射物）',
      ['clip'] = '彈夾',
      ['damage: the same as the other rounds (Damage above)'] = '傷害：與其他彈種相同（見上方「傷害」）',
      ['direct hit: the same as the first mode\'s (Damage above)'] = '直擊：與第一種模式相同（見上方「傷害」）',
      ['its own. - / + : fire another weapon\'s'] = '自身射彈。- / +：改為發射其他武器的射彈',
      ['loaded into an empty weapon, from your spare rounds'] = '裝入空槍時，從備用彈藥中補充',
      ['min charge'] = '最少充能',
      ['no shrapnel'] = '無破片',
      ['none (no explosion)'] = '無（不爆炸）',
      ['none (no projectile)'] = '無（沒有射彈）',
      ['normal projectile'] = '常規射彈',
      ['overcharge'] = '過充',
      ['panels, mines per panel: lower only (more than the default crashes the game)'] = '面板數、每面板地雷數：只能調低（高於預設值會讓遊戲崩潰）',
      ['shared with'] = '共用',
      ['speedloader'] = '快速裝填器',
      ['stage 1: partial charge shot, stages 2-3: full charge shot'] = '第 1 階段：部分蓄力射擊；第 2-3 階段：滿蓄力射擊',
      ['stage 1: uncharged shot, stages 2-3: charged shot'] = '第 1 階段：未蓄力射擊；第 2-3 階段：蓄力射擊',
      ['the game\'s tiers: 10 small arms, 20 HMG, 30 autocannon, 40 Strider, 50 orbital, 60 Hellbomb, 250 never'] = '遊戲的分級：10 輕武器、20 重機槍、30 機炮、40 蹂躪者、50 軌道、60 地獄炸彈、250 不可摧毀',
      ['the shot fired from this heat on, and what it does to you'] = '從該熱量值起發射的射彈，以及它對你自己造成的效果',
      ['the spare ammo in its backpack; read when the backpack is called in'] = '背包裡的備用彈藥；在被投放時讀取',
    },
    lower = {
      ['"+ new preset" (or insert) saves your current changes as one; you name it next.'] = '「+ 新建預設」（或 Insert 鍵）會把當前修改存為一組，接著你可以為它命名。',
      ['+ armor rating'] = '護甲值',
      ['+ ergonomics'] = '人機工效',
      ['+ new preset from current changes'] = '從當前修改新建預設',
      ['+ stamina when hit'] = '受擊時耐力',
      ['+ stim duration (s)'] = '治療劑持續時間（秒）',
      ['+ stims (start, max)'] = '治療劑數量（初始 / 上限）',
      ['+ throwables (start, max)'] = '手雷數量（初始 / 上限）',
      ['100kg bomb'] = '100KG炸彈',
      ['100kg bomb mk2'] = '100KG炸彈MK2',
      ['100kg bomb mk3'] = '100KG炸彈MK3',
      ['100kg cluster bomb'] = '100KG集束炸彈',
      ['10g birdshot'] = '10g鳥彈',
      ['10g bugshot'] = '10g蟲彈',
      ['10g dual sabot'] = '10g雙脫殼彈',
      ['10g flechettes'] = '10g飛鏢彈',
      ['10g fragmentation'] = '10g破片彈',
      ['10g high velocity sabot'] = '10g高速脫殼彈',
      ['10g liberty fire'] = '10g自由之火散彈',
      ['10g magnum'] = '10g麥格農散彈',
      ['10g magnum triball'] = '10g麥格農三式彈',
      ['10g rifled slugs'] = '10g線膛加重彈',
      ['10g sabot'] = '10g脫殼彈',
      ['10g scatter shot'] = '10g散彈',
      ['10g stun rounds'] = '10g眩暈彈',
      ['10g tri-ball'] = '10g三式彈',
      ['10g. duckbill'] = '10g. 扁平槍口',
      ['10g. full choke'] = '10g. 全收束器',
      ['10g. half choke'] = '10g. 半收束器',
      ['110mm airburst cannon round'] = '110mm空爆炮彈',
      ['110mm airburst cannon round mk2'] = '110mm空爆炮彈MK2',
      ['110mm e.m.s. cannon round'] = '110mm電擊波炮彈',
      ['110mm e.m.s. cannon round mk2'] = '110mm電擊波炮彈MK2',
      ['110mm e.m.s. cannon round mk3'] = '110mm電擊波炮彈MK3',
      ['110mm gas cannon round'] = '110mm毒氣炮彈',
      ['110mm standard rocket'] = '110mm標準火箭彈',
      ['110mm standard rocket mk2'] = '110mm標準火箭彈MK2',
      ['12.5mm bchp rifle rounds'] = '12.5mm鍵合中空步槍彈藥',
      ['12.5mm eit rounds'] = '12.5mm爆燃曳光彈',
      ['12.5mm standard rifle rounds'] = '12.5mm標準步槍彈藥',
      ['120mm he cannon round'] = '120mm高爆炮彈',
      ['12g birdshot'] = '12g鳥彈',
      ['12g buckshot'] = '12g鹿彈',
      ['12g bugshot'] = '12g蟲彈',
      ['12g flechettes'] = '12g飛鏢彈',
      ['12g liberty fire'] = '12g自由之火散彈',
      ['12g magnum'] = '12g麥格農散彈',
      ['12g magnum triball'] = '12g麥格農三式彈',
      ['12g scatter shot'] = '12g散彈',
      ['12g tri-ball'] = '12g三式彈',
      ['12g. duckbill'] = '12g. 扁平槍口',
      ['12g. full choke'] = '12g. 全收束器',
      ['12g. half choke'] = '12g. 半收束器',
      ['12mm. compensator'] = '12mm. 補償器',
      ['12mm. flash hider'] = '12mm. 消焰器',
      ['12mm. muzzle break'] = '12mm. 槍口制動器',
      ['12x25mm explosive'] = '12x25mm炸彈',
      ['12x25mm full metal jacket'] = '12x25mm全金屬被甲彈',
      ['12x25mm high velocity'] = '12x25mm高速彈',
      ['12x25mm hollow point'] = '12x25mm中空彈',
      ['12x25mm plasma'] = '12x25mm電漿彈',
      ['12x25mm ripper'] = '12x25mm撕裂彈',
      ['12x25mm thermite'] = '12x25mm鋁熱彈',
      ['12x25mm toxic'] = '12x25mm毒氣彈',
      ['13x40mm full metal jacket'] = '13x40mm全金屬被甲彈',
      ['13x40mm hollow point'] = '13x40mm中空彈',
      ['13x40mm magnum'] = '13x40mm麥格農子彈',
      ['13x40mm penetrator'] = '13x40mm穿甲彈',
      ['13x40mm ripper'] = '13x40mm撕裂彈',
      ['15x100mm emp-rounds'] = '15x100mm電磁脈衝彈',
      ['15x100mm fragmentation'] = '15x100mm破片彈',
      ['15x100mm high explosive'] = '15x100mm高爆彈',
      ['15x100mm high velocity'] = '15x100mm高速彈',
      ['15x100mm plasma'] = '15x100mm電漿彈',
      ['15x100mm standard rocket'] = '15x100mm標準火箭彈',
      ['15x100mm thermite'] = '15x100mm鋁熱彈',
      ['15x100mm toxic'] = '15x100mm毒氣彈',
      ['20mm aphet rounds'] = '20mm穿甲高爆彈',
      ['20mm flak rounds'] = '20mm高射炮彈',
      ['20mm he cannon'] = '20mm高爆炮彈',
      ['20mm hvap rounds'] = '20mm高速穿甲彈',
      ['23mm he cannon'] = '23mm高爆炮彈',
      ['30mm aphe cannon'] = '30mm穿甲高爆炮彈',
      ['380mm he cannon round'] = '380mm高爆炮彈',
      ['40-k meltagun'] = '40-K 熱熔槍',
      ['40mm aphe cannon'] = '40mm穿甲高爆炮彈',
      ['40mm flak cannon'] = '40mm高射炮彈',
      ['40mm he grenade'] = '40mm高爆手榴彈',
      ['40mm he mortar'] = '40mm高爆迫擊炮彈',
      ['40mm heat grenade'] = '40mm反戰車高爆彈',
      ['40mm proximity grenade'] = '40mm感應式手榴彈',
      ['5,5mm. compensator'] = '5,5mm. 補償器',
      ['5,5mm. flash hider'] = '5,5mm. 消焰器',
      ['5,5mm. muzzle break'] = '5,5mm. 槍口制動器',
      ['5.5x50mm devastator'] = '5.5x50mm毀滅者彈',
      ['5.5x50mm double power'] = '5.5x50mm雙效彈',
      ['5.5x50mm explosive'] = '5.5x50mm炸彈',
      ['5.5x50mm full metal jacket'] = '5.5x50mm全金屬被甲彈',
      ['5.5x50mm high velocity'] = '5.5x50mm高速彈',
      ['5.5x50mm hollow-point'] = '5.5x50mm中空彈',
      ['5.5x50mm penetrator'] = '5.5x50mm穿甲彈',
      ['5.5x50mm ripper'] = '5.5x50mm撕裂彈',
      ['5.5x50mm self propelled'] = '5.5x50mm自走彈',
      ['5.5x50mm subsonic'] = '5.5x50mm次音速彈',
      ['5.5x50mm super uranium core'] = '5.5x50mm超鈾核心彈',
      ['500kg bomb'] = '500kg炸彈',
      ['500kg bomb mk2'] = '500kg炸彈MK2',
      ['500kg bomb mk3'] = '500kg炸彈MK3',
      ['66mm missile'] = '66mm飛彈',
      ['66mm missile mk2'] = '66mm飛彈MK2',
      ['70mm laser-guided missile'] = '70mm雷射導引飛彈',
      ['70mm laser-guided missile mk2'] = '70mm雷射導引飛彈MK2',
      ['70mm standard rocket'] = '70mm標準火箭彈',
      ['75mm heat grenade'] = '75mm反戰車高爆彈',
      ['85mm heat grenade'] = '85mm反戰車高爆彈',
      ['85mm heat grenade mk2'] = '85mm反戰車高爆彈MK2',
      ['85mm high-explosive grenade'] = '85mm高爆手榴彈',
      ['85mm high-explosive grenade mk2'] = '85mm高爆手榴彈MK2',
      ['8mm. compensator'] = '8mm. 補償器',
      ['8mm. flash hider'] = '8mm. 消焰器',
      ['8mm. muzzle break'] = '8mm. 槍口制動器',
      ['8x60mm airburst'] = '8x60mm空爆彈',
      ['8x60mm devastator'] = '8x60mm毀滅者彈',
      ['8x60mm double power'] = '8x60mm雙效彈',
      ['8x60mm explosive'] = '8x60mm炸彈',
      ['8x60mm full metal jacket'] = '8x60mm全金屬被甲彈',
      ['8x60mm high velocity'] = '8x60mm高速彈',
      ['8x60mm liberty fire'] = '8x60mm自由之火子彈',
      ['8x60mm penetrator'] = '8x60mm穿甲彈',
      ['8x60mm sniper armour piercing'] = '8x60mm狙擊穿甲彈',
      ['8x60mm subsonic'] = '8x60mm次音速彈',
      ['8x60mm super uranium core'] = '8x60mm超鈾核心彈',
      ['9mm. compensator'] = '9mm. 補償器',
      ['9mm. flash hider'] = '9mm. 消焰器',
      ['9mm. muzzle break'] = '9mm. 槍口制動器',
      ['9x20mm explosive'] = '9x20mm炸彈',
      ['9x20mm full metal jacket'] = '9x20mm全金屬被甲彈',
      ['9x20mm high velocity'] = '9x20mm高速彈',
      ['9x20mm hollow point'] = '9x20mm中空彈',
      ['9x20mm plasma'] = '9x20mm電漿彈',
      ['9x20mm ripper'] = '9x20mm撕裂彈',
      ['9x20mm thermite'] = '9x20mm鋁熱彈',
      ['9x20mm toxic'] = '9x20mm毒氣彈',
      ['9x70mm full metal jacket'] = '9x70mm全金屬被甲彈',
      ['9x70mm high velocity'] = '9x70mm高速彈',
      ['9x70mm penetrator'] = '9x70mm穿甲彈',
      ['9x70mm self propelled'] = '9x70mm自走彈',
      ['9x70mm sniper armour piercing'] = '9x70mm狙擊穿甲彈',
      ['9x70mm socom assassin'] = '9x70mm特種暗殺彈',
      ['9x70mm super uranium core'] = '9x70mm超鈾核心彈',
      ['a mounted cannon with a seat, dropped by hellpod. not the one you carry.'] = '帶座位的固定火炮，由空投艙投送。不是你攜帶的那把。',
      ['a mounted copy aimed by ai. not the one you carry.'] = '由 AI 瞄準的固定版本。不是你攜帶的那把。',
      ['a mounted copy run by ai (emplacement-style). not the one you carry.'] = '由 AI 操作的固定版本（炮台式）。不是你攜帶的那把。',
      ['a mounted copy. not the one you carry.'] = '固定版本。不是你攜帶的那把。',
      ['a preset keeps every change you have made as one set, under a name you choose.'] = '預設會把你所有的修改作為一組儲存，並取一個你指定的名字。',
      ['a/ac-8 autocannon sentry'] = 'A/AC-8 哨戒機炮',
      ['a/arc-3 tesla tower'] = 'A/ARC-3 特斯拉塔',
      ['a/flam-40 flame sentry'] = 'A/FLAM-40 火焰火箭炮',
      ['a/g-16 gatling sentry'] = 'A/G-16 哨戒格林炮',
      ['a/gm-17 gas mortar sentry'] = 'A/GM-17 毒氣彈哨戒迫擊炮',
      ['a/las-98 laser sentry'] = 'A/LAS-98 雷射哨戒炮',
      ['a/m-12 mortar sentry'] = 'A/M-12 哨戒迫擊炮',
      ['a/m-23 ems mortar sentry'] = 'A/M-23 電磁干擾哨戒迫擊炮',
      ['a/mg-43 machine gun sentry'] = 'A/MG-43 哨戒機槍',
      ['a/mls-4x rocket sentry'] = 'A/MLS-4X 哨戒火箭炮',
      ['ac-8 autocannon'] = 'AC-8 機炮',
      ['acceleration (m/s2)'] = '加速度(米/秒^2)',
      ['accelerator rifle'] = '加速步槍',
      ['acclimated'] = '適應自如',
      ['acid'] = '酸液',
      ['adjudicator'] = '審判者',
      ['adreno-defibrillator'] = '腎上腺素除顫器',
      ['advanced filtration'] = '進階過濾',
      ['airburst rocket launcher'] = '空爆火箭發射器',
      ['alternate ammunition'] = '備用彈藥',
      ['amendment'] = '修正',
      ['ammo'] = '彈藥',
      ['ammo at the start'] = '初始彈藥',
      ['ammo capacity'] = '彈藥容量',
      ['ammo carried'] = '攜帶彈藥',
      ['ammo from resupply'] = '補給箱補充彈藥',
      ['ammunition'] = '彈藥',
      ['amw-20 apex'] = 'AMW-20 巔峰',
      ['angled foregrip'] = '斜角前握把',
      ['angled foregrip advanced'] = '進階斜角前握把',
      ['angled foregrip with laser'] = '雷射斜角前握把',
      ['another copy of this weapon, not identified yet.'] = '該武器的另一份副本，尚未識別。',
      ['antenna'] = '天線',
      ['anti-air missile'] = '防空飛彈',
      ['anti-materiel rifle'] = '反器材步槍',
      ['anti-tank emplacement'] = '反坦克炮台',
      ['anti-tank seeker'] = '反坦克追擊者',
      ['apex'] = '巔峰',
      ['apply my changes'] = '應用我的修改',
      ['apw-1 anti-materiel rifle'] = 'APW-1 反器材步槍',
      ['ar-11 arbitrator'] = 'AR-11 仲裁者',
      ['ar-11 arbitrator (underbarrel shotgun)'] = 'AR-11 仲裁者（下掛霰彈槍）',
      ['ar-2 coyote'] = 'AR-2 郊狼',
      ['ar-23 liberator'] = 'AR-23 解放者',
      ['ar-23a liberator carbine'] = 'AR-23A 卡賓槍解放者',
      ['ar-23c liberator concussive'] = 'AR-23C 震盪解放者',
      ['ar-23l liberator legacy'] = 'AR-23L 解放者「榮光」',
      ['ar-23p liberator penetrator'] = 'AR-23P 穿甲解放者',
      ['ar-32 pacifier'] = 'AR-32 安撫者',
      ['ar-59 suppressor'] = 'AR-59 消音器',
      ['ar-61 tenderizer'] = 'AR-61 肉錘',
      ['ar/gl-21 one-two'] = 'AR/GL-21 雙響',
      ['ar/gl-21 one-two (grenade launcher)'] = 'AR/GL-21 雙響（下掛榴彈發射器）',
      ['arbitrator'] = '仲裁者',
      ['arc'] = '電弧',
      ['arc chain edits in multiplayer'] = '多人模式下修改電弧連鎖',
      ['arc chains'] = '電弧連鎖',
      ['arc chains use the game\'s values while other players are in your game (see settings).'] = '對局中有其他玩家時，電弧連鎖使用遊戲原值（詳見設定）。',
      ['arc damage taken'] = '受到的電弧傷害',
      ['arc splits'] = '電弧分裂',
      ['arc thrower'] = '電弧發射器',
      ['arc-12 blitzer'] = 'ARC-12 閃擊者',
      ['arc-3 arc thrower'] = 'ARC-3 電弧發射器',
      ['arming time (s)'] = '佈防時間(秒)',
      ['armor'] = '護甲',
      ['armor pen. (direct)'] = '穿甲(直射)',
      ['armor pen. (extreme angle)'] = '穿甲(極端角度)',
      ['armor pen. (large angle)'] = '穿甲(大角度)',
      ['armor pen. (slight angle)'] = '穿甲(小角度)',
      ['armors'] = '護甲',
      ['assault rifle'] = '突擊步槍',
      ['attachment'] = '配件',
      ['attachments'] = '配件',
      ['autocannon'] = '機炮',
      ['autocannon sentry'] = '哨戒機炮',
      ['b-1 supply pack'] = 'B-1 補給背包',
      ['b-100 portable hellbomb'] = 'B-100 可攜式絕地彈',
      ['b/flam-80 cremator'] = 'B/FLAM-80 火葬者',
      ['b/md c4 pack'] = 'B/MD C4背包',
      ['back'] = '返回',
      ['back door block'] = '後艙門塊',
      ['back hatch'] = '後艙蓋',
      ['back periscope side 8'] = '潛望鏡後側 8',
      ['background opacity'] = '背景不透明度',
      ['backpack'] = '背包',
      ['ballistic padding'] = '防彈襯墊',
      ['ballistic shield'] = '防彈盾',
      ['ballistic shield backpack'] = '彈道防護罩背包',
      ['barrage'] = '彈幕',
      ['bastion mk xvi'] = '堡壘Mk XVI',
      ['belt-fed grenade launcher'] = '彈鏈式榴彈發射器',
      ['bingus shared loader by cowboybingus'] = 'Bingus 共享載入器 · CowboyBingus',
      ['blast'] = '爆炸',
      ['blast radius'] = '爆炸半徑',
      ['blitzer'] = '閃擊者',
      ['block game input while open'] = '開啟時遮蔽遊戲輸入',
      ['blunt-force mitigation'] = '鈍擊緩解',
      ['body parts'] = '身體部位',
      ['bolt pistol'] = '爆彈手槍',
      ['bonnet'] = '引擎蓋',
      ['boost after the launch (s)'] = '發射後加速(秒)',
      ['br-14 adjudicator'] = 'BR-14 審判者',
      ['breacher'] = '突破者',
      ['breaching hammer'] = '破門戰錘',
      ['break-action shotgun'] = '中折式散彈槍',
      ['breaker'] = '破裂者',
      ['breaker incendiary'] = '燃燒破裂者',
      ['breaker spray&pray'] = '掃射破裂者',
      ['breakthrough exosuit'] = '突破外骨骼裝甲',
      ['bullet storm'] = '子彈風暴',
      ['burn time (s)'] = '燃燒時間(秒)',
      ['burning'] = '燃燒',
      ['burning applied to you'] = '對你施加的燃燒',
      ['burst'] = '爆風',
      ['burst radius'] = '爆風半徑',
      ['bushwhacker'] = '游擊者',
      ['caltrops'] = '蒺藜',
      ['cancel'] = '取消',
      ['cb-9 exploding crossbow'] = 'CB-9 猛爆十字弓',
      ['censor'] = '審查官',
      ['chain length'] = '連鎖長度',
      ['chain reaction delay (s)'] = '連鎖延遲(秒)',
      ['chain split'] = '連鎖分裂',
      ['charge'] = '充能',
      ['charge when it comes back'] = '恢復後初始充能',
      ['charged'] = '已充能',
      ['charges'] = '使用次數',
      ['charges from resupply'] = '補給箱補充的使用次數',
      ['chest bleeding damage'] = '胸部流血傷害',
      ['chest damage taken'] = '受到胸部傷害',
      ['choose a weapon on the left.'] = '請在左側選擇武器。',
      ['clear'] = '清除',
      ['click again to overwrite'] = '再次點選以覆蓋',
      ['climb acceleration'] = '爬升加速度',
      ['climb multiplier (horizontal)'] = '攀爬倍率(水平)',
      ['climb multiplier (vertical)'] = '攀爬倍率(垂直)',
      ['climb speed (m/s)'] = '爬升速度(米/秒)',
      ['climb time limit (s)'] = '爬升時限(秒)',
      ['cluster bomb'] = '集束炸彈',
      ['combat hatchet'] = '戰鬥斧',
      ['combat scope 4x'] = '4倍戰鬥瞄具',
      ['commando'] = '突擊兵',
      ['concussive padding (grenadier)'] = '擲彈兵防震盪襯墊',
      ['concussive padding (hazmat)'] = '危害物質防震盪襯墊',
      ['concussive padding (reinforced)'] = '強化防震盪襯墊',
      ['constitution'] = '憲法',
      ['contact mine'] = '水雷',
      ['cookout'] = '燎原',
      ['cooldown (s)'] = '冷卻時間(秒)',
      ['cooling (% per s)'] = '散熱(每秒%)',
      ['copy'] = '複製',
      ['coyote'] = '郊狼',
      ['cqc-1 one true flag'] = 'CQC-1 唯一真旗',
      ['cqc-19 stun lance'] = 'CQC-19 暈眩長槍',
      ['cqc-2 saber'] = 'CQC-2 軍刀',
      ['cqc-20 breaching hammer'] = 'CQC-20 破門戰錘',
      ['cqc-30 stun baton'] = 'CQC-30 暈眩棍',
      ['cqc-42 machete'] = 'CQC-42 彎刀',
      ['cqc-5 combat hatchet'] = 'CQC-5 戰鬥斧',
      ['cqc-72 entrenchment tool'] = 'CQC-72 挖掘工具',
      ['cqc-73 entrenchment tool'] = 'CQC-73 挖掘工具',
      ['cqc-9 defoliation tool'] = 'CQC-9 除草器',
      ['cremator'] = '火葬者',
      ['crisper'] = '火舌',
      ['cruise speed (m/s)'] = '巡航速度(米/秒)',
      ['dagger'] = '匕首',
      ['damage'] = '傷害',
      ['damage tick (s)'] = '傷害間隔(秒)',
      ['damage to you'] = '對你造成的傷害',
      ['damage: the same as the other rounds (damage above)'] = '傷害：與其他彈種相同（見上方「傷害」）',
      ['dbs-2 double freedom'] = 'DBS-2 雙重自由',
      ['de-escalator'] = '緩和使者',
      ['deadeye'] = '鷹眼',
      ['defender'] = '防衛者',
      ['defoliation tool'] = '除草器',
      ['delete'] = '刪除',
      ['democracy protects'] = '民主守護者',
      ['demolition force'] = '拆毀力',
      ['deployer'] = '部署艙',
      ['desert stormer'] = '沙塵暴之王',
      ['diligence'] = '勤勉',
      ['diligence counter sniper'] = '反狙擊勤勉',
      ['direct hit'] = '直擊',
      ['direct hit: the same as the first mode\'s (damage above)'] = '直擊：與第一種模式相同（見上方「傷害」）',
      ['directional shield'] = '定向護盾',
      ['dominator'] = '主導者',
      ['double freedom'] = '雙重自由',
      ['double-edge sickle'] = '雙刃鐮刀',
      ['down'] = '下移',
      ['drag factor'] = '阻力系數',
      ['driver gun'] = '駕駛員機槍',
      ['drone'] = '無人機',
      ['drum magazine'] = '彈鼓',
      ['dune walker sniper scope 10x'] = '10倍狙擊鏡',
      ['durable damage'] = '耐傷傷害',
      ['durable ratio (0-1)'] = '耐傷比例(0-1)',
      ['duration (s)'] = '持續時間(秒)',
      ['dynamite'] = '炸藥',
      ['e/at-12 anti-tank emplacement'] = 'E/AT-12 反坦克炮台',
      ['e/gl-21 grenadier battlement'] = 'E/GL-21 擲彈兵掩體',
      ['e/mg-101 hmg emplacement'] = 'E/MG-101 重機槍炮台',
      ['each arm'] = '每條手臂',
      ['each leg'] = '每條腿',
      ['eagle'] = '飛鷹',
      ['eagle 110mm rocket pods'] = '飛鷹110mm火箭莢艙',
      ['eagle 500kg bomb'] = '飛鷹500kg炸彈',
      ['eagle airstrike'] = '飛鷹空襲',
      ['eagle cluster bomb'] = '飛鷹集束炸彈',
      ['eagle gas airstrike'] = '飛鷹毒氣空襲',
      ['eagle napalm airstrike'] = '飛鷹凝固汽油彈空襲',
      ['eagle rearm time (s)'] = '飛鷹補充時間(秒)',
      ['eagle smoke strike'] = '飛鷹煙霧突襲',
      ['eagle strafing run'] = '飛鷹機槍掃射',
      ['eagle strike. the rearm time is shared by every eagle.'] = '飛鷹打擊。所有飛鷹共用同一重新整備時間。',
      ['eat-17 expendable anti-tank'] = 'EAT-17 反坦克消耗品',
      ['eat-17 expendable anti-tank (seaf)'] = 'EAT-17 反坦克消耗品（SEAF）',
      ['eat-411 leveller'] = 'EAT-411 夷平者',
      ['eat-700 expendable napalm'] = 'EAT-700 消耗型凝固汽油彈',
      ['electrical conduit'] = '電氣管線',
      ['emancipator exosuit'] = '解放者外骨骼裝甲',
      ['emplacement: its cooldown, its body, then its weapon.'] = '炮台：依次為冷卻時間、本體、武器。',
      ['ems mortar sentry'] = '電磁干擾哨戒迫擊炮',
      ['enemy detection range'] = '敵人偵測範圍',
      ['engineering kit'] = '工程套組',
      ['entrenchment tool'] = '挖掘工具',
      ['epoch'] = '紀元',
      ['ergonomics'] = '人機工效',
      ['ergonomics bonus'] = '人機工效加成',
      ['eruptor'] = '噴發者',
      ['evictor'] = '驅離者',
      ['exo-45 patriot exosuit'] = 'EXO-45 愛國者外骨骼裝甲',
      ['exo-49 emancipator exosuit'] = 'EXO-49 解放者外骨骼裝甲',
      ['exo-51 lumberer exosuit'] = 'EXO-51 伐木工外骨骼裝甲',
      ['exo-55 breakthrough exosuit'] = 'EXO-55 突破外骨骼裝甲',
      ['expendable anti-tank'] = '反坦克消耗品',
      ['expendable napalm'] = '消耗型凝固汽油彈',
      ['explodes after death (s)'] = '死亡後爆炸（秒）',
      ['exploding crossbow'] = '猛爆十字弓',
      ['explosion'] = '爆炸',
      ['explosive damage taken'] = '受到爆炸傷害',
      ['extended magazine'] = '擴充彈匣',
      ['extra padding'] = '額外填充',
      ['faf-14 spear'] = 'FAF-14 長矛',
      ['feet first'] = '護腿優先',
      ['field depth (m)'] = '佈設縱深(米)',
      ['field width (m)'] = '佈設寬度(米)',
      ['fire'] = '開火',
      ['fire damage taken'] = '受到火焰傷害',
      ['fire duration (s)'] = '持續燃燒時間(秒)',
      ['fire rate (rpm)'] = '射速(RPM)',
      ['fire/gas/acid/arc damage taken'] = '受到火焰 / 毒氣 / 酸液 / 電弧傷害',
      ['flam-40 flamethrower'] = 'FLAM-40 火焰噴射器',
      ['flam-66 torcher'] = 'FLAM-66 噴火者',
      ['flame sentry'] = '火焰火箭炮',
      ['flames'] = '火焰噴射器',
      ['flames mk2'] = '火焰噴射器MK2',
      ['flamethrower'] = '火焰噴射器',
      ['flashlight'] = '手電筒',
      ['flinch'] = '僵直',
      ['flinch (0 prevents it)'] = '僵直（0 為免疫）',
      ['folder'] = '資料夾',
      ['fortified'] = '強化',
      ['forward share of the launch (0-1)'] = '起跳前衝佔比(0-1)',
      ['frag'] = '破片彈',
      ['from supply'] = '來自補給',
      ['front hull'] = '前車體',
      ['front left cockpit'] = '左前駕駛艙',
      ['front right cockpit'] = '右前駕駛艙',
      ['full charge'] = '充滿',
      ['fuse time (s)'] = '引信時間(秒)',
      ['g-10 incendiary'] = 'G-10 燃燒彈',
      ['g-109 urchin'] = 'G-109 海膽',
      ['g-11 caltrops'] = 'G-11 蒺藜',
      ['g-12 high explosive'] = 'G-12 高爆彈',
      ['g-123 thermite'] = 'G-123 鋁熱彈',
      ['g-13 incendiary impact'] = 'G-13 衝擊燃燒彈',
      ['g-142 pyrotech'] = 'G-142 煙火表演',
      ['g-16 impact'] = 'G-16 衝擊彈',
      ['g-23 stun'] = 'G-23 暈眩彈',
      ['g-3 smoke'] = 'G-3 煙霧彈',
      ['g-31 arc'] = 'G-31 電弧',
      ['g-4 gas'] = 'G-4 毒氣彈',
      ['g-48 giga grenade'] = 'G-48 巨型手榴彈',
      ['g-50 seeker'] = 'G-50 追擊者',
      ['g-6 frag'] = 'G-6 破片彈',
      ['g-60 anti-tank seeker'] = 'G-60 反坦克追擊者',
      ['g-7 pineapple'] = 'G-7 鳳梨',
      ['g-8 immolation'] = 'G-8 焚毀',
      ['g-89 smokescreen'] = 'G-89 煙幕',
      ['g/40-k melta mine'] = 'G/40-K 熱熔地雷',
      ['g/sh-39 shield'] = 'G/SH-39 防護罩',
      ['gallant'] = '英勇',
      ['gas'] = '毒氣彈',
      ['gas damage taken'] = '受到毒氣傷害',
      ['gas mortar sentry'] = '毒氣彈哨戒迫擊炮',
      ['gatling sentry'] = '哨戒格林炮',
      ['generator'] = '發電機',
      ['giga grenade'] = '巨型手榴彈',
      ['github'] = 'GitHub',
      ['gl-15 evictor'] = 'GL-15 驅離者',
      ['gl-21 grenade launcher'] = 'GL-21 榴彈發射器',
      ['gl-28 belt-fed grenade launcher'] = 'GL-28 彈鏈式榴彈發射器',
      ['gl-52 de-escalator'] = 'GL-52 緩和使者',
      ['gp-20 ultimatum'] = 'GP-20 最後通牒',
      ['gp-31 grenade pistol'] = 'GP-31 榴彈槍',
      ['gr-8 recoilless rifle'] = 'GR-8 無後座力炮',
      ['gravity factor'] = '重力系數',
      ['grenade'] = '手雷',
      ['grenade fired (choice)'] = '發射手雷(選擇)',
      ['grenade launcher'] = '榴彈發射器',
      ['grenade pistol'] = '榴彈槍',
      ['grenade selection takes priority over projectile swap. fire rate, ammo and handling stay.'] = '手雷選擇優先於彈種交換。射速、彈藥與操控保持不變。',
      ['grenade swap'] = '手雷交換',
      ['grenade swap stopped (see the log); launchers fire their own projectiles again.'] = '已停止榴彈替換（詳見日誌）；發射器恢復使用自身射彈。',
      ['grenadier battlement'] = '擲彈兵掩體',
      ['guidance on after (s)'] = '導引啟動延遲(秒)',
      ['gun'] = '槍械',
      ['gunner frv'] = '炮手FRV',
      ['gunslinger'] = '神槍手',
      ['halt'] = '制止者',
      ['handling'] = '操控',
      ['head'] = '頭部',
      ['health'] = '生命值',
      ['heat per second firing'] = '射擊時每秒積熱',
      ['heat per shot'] = '每發積熱',
      ['heatsinks from supply'] = '補給散熱片',
      ['heavy burning'] = '重度燃燒',
      ['heavy machine gun'] = '重機槍',
      ['high capacity heatsink'] = '大容量散熱器',
      ['high dissipation heatsink'] = '高效能散熱器',
      ['high explosive'] = '高爆彈',
      ['high-velocity shrapnel'] = '高速榴散彈',
      ['hips'] = '腰部',
      ['hmg emplacement'] = '重機槍炮台',
      ['homing anti-air missile'] = '地對地飛彈',
      ['homing ground missile'] = '地對地飛彈',
      ['homing ground missile mk2'] = '地對地飛彈MK2',
      ['hot-shot marksman rifle'] = '火燙神射手步槍',
      ['hover agility (acceleration)'] = '懸停敏捷度(加速度)',
      ['hover pack'] = '懸浮背包',
      ['hover speed (m/s)'] = '懸停速度(米/秒)',
      ['hover time, full-speed climb (s)'] = '懸停時間：全速爬升(秒)',
      ['hover time, holding height (s)'] = '懸停時間：保持高度(秒)',
      ['hyena'] = '土狼',
      ['immolation'] = '焚毀',
      ['impact'] = '衝擊彈',
      ['impact damage taken'] = '受到衝擊傷害',
      ['incendiary'] = '燃燒彈',
      ['incendiary impact'] = '衝擊燃燒彈',
      ['incinerator frv'] = '焚燒者FRV',
      ['inflammable'] = '易燃物',
      ['injures you above heat (%)'] = '超過此熱量會灼傷(%)',
      ['inner radius (m)'] = '內半徑(米)',
      ['integrated explosives'] = '整合型炸藥',
      ['interface language'] = '介面語言',
      ['iron sights'] = '金屬瞄具',
      ['jar-5 dominator'] = 'JAR-5 主導者',
      ['jump pack'] = '彈跳背包',
      ['k-2 throwing knife'] = 'K-2 飛刀',
      ['kinetic displacement mitigation'] = '動能緩衝',
      ['knight'] = '騎士',
      ['knockdown chance'] = '擊倒機率',
      ['large plasma bolt'] = '大型電漿彈',
      ['larger plasma container'] = '加大電漿匣',
      ['las-12 sai'] = 'LAS-12 釵',
      ['las-13 trident'] = 'LAS-13 三叉戟',
      ['las-16 sickle'] = 'LAS-16 鐮刀',
      ['las-17 double-edge sickle'] = 'LAS-17 雙刃鐮刀',
      ['las-22 shear'] = 'LAS-22 雷射剪',
      ['las-44 nova'] = 'LAS-44 新星',
      ['las-5 scythe'] = 'LAS-5 長柄鐮',
      ['las-58 talon'] = 'LAS-58 利爪',
      ['las-7 dagger'] = 'LAS-7 匕首',
      ['las-98 laser cannon'] = 'LAS-98 雷射大炮',
      ['las-98 laser cannon (crewed mount)'] = 'LAS-98 雷射大炮（乘員炮座）',
      ['las-99 quasar cannon'] = 'LAS-99 類星體大砲',
      ['laser'] = '雷射',
      ['laser cannon'] = '雷射大炮',
      ['laser damage'] = '雷射傷害',
      ['laser sentry'] = '雷射哨戒炮',
      ['laser sight'] = '雷射瞄準器',
      ['laser sight flashlight'] = '附手電筒的雷射瞄準器',
      ['laser. standard prism'] = '標準稜鏡',
      ['launch duration (s)'] = '發射持續(秒)',
      ['launch force'] = '投擲力度',
      ['launch speed (m/s)'] = '投擲速度(米/秒)',
      ['left'] = '左',
      ['left arm'] = '左臂',
      ['left back panel'] = '左後板',
      ['left box 0'] = '左儲物箱 0',
      ['left box 1'] = '左儲物箱 1',
      ['left box 2'] = '左儲物箱 2',
      ['left front block'] = '左前塊',
      ['left front door'] = '左前門',
      ['left front light'] = '左前燈',
      ['left leg'] = '左腿',
      ['left mirror'] = '左後視鏡',
      ['left rear door'] = '左後門',
      ['left side panel 0'] = '左側板 0',
      ['left side panel 1'] = '左側板 1',
      ['left top block'] = '左上塊',
      ['left track'] = '左履帶',
      ['leg injury immunity (1 on)'] = '免疫腿部受傷（1 為開啟）',
      ['leveller'] = '夷平者',
      ['liberator'] = '解放者',
      ['liberator carbine'] = '卡賓槍解放者',
      ['liberator concussive'] = '震盪解放者',
      ['liberator legacy'] = '解放者「榮光」',
      ['liberator penetrator'] = '穿甲解放者',
      ['lift-182 warp pack'] = 'LIFT-182 傳送背包',
      ['lift-850 jump pack'] = 'LIFT-850 彈跳背包',
      ['lift-860 hover pack'] = 'LIFT-860 懸浮背包',
      ['limb health'] = '四肢生命值',
      ['limb injury avoidance'] = '免疫肢體受傷',
      ['load'] = '讀取',
      ['log file'] = '日誌檔案',
      ['logs'] = '日誌',
      ['loses its target past (deg)'] = '超出此角度丟失目標(度)',
      ['loyalist'] = '忠誠者',
      ['lumberer exosuit'] = '伐木工外骨骼裝甲',
      ['lure mine'] = '誘餌地雷',
      ['m-1000 maxigun'] = 'M-1000 麥西極槍',
      ['m-102 gunner frv'] = 'M-102 炮手FRV',
      ['m-103 supply frv'] = 'M-103 補給FRV',
      ['m-104 incinerator frv'] = 'M-104 焚燒者FRV',
      ['m-105 stalwart'] = 'M-105 盟友',
      ['m-105 stalwart (mounted)'] = 'M-105 盟友（固定式）',
      ['m-105 stalwart (mounted, ai-aimed 1)'] = 'M-105 盟友（固定式·AI 瞄準 1）',
      ['m-105 stalwart (mounted, ai-aimed 2)'] = 'M-105 盟友（固定式·AI 瞄準 2）',
      ['m6c/socom pistol'] = 'M6C/特種作戰 手槍',
      ['m7s smg'] = 'M7S 衝鋒槍',
      ['m90a shotgun'] = 'M90A 霰彈槍',
      ['ma5c assault rifle'] = 'MA5C 突擊步槍',
      ['machete'] = '彎刀',
      ['machine gun'] = '機槍',
      ['machine gun sentry'] = '哨戒機槍',
      ['made by shodan'] = '作者 SHODAN',
      ['maelstrom'] = '風暴渦旋',
      ['magazine size'] = '彈匣容量',
      ['magazines from supply'] = '補給彈匣',
      ['main gun'] = '主炮',
      ['marker radar scan every (s)'] = '標記雷達掃描間隔（秒）',
      ['max carried'] = '最大攜帶',
      ['max flight time (s)'] = '最大飛行時間(秒)',
      ['max spare heatsinks'] = '最多備用散熱片',
      ['max spare magazines'] = '最多備用彈匣',
      ['max spare rounds'] = '最多備用彈藥',
      ['max throw distance (m)'] = '最大投擲距離(米)',
      ['maxigun'] = '麥西極槍',
      ['mechas'] = '機甲',
      ['med-kit'] = '醫療套組',
      ['medium plasma bolt'] = '中型電漿彈',
      ['melee damage'] = '近戰傷害',
      ['melta mine'] = '熱熔地雷',
      ['meltagun'] = '熱熔槍',
      ['mg-206 heavy machine gun'] = 'MG-206 重機槍',
      ['mg-206 heavy machine gun (mounted b)'] = 'MG-206 重機槍（固定式 B）',
      ['mg-43 machine gun'] = 'MG-43 機槍',
      ['mg-43 machine gun (seaf)'] = 'MG-43 機槍（SEAF）',
      ['mgx-42 bullet storm'] = 'MGX-42 子彈風暴',
      ['mid-air steering force'] = '空中轉向力',
      ['mine'] = '地雷',
      ['minefield'] = '雷區',
      ['mines deep'] = '縱深地雷',
      ['mines per panel'] = '每面板地雷數',
      ['mines wide'] = '橫向地雷',
      ['minimum speed (m/s)'] = '最低速度(米/秒)',
      ['missile'] = '導彈',
      ['missile flight'] = '導彈飛行',
      ['missile pistol'] = '飛彈手槍',
      ['mist'] = '迷霧',
      ['mls-4x commando'] = 'MLS-4X 突擊兵',
      ['mortar sentry'] = '哨戒迫擊炮',
      ['move while reloading'] = '換彈時可移動',
      ['mp-98 knight'] = 'MP-98 騎士',
      ['ms-11 solo silo'] = 'MS-11 單發導彈筒',
      ['muzzle'] = '槍口',
      ['muzzle brake'] = '槍口制退器',
      ['napalm bomb'] = '凝固汽油彈',
      ['napalm bomb mk2'] = '凝固汽油彈MK2',
      ['napalm bomb mk3'] = '凝固汽油彈MK3',
      ['no changes: loading it puts every value back to the game\'s.'] = '沒有修改：讀取它會把所有數值恢復為遊戲原值。',
      ['no presets yet.'] = '還沒有預設。',
      ['noise'] = '噪音',
      ['not offered by the game: a laser built on the scythe. settings: unlock las-22 shear.'] = '遊戲本身未提供：基於「收割者」改造的雷射武器。設定項：解鎖 LAS-22 剪刀。',
      ['nothing matches.'] = '沒有符合項。',
      ['nova'] = '新星',
      ['nuke'] = '核彈',
      ['off'] = '關',
      ['off: the game\'s values everywhere; your '] = '關閉：全域性使用遊戲數值，你的',
      ['off: with other players, arc chain length / split use the game\'s values (else arcs can stay on screen).'] = '關閉：多人對局時電弧連鎖長度 / 分裂使用遊戲數值（否則電弧可留在螢幕上）。',
      ['ok'] = '確定',
      ['ombudsman'] = '監察官',
      ['on'] = '開',
      ['on: a loadout can take more than one exosuit, frv or tank.'] = '開啟：單次配裝可攜帶多台 外骨骼裝甲、FRV 或坦克。',
      ['on: in your armory / stratagem list.'] = '開啟：出現在你的軍械庫 / 戰略配備列表中。',
      ['on: your '] = '開啟：你的',
      ['on: your arc chain length / split apply with other players too (arcs can stay on screen).'] = '開啟：你的電弧連鎖長度 / 分裂對其他玩家同樣生效（電弧可留在螢幕上）。',
      ['one true flag'] = '唯一真旗',
      ['one-two'] = '雙響',
      ['open'] = '開啟',
      ['open / close key'] = '開啟 / 關閉熱鍵',
      ['optic'] = '瞄具',
      ['orbital'] = '軌道',
      ['orbital 120mm he barrage'] = '軌道120mm高爆彈彈幕',
      ['orbital 380mm he barrage'] = '軌道380mm高爆彈彈幕',
      ['orbital airburst strike'] = '軌道空爆打擊',
      ['orbital beam'] = '軌道光束',
      ['orbital ems strike'] = '軌道電磁干擾打擊',
      ['orbital gas strike'] = '軌道毒氣攻擊',
      ['orbital gatling barrage'] = '軌道格林機槍彈幕',
      ['orbital laser'] = '軌道雷射',
      ['orbital napalm barrage'] = '軌道汽油彈彈幕',
      ['orbital precision strike'] = '軌道精準攻擊',
      ['orbital railcannon strike'] = '軌道電磁炮攻擊',
      ['orbital smoke strike'] = '軌道煙霧突襲',
      ['orbital strike.'] = '軌道打擊。',
      ['orbital walking barrage'] = '軌道步行者彈幕',
      ['other players are in your game: arc chain length / split use the game\'s values.'] = '你的對局中存在其他玩家：電弧連鎖長度 / 分裂將使用遊戲數值。',
      ['outer radius (m)'] = '外半徑(米)',
      ['overcharge limit (s)'] = '過載上限(秒)',
      ['overheat threshold'] = '過熱閾值',
      ['oxygenator'] = '氧合器',
      ['p-11 stim pistol'] = 'P-11 治療槍',
      ['p-113 verdict'] = 'P-113 判官',
      ['p-19 redeemer'] = 'P-19 救世主',
      ['p-2 peacemaker'] = 'P-2 和平製造者',
      ['p-33 missile pistol'] = 'P-33 飛彈手槍',
      ['p-34 breacher'] = 'P-34 突破者',
      ['p-35 re-educator'] = 'P-35 思想改造',
      ['p-4 senator'] = 'P-4 參議員',
      ['p-41 ombudsman'] = 'P-41 監察官',
      ['p-41 ombudsman (variant 2)'] = 'P-41 監察官（變體 2）',
      ['p-44 mist'] = 'P-44 迷霧',
      ['p-69 veto'] = 'P-69 否決者',
      ['p-72 crisper'] = 'P-72 火舌',
      ['p-92 warrant'] = 'P-92 搜查令',
      ['p/40-k bolt pistol'] = 'P/40-K 爆彈手槍',
      ['pacifier'] = '安撫者',
      ['panel side'] = '面板位置',
      ['panel size'] = '面板大小',
      ['panels'] = '面板',
      ['passive'] = '被動',
      ['patriot exosuit'] = '愛國者外骨骼裝甲',
      ['peacemaker'] = '和平製造者',
      ['peak physique'] = '巔峰體態',
      ['pen.'] = '穿甲',
      ['penetration slowdown'] = '穿透衰減',
      ['pineapple'] = '鳳梨',
      ['plas-1 scorcher'] = 'PLAS-1 焦土',
      ['plas-101 purifier'] = 'PLAS-101 淨化者',
      ['plas-15 loyalist'] = 'PLAS-15 忠誠者',
      ['plas-39 accelerator rifle'] = 'PLAS-39 加速步槍',
      ['plas-45 epoch'] = 'PLAS-45 紀元',
      ['point of interest range'] = '興趣點探測範圍',
      ['portable hellbomb'] = '可攜式絕地彈',
      ['position scatter (m)'] = '散佈半徑(米)',
      ['presets'] = '預設',
      ['press a key (esc cancels)'] = '請按一個鍵(Esc 取消)',
      ['press the key that should open and close the panel: f1-f12, insert, home, end, pause or scroll lock. esc cancels.'] = '請按下用於開啟 / 關閉面板的按鍵：F1-F12、Insert、Home、End、Pause 或 Scroll Lock。Esc 取消。',
      ['primary'] = '主武器',
      ['primary reload speed'] = '主武器裝填速度',
      ['projectile'] = '射彈',
      ['projectile fired (id)'] = '發射的射彈(編號)',
      ['projectile swap'] = '彈種交換',
      ['projectiles per shot'] = '每次射擊射彈數',
      ['punisher'] = '制裁者',
      ['punisher plasma'] = '電漿制裁者',
      ['purifier'] = '淨化者',
      ['push force'] = '推力',
      ['pyrotech'] = '煙火表演',
      ['quasar cannon'] = '類星體大砲',
      ['r-2 amendment'] = 'R-2 修正',
      ['r-2124 constitution'] = 'R-2124 憲法',
      ['r-36 eruptor'] = 'R-36 噴發者',
      ['r-4 hyena'] = 'R-4 土狼',
      ['r-40 sightliner'] = 'R-40 視界者',
      ['r-6 deadeye'] = 'R-6 鷹眼',
      ['r-63 diligence'] = 'R-63 勤勉',
      ['r-63cs diligence counter sniper'] = 'R-63CS 反狙擊勤勉',
      ['r-72 censor'] = 'R-72 審查官',
      ['r/40-k hot-shot marksman rifle'] = 'R/40-K 火燙神射手步槍',
      ['rack'] = '掛架',
      ['radar'] = '雷達',
      ['radius (m)'] = '半徑(米)',
      ['rail cannon round'] = '軌道炮彈',
      ['railgun'] = '磁軌炮',
      ['railgun round'] = '磁軌炮彈',
      ['railgun stun round'] = '磁軌炮暈眩彈',
      ['range'] = '射程',
      ['range (m)'] = '射程(米)',
      ['rapid heatsink'] = '快速散熱器',
      ['re-educator'] = '思想改造',
      ['reach downward (m)'] = '向下觸及(米)',
      ['reach upward (m)'] = '向上觸及(米)',
      ['reading the game\'s weapon tables... ('] = '正在讀取遊戲武器表…（',
      ['rear cockpit'] = '後駕駛艙',
      ['recharge delay (s)'] = '重新充能延遲(秒)',
      ['recharge delay once broken (s)'] = '破損後的充能延遲(秒)',
      ['recharge rate (per s)'] = '充能速率(每秒)',
      ['recharge time (s)'] = '充能時間(秒)',
      ['recoil (horizontal)'] = '後坐力(水平)',
      ['recoil (vertical)'] = '後坐力(垂直)',
      ['recoil crouching / prone'] = '蹲姿 / 臥姿後坐力',
      ['recoil multiplier (horizontal)'] = '後坐倍率(水平)',
      ['recoil multiplier (vertical)'] = '後坐倍率(垂直)',
      ['recoilless rifle'] = '無後座力炮',
      ['redeemer'] = '救世主',
      ['reduced signature'] = '隱跡',
      ['regeneration (health/s)'] = '再生(生命/秒)',
      ['reinforced epaulettes'] = '強化護肩',
      ['reload allowed below (rounds)'] = '允許換彈下限(發)',
      ['reload time (s)'] = '換彈時間(秒)',
      ['remember last tab and weapon'] = '記住上次的分頁與武器',
      ['rename'] = '重新命名',
      ['reprimand'] = '懲戒',
      ['reset all values'] = '重置全部數值',
      ['reset passive'] = '重置被動',
      ['reset weapon'] = '重置武器',
      ['resets all values from the current preset to default.'] = '將當前預設的全部數值恢復為預設值。',
      ['right'] = '右',
      ['right arm'] = '右臂',
      ['right back panel'] = '右後板',
      ['right box 0'] = '右儲物箱 0',
      ['right box 1'] = '右儲物箱 1',
      ['right box 2'] = '右儲物箱 2',
      ['right front block'] = '右前塊',
      ['right front door'] = '右前門',
      ['right front light'] = '右前燈',
      ['right leg'] = '右腿',
      ['right mirror'] = '右後視鏡',
      ['right rear door'] = '右後門',
      ['right side panel 0'] = '右側板 0',
      ['right side panel 1'] = '右側板 1',
      ['right top block'] = '右上塊',
      ['right track'] = '右履帶',
      ['rl-77 airburst rocket launcher'] = 'RL-77 空爆火箭發射器',
      ['rock solid'] = '堅如磐石',
      ['rocket sentry'] = '哨戒火箭炮',
      ['round 1 blast'] = '第 1 發爆炸',
      ['round 1 blast radius'] = '第 1 發爆炸半徑',
      ['round 1 projectile'] = '第 1 發射彈',
      ['rounds 2, 3 blast radius'] = '第 2、3 發爆炸半徑',
      ['rounds 2, 3 projectile'] = '第 2、3 發射彈',
      ['rounds 2, 3, 4 projectile'] = '第 2、3、4 發射彈',
      ['rounds from supply'] = '補給彈藥',
      ['rounds loaded'] = '裝填彈數',
      ['rounds per reload'] = '每次裝填彈數',
      ['rs-422 railgun'] = 'RS-422 磁軌炮',
      ['run length (m)'] = '推進距離(米)',
      ['s-11 speargun'] = 'S-11 矛槍',
      ['safe below heat (%)'] = '安全熱量(%)',
      ['sai'] = '釵',
      ['salvos'] = '齊射次數',
      ['save'] = '儲存',
      ['save current changes here'] = '在此儲存當前修改',
      ['scorcher'] = '焦土',
      ['scout'] = '偵察兵',
      ['scythe'] = '長柄鐮',
      ['search radius (m)'] = '搜尋半徑(米)',
      ['search weapons and stratagems'] = '搜尋武器與戰略配備',
      ['second mode'] = '第二模式',
      ['second mode fires (id)'] = '第二模式發射的射彈(編號)',
      ['secondary'] = '副武器',
      ['secondary draw speed'] = '副武器拔出速度',
      ['secondary recoil'] = '副武器後坐力',
      ['secondary reload speed'] = '副武器裝填速度',
      ['seeker'] = '追擊者',
      ['senator'] = '參議員',
      ['sentry: its cooldown, its body, then its weapon.'] = '哨戒炮：依次為冷卻時間、本體、武器。',
      ['servo-assisted'] = '伺服輔助',
      ['settings'] = '設定',
      ['settings are saved at once, in config.txt with your changes.'] = '設定會與你的修改一併即時儲存到 config.txt。',
      ['several vehicles of a kind'] = '同類載具數量',
      ['sg-20 halt'] = 'SG-20 制止者',
      ['sg-22 bushwhacker'] = 'SG-22 游擊者',
      ['sg-225 breaker'] = 'SG-225 破裂者',
      ['sg-225ie breaker incendiary'] = 'SG-225IE 燃燒破裂者',
      ['sg-225sp breaker spray&pray'] = 'SG-225SP 掃射破裂者',
      ['sg-451 cookout'] = 'SG-451 燎原',
      ['sg-8 punisher'] = 'SG-8 制裁者',
      ['sg-88 break-action shotgun'] = 'SG-88 中折式散彈槍',
      ['sg-8p punisher plasma'] = 'SG-8P 電漿制裁者',
      ['sg-8s slugger'] = 'SG-8S 制裁者散彈槍',
      ['sg-97 sweeper'] = 'SG-97 掃蕩者',
      ['sh-20 ballistic shield backpack'] = 'SH-20 彈道防護罩背包',
      ['sh-32 shield generator pack'] = 'SH-32 防護罩生成背包',
      ['sh-51 directional shield'] = 'SH-51 定向護盾',
      ['shear'] = '雷射剪',
      ['shells per salvo'] = '每次齊射彈數',
      ['shield'] = '防護罩',
      ['shield capacity'] = '護盾容量',
      ['shield emitter'] = '護盾發生器',
      ['shield generator pack'] = '防護罩生成背包',
      ['shockwave radius (m)'] = '衝擊波半徑(米)',
      ['shodan stat editor'] = 'SHODAN 數值編輯器',
      ['shodan weapon mods are running too: they put their own values back every 5 s'] = '檢測到 SHODAN 武器 mod 同時執行：它們每 5 秒會把數值改回自己的設定',
      ['short magazine'] = '短型彈匣',
      ['shrapnel'] = '榴散彈',
      ['shrapnel blast radius'] = '破片爆炸半徑',
      ['shrapnel direct hit'] = '破片直擊',
      ['shrapnel pieces'] = '破片數量',
      ['shrapnel projectile'] = '破片射彈',
      ['sickle'] = '鐮刀',
      ['siege-ready'] = '圍攻準備完畢',
      ['sightliner'] = '視界者',
      ['silo'] = '發射井',
      ['slide speed / duration'] = '滑行速度 / 持續時間',
      ['slugger'] = '制裁者散彈槍',
      ['small plasma bolt'] = '小型電漿彈',
      ['smg'] = '衝鋒槍',
      ['smg-203 gallant'] = 'SMG-203 英勇',
      ['smg-32 reprimand'] = 'SMG-32 懲戒',
      ['smg-37 defender'] = 'SMG-37 防衛者',
      ['smg-37 defender (seaf)'] = 'SMG-37 防衛者（SEAF）',
      ['smg-72 pummeler'] = 'SMG-72 猛擊者',
      ['smg/flam-34 stoker'] = 'SMG/FLAM-34 爆燃者',
      ['smg/flam-34 stoker (underbarrel flamer)'] = 'SMG/FLAM-34 爆燃者（下掛噴火器）',
      ['smoke'] = '煙霧彈',
      ['smokescreen'] = '煙幕',
      ['sniper scope 10x'] = '10倍狙擊鏡',
      ['sniper scope 10x helghast'] = '10倍狙擊鏡',
      ['solo silo'] = '單發導彈筒',
      ['spear'] = '長矛',
      ['speargun'] = '矛槍',
      ['spotting range (m)'] = '索敵距離(米)',
      ['spread (horizontal)'] = '散佈(水平)',
      ['spread (vertical)'] = '散佈(垂直)',
      ['spread area (m)'] = '散佈範圍(米)',
      ['spread multiplier (horizontal)'] = '散佈倍率(水平)',
      ['spread multiplier (vertical)'] = '散佈倍率(垂直)',
      ['sta-11 smg'] = 'StA-11 衝鋒槍',
      ['sta-52 assault rifle'] = 'StA-52 突擊步槍',
      ['sta-x3 w.a.s.p. launcher'] = 'StA-X3 W.A.S.P.火箭發射器',
      ['stage '] = '階段 ',
      ['stagger force'] = '硬直力',
      ['stalwart'] = '盟友',
      ['standard drum'] = '標準彈鼓',
      ['standard heatsink'] = '標準散熱器',
      ['standard plasma container'] = '標準電漿匣',
      ['starting charges'] = '初始使用次數',
      ['starting count'] = '初始數量',
      ['starting heatsinks'] = '初始散熱片',
      ['starting magazines'] = '初始彈匣',
      ['starting rounds'] = '初始彈藥',
      ['starts at heat'] = '初始熱量',
      ['stationary shroud'] = '定點匿蹤',
      ['stim pistol'] = '治療槍',
      ['stoker'] = '爆燃者',
      ['stops you while firing'] = '開火時鎖定移動',
      ['stratagem'] = '戰略配備',
      ['stratagems'] = '戰略配備',
      ['stun'] = '暈眩彈',
      ['stun (large)'] = '暈眩彈（大）',
      ['stun (massive)'] = '暈眩彈（極大）',
      ['stun (medium)'] = '暈眩彈（中）',
      ['stun (small)'] = '暈眩彈（小）',
      ['stun baton'] = '暈眩棍',
      ['stun lance'] = '暈眩長槍',
      ['supplementary adrenaline'] = '腎上腺素補劑',
      ['supply frv'] = '補給FRV',
      ['supply pack'] = '補給背包',
      ['support'] = '支援武器',
      ['support reload speed'] = '支援武器裝填速度',
      ['support weapon drop; the weapon itself is under support.'] = '支援武器空投；武器本身列在「支援武器」分類下。',
      ['suppressor'] = '消音器',
      ['sure?'] = '確定？',
      ['surviving lethal damage'] = '致命傷害存活',
      ['sway multiplier'] = '晃動係數',
      ['sweeper'] = '掃蕩者',
      ['talon'] = '利爪',
      ['td-110 maelstrom'] = 'TD-110 風暴渦旋',
      ['td-220 bastion mk xvi'] = 'TD-220 堡壘MK XVI',
      ['ted-63 dynamite'] = 'TED-63 炸藥',
      ['tenderizer'] = '肉錘',
      ['tesla tower'] = '特斯拉塔',
      ['the arbitrator\'s underbarrel shotgun, not the rifle itself.'] = '「仲裁者」的下掛霰彈槍，不是步槍本身。',
      ['the charge backpack, the charge and its blast. cooldown: stratagems tab.'] = '充能背包、充能及其爆炸。冷卻時間見「戰略配備」頁。',
      ['the defender seaf soldiers carry. not yours.'] = 'SEAF 士兵攜帶的「防衛者」。不是你的那把。',
      ['the eat-17 seaf soldiers carry. not yours.'] = 'SEAF 士兵攜帶的 EAT-17。不是你的那把。',
      ['the flamethrower you carry.'] = '你攜帶的火焰噴射器。',
      ['the game\'s tiers: 10 small arms, 20 hmg, 30 autocannon, 40 strider, 50 orbital, 60 hellbomb, 250 never'] = '遊戲的分級：10 輕武器、20 重機槍、30 機炮、40 蹂躪者、50 軌道、60 地獄炸彈、250 不可摧毀',
      ['the mg-43 seaf soldiers carry. not yours.'] = 'SEAF 士兵攜帶的 MG-43。不是你的那把。',
      ['the one you carry.'] = '你攜帶的那一把。',
      ['the one you carry. the cqc-20 breaching hammer is listed under support.'] = '你攜帶的那一把。CQC-20 破拆錘列在「支援武器」下。',
      ['the one you carry. the cqc-72 support version is listed under support.'] = '你攜帶的那一把。CQC-72 支援版本列在「支援武器」下。',
      ['the one-two\'s underbarrel launcher, not the rifle. fires the gp-31\'s grenade.'] = '「么二」的下掛發射器，不是步槍本身。發射 GP-31 的榴彈。',
      ['the pistol you carry. the one-two\'s launcher is listed under the one-two.'] = '你攜帶的手槍。「么二」的發射器列在「么二」下。',
      ['the recharge time is 0: set it above 0 first.'] = '重新裝填時間為 0：請先設為大於 0 的值。',
      ['the rifle you carry. the grenade launcher is listed separately.'] = '你攜帶的步槍。榴彈發射器單獨列出。',
      ['the rifle you carry. the underbarrel shotgun is listed separately.'] = '你攜帶的步槍。下掛霰彈槍單獨列出。',
      ['the scythe you carry.'] = '你攜帶的「收割者」。',
      ['the smg you carry. its underbarrel flamer is listed separately.'] = '你攜帶的衝鋒槍。其下掛火焰噴射器單獨列出。',
      ['the stoker\'s underbarrel flamer, not the smg itself.'] = '「司爐者」的下掛火焰噴射器，不是衝鋒槍本身。',
      ['the support hammer delivered by hellpod. the game data files it next to the machete.'] = '由空投艙投送的支援錘。遊戲資料將它列在砍刀旁邊。',
      ['the support weapon. the cqc-73 is listed under secondary.'] = '支援武器。CQC-73 列在「副武器」下。',
      ['thermite'] = '鋁熱彈',
      ['throw range'] = '投擲距離',
      ['throw spread (degrees)'] = '投擲散佈(度)',
      ['throw velocity, max (m/s)'] = '投擲速度上限(米/秒)',
      ['throw velocity, min (m/s)'] = '投擲速度下限(米/秒)',
      ['throwable'] = '投擲物',
      ['throwables'] = '投擲物',
      ['throwing knife'] = '飛刀',
      ['time between bombs (s)'] = '投彈間隔(秒)',
      ['time between salvos (s)'] = '齊射間隔(秒)',
      ['time between shells (s)'] = '彈藥間隔(秒)',
      ['tm-1 lure mine'] = 'TM-1 誘餌地雷',
      ['top left hatch'] = '左上艙蓋',
      ['top right hatch'] = '右上艙蓋',
      ['torcher'] = '噴火者',
      ['tracking speed'] = '跟蹤速度',
      ['trigger delay (s)'] = '觸發延遲(秒)',
      ['true grit'] = '堅毅不屈',
      ['tube reddot 2x'] = '2倍紅點瞄具',
      ['turn speed at cruise'] = '巡航轉向速率',
      ['turn speed at slowest'] = '最慢轉向速率',
      ['tx-41 sterilizer'] = 'TX-41 滅菌者',
      ['type the name: enter keeps it, esc cancels. the game sees these keys too, so name presets from a menu.'] = '輸入名稱：回車確認，Esc 取消。遊戲同樣會收到這些按鍵，建議在選單介面命名。',
      ['type the percent (%d-%d): enter sets it, esc cancels.'] = '輸入百分比(%d-%d)：回車確認，Esc 取消。',
      ['type the value: enter sets it, esc cancels. values out of range are set to the nearest allowed one.'] = '輸入數值：回車確認，Esc 取消。超出範圍的數值會取最接近的合法值。',
      ['type to search: enter keeps the results, esc clears the search. the game sees these keys too.'] = '輸入以搜尋：回車確認結果，Esc 清空搜尋。遊戲同樣會收到這些按鍵。',
      ['ultimatum'] = '最後通牒',
      ['underbarrel'] = '下掛',
      ['unflinching'] = '無懼',
      ['unlock unused items'] = '解鎖未使用物品',
      ['unsafe warp: damage to you'] = '不安全躍遷：對你造成的傷害',
      ['up'] = '上移',
      ['up/down choose a stat, left/right change it (shift: bigger steps), click a value or press enter to type it,'] = '上下鍵選擇數值項，左右鍵調整（Shift 為大步長），點選數值或按回車直接輸入，',
      ['up/down choose, enter loads, insert makes a new one, shift+insert saves into it, f2 renames, del deletes.'] = '上下鍵選擇，回車讀取，Insert 新建，Shift+Insert 存入當前預設，F2 重新命名，Del 刪除。',
      ['urchin'] = '海膽',
      ['uses per rearm'] = '每次補充可用次數',
      ['variable'] = '變數',
      ['vehicle'] = '載具',
      ['velocity'] = '初速',
      ['velocity (m/s)'] = '初速(米/秒)',
      ['verdict'] = '判官',
      ['vertical grip'] = '直立前握把',
      ['vertical grip 45 degree'] = '45度角直立前握把',
      ['vertical grip advanced'] = '進階直立前握把',
      ['veto'] = '否決者',
      ['vg-70 variable'] = 'VG-70 變數',
      ['volatile plasma bolt'] = '揮發性電漿彈',
      ['w.a.s.p. launcher'] = 'W.A.S.P.火箭發射器',
      ['walk / run speed'] = '行走 / 奔跑速度',
      ['walking speed (m/s)'] = '遊走速度(米/秒)',
      ['warp distance (m)'] = '躍遷距離(米)',
      ['warp pack'] = '傳送背包',
      ['warrant'] = '搜查令',
      ['weapon stats'] = '武器數值',
      ['wind-down time (s)'] = '洩壓時間(秒)',
      ['wind-up'] = '預熱',
      ['wind-up time (s)'] = '預熱時間(秒)',
      ['your changes are off: turn them on in settings to edit.'] = '你的改動當前處於關閉狀態：請在設定裡開啟後再編輯。',
    },
    patterns = {
      { '^(.-) SHRAPNEL$', '%1破片' },
      { '^(.-) EXPLOSION ID$', '%1爆炸 ID' },
      { '^projectile (%d+) %(not in this game build%)$', '射彈 %1（本版本遊戲裡沒有）' },
      { '^explosion (%d+) %(not in this game build%)$', '爆炸 %1（本版本遊戲裡沒有）' },
      { '^No explosion (.+) in the game%.$', '遊戲裡沒有編號為 %1 的爆炸。' },
      { '^each piece is (.+)$', '每塊破片為 %1' },
      { '^sets off: (.+)$', '引發：%1' },
      { '^Set off by: (.+)$', '引爆武器：%L1' },
      { '^Fired by: (.+)$', '發射武器：%L1' },
      { '^(%*? ?)Status #(%d+)$', '%1狀態 #%2' },
      { '^(%*? ?)Status #(%d+) · (.+)$', '%1狀態 #%2 · %3' },
      { '^(%*? ?)Explosion #(%d+)$', '%1爆炸 #%2' },
      { '^(%*? ?)Explosion #(%d+) · (.+)$', '%1爆炸 #%2 · %3' },
      { '^(%*? ?)Projectile #(%d+)$', '%1射彈 #%2' },
      { '^(%*? ?)Projectile #(%d+) · (.+)$', '%1射彈 #%2 · %3' },
      { '^Your values are installed %((%d+) game files%)%. Close the game before installing%.$', '你的數值已安裝（%1 個遊戲檔案）。安裝前請先關閉遊戲。' },
      { '^Installing: preparing (.+) %((%d+) of (%d+)%)%.%.%.$', '安裝中：正在準備 %1（%2 / %3）...' },
      { '^Not installed: (.+) could not be prepared %((.+)%)%. Nothing was changed%.$', '未安裝：無法準備 %1（%2）。未做任何更改。' },
      { '^Not installed: (.+)$', '未安裝：%1' },
      { '^Installed %((%d+) game files changed%)%. Start the game to play with your values%.$', '已安裝（修改了 %1 個遊戲檔案）。啟動遊戲即可使用你的數值。' },
      { '^Installed %((%d+) game files changed, (%d+) back to the original%)%. Start the game to play with your values%.$', '已安裝（修改了 %1 個遊戲檔案，%2 個恢復為原始檔案）。啟動遊戲即可使用你的數值。' },
      { '^Not restored: (.+)$', '未恢復：%1' },
      { '^Update failed: (.+)%. The release page has it: (.+)$', '更新失敗：%1。可在釋出頁面下載：%2' },
      { '^Update failed: (.+)%. Nothing was changed%.$', '更新失敗：%1。未做任何更改。' },
      { '^Update to (.+)$', '更新到 %1' },
      { '^Updating: downloading (.+)%.%.%.$', '正在更新：下載 %1...' },
      { '^Updating: installing (.+)%.%.%.$', '正在更新：安裝 %1...' },
      { '^Updated to (.+)%.$', '已更新到 %1。' },
      { '^Add a passive to (.+)$', '為 %1 新增被動' },
      { '^Not installed: the armor passives could not be stacked %((.+)%)%. Nothing was changed%.$', '未安裝：無法疊加護甲被動（%1）。未做任何更改。' },
      { '^Heat level (%d+)$', '熱量等級 %1' },
      { '^(.+); ammo type shared with (.+)$', '%1；彈種與以下共用：%L2' },
      { '^fires: (.+)%. The rows above stay its own$', '發射：%1。上方各行仍為其自身數值' },
      { '^fires: (.+)$', '發射：%1' },
      { '^loading: (.+)$', '載入中：%1' },
      { '^projectile (%d+)$', '射彈 %1' },
      { '^Preset (%d+)$', '預設 %1' },
      { '^Saved (.+) preset (%d+) %((%d+) changed value%(s%)%)$', '已儲存%1的預設 %2（%3 項改動）' },
      { '^(.+) preset (%d+) is empty$', '%1的預設 %2 為空' },
      { '^Loaded (.+) preset (%d+) %((%d+) value%(s%) not applied%)$', '已讀取%1的預設 %2（%3 項未應用）' },
      { '^Loaded (.+) preset (%d+)$', '已讀取%1的預設 %2' },
      { '^Cleared (.+) preset (%d+)$', '已清除%1的預設 %2' },
      { '^Empty name: kept "(.+)"$', '名稱為空：保留「%1」' },
      { '^Named it "(.+)"$', '已命名為「%1」' },
      { '^All (%d+) presets are in use: delete one first$', '全部 %1 個預設均已使用：請先刪除一個' },
      { '^Saved (%d+) changed value%(s%) as a new preset%. Type its name, Enter keeps it%.$', '已將 %1 項改動儲存為新預設。輸入名稱，按 Enter 確認。' },
      { '^Saved (%d+) changed value%(s%) into "(.+)"$', '已將 %1 項改動儲存到「%2」' },
      { '^Loaded "(.+)" %((%d+) value%(s%) not applied%)$', '已讀取「%1」（%2 項未應用）' },
      { '^Loaded "(.+)"$', '已讀取「%1」' },
      { '^Deleted "(.+)"$', '已刪除「%1」' },
      { '^Again to overwrite "(.+)"$', '再次點選以覆蓋「%1」' },
      { '^Again to delete "(.+)"$', '再次點選以刪除「%1」' },
      { '^rows (%d+)%-(%d+) of (%d+)$', '第 %1-%2 行 / 共 %3 行' },
      { '^Above (%d+)%% heat$', '熱量高於 %1%' },
      { '^ABOVE (%d+)%% HEAT$', '熱量高於 %1%' },
      { '^Fire rate (%d+) %(RPM%)$', '射速 %1（RPM）' },
      { '^Modifier (%x+)$', '修正項 %1' },
      { '^(.+) %(SEAF%)$', '%1（SEAF）' },
      { '^The (.+) SEAF soldiers carry%. Not yours%.$', 'SEAF 士兵攜帶的%1。不是你的。' },
      { '^(.+): in the game files, not offered by it%.$', '%L1：存在於遊戲檔案中，但遊戲本身並未提供。' },
      { '^shared with (.+) %+(%d+)$', '與以下共用：%L1 等 %2 項' },
      { '^shared with (.+)$', '與以下共用：%L1' },
      { '^Reading the game\'s weapon tables%.%.%. %((%d+) of (%d+) found%)$', '正在讀取遊戲的武器資料表…（已找到 %1 / %2）' },
      { '^(%d+)%-(%d+) of (%d+) found$', '第 %1-%2 項 / 共 %3 項（搜尋命中）' },
      { '^(%d+) found$', '共 %1 項命中' },
      { '^(%d+)%-(%d+) of (%d+) listed$', '第 %1-%2 項 / 共 %3 項' },
      { '^(%d+) listed$', '共 %1 項' },
      { '^(%d+)%-(%d+) of (%d+) %(max (%d+)%)$', '第 %1-%2 項 / 共 %3 項（上限 %4）' },
      { '^(%d+) %(max (%d+)%)$', '共 %1 項（上限 %2）' },
      { '^(%d+) value%(s%) for (%d+) weapon%(s%) / stratagem%(s%):$', '%1 項改動，涉及 %2 個武器 / 戰略配備：' },
      { '^(%d+) value%(s%)$', '%1 項' },
      { '^On: your (%d+) change%(s%) are applied%.$', '開啟：你的 %1 項改動已生效。' },
      { '^Off: the game\'s values everywhere; your (%d+) change%(s%) are kept for when you turn them on%.$', '關閉：介面全部顯示遊戲原值；你的 %1 項改動已保留，開啟後即生效。' },
      { '^%(untested%) Other players are in your game: arc chain length / split use the game\'s values%.$', '（未測試）你的對局中存在其他玩家：電弧連鎖長度 / 分裂使用遊戲數值。' },
      { '^%(untested%) On: your arc chain length / split apply with other players too %(arcs can stay on screen%)%.$', '（未測試）開啟：你的電弧連鎖長度 / 分裂對其他玩家同樣生效（電弧可能留在螢幕上）。' },
      { '^%(untested%) Off: with other players, arc chain length / split use the game\'s values %(else arcs can stay on screen%)%.$', '（未測試）關閉：多人對局時電弧連鎖長度 / 分裂使用遊戲數值（否則電弧可能留在螢幕上）。' },
      { '^%(untested%) Arc chains: player count unavailable: .+; your values stay%.$', '（未測試）電弧連鎖：暫時讀不到玩家人數；你的數值仍會保留。' },
      { '^Also changes %((%d+)%):$', '同時影響 %1 項：' },
      { '^%+ (%d+) more$', '另有 %1 項' },
      { '^%+(%d+) more$', '另有 %1 項' },
      { '^(.+) applied per hit$', '%1：每次命中施加' },
      { '^(.+) applied per blast$', '%1：每次爆炸施加' },
      { '^(.+) duration %(s%)$', '%1持續時間（秒）' },
      { '^every (.+) source shares these %(other weapons, strikes, hazards, enemies%)$', '所有%1來源共用這組數值（其他武器、軌道打擊、環境危害、敵人）' },
      { '^every (.+) source shares this %(other weapons, grenades, strikes%)$', '所有%1來源共用這組數值（其他武器、投擲物、軌道打擊）' },
      { '^explosion: also the (.+)\'s$', '爆炸：同樣適用於%1' },
      { '^damage: the same as the (.+)\'s %(above%)$', '傷害：同上方%1' },
      { '^also the (.+)\'s damage$', '傷害同樣取自%1' },
      { '^direct hit: also the (.+) shot\'s$', '直擊：同樣適用於%1射彈' },
      { '^direct hit: see the (.+) shot$', '直擊：見%1射彈' },
      { '^Stage (%d+) charge time %(s%)$', '第 %1 階段充能時間（秒）' },
      { '^(.+) multiplier, min charge$', '%1倍率（最少充能）' },
      { '^(.+) multiplier, overcharge$', '%1倍率（過充）' },
      { '^(.+) durable$', '%1堅固值' },
      { '^(.+) health$', '%1生命值' },
      { '^(.+) armor$', '%1護甲值' },
      { '^(.+) damage$', '%1傷害' },
      { '^Guard Dog backpack: the drone and the gun it carries%. (.+)$', '護衛犬背包：無人機與它攜帶的槍械。%1' },
      { '^(.+) stratagem %((.+)%)%.$', '%1戰略配備（%2）。' },
      { '^Mounted on the (.+), (.+)%.$', '安裝在%1、%2上。' },
      { '^Mounted on the (.+)%.$', '安裝在%1上。' },
      { '^(.+): Left arm$', '%1：左臂' },
      { '^(.+): Right arm$', '%1：右臂' },
      { '^(.+): Main gun$', '%1：主炮' },
      { '^(.+): Driver gun$', '%1：駕駛員機槍' },
      { '^(.+): Turret$', '%1：炮塔' },
      { '^(.+): Gun$', '%1：槍械' },
      { '^(.+): Rack$', '%1：掛架' },
      { '^(.+): Weapon (%d+)$', '%1：武器 %2' },
      { '^(.+), ([A-Z][^%.,;:]+)%.$', '%1，%2。' },
      { '^Muzzle brake %((.+)%)$', '槍口制退器（%1）' },
      { '^Muzzle%. Only the (.+) comes with it%.$', '槍口：僅%1自帶此槍口。' },
      { '^(.+)%. Its modifiers apply to every weapon fitted with it%.$', '%1：其修正項對每一件裝配它的武器生效。' },
      { '^(.+)%. Its modifiers apply to every weapon loaded with it%.$', '%1：其修正項對每一件裝載它的武器生效。' },
      { '^(.+) %(alternate%)$', '%1（備用）' },
      { '^Rounds per (.+) %(empty%)$', '空槍 %1 裝填數' },
      { '^Demolition force, stage (%d+)$', '拆解力：第 %1 階段' },
      { '^Demolition force to destroy it %(direct hits%)$', '摧毀所需拆解力（直擊）' },
      { '^Demolition force to destroy it$', '摧毀所需拆解力' },
      { '^Status (%d+)$', '狀態 %1' },
      { '^Passive (%d+)$', '護甲被動 %1' },
      { '^Stat (%d+)$', '數值項 %1' },
      { '^Part (%d+)$', '部件 %1' },
      { '^Weapon (%d+)$', '武器 %1' },
    },
    prefix = {
      { 'PgUp/PgDn change weapon, Del resets, Ctrl+1-5 loads a weapon preset, Ctrl+Shift+1-5 saves one; ', 'PgUp/PgDn 切換武器，Del 重置，Ctrl+1-5 讀取武器預設，Ctrl+Shift+1-5 儲存預設；' },
      { 'Overwriting and deleting ask twice. Changes apply at once and are saved; ', '覆蓋儲存與刪除需二次確認。修改會立即生效並儲存；' },
      { 'The panel now opens and closes with ', '面板現在透過 ' },
      { 'Saved as StatEditor\\preset_', '已儲存為 StatEditor\\preset_' },
      { 'Arc chains: player count ', '電弧連鎖：玩家人數 ' },
      { 'No grenade choice ', '未選擇投擲物：' },
      { 'No projectile ', '未選擇射彈：' },
      { 'Also changes (', '同時改動（' },
      { 'value(s) for ', '項改動，涉及 ' },
      { 'Now changed: ', '當前已修改：' },
      { '(untested) ', '（未測試）' },
      { 'unknown ', '未知 ' },
      { 'was ', '原為 ' },
    },
    suffix = {
      { ' value(s). Loading a preset replaces every current change with it.', ' 項改動。讀取預設會覆蓋當前所有修改。' },
      { ' change(s) are kept for when you turn them on.', ' 項改動將在你開啟時保留。' },
      { ': in the game files, not offered by it.', '：存在於遊戲檔案中，但遊戲本身並未提供。' },
      { '.txt (copy it to share the set).', '.txt（複製它即可分享該配置）。' },
      { ' weapon(s) / stratagem(s):', ' 個武器 / 戰略配備：' },
      { ' change(s) are applied.', ' 項改動已應用。' },
      { '; your values stay.', '；你的數值仍會保留。' },
      { ' value(s) changed.', ' 項已修改。' },
      { ' charge time (s)', ' 充能時間(秒)' },
      { ' to open/close', ' 開啟 / 關閉面板' },
      { ', min charge', '，最少充能' },
      { ', overcharge', '，過充' },
      { ' value(s)', ' 項' },
      { ' found)', ' 已找到)' },
      { ' listed', ' 項' },
      { ' found', ' 已找到' },
      { ' more', ' 更多' },
    },
  },
  { id = 'ru', name = 'Русский', list = ', ',
    fonts = { { font = 'abf8b5ba1469879a', atlas = '6b02f70a77aafd2d' }, { font = 'e6944ade8a140216', atlas = '529a0ff67a1c8a0b' } },
    exact = {
      ['"+ New preset" (or Insert) saves your current changes as one; you name it next.'] = '«+ Новый пресет» (или Insert) сохраняет текущие изменения как пресет; затем вы даете ему имя.',
      ['+ Add passive'] = '+ Добавить эффект',
      ['+ Armor rating'] = '+ Рейтинг брони',
      ['+ Ergonomics'] = '+ Эргономика',
      ['+ New preset from current changes'] = '+ Новый пресет из текущих изменений',
      ['+ Stamina when hit'] = '+ Выносливость при попадании',
      ['+ Stim duration (s)'] = '+ Длительность стима (с)',
      ['+ Stims (start, max)'] = '+ Стимы (в начале, макс.)',
      ['+ Throwables (start, max)'] = '+ Метательное (в начале, макс.)',
      ['0 = normal projectile; - / + selects a throwable grenade by name above.'] = '0 = обычный снаряд; - / + выбирает гранату по названию выше.',
      ['0: hits deal their normal damage, 1: their durable damage (the weapon\'s lower one)'] = '0: попадания наносят обычный урон, 1: урон по прочным (меньший у оружия)',
      ['100kg Bomb'] = 'Бомба (100 кг)',
      ['100kg Bomb Mk2'] = 'Бомба Mk2 (100 кг)',
      ['100kg Bomb Mk3'] = 'Бомба Mk3 (100 кг)',
      ['100kg Cluster Bomb'] = 'Кластерная бомба (100кг)',
      ['10g Birdshot'] = 'Дробь 10 кал.',
      ['10g Buckshot'] = 'Картечь 10 кал.',
      ['10g Bugshot'] = 'Противожучиные боеприпасы 10 кал.',
      ['10g Dual Sabot'] = 'Двойной снаряд с поддоном 10 кал.',
      ['10g Flechettes'] = 'Флешетты 10 кал.',
      ['10g Fragmentation'] = 'Осколочные 10 кал.',
      ['10g High Velocity Sabot'] = 'Высокоскоростной снаряд с поддоном 10 кал.',
      ['10g Liberty Fire'] = 'Огонь свободы 10 кал.',
      ['10g Magnum'] = 'Магнум 10 кал.',
      ['10g Magnum Triball'] = 'Магнум с тремя шариками 10 кал.',
      ['10g Rifled Slugs'] = 'Нарезные боеприпасы 10 кал.',
      ['10g STUN ROUNDS'] = 'ОГЛУШАЮЩИЕ БОЕПРИПАСЫ 10 кал.',
      ['10g Sabot'] = 'Снаряд с поддоном 10 кал.',
      ['10g Scatter Shot'] = 'Боеприпасы для дробовика 10 кал.',
      ['10g Stun'] = 'Оглушающие 10 кал.',
      ['10g Tri-Ball'] = 'С тремя шариками 10 кал.',
      ['10g. Duckbill'] = '10g. Утконос',
      ['10g. Full Choke'] = '10g. Полный чок',
      ['10g. Half Choke'] = '10g. Получок',
      ['110mm Airburst Cannon Round'] = 'Артиллерийский выстрел с подрывом в воздухе 110 мм',
      ['110mm Airburst Cannon Round Mk2'] = 'Артиллерийский выстрел с подрывом в воздухе Mk2 110 мм',
      ['110mm E.M.S. Cannon Round'] = 'ЭМ-артиллерийский выстрел 110 мм',
      ['110mm E.M.S. Cannon Round Mk2'] = 'ЭМ-артиллерийский выстрел Mk2 110 мм',
      ['110mm E.M.S. Cannon Round Mk3'] = 'ЭМ-артиллерийский выстрел Mk3 110 мм',
      ['110mm Gas Cannon Round'] = 'Газовый артиллерийский выстрел 110 мм',
      ['110mm Standard Rocket'] = 'Стандартная ракета 110 мм',
      ['110mm Standard Rocket Mk2'] = 'Стандартная ракета Mk2 110 мм',
      ['12.5mm BCHP Rifle Rounds'] = 'Боеприпасы BCHP для винтовки 12,5 мм',
      ['12.5mm EIT Rounds'] = 'Боеприпасы EIT 12,5 мм',
      ['12.5mm Standard Rifle Rounds'] = 'Стандартные боеприпасы для винтовки 12,5 мм',
      ['120mm HE Cannon Round'] = 'ОФ-артиллерийский выстрел 120 мм',
      ['12g Birdshot'] = 'Дробь 12 кал.',
      ['12g Buckshot'] = 'Картечь 12 кал.',
      ['12g Bugshot'] = 'Противожучиные боеприпасы 12 кал.',
      ['12g Flechettes'] = 'Флешетты 12 кал.',
      ['12g Liberty Fire'] = 'Огонь свободы 12 кал.',
      ['12g Magnum'] = 'Магнум 12 кал.',
      ['12g Magnum Triball'] = 'Магнум с тремя шариками 12 кал.',
      ['12g Scatter Shot'] = 'Боеприпасы для дробовика 12 кал.',
      ['12g Tri-Ball'] = 'С тремя шариками 12 кал.',
      ['12g. Duckbill'] = '12g. Утконос',
      ['12g. Full Choke'] = '12g. Полный чок',
      ['12g. Half Choke'] = '12g. Получок',
      ['12mm. Compensator'] = '12mm. Компенсатор',
      ['12mm. Flash Hider'] = '12mm. Пламегаситель',
      ['12mm. Muzzle break'] = '12mm. Дульный тормоз',
      ['12x25mm Explosive'] = 'Разрывные 12x25 мм',
      ['12x25mm Full Metal Jacket'] = 'С цельнометаллической оболочкой 12x25 мм',
      ['12x25mm High Velocity'] = 'Высокоскоростные 12x25 мм',
      ['12x25mm Hollow Point'] = 'Экспансивные 12x25 мм',
      ['12x25mm Plasma'] = 'Плазменные 12x25 мм',
      ['12x25mm Ripper'] = 'Жнец 12x25 мм',
      ['12x25mm Thermite'] = 'Термитные 12x25 мм',
      ['12x25mm Toxic'] = 'Ядовитые 12x25 мм',
      ['13x40mm Full Metal Jacket'] = 'С цельнометаллической оболочкой 13х40 мм',
      ['13x40mm Hollow Point'] = 'Экспансивные 13х40 мм',
      ['13x40mm Magnum'] = 'Магнум 13х40 мм',
      ['13x40mm Penetrator'] = 'Проникающие 13х40 мм',
      ['13x40mm Ripper'] = 'Жнец 13х40 мм',
      ['15x100mm Emp-Rounds'] = 'ЭМ-боеприпасы 15x100 мм',
      ['15x100mm Fragmentation'] = 'Осколочные 15x100 мм',
      ['15x100mm High Explosive'] = 'Фугасные 15x100 мм',
      ['15x100mm High Velocity'] = 'Высокоскоростные 15x100 мм',
      ['15x100mm Plasma'] = 'Плазменные 15x100 мм',
      ['15x100mm Standard Rocket'] = 'Стандартная ракета 15x100 мм',
      ['15x100mm Thermite'] = 'Термитные 15x100 мм',
      ['15x100mm Toxic'] = 'Ядовитые 15x100 мм',
      ['20mm APHET Rounds'] = 'Бронебойно-фугасные снаряды 20 мм',
      ['20mm Flak Rounds'] = 'Зенитный снаряд 20 мм',
      ['20mm HE Cannon'] = 'ОФ пушка 20 мм',
      ['20mm HVAP Rounds'] = 'Бронебойные подкалиберные боеприпасы 20 мм',
      ['23mm HE Cannon'] = 'ОФ пушка 23 мм',
      ['30mm APHE Cannon'] = 'Бронебойно-фугасная пушка 30 мм',
      ['380mm HE Cannon Round'] = 'ОФ-артиллерийский выстрел 380 мм',
      ['40-K Meltagun'] = '40-K Плавкопушка',
      ['40mm APHE Cannon'] = 'Бронебойно-фугасная пушка 40 мм',
      ['40mm Flak Cannon'] = 'Зенитная пушка 40 мм',
      ['40mm HE Grenade'] = 'ОФ граната 40 мм',
      ['40mm HE Mortar'] = 'ОФ МИНОМЕТ40 мм',
      ['40mm HEAT Grenade'] = 'Кумулятивная граната 40 мм',
      ['40mm Proximity Grenade'] = 'Неконтактная граната 40 мм',
      ['5,5mm. Compensator'] = '5,5mm. Компенсатор',
      ['5,5mm. Flash Hider'] = '5,5mm. Пламегаситель',
      ['5,5mm. Muzzle break'] = '5,5mm. Дульный тормоз',
      ['5.5x50mm Devastator'] = 'Разрушитель 5,5x50 мм',
      ['5.5x50mm Double Power'] = 'Двойной мощности 5,5x50 мм',
      ['5.5x50mm Explosive'] = 'Разрывные 5,5x50 мм',
      ['5.5x50mm Full Metal Jacket'] = 'С цельнометаллической оболочкой 5,5x50 мм',
      ['5.5x50mm High Velocity'] = 'Высокоскоростные 5,5x50 мм',
      ['5.5x50mm Hollow-Point'] = 'Экспансивные 5,5x50 мм',
      ['5.5x50mm Penetrator'] = 'Проникающие 5,5x50 мм',
      ['5.5x50mm Ripper'] = 'Жнец 5,5x50 мм',
      ['5.5x50mm Self Propelled'] = 'Самодвижущиеся 5,5x50 мм',
      ['5.5x50mm Subsonic'] = 'Дозвуковые 5,5x50 мм',
      ['5.5x50mm Super Uranium Core'] = 'С суперурановым сердечником 5,5x50 мм',
      ['500kg Bomb'] = 'Бомба (500 кг)',
      ['500kg Bomb Mk2'] = 'Бомба Mk2 (500 кг)',
      ['500kg Bomb Mk3'] = 'Бомба Mk3 (500 кг)',
      ['66mm Missile'] = 'Ракета 66 мм',
      ['66mm Missile Mk2'] = 'Ракета Mk2 66 мм',
      ['70mm Laser-Guided Missile'] = 'Ракета с лазерным наведением 70 мм',
      ['70mm Laser-Guided Missile Mk2'] = 'Ракета с лазерным наведением Mk2 70 мм',
      ['70mm Standard Rocket'] = 'Стандартная ракета 70 мм',
      ['75mm HEAT Grenade'] = 'Кумулятивная граната 75 мм',
      ['85mm HEAT Grenade'] = 'Кумулятивная граната 85 мм',
      ['85mm HEAT Grenade Mk2'] = 'Кумулятивная граната Mk2 85 мм',
      ['85mm High-Explosive Grenade'] = 'Осколочно-фугасная граната 85 мм',
      ['85mm High-Explosive Grenade Mk2'] = 'Осколочно-фугасная граната MK2 85 мм',
      ['8mm. Compensator'] = '8mm. Компенсатор',
      ['8mm. Flash Hider'] = '8mm. Пламегаситель',
      ['8mm. Muzzle break'] = '8mm. Дульный тормоз',
      ['8x60mm Airburst'] = 'С подрывом в воздухе 8х60 мм',
      ['8x60mm Devastator'] = 'Разрушитель 8х60 мм',
      ['8x60mm Double Power'] = 'Двойной мощности 8х60 мм',
      ['8x60mm Explosive'] = 'Разрывные 8х60 мм',
      ['8x60mm Full Metal Jacket'] = 'С цельнометаллической оболочкой 8х60 мм',
      ['8x60mm High Velocity'] = 'Высокоскоростные 8х60 мм',
      ['8x60mm Liberty Fire'] = 'Огонь свободы 8х60 мм',
      ['8x60mm Penetrator'] = 'Проникающие 8х60 мм',
      ['8x60mm Sniper Armour Piercing'] = 'Снайперские бронебойные 8х60 мм',
      ['8x60mm Subsonic'] = 'Дозвуковые 8х60 мм',
      ['8x60mm Super Uranium Core'] = 'С суперурановым сердечником 8х60 мм',
      ['9mm. Compensator'] = '9mm. Компенсатор',
      ['9mm. Flash Hider'] = '9mm. Пламегаситель',
      ['9mm. Muzzle break'] = '9mm. Дульный тормоз',
      ['9x20mm Explosive'] = 'Разрывные 9x20 мм',
      ['9x20mm Full Metal Jacket'] = 'С цельнометаллической оболочкой 9x20 мм',
      ['9x20mm High Velocity'] = 'Высокоскоростные 9x20 мм',
      ['9x20mm Hollow Point'] = 'Экспансивные 9x20 мм',
      ['9x20mm Plasma'] = 'Плазменные 9x20 мм',
      ['9x20mm Ripper'] = 'Жнец 9x20 мм',
      ['9x20mm Thermite'] = 'Термитные 9x20 мм',
      ['9x20mm Toxic'] = 'Ядовитые 9x20 мм',
      ['9x70mm Full Metal Jacket'] = 'С цельнометаллической оболочкой 9x70 мм',
      ['9x70mm High Velocity'] = 'Высокоскоростные 9x70 мм',
      ['9x70mm Penetrator'] = 'Проникающие 9x70 мм',
      ['9x70mm Self Propelled'] = 'Самодвижущиеся 9x70 мм',
      ['9x70mm Sniper Armour Piercing'] = 'Снайперские бронебойные 9x70 мм',
      ['9x70mm Socom Assassin'] = 'Спецназ «Убийца» 9x70 мм',
      ['9x70mm Super Uranium Core'] = 'С суперурановым сердечником 9x70 мм',
      ['A mounted cannon with a seat, dropped by hellpod. Not the one you carry.'] = 'Станковое орудие с сиденьем, сбрасывается в Адской капсуле. Не то, что вы носите.',
      ['A mounted copy aimed by AI. Not the one you carry.'] = 'Станковая копия с наводкой ИИ. Не то, что вы носите.',
      ['A mounted copy run by AI (emplacement-style). Not the one you carry.'] = 'Станковая копия под управлением ИИ (как огневая позиция). Не то, что вы носите.',
      ['A mounted copy. Not the one you carry.'] = 'Станковая копия. Не то, что вы носите.',
      ['A preset keeps every change you have made as one set, under a name you choose.'] = 'Пресет хранит все ваши изменения одним набором под выбранным вами именем.',
      ['A/AC-8 Autocannon Sentry'] = 'A/AC-8 «Турель с автопушкой»',
      ['A/ARC-3 Tesla Tower'] = 'A/ARC-3 «Тесла-башня»',
      ['A/FLAM-40 Flame Sentry'] = 'A/FLAM-40 Турель-огнемет',
      ['A/G-16 Gatling Sentry'] = 'A/G-16 «Турель Гатлинга»',
      ['A/GM-17 Gas Mortar Sentry'] = 'A/GM-17 Турель с газовым минометом',
      ['A/LAS-98 Laser Sentry'] = 'A/LAS-98 Лазерная турель',
      ['A/M-12 Mortar Sentry'] = 'A/M-12 «Турель с минометом»',
      ['A/M-23 EMS Mortar Sentry'] = 'A/M-23 «Турель с ЭМ-минометом»',
      ['A/MG-43 Machine Gun Sentry'] = 'A/MG-43 «Пулеметная турель»',
      ['A/MLS-4X Rocket Sentry'] = 'A/MLS-4X «Ракетная турель»',
      ['AC-8 Autocannon'] = 'AC-8 «Автопушка»',
      ['AMMO'] = 'БОЕПРИПАСЫ',
      ['AMW-20 Apex'] = 'AMW-20 «Апогей»',
      ['APW-1 Anti-Materiel Rifle'] = 'APW-1 «Крупнокалиберная винтовка»',
      ['AR-11 Arbitrator'] = 'AR-11 Третейский судья',
      ['AR-11 Arbitrator (underbarrel shotgun)'] = 'AR-11 Третейский судья (подствольный дробовик)',
      ['AR-2 Coyote'] = 'AR-2 Койот',
      ['AR-23 Liberator'] = 'AR-23 «Освободитель»',
      ['AR-23A Liberator Carbine'] = 'AR-23A Карабин «Освободитель»',
      ['AR-23C Liberator Concussive'] = 'AR-23C «Сотрясающий освободитель»',
      ['AR-23L Liberator Legacy'] = 'AR-23L «Классический освободитель»',
      ['AR-23P Liberator Penetrator'] = 'AR-23P «Пробойный освободитель»',
      ['AR-32 Pacifier'] = 'AR-32 Усмиритель',
      ['AR-59 Suppressor'] = 'AR-59 Подавитель',
      ['AR-61 Tenderizer'] = 'AR-61 «Размягчитель»',
      ['AR/GL-21 One-Two'] = 'AR/GL-21 Двоечка',
      ['AR/GL-21 One-Two (grenade launcher)'] = 'AR/GL-21 Двоечка (гранатомет)',
      ['ARC'] = 'ДУГА',
      ['ARC-12 Blitzer'] = 'ARC-12 «Налетчик»',
      ['ARC-3 Arc Thrower'] = 'ARC-3 «Дуговой метатель»',
      ['AX/AR-23 "Guard Dog"'] = 'AX/AR-23 «Сторожевой пес»',
      ['AX/ARC-3 "Guard Dog" K-9'] = 'AX/ARC-3 «Сторожевой пес» K-9',
      ['AX/FLAM-75 "Guard Dog" Hot Dog'] = 'AX/FLAM-75 «Сторожевой пес» Хот-дог',
      ['AX/LAS-5 "Guard Dog" Rover'] = 'AX/LAS-5 «Сторожевой пес» Аппарат',
      ['AX/TX-13 "Guard Dog" Dog Breath'] = 'AX/TX-13 «Сторожевой пес» Вонючка',
      ['Acceleration (m/s2)'] = 'Ускорение (м/с^2)',
      ['Accelerator Rifle'] = 'Акселераторная винтовка',
      ['Acclimated'] = 'Акклиматизированный',
      ['Acid'] = 'Кислота',
      ['Adjudicator'] = '«Эксперт»',
      ['Adreno-Defibrillator'] = 'Адрено-дефибрилятор',
      ['Advanced Filtration'] = 'Продвинутая фильтрация',
      ['Aiming sway'] = 'Покачивание при прицеливании',
      ['Airburst Rocket Launcher'] = '«Ракетница с подрывом в воздухе»',
      ['Also includes'] = 'Также включает',
      ['Alternate ammunition'] = 'Альтернативные боеприпасы',
      ['Amendment'] = 'Поправка',
      ['Ammo'] = 'Боеприпасы',
      ['Ammo at the start'] = 'Боеприпасы в начале',
      ['Ammo capacity'] = 'Запас боеприпасов',
      ['Ammo carried'] = 'Боеприпасы при себе',
      ['Ammo from resupply'] = 'Боеприпасы из пополнения',
      ['Ammunition'] = 'Боеприпасы',
      ['Angled Foregrip'] = 'Угловая рукоять',
      ['Angled Foregrip Advanced'] = 'Улучшенная угловая рукоять',
      ['Angled Foregrip With Laser'] = 'Угловая рукоять с лазерным прицелом',
      ['Another copy of this weapon, not identified yet.'] = 'Еще одна копия этого оружия, пока не опознана.',
      ['Antenna'] = 'Антенна',
      ['Anti-Air Missile'] = 'Ракета ПВО',
      ['Anti-Materiel Rifle'] = '«Крупнокалиберная винтовка»',
      ['Anti-Tank Emplacement'] = 'Противотанковое орудие',
      ['Anti-Tank Seeker'] = 'Противотанковый искатель',
      ['Apex'] = '«Апогей»',
      ['Apply my changes'] = 'Применять мои изменения',
      ['Arbitrator'] = 'Третейский судья',
      ['Arc'] = 'Дуга',
      ['Arc Thrower'] = '«Дуговой метатель»',
      ['Arc chain edits in multiplayer'] = 'Цепи дуги в мультиплеере',
      ['Arc chains'] = 'Цепи дуги',
      ['Arc chains use the game\'s values while other players are in your game (see Settings).'] = 'Пока в вашей игре есть другие игроки, цепи дуги используют значения игры (см. Настройки).',
      ['Arc damage taken'] = 'Получаемый урон от дуги',
      ['Arc splits'] = 'Разветвления дуги',
      ['Arming distance (m)'] = 'Дистанция взведения (м)',
      ['Arming time (s)'] = 'Время взведения (с)',
      ['Armor'] = 'Броня',
      ['Armor pen. (direct)'] = 'Пробив. брони (прямо)',
      ['Armor pen. (extreme angle)'] = 'Пробив. брони (предельный угол)',
      ['Armor pen. (large angle)'] = 'Пробив. брони (большой угол)',
      ['Armor pen. (slight angle)'] = 'Пробив. брони (малый угол)',
      ['Armors'] = 'Броня',
      ['Ask'] = 'Спрашивать',
      ['Assault Rifle'] = 'Штурмовая винтовка',
      ['Attachment'] = 'Модуль',
      ['Attachments'] = 'Модули',
      ['Autocannon'] = '«Автопушка»',
      ['Autocannon Sentry'] = '«Турель с автопушкой»',
      ['Automatic'] = 'Автоматически',
      ['B-1 Supply Pack'] = 'B-1 «Рюкзак: боеприпасы»',
      ['B-100 Portable Hellbomb'] = 'B-100 Переносная Адская бомба',
      ['B/FLAM-80 Cremator'] = 'B/FLAM-80 Крематорий',
      ['B/MD C4 Pack'] = 'B/MD Комплект C4',
      ['BACKPACK'] = 'РЮКЗАК',
      ['BARRAGE'] = 'ЗАЛП',
      ['BLAST'] = 'ВЗРЫВ',
      ['BLAST RADIUS'] = 'РАДИУС ВЗРЫВА',
      ['BODY PARTS'] = 'ЧАСТИ КОРПУСА',
      ['BR-14 Adjudicator'] = 'BR-14 «Эксперт»',
      ['BURST'] = 'РАЗРЫВ',
      ['BURST RADIUS'] = 'РАДИУС РАЗРЫВА',
      ['Back'] = 'Назад',
      ['Back door block'] = 'Блок задней двери',
      ['Back hatch'] = 'Задний люк',
      ['Back periscope side 8'] = 'Задний перископ, сторона 8',
      ['Background opacity'] = 'Непрозрачность фона',
      ['Backpack'] = 'Рюкзак',
      ['Ballistic Padding'] = 'Баллистическая подкладка',
      ['Ballistic Shield Backpack'] = '«Рюкзак: баллистический щит»',
      ['Ballistic shield'] = 'Баллистический щит',
      ['Barrage'] = 'Залп',
      ['Bastion MK XVI'] = 'Mk-XVI «Бастион»',
      ['Belt-Fed Grenade Launcher'] = 'Ленточный гранатомет',
      ['Bingus Shared Loader by CowboyBingus'] = 'Bingus Shared Loader от CowboyBingus',
      ['Blast'] = 'Взрыв',
      ['Blast angle (deg)'] = 'Угол взрыва (град)',
      ['Blast delay (s)'] = 'Задержка взрыва (с)',
      ['Blast proximity (m)'] = 'Дистанция подрыва (м)',
      ['Blast radius'] = 'Радиус взрыва',
      ['Blitzer'] = '«Налетчик»',
      ['Block game input while open'] = 'Блокировать ввод в игре',
      ['Blunt-Force Mitigation'] = 'Уменьшение дробящего урона',
      ['Body health'] = 'Здоровье туловища',
      ['Body parts'] = 'Части корпуса',
      ['Bolt Pistol'] = 'Болтострел',
      ['Bonnet'] = 'Капот',
      ['Boost after the launch (s)'] = 'Ускорение после пуска (с)',
      ['Breacher'] = 'Прорывник',
      ['Breaching Hammer'] = 'Штурмовой молот',
      ['Break-Action Shotgun'] = 'Дробовик-переломка',
      ['Breaker'] = '«Крушитель»',
      ['Breaker Incendiary'] = '«Зажигательный крушитель»',
      ['Breaker Spray&Pray'] = '«Крушитель ураган»',
      ['Breakthrough Exosuit'] = 'Экзокостюм «Прорыв»',
      ['Bullet Storm'] = '«Шквал пуль»',
      ['Burn time (s)'] = 'Время горения (с)',
      ['Burning'] = 'Горение',
      ['Burning applied to you'] = 'Горение, наносимое вам',
      ['Burst'] = 'Разрыв',
      ['Burst radius'] = 'Радиус разрыва',
      ['Bushwhacker'] = '«Партизан»',
      ['CB-9 Exploding Crossbow'] = 'CB-9 «Взрывной арбалет»',
      ['CHARGE'] = 'ЗАРЯД',
      ['CLUSTER BOMB'] = 'КЛАСТЕРНАЯ БОМБА',
      ['CQC-1 One True Flag'] = 'CQC-1 Один истинный флаг',
      ['CQC-19 Stun Lance'] = 'CQC-19 Оглушающее копье',
      ['CQC-2 Saber'] = 'CQC-2 Сабля',
      ['CQC-20 Breaching Hammer'] = 'CQC-20 Штурмовой молот',
      ['CQC-30 Stun Baton'] = 'CQC-30 Оглушающая дубинка',
      ['CQC-42 Machete'] = 'CQC-42 Мачете',
      ['CQC-5 Combat Hatchet'] = 'CQC-5 Боевой топорик',
      ['CQC-72 Entrenchment Tool'] = 'CQC-72 Орудие окапывания',
      ['CQC-73 Entrenchment Tool'] = 'CQC-73 Орудие окапывания',
      ['CQC-9 Defoliation Tool'] = 'CQC-9 Дефолиатор',
      ['Calibre (mm)'] = 'Калибр (мм)',
      ['Caltrops'] = 'Проволочные силки',
      ['Camera shake radius (m)'] = 'Радиус тряски камеры (м)',
      ['Cancel'] = 'Отмена',
      ['Censor'] = 'Цензор',
      ['Chain length'] = 'Длина цепи',
      ['Chain reaction delay (s)'] = 'Задержка цепной реакции (с)',
      ['Chain split'] = 'Разветвление цепи',
      ['Changed since the last install: Install to put it in the game.'] = 'Есть изменения после последней установки: нажмите «Установить в игру».',
      ['Charge'] = 'Заряд',
      ['Charge when it comes back'] = 'Заряд при возвращении',
      ['Charged'] = 'Заряженный',
      ['Charged explosion'] = 'Заряженный взрыв',
      ['Charged shot'] = 'Заряженный выстрел',
      ['Charges'] = 'Заряды',
      ['Charges from resupply'] = 'Заряды из пополнения',
      ['Chest bleeding damage'] = 'Урон от кровотечения в груди',
      ['Chest damage taken'] = 'Получаемый урон в грудь',
      ['Choose a weapon on the left.'] = 'Выберите оружие слева.',
      ['Clear'] = 'Очистить',
      ['Click again to overwrite'] = 'Нажмите еще раз, чтобы перезаписать',
      ['Climb acceleration'] = 'Ускорение подъема',
      ['Climb multiplier (horizontal)'] = 'Множитель подъема (по горизонтали)',
      ['Climb multiplier (vertical)'] = 'Множитель подъема (по вертикали)',
      ['Climb speed (m/s)'] = 'Скорость подъема (м/с)',
      ['Climb time limit (s)'] = 'Предел времени подъема (с)',
      ['Cluster Bomb'] = 'Кластерная бомба',
      ['Combat Hatchet'] = 'Боевой топорик',
      ['Combat Scope 4x'] = 'Боевой прицел (4х)',
      ['Commando'] = '«Коммандос»',
      ['Concealment when still, crouched / prone'] = 'Скрытность без движения, присев / лёжа',
      ['Concussive Padding (Grenadier)'] = 'Противовзрывная подкладка, гренадер',
      ['Concussive Padding (Hazmat)'] = 'Противовзрывная подкладка, химзащита',
      ['Concussive Padding (Reinforced)'] = 'Противовзрывная подкладка, усиленная',
      ['Cone angle (deg)'] = 'Угол конуса (град)',
      ['Constitution'] = '«Конституция»',
      ['Consumables'] = 'Расходники',
      ['Contact Mine'] = 'Контактная мина',
      ['Cookout'] = '«Барбекю»',
      ['Cool-down time after overheat (s)'] = 'Время остывания после перегрева (с)',
      ['Cool-down time, full heat (s)'] = 'Время остывания с полного нагрева (с)',
      ['Cooldown (s)'] = 'Перезарядка (с)',
      ['Cooling (% per s)'] = 'Охлаждение (% в с)',
      ['Copy'] = 'Копир.',
      ['Coyote'] = 'Койот',
      ['Cremator'] = 'Крематорий',
      ['Crisper'] = '«Фритюр»',
      ['Crouched jog speed (m/s)'] = 'Скорость бега трусцой пригнувшись (м/с)',
      ['Crouched speed while aiming (m/s)'] = 'Скорость прицеливания пригнувшись (м/с)',
      ['Crouched sprint speed (m/s)'] = 'Скорость спринта пригнувшись (м/с)',
      ['Crouched walk speed (m/s)'] = 'Скорость шага пригнувшись (м/с)',
      ['Cruise speed (m/s)'] = 'Крейсерская скорость (м/с)',
      ['DAMAGE'] = 'УРОН',
      ['DBS-2 Double Freedom'] = 'DBS-2 Двойная свобода',
      ['DEPLOYER'] = 'УСТАНОВЩИК',
      ['DIRECT HIT'] = 'ПРЯМОЕ ПОПАДАНИЕ',
      ['Dagger'] = '«Кинжал»',
      ['Damage'] = 'Урон',
      ['Damage tick (s)'] = 'Такт урона (с)',
      ['Damage to you'] = 'Урон вам',
      ['De-Escalator'] = 'Деэскалатор',
      ['Deadeye'] = 'Меткий стрелок',
      ['Defender'] = 'Защитник',
      ['Defoliation Tool'] = 'Дефолиатор',
      ['Delete'] = 'Удалить',
      ['Democracy Protects'] = 'Демократия защищает',
      ['Demolition force'] = 'Сила разрушения',
      ['Deployer'] = 'Установщик',
      ['Desert Stormer'] = 'Пустынный штурмовик',
      ['Diligence'] = '«Рвение»',
      ['Diligence Counter Sniper'] = '«Рвение антиснайпер»',
      ['Direct hit'] = 'Прямое попадание',
      ['Directional Shield'] = 'Щит направленного действия',
      ['Dive cost (share of stamina)'] = 'Цена прыжка рыбкой (доля выносливости)',
      ['Dominator'] = '«Угнетатель»',
      ['Double Freedom'] = 'Двойная свобода',
      ['Double-Edge Sickle'] = 'Обоюдоострый серп',
      ['Down'] = 'Вниз',
      ['Drag factor'] = 'Коэффициент сопротивления',
      ['Driver gun'] = 'Орудие водителя',
      ['Drone'] = 'Дрон',
      ['Drum Magazine'] = 'Барабанный магазин',
      ['Dune Walker Sniper Scope 10x'] = 'Снайперский прицел (10х)',
      ['Durable damage'] = 'Урон по прочным целям',
      ['Durable ratio (0-1)'] = 'Доля урона по прочным (0-1)',
      ['Duration (s)'] = 'Длительность (с)',
      ['Dynamite'] = 'Динамит',
      ['E/AT-12 Anti-Tank Emplacement'] = 'E/AT-12 Противотанковое орудие',
      ['E/GL-21 Grenadier Battlement'] = 'E/GL-21 Амбразура гранатометчика',
      ['E/MG-101 HMG Emplacement'] = 'E/MG-101 «Огневая позиция: тяжелый пулемет»',
      ['EAGLE'] = 'ОРЕЛ',
      ['EAT-17 Expendable Anti-Tank'] = 'EAT-17 «Одноразовый бронебой»',
      ['EAT-17 Expendable Anti-Tank (SEAF)'] = 'EAT-17 «Одноразовый бронебой» (ВССЗ)',
      ['EAT-411 Leveller'] = 'EAT-411 Уравнитель',
      ['EAT-700 Expendable Napalm'] = 'EAT-700 Одноразовый напалм',
      ['EMS Mortar Sentry'] = '«Турель с ЭМ-минометом»',
      ['EXO-45 Patriot Exosuit'] = 'EXO-45 Экзокостюм «Патриот»',
      ['EXO-49 Emancipator Exosuit'] = 'EXO-49 Экзокостюм «Благодетель»',
      ['EXO-51 Lumberer Exosuit'] = 'EXO-51 Экзокостюм «Лесоруб»',
      ['EXO-55 Breakthrough Exosuit'] = 'EXO-55 Экзокостюм «Прорыв»',
      ['Each arm'] = 'Каждая рука',
      ['Each leg'] = 'Каждая нога',
      ['Eagle'] = 'Орел',
      ['Eagle 110mm Rocket Pods'] = '«Орел: 110-мм ракетные блоки»',
      ['Eagle 500kg Bomb'] = '«Орел: бомба (500 кг)»',
      ['Eagle Airstrike'] = '«Орел: воздушный налет»',
      ['Eagle Cluster Bomb'] = '«Орел: кластерная бомба»',
      ['Eagle Gas Airstrike'] = '«Орел: газовый налет»',
      ['Eagle Napalm Airstrike'] = '«Орел: авиаудар напалмом»',
      ['Eagle Smoke Strike'] = '«Орел: дымовая завеса»',
      ['Eagle Strafing Run'] = '«Орел: бреющий полет»',
      ['Eagle rearm time (s)'] = 'Время перевооружения «Орла» (с)',
      ['Eagle strike. The rearm time is shared by every Eagle.'] = 'Удар «Орла». Время перевооружения общее для всех ударов «Орла».',
      ['Edit the grenade on Throwables to tune it. Assets load before selection applies.'] = 'Настраивайте гранату во вкладке «Метательное». Выбор применяется после загрузки ресурсов.',
      ['Electrical Conduit'] = 'Электропроводник',
      ['Emancipator Exosuit'] = 'Экзокостюм «Благодетель»',
      ['Emplacement'] = 'Огневая позиция',
      ['Emplacement: its cooldown, its body, then its weapon.'] = 'Огневая позиция: перезарядка, корпус, затем оружие.',
      ['Enemy detection range'] = 'Дальность обнаружения врагов',
      ['Engineering Kit'] = 'Инженерный комплект',
      ['Entrenchment Tool'] = 'Орудие окапывания',
      ['Epoch'] = 'Эпоха',
      ['Ergonomics'] = 'Эргономика',
      ['Ergonomics bonus'] = 'Бонус эргономики',
      ['Eruptor'] = '«Извергатель»',
      ['Every armor with this passive gets their effects too (set on their own pages).'] = 'Вся броня с этим эффектом получает и их эффекты (настраиваются на их страницах).',
      ['Every change as soon as it is pushed, before testing: it may break.'] = 'Каждое изменение сразу после публикации, без проверки: возможны ошибки.',
      ['Every commit'] = 'Каждый коммит',
      ['Every helldiver in your game. Restore the game\'s files before joining other players\' lobbies.'] = 'Все десантники в вашей игре. Восстановите файлы игры, прежде чем заходить в лобби других игроков.',
      ['Every passive is in already.'] = 'Все пассивные эффекты уже добавлены.',
      ['Evictor'] = 'Вытеснитель',
      ['Expendable Anti-Tank'] = '«Одноразовый бронебой»',
      ['Expendable Napalm'] = 'Одноразовый напалм',
      ['Expiry explosion (id)'] = 'Взрыв по истечении (ID)',
      ['Explodes after death (s)'] = 'Взрывается после гибели (с)',
      ['Exploding Crossbow'] = '«Взрывной арбалет»',
      ['Explosion'] = 'Взрыв',
      ['Explosion (expiry)'] = 'Взрыв (по истечении)',
      ['Explosion id'] = 'ID взрыва',
      ['Explosive damage taken'] = 'Получаемый урон от взрывов',
      ['Extended Magazine'] = 'Увеличенный магазин',
      ['Extra Padding'] = 'Экстра-уплотнение',
      ['FAF-14 Spear'] = 'FAF-14 Копье',
      ['FIRE'] = 'ОГОНЬ',
      ['FLAM-40 Flamethrower'] = 'FLAM-40 «Огнемет»',
      ['FLAM-66 Torcher'] = 'FLAM-66 «Сжигатель»',
      ['Feet First'] = 'Вперед ногами',
      ['Field depth (m)'] = 'Глубина поля (м)',
      ['Field width (m)'] = 'Ширина поля (м)',
      ['Finding the stats...'] = 'Поиск характеристик...',
      ['Fire'] = 'Огонь',
      ['Fire damage taken'] = 'Получаемый урон от огня',
      ['Fire duration (s)'] = 'Длительность огня (с)',
      ['Fire rate (RPM)'] = 'Скорострельность (выстр./мин)',
      ['Fire/gas/acid/arc damage taken'] = 'Получаемый урон от огня/газа/кислоты/дуги',
      ['Flame Sentry'] = 'Турель-огнемет',
      ['Flames'] = 'Горючая смесь',
      ['Flames Mk2'] = 'Горючая смесь Mk2',
      ['Flamethrower'] = '«Огнемет»',
      ['Flashlight'] = 'Фонарик',
      ['Flinch'] = 'Вздрагивание',
      ['Flinch (0 prevents it)'] = 'Вздрагивание (0 — нет)',
      ['Folder'] = 'Папка',
      ['Folder path copied.'] = 'Путь к папке скопирован.',
      ['Fortified'] = 'Укрепление',
      ['Forward share of the launch (0-1)'] = 'Доля толчка вперед (0-1)',
      ['Found in the game data (not in the built-in list).'] = 'Найдено в данных игры (нет во встроенном списке).',
      ['Frag'] = '«Осколочная»',
      ['From supply'] = 'Из снабжения',
      ['Front hull'] = 'Передняя часть корпуса',
      ['Front left cockpit'] = 'Кабина спереди слева',
      ['Front right cockpit'] = 'Кабина спереди справа',
      ['Full charge'] = 'Полный заряд',
      ['Full charge explosion'] = 'Взрыв с полным зарядом',
      ['Full charge shot'] = 'Выстрел с полным зарядом',
      ['Fuse time (s)'] = 'Время запала (с)',
      ['G-10 Incendiary'] = 'G-10 «Зажигательная»',
      ['G-109 Urchin'] = 'G-109 Озорник',
      ['G-11 Caltrops'] = 'G-11 Проволочные силки',
      ['G-12 High Explosive'] = 'G-12 «Фугасная»',
      ['G-123 Thermite'] = 'G-123 «Термитная»',
      ['G-13 Incendiary Impact'] = 'G-13 Зажигательная ударная',
      ['G-142 Pyrotech'] = 'G-142 Пиротех',
      ['G-16 Impact'] = 'G-16 «Ударная»',
      ['G-23 Stun'] = 'G-23 «Оглушающая»',
      ['G-3 Smoke'] = 'G-3 «Дымовая»',
      ['G-31 Arc'] = 'G-31 Дуга',
      ['G-4 Gas'] = 'G-4 Газовая',
      ['G-48 Giga Grenade'] = 'G-48 Гигаграната',
      ['G-50 Seeker'] = 'G-50 Искатель',
      ['G-6 Frag'] = 'G-6 «Осколочная»',
      ['G-60 Anti-Tank Seeker'] = 'G-60 Противотанковый искатель',
      ['G-7 Pineapple'] = 'G-7 Лимонка',
      ['G-8 Immolation'] = 'G-8 Испепелитель',
      ['G-89 Smokescreen'] = 'G-89 Дымовая завеса',
      ['G/40-K Melta Mine'] = 'G/40-K Плавкомина',
      ['G/SH-39 Shield'] = 'G/SH-39 Щит',
      ['GATER'] = 'ЗАБОР',
      ['GL-15 Evictor'] = 'GL-15 Вытеснитель',
      ['GL-21 Grenade Launcher'] = 'GL-21 «Гранатомет»',
      ['GL-28 Belt-Fed Grenade Launcher'] = 'GL-28 Ленточный гранатомет',
      ['GL-52 De-Escalator'] = 'GL-52 Деэскалатор',
      ['GP-20 Ultimatum'] = 'GP-20 Ультиматум',
      ['GP-31 Grenade Pistol'] = 'GP-31 «Пистолет-гранатомет»',
      ['GR-8 Recoilless Rifle'] = 'GR-8 «Безоткатная винтовка»',
      ['GRENADE SWAP'] = 'ЗАМЕНА ГРАНАТЫ',
      ['Gallant'] = '«Кавалер»',
      ['Gas'] = 'Газовая',
      ['Gas Mortar Sentry'] = 'Турель с газовым минометом',
      ['Gas damage taken'] = 'Получаемый урон от газа',
      ['Gatling Sentry'] = '«Турель Гатлинга»',
      ['Generator'] = 'Генератор',
      ['Giga Grenade'] = 'Гигаграната',
      ['GitHub'] = 'GitHub',
      ['GitHub link copied.'] = 'Ссылка на GitHub скопирована.',
      ['Gravity factor'] = 'Коэффициент гравитации',
      ['Grenade'] = 'Граната',
      ['Grenade Launcher'] = '«Гранатомет»',
      ['Grenade Pistol'] = '«Пистолет-гранатомет»',
      ['Grenade fired (choice)'] = 'Выпускаемая граната (выбор)',
      ['Grenade selection takes priority over Projectile swap. Fire rate, ammo and handling stay.'] = 'Выбор гранаты важнее замены снаряда. Скорострельность, боеприпасы и управление не меняются.',
      ['Grenade swap'] = 'Замена гранаты',
      ['Grenade swap stopped (see the log); launchers fire their own projectiles again.'] = 'Замена гранат остановлена (см. журнал); гранатометы снова стреляют своими снарядами.',
      ['Grenadier Battlement'] = 'Амбразура гранатометчика',
      ['Ground All-Terrain Extraction Rig (GATER)'] = 'Аппарат быстрой откачки ресурсов (ЗАБОР)',
      ['Guidance on after (s)'] = 'Наведение включается через (с)',
      ['Gun'] = 'Орудие',
      ['Gunner FRV'] = 'МТР «Стрелок»',
      ['Gunslinger'] = 'Стрелок',
      ['HANDLING'] = 'УПРАВЛЕНИЕ',
      ['HMG Emplacement'] = '«Огневая позиция: тяжелый пулемет»',
      ['Halt'] = 'Стоп',
      ['Handling'] = 'Управление',
      ['Head'] = 'Голова',
      ['Head health'] = 'Здоровье головы',
      ['Health'] = 'Здоровье',
      ['Health Pack Rack'] = 'Стойка с аптечками',
      ['Heat'] = 'Нагрев',
      ['Heat per second firing'] = 'Нагрев за секунду стрельбы',
      ['Heat per shot'] = 'Нагрев за выстрел',
      ['Heat per warp (%)'] = 'Нагрев за варп (%)',
      ['Heatsinks from supply'] = 'Радиаторы из снабжения',
      ['Heavy Machine Gun'] = '«Тяжелый пулемет»',
      ['Heavy burning'] = 'Сильное горение',
      ['Helldiver'] = 'Адский десантник',
      ['Helldivers 2 is running: close it, then Install.'] = 'Helldivers 2 запущена: закройте её, затем нажмите «Установить в игру».',
      ['Helldivers 2 is running: close it, then restore.'] = 'Helldivers 2 запущена: закройте её, затем верните файлы.',
      ['Helldivers 2 is running: you can edit, but close it before you Install.'] = 'Helldivers 2 запущена: редактировать можно, но перед установкой закройте её.',
      ['High Capacity Heatsink'] = 'Высокоемкий радиатор',
      ['High Dissipation Heatsink'] = 'Высокоэффективный радиатор',
      ['High Explosive'] = '«Фугасная»',
      ['High-Velocity Shrapnel'] = 'Высокоскоростной снаряд со шрапнелью',
      ['Hips'] = 'Таз',
      ['Homing Anti-Air Missile'] = 'Самонаводящаяся ракета ПВО',
      ['Homing Ground Missile'] = 'Самонаводящаяся ракета «воздух-земля»',
      ['Homing Ground Missile Mk2'] = 'Самонаводящаяся ракета «воздух-земля» Mk2',
      ['Hot-Shot Marksman Rifle'] = 'Марксманская винтовка «Лихач»',
      ['Hover Pack'] = 'Ранец для парения',
      ['Hover agility (acceleration)'] = 'Маневренность парения (ускор.)',
      ['Hover pack'] = 'Ранец для парения',
      ['Hover speed (m/s)'] = 'Скорость парения (м/с)',
      ['Hover time, full-speed climb (s)'] = 'Парение: быстрый подъем (с)',
      ['Hover time, holding height (s)'] = 'Парение: удержание высоты (с)',
      ['Hyena'] = 'Гиена',
      ['Immolation'] = 'Испепелитель',
      ['Impact'] = '«Ударная»',
      ['Impact damage taken'] = 'Получаемый урон от ударов',
      ['Impact explosion (id)'] = 'Взрыв при попадании (ID)',
      ['Incendiary'] = '«Зажигательная»',
      ['Incendiary Impact'] = 'Зажигательная ударная',
      ['Incinerator FRV'] = 'Огнеметная МТР',
      ['Inflammable'] = 'Огнеопасный',
      ['Injures you above heat (%)'] = 'Ранит вас при нагреве выше (%)',
      ['Inner radius (m)'] = 'Внутренний радиус (м)',
      ['Install into the game'] = 'Установить в игру',
      ['Installing: finding what changed...'] = 'Установка: поиск изменений...',
      ['Installing: writing the files...'] = 'Установка: запись файлов...',
      ['Integrated Explosives'] = 'Встроенная взрывчатка',
      ['Interface language'] = 'Язык интерфейса',
      ['Iron Sights'] = 'Механический прицел',
      ['Its effects are added to every armor with this passive.'] = 'Его эффекты добавляются всей броне с этим пассивным эффектом.',
      ['Its stats above apply.'] = 'Его характеристики выше действуют.',
      ['JAR-5 Dominator'] = 'JAR-5 «Угнетатель»',
      ['Jog speed (m/s)'] = 'Скорость бега трусцой (м/с)',
      ['Jogging empties it in (s)'] = 'Бег трусцой расходует её за (с)',
      ['Jump Pack'] = '«Реактивный ранец»',
      ['Jump cost (share of stamina)'] = 'Цена прыжка (доля выносливости)',
      ['Jump pack'] = 'Реактивный ранец',
      ['K-2 Throwing Knife'] = 'K-2 Метательный нож',
      ['Kinetic Displacement Mitigation'] = 'Кинетическое демпфирование',
      ['Knight'] = 'Рыцарь',
      ['Knockdown chance'] = 'Шанс сбить с ног',
      ['LAS-12 Sai'] = 'LAS-12 Сай',
      ['LAS-13 Trident'] = 'LAS-13 «Трезубец»',
      ['LAS-16 Sickle'] = 'LAS-16 «Серп»',
      ['LAS-17 Double-Edge Sickle'] = 'LAS-17 Обоюдоострый серп',
      ['LAS-22 Shear'] = 'LAS-22 Ножницы',
      ['LAS-44 Nova'] = 'LAS-44 «Нова»',
      ['LAS-5 Scythe'] = 'LAS-5 «Коса»',
      ['LAS-58 Talon'] = 'LAS-58 Коготь',
      ['LAS-7 Dagger'] = 'LAS-7 «Кинжал»',
      ['LAS-98 Laser Cannon'] = 'LAS-98 «Лазерная пушка»',
      ['LAS-98 Laser Cannon (crewed mount)'] = 'LAS-98 «Лазерная пушка» (станковая, с расчетом)',
      ['LAS-99 Quasar Cannon'] = 'LAS-99 Пушка «Квазар»',
      ['LASER DAMAGE'] = 'УРОН ЛАЗЕРОМ',
      ['LIFT-182 Warp Pack'] = 'LIFT-182 Варп-ранец',
      ['LIFT-850 Jump Pack'] = 'LIFT-850 «Реактивный ранец»',
      ['LIFT-860 Hover Pack'] = 'LIFT-860 Ранец для парения',
      ['Language'] = 'Язык',
      ['Large Plasma Bolt'] = 'Большой заряд плазмы',
      ['Larger Plasma Container'] = 'Увеличенный контейнер для плазмы',
      ['Laser'] = 'Лазер',
      ['Laser Cannon'] = '«Лазерная пушка»',
      ['Laser Sentry'] = 'Лазерная турель',
      ['Laser Sight'] = 'Лазерный прицел',
      ['Laser Sight Flashlight'] = 'Лазерный прицел с фонариком',
      ['Laser damage'] = 'Урон лазером',
      ['Laser. Blaster Focus'] = 'Лазер. Фокусировка бластера',
      ['Laser. Charge Standard'] = 'Лазер. Стандартный заряд',
      ['Laser. Standard Prism'] = 'Стандартная призма',
      ['Launch duration (s)'] = 'Длительность толчка (с)',
      ['Launch force'] = 'Сила толчка',
      ['Launch speed (m/s)'] = 'Скорость пуска (м/с)',
      ['Left'] = 'Слева',
      ['Left arm'] = 'Левая рука',
      ['Left arm health'] = 'Здоровье левой руки',
      ['Left back panel'] = 'Левая задняя панель',
      ['Left box 0'] = 'Левый ящик 0',
      ['Left box 1'] = 'Левый ящик 1',
      ['Left box 2'] = 'Левый ящик 2',
      ['Left front block'] = 'Левый передний блок',
      ['Left front door'] = 'Левая передняя дверь',
      ['Left front light'] = 'Левая передняя фара',
      ['Left leg'] = 'Левая нога',
      ['Left leg health'] = 'Здоровье левой ноги',
      ['Left mirror'] = 'Левое зеркало',
      ['Left rear door'] = 'Левая задняя дверь',
      ['Left side panel 0'] = 'Левая боковая панель 0',
      ['Left side panel 1'] = 'Левая боковая панель 1',
      ['Left top block'] = 'Левый верхний блок',
      ['Left track'] = 'Левая гусеница',
      ['Leg injury immunity (1 on)'] = 'Иммунитет к ранению ног (1 — вкл.)',
      ['Leveller'] = 'Уравнитель',
      ['Liberator'] = '«Освободитель»',
      ['Liberator Carbine'] = 'Карабин «Освободитель»',
      ['Liberator Concussive'] = '«Сотрясающий освободитель»',
      ['Liberator Legacy'] = '«Классический освободитель»',
      ['Liberator Penetrator'] = '«Пробойный освободитель»',
      ['Lifetime (s)'] = 'Время жизни (с)',
      ['Limb health'] = 'Здоровье конечностей',
      ['Limb injury avoidance'] = 'Защита конечностей от ранений',
      ['Load'] = 'Загрузить',
      ['Log file'] = 'Файл журнала',
      ['Log file path copied.'] = 'Путь к файлу журнала скопирован.',
      ['Logs'] = 'Журналы',
      ['Logs and Presets'] = 'Журналы и пресеты',
      ['Loses its target past (deg)'] = 'Теряет цель за пределами (град.)',
      ['Loyalist'] = 'Верный',
      ['Lumberer Exosuit'] = 'Экзокостюм «Лесоруб»',
      ['Lure Mine'] = 'Мина-приманка',
      ['M-1000 Maxigun'] = 'M-1000 Максиган',
      ['M-102 Gunner FRV'] = 'M-102 МТР «Стрелок»',
      ['M-103 Supply FRV'] = 'M-103 МТР снабжения',
      ['M-104 Incinerator FRV'] = 'M-104 Огнеметная МТР',
      ['M-105 Stalwart'] = 'M-105 «Доблесть»',
      ['M-105 Stalwart (mounted)'] = 'M-105 «Доблесть» (станковый)',
      ['M-105 Stalwart (mounted, AI-aimed 1)'] = 'M-105 «Доблесть» (станковый, наводка ИИ 1)',
      ['M-105 Stalwart (mounted, AI-aimed 2)'] = 'M-105 «Доблесть» (станковый, наводка ИИ 2)',
      ['M6C/SOCOM Pistol'] = 'M6C/SOCOM Пистолет',
      ['M7S SMG'] = 'M7S Пистолет-пулемет',
      ['M90A Shotgun'] = 'M90A Дробовик',
      ['MA5C Assault Rifle'] = 'MA5C Штурмовая винтовка',
      ['MG-206 Heavy Machine Gun'] = 'MG-206 «Тяжелый пулемет»',
      ['MG-206 Heavy Machine Gun (mounted B)'] = 'MG-206 «Тяжелый пулемет» (станковый B)',
      ['MG-43 Machine Gun'] = 'MG-43 «Пулемет»',
      ['MG-43 Machine Gun (SEAF)'] = 'MG-43 «Пулемет» (ВССЗ)',
      ['MGX-42 Bullet Storm'] = 'MGX-42 «Шквал пуль»',
      ['MINEFIELD'] = 'МИННОЕ ПОЛЕ',
      ['MISSILE FLIGHT'] = 'ПОЛЕТ РАКЕТЫ',
      ['MLS-4X Commando'] = 'MLS-4X «Коммандос»',
      ['MP-98 Knight'] = 'MP-98 Рыцарь',
      ['MS-11 Solo Silo'] = 'MS-11 Одиночная пусковая шахта',
      ['Machete'] = 'Мачете',
      ['Machine Gun'] = '«Пулемет»',
      ['Machine Gun Sentry'] = '«Пулеметная турель»',
      ['Made by SHODAN'] = 'Автор: SHODAN',
      ['Maelstrom'] = 'Водоворот',
      ['Magazine size'] = 'Размер магазина',
      ['Magazines from supply'] = 'Магазины из снабжения',
      ['Main gun'] = 'Основное орудие',
      ['Marker radar scan every (s)'] = 'Радарное сканирование меток каждые (с)',
      ['Mass (kg)'] = 'Масса (кг)',
      ['Max carried'] = 'Макс. при себе',
      ['Max flight time (s)'] = 'Макс. время полета (с)',
      ['Max spare heatsinks'] = 'Макс. запасных радиаторов',
      ['Max spare magazines'] = 'Макс. запасных магазинов',
      ['Max spare rounds'] = 'Макс. запасных патронов',
      ['Max throw distance (m)'] = 'Макс. дальность броска (м)',
      ['Maxigun'] = 'Максиган',
      ['Mechas'] = 'Техника',
      ['Med-Kit'] = 'Аптечка',
      ['Medium Plasma Bolt'] = 'Средний заряд плазмы',
      ['Melee damage'] = 'Урон в ближнем бою',
      ['Melta Mine'] = 'Плавкомина',
      ['Meltagun'] = 'Плавкопушка',
      ['Mid-air steering force'] = 'Сила управления в воздухе',
      ['Mine'] = 'Мина',
      ['Mine explosion'] = 'Взрыв мины',
      ['Minefield'] = 'Минное поле',
      ['Mines deep'] = 'Мин в глубину',
      ['Mines per panel'] = 'Мин на секцию',
      ['Mines wide'] = 'Мин в ширину',
      ['Minimum speed (m/s)'] = 'Минимальная скорость (м/с)',
      ['Missile'] = 'Ракета',
      ['Missile Pistol'] = 'Ракетный пистолет',
      ['Missile flight'] = 'Полет ракеты',
      ['Mist'] = '«Дымка»',
      ['Mortar Sentry'] = '«Турель с минометом»',
      ['Move while reloading'] = 'Движение при перезарядке',
      ['Movement'] = 'Передвижение',
      ['Muzzle'] = 'Дуло',
      ['Muzzle brake'] = 'Дульный тормоз',
      ['Napalm Bomb'] = 'Напалмовая бомба',
      ['Napalm Bomb Mk2'] = 'Напалмовая бомба Mk2',
      ['Napalm Bomb Mk3'] = 'Напалмовая бомба Mk3',
      ['No changes: loading it puts every value back to the game\'s.'] = 'Изменений нет: загрузка вернет все значения игры.',
      ['No presets yet.'] = 'Пресетов пока нет.',
      ['Noise'] = 'Шум',
      ['Normal projectile'] = 'Обычный снаряд',
      ['Not offered by the game: a laser built on the Scythe. Settings: Unlock LAS-22 Shear.'] = 'Игра его не предлагает: лазер на основе «Косы». Настройки: разблокировать LAS-22 Ножницы.',
      ['Not used by any weapon or stratagem in this list.'] = 'Ни одно оружие или стратагема в этом списке его не использует.',
      ['Nothing matches.'] = 'Ничего не найдено.',
      ['Nothing to install: your values are the game\'s own.'] = 'Устанавливать нечего: ваши значения совпадают с игровыми.',
      ['Nova'] = '«Нова»',
      ['Nuke'] = 'Ядерная бомба',
      ['OFFLINE  -  edits the game\'s files; they apply when the game starts'] = 'ОФЛАЙН  -  меняет файлы игры; изменения действуют при запуске игры',
      ['OK'] = 'ОК',
      ['ORBITAL BEAM'] = 'ОРБИТАЛЬНЫЙ ЛУЧ',
      ['Off'] = 'Выкл',
      ['Off: its stats above are left out; only the passives below apply.'] = 'Выкл.: его характеристики выше не действуют; действуют только эффекты ниже.',
      ['Off: the game\'s values everywhere; your '] = 'Выкл: везде значения игры; ваши ',
      ['Off: with other players, arc chain length / split use the game\'s values (else arcs can stay on screen).'] = 'Выкл: с другими игроками длина и разветвление цепи дуги берутся из игры (иначе дуги могут оставаться на экране).',
      ['Ombudsman'] = 'Омбудсмен',
      ['On'] = 'Вкл',
      ['On: a loadout can take more than one exosuit, FRV or tank.'] = 'Вкл: в снаряжение можно взять больше одного экзокостюма, МТР или танка.',
      ['On: in your armory / stratagem list.'] = 'Вкл: в вашем арсенале / списке стратагем.',
      ['On: your '] = 'Вкл: ваши ',
      ['On: your arc chain length / split apply with other players too (arcs can stay on screen).'] = 'Вкл: ваши длина и разветвление цепи дуги действуют и с другими игроками (дуги могут оставаться на экране).',
      ['One True Flag'] = 'Один истинный флаг',
      ['One-Two'] = 'Двоечка',
      ['Open'] = 'Открыть',
      ['Open / close key'] = 'Клавиша открытия / закрытия',
      ['Opened the GitHub page in your browser.'] = 'Страница GitHub открыта в браузере.',
      ['Opened the folder.'] = 'Папка открыта.',
      ['Opened the log folder.'] = 'Папка журналов открыта.',
      ['Optic'] = 'Прицел',
      ['Orbital'] = 'Орбитальный',
      ['Orbital 120mm HE Barrage'] = '«Орбитальный залп 120-мм ОФ»',
      ['Orbital 380mm HE Barrage'] = '«Орбитальный залп 380-мм ОФ»',
      ['Orbital Airburst Strike'] = '«Орбитальная воздушная бомба»',
      ['Orbital EMS Strike'] = '«Орбитальный ЭМ-удар»',
      ['Orbital Gas Strike'] = '«Орбитальный газовый удар»',
      ['Orbital Gatling Barrage'] = '«Орбитальный залп Гатлинга»',
      ['Orbital Laser'] = '«Орбитальный лазер»',
      ['Orbital Napalm Barrage'] = '«Орбитальный удар напалмом»',
      ['Orbital Precision Strike'] = '«Орбитальный высокоточный удар»',
      ['Orbital Railcannon Strike'] = '«Орбитальный рельсотронный залп»',
      ['Orbital Smoke Strike'] = '«Орбитальная дымовая завеса»',
      ['Orbital Walking Barrage'] = '«Орбитальный огневой вал»',
      ['Orbital beam'] = 'Орбитальный луч',
      ['Orbital strike.'] = 'Орбитальный удар.',
      ['Other players are in your game: arc chain length / split use the game\'s values.'] = 'В вашей игре другие игроки: длина и разветвление цепи дуги берутся из игры.',
      ['Outer radius (m)'] = 'Внешний радиус (м)',
      ['Overcharge limit (s)'] = 'Предел перезаряда (с)',
      ['Overheat threshold'] = 'Порог перегрева',
      ['Own effects'] = 'Свои эффекты',
      ['Oxygenator'] = 'Аэратор',
      ['P-11 Stim Pistol'] = 'P-11 Стим-пистолет',
      ['P-113 Verdict'] = 'P-113 «Вердикт»',
      ['P-19 Redeemer'] = 'P-19 «Избавитель»',
      ['P-2 Peacemaker'] = 'P-2 «Миротворец»',
      ['P-33 Missile Pistol'] = 'P-33 Ракетный пистолет',
      ['P-34 Breacher'] = 'P-34 Прорывник',
      ['P-35 Re-Educator'] = 'P-35 Реформатор',
      ['P-4 Senator'] = 'P-4 Сенатор',
      ['P-41 Ombudsman'] = 'P-41 Омбудсмен',
      ['P-41 Ombudsman (variant 2)'] = 'P-41 Омбудсмен (вариант 2)',
      ['P-44 Mist'] = 'P-44 «Дымка»',
      ['P-69 Veto'] = 'P-69 Вето',
      ['P-72 Crisper'] = 'P-72 «Фритюр»',
      ['P-92 Warrant'] = 'P-92 Ордер',
      ['P/40-K Bolt Pistol'] = 'P/40-K Болтострел',
      ['PASSIVE'] = 'ПАССИВНЫЙ ЭФФЕКТ',
      ['PLAS-1 Scorcher'] = 'PLAS-1 «Поджигатель»',
      ['PLAS-101 Purifier'] = 'PLAS-101 «Очиститель»',
      ['PLAS-15 Loyalist'] = 'PLAS-15 Верный',
      ['PLAS-39 Accelerator Rifle'] = 'PLAS-39 Акселераторная винтовка',
      ['PLAS-45 Epoch'] = 'PLAS-45 Эпоха',
      ['PRESETS'] = 'ПРЕСЕТЫ',
      ['PROJECTILE'] = 'СНАРЯД',
      ['PROJECTILE SWAP'] = 'ЗАМЕНА СНАРЯДА',
      ['Pacifier'] = 'Усмиритель',
      ['Panel side'] = 'Сторона панели',
      ['Panel size'] = 'Размер панели',
      ['Panels'] = 'Секции',
      ['Partial charge'] = 'Частичный заряд',
      ['Partial charge explosion'] = 'Взрыв с частичным зарядом',
      ['Partial charge shot'] = 'Выстрел с частичным зарядом',
      ['Passive'] = 'Пассивный эффект',
      ['Patriot Exosuit'] = 'Экзокостюм «Патриот»',
      ['Peacemaker'] = '«Миротворец»',
      ['Peak Physique'] = 'Пик формы',
      ['Pen.'] = 'Проб.',
      ['Penetration slowdown'] = 'Замедление при пробитии',
      ['Pineapple'] = 'Лимонка',
      ['Plasma Pistol. Canister Extended'] = 'Плазменный пистолет. Увеличенный баллон',
      ['Plasma Pistol. Canister Pistol'] = 'Плазменный пистолет. Стандартный баллон',
      ['Point of interest range'] = 'Дальность точек интереса',
      ['Portable Hellbomb'] = 'Переносная Адская бомба',
      ['Position scatter (m)'] = 'Разброс позиции (м)',
      ['Presets'] = 'Пресеты',
      ['Press a key (Esc cancels)'] = 'Нажмите клавишу (Esc — отмена)',
      ['Press the key that should open and close the panel: F1-F12, Insert, Home, End, Pause or Scroll Lock. Esc cancels.'] = 'Нажмите клавишу для открытия и закрытия панели: F1-F12, Insert, Home, End, Pause или Scroll Lock. Esc — отмена.',
      ['Primary'] = 'Основное',
      ['Primary reload speed'] = 'Перезарядка осн. оружия',
      ['Projectile'] = 'Снаряд',
      ['Projectile explosion id'] = 'Взрыв снаряда: ID',
      ['Projectile fired (id)'] = 'Выпускаемый снаряд (id)',
      ['Projectile swap'] = 'Замена снаряда',
      ['Projectiles per shot'] = 'Снарядов за выстрел',
      ['Prone speed (m/s)'] = 'Скорость ползком (м/с)',
      ['Punisher'] = '«Каратель»',
      ['Punisher Plasma'] = '«Плазменный каратель»',
      ['Purifier'] = '«Очиститель»',
      ['Push force'] = 'Сила толчка',
      ['Pyrotech'] = 'Пиротех',
      ['Quasar Cannon'] = 'Пушка «Квазар»',
      ['R-2 Amendment'] = 'R-2 Поправка',
      ['R-2124 Constitution'] = 'R-2124 «Конституция»',
      ['R-36 Eruptor'] = 'R-36 «Извергатель»',
      ['R-4 Hyena'] = 'R-4 Гиена',
      ['R-40 Sightliner'] = 'R-40 «Целенаводчик»',
      ['R-6 Deadeye'] = 'R-6 Меткий стрелок',
      ['R-63 Diligence'] = 'R-63 «Рвение»',
      ['R-63CS Diligence Counter Sniper'] = 'R-63CS «Рвение антиснайпер»',
      ['R-72 Censor'] = 'R-72 Цензор',
      ['R/40-K Hot-Shot Marksman Rifle'] = 'R/40-K Марксманская винтовка «Лихач»',
      ['RL-77 Airburst Rocket Launcher'] = 'RL-77 «Ракетница с подрывом в воздухе»',
      ['ROUND 1 BLAST'] = 'ВЗРЫВ ВЫСТРЕЛА 1',
      ['ROUND 1 BLAST RADIUS'] = 'РАДИУС ВЗРЫВА ВЫСТРЕЛА 1',
      ['ROUND 1 PROJECTILE'] = 'СНАРЯД ВЫСТРЕЛА 1',
      ['ROUNDS 2, 3 BLAST RADIUS'] = 'РАДИУС ВЗРЫВА ВЫСТРЕЛОВ 2, 3',
      ['ROUNDS 2, 3 PROJECTILE'] = 'СНАРЯД ВЫСТРЕЛОВ 2, 3',
      ['ROUNDS 2, 3, 4 PROJECTILE'] = 'СНАРЯД ВЫСТРЕЛОВ 2, 3, 4',
      ['RS-422 Railgun'] = 'RS-422 «Рельсотрон»',
      ['Rack'] = 'Стойка',
      ['Radar'] = 'Радар',
      ['Radius'] = 'Радиус',
      ['Radius (m)'] = 'Радиус (м)',
      ['Rail Cannon Round'] = 'Выстрел рельсотрона',
      ['Railgun'] = '«Рельсотрон»',
      ['Railgun Round'] = 'Снаряд рельсотрона',
      ['Railgun Stun Round'] = 'Оглушающий снаряд рельсотрона',
      ['Range'] = 'Дальность',
      ['Range (m)'] = 'Дальность (м)',
      ['Rapid Heatsink'] = 'Быстрый радиатор',
      ['Re-Educator'] = 'Реформатор',
      ['Reach downward (m)'] = 'Досягаемость вниз (м)',
      ['Reach upward (m)'] = 'Досягаемость вверх (м)',
      ['Reading the game\'s weapon tables... ('] = 'Чтение таблиц оружия игры... (',
      ['Rear cockpit'] = 'Задняя кабина',
      ['Recharge delay (s)'] = 'Задержка восстановления (с)',
      ['Recharge delay once broken (s)'] = 'Задержка восстановления после пробития (с)',
      ['Recharge rate (per s)'] = 'Скорость восстановления (в с)',
      ['Recharge time (s)'] = 'Время восстановления (с)',
      ['Recoil (horizontal)'] = 'Отдача (по горизонтали)',
      ['Recoil (vertical)'] = 'Отдача (по вертикали)',
      ['Recoil crouching / prone'] = 'Отдача сидя / лежа',
      ['Recoil multiplier (horizontal)'] = 'Множитель отдачи (по горизонтали)',
      ['Recoil multiplier (vertical)'] = 'Множитель отдачи (по вертикали)',
      ['Recoilless Rifle'] = '«Безоткатная винтовка»',
      ['Records'] = 'Записи',
      ['Redeemer'] = '«Избавитель»',
      ['Reduced Signature'] = 'Уменьшенный след',
      ['Refill starts after (s)'] = 'Восстановление начинается через (с)',
      ['Refills crouched in (s)'] = 'Восстановление пригнувшись за (с)',
      ['Refills prone in (s)'] = 'Восстановление лёжа за (с)',
      ['Refills standing in (s)'] = 'Восстановление стоя за (с)',
      ['Regeneration (health/s)'] = 'Регенерация (здоровье/с)',
      ['Reinforced Epaulettes'] = 'Армированные эполеты',
      ['Releases'] = 'Релизы',
      ['Reload allowed below (rounds)'] = 'Перезарядка разрешена ниже (патронов)',
      ['Reload time (s)'] = 'Время перезарядки (с)',
      ['Reload time (s; 0 = animation length)'] = 'Время перезарядки (с; 0 = длина анимации)',
      ['Remember last tab and weapon'] = 'Запоминать последнюю вкладку и оружие',
      ['Remove'] = 'Убрать',
      ['Rename'] = 'Переимен.',
      ['Reprimand'] = 'Взыскание',
      ['Reset all values'] = 'Сбросить все значения',
      ['Reset helldiver'] = 'Сбросить десантника',
      ['Reset passive'] = 'Сброс эффекта',
      ['Reset record'] = 'Сбросить запись',
      ['Reset weapon'] = 'Сброс оружия',
      ['Resets all values from the current preset to default.'] = 'Сбрасывает все значения текущего пресета к значениям по умолчанию.',
      ['Restore the game\'s files'] = 'Вернуть файлы игры',
      ['Restoring the game\'s files...'] = 'Возврат исходных файлов игры...',
      ['Resupply'] = '«Пополнение запасов»',
      ['Rifle Justice. Short '] = 'Винтовка «Правосудие». Короткий магазин',
      ['Right'] = 'Справа',
      ['Right arm'] = 'Правая рука',
      ['Right arm health'] = 'Здоровье правой руки',
      ['Right back panel'] = 'Правая задняя панель',
      ['Right box 0'] = 'Правый ящик 0',
      ['Right box 1'] = 'Правый ящик 1',
      ['Right box 2'] = 'Правый ящик 2',
      ['Right front block'] = 'Правый передний блок',
      ['Right front door'] = 'Правая передняя дверь',
      ['Right front light'] = 'Правая передняя фара',
      ['Right leg'] = 'Правая нога',
      ['Right leg health'] = 'Здоровье правой ноги',
      ['Right mirror'] = 'Правое зеркало',
      ['Right rear door'] = 'Правая задняя дверь',
      ['Right side panel 0'] = 'Правая боковая панель 0',
      ['Right side panel 1'] = 'Правая боковая панель 1',
      ['Right top block'] = 'Правый верхний блок',
      ['Right track'] = 'Правая гусеница',
      ['Rock Solid'] = 'Кремень',
      ['Rocket Sentry'] = '«Ракетная турель»',
      ['Round 1 blast'] = 'Взрыв выстрела 1',
      ['Round 1 blast radius'] = 'Радиус взрыва выстрела 1',
      ['Round 1 projectile'] = 'Снаряд выстрела 1',
      ['Rounds 2, 3 blast radius'] = 'Радиус взрыва выстрелов 2, 3',
      ['Rounds 2, 3 projectile'] = 'Снаряд выстрелов 2, 3',
      ['Rounds 2, 3, 4 projectile'] = 'Снаряд выстрелов 2, 3, 4',
      ['Rounds from supply'] = 'Патроны из снабжения',
      ['Rounds loaded'] = 'Патронов заряжено',
      ['Rounds per reload'] = 'Патронов за перезарядку',
      ['Run length (m)'] = 'Длина захода (м)',
      ['S-11 Speargun'] = 'S-11 Гарпун',
      ['SECOND MODE'] = 'ВТОРОЙ РЕЖИМ',
      ['SG-20 Halt'] = 'SG-20 Стоп',
      ['SG-22 Bushwhacker'] = 'SG-22 «Партизан»',
      ['SG-225 Breaker'] = 'SG-225 «Крушитель»',
      ['SG-225IE Breaker Incendiary'] = 'SG-225IE «Зажигательный крушитель»',
      ['SG-225SP Breaker Spray&Pray'] = 'SG-225SP «Крушитель ураган»',
      ['SG-451 Cookout'] = 'SG-451 «Барбекю»',
      ['SG-8 Punisher'] = 'SG-8 «Каратель»',
      ['SG-88 Break-Action Shotgun'] = 'SG-88 Дробовик-переломка',
      ['SG-8P Punisher Plasma'] = 'SG-8P «Плазменный каратель»',
      ['SG-8S Slugger'] = 'SG-8S «Крушила»',
      ['SG-97 Sweeper'] = 'SG-97 Чистильщик',
      ['SH-20 Ballistic Shield Backpack'] = 'SH-20 «Рюкзак: баллистический щит»',
      ['SH-32 Shield Generator Pack'] = 'SH-32 «Генератор щита»',
      ['SH-51 Directional Shield'] = 'SH-51 Щит направленного действия',
      ['SHARED WITH'] = 'ОБЩЕЕ С',
      ['SHIELD'] = 'ЩИТ',
      ['SHODAN STAT EDITOR'] = 'РЕДАКТОР ХАРАКТЕРИСТИК SHODAN',
      ['SHODAN weapon mods are running too: they put their own values back every 5 s'] = 'Также работают оружейные моды SHODAN: они возвращают свои значения каждые 5 с',
      ['SHRAPNEL'] = 'ОСКОЛКИ',
      ['SHRAPNEL BLAST RADIUS'] = 'РАДИУС ВЗРЫВА ОСКОЛКОВ',
      ['SHRAPNEL DIRECT HIT'] = 'ПРЯМОЕ ПОПАДАНИЕ ОСКОЛКОВ',
      ['SHRAPNEL PROJECTILE'] = 'СНАРЯД ОСКОЛКОВ',
      ['SILO'] = 'ШАХТА',
      ['SMG'] = 'ПИСТОЛЕТ-ПУЛЕМЕТ',
      ['SMG-203 Gallant'] = 'SMG-203 «Кавалер»',
      ['SMG-32 Reprimand'] = 'SMG-32 Взыскание',
      ['SMG-37 Defender'] = 'SMG-37 Защитник',
      ['SMG-37 Defender (SEAF)'] = 'SMG-37 Защитник (ВССЗ)',
      ['SMG-72 Pummeler'] = 'SMG-72 «Трамбовщик»',
      ['SMG/FLAM-34 Stoker'] = 'SMG/FLAM-34 Топка',
      ['SMG/FLAM-34 Stoker (underbarrel flamer)'] = 'SMG/FLAM-34 Топка (подствольный огнемет)',
      ['STRATAGEM'] = 'СТРАТАГЕМА',
      ['Safe below heat (%)'] = 'Безопасно ниже нагрева (%)',
      ['Sai'] = 'Сай',
      ['Salvos'] = 'Залпы',
      ['Save'] = 'Сохранить',
      ['Save current changes here'] = 'Сохранить изменения сюда',
      ['Scorcher'] = '«Поджигатель»',
      ['Scout'] = 'Разведчик',
      ['Scythe'] = '«Коса»',
      ['Search radius (m)'] = 'Радиус поиска (м)',
      ['Search weapons and stratagems'] = 'Поиск оружия и стратагем',
      ['Second ammo'] = 'Второй тип боеприпасов',
      ['Second mode'] = 'Второй режим',
      ['Second mode explosion'] = 'Взрыв второго режима',
      ['Second mode fires (id)'] = 'Второй режим выпускает (id)',
      ['Secondary'] = 'Дополнит.',
      ['Secondary draw speed'] = 'Извлечение доп. оружия',
      ['Secondary recoil'] = 'Отдача доп. оружия',
      ['Secondary reload speed'] = 'Перезарядка доп. оружия',
      ['Seeker'] = 'Искатель',
      ['Senator'] = 'Сенатор',
      ['Sentry'] = 'Турель',
      ['Sentry: its cooldown, its body, then its weapon.'] = 'Турель: перезарядка, корпус, затем оружие.',
      ['Servo-Assisted'] = 'Сервопривод',
      ['Settings'] = 'Настройки',
      ['Settings are saved at once, in config.txt with your changes.'] = 'Настройки сохраняются сразу, в config.txt вместе с вашими изменениями.',
      ['Several vehicles of a kind'] = 'Несколько машин одного вида',
      ['Shape'] = 'Форма',
      ['Shared by every armor with this passive. Multipliers: 1 = no change.'] = 'Общее для всей брони с этим эффектом. Множители: 1 = без изменений.',
      ['Shear'] = 'Ножницы',
      ['Shells per salvo'] = 'Снарядов в залпе',
      ['Shield'] = 'Щит',
      ['Shield Generator Pack'] = '«Генератор щита»',
      ['Shield capacity'] = 'Емкость щита',
      ['Shield emitter'] = 'Излучатель щита',
      ['Shockwave radius (m)'] = 'Радиус ударной волны (м)',
      ['Short Magazine'] = 'Короткий магазин',
      ['Shrapnel'] = 'Шрапнель',
      ['Shrapnel blast radius'] = 'Радиус взрыва осколков',
      ['Shrapnel direct hit'] = 'Прямое попадание осколков',
      ['Shrapnel explosion'] = 'Взрыв осколков',
      ['Shrapnel pieces'] = 'Число осколков',
      ['Shrapnel projectile'] = 'Снаряд осколков',
      ['Shrapnel projectile (id)'] = 'Снаряд осколков (ID)',
      ['Sickle'] = '«Серп»',
      ['Siege-Ready'] = 'К осаде готов',
      ['Sightliner'] = '«Целенаводчик»',
      ['Silo'] = 'Шахта',
      ['Slide speed / duration'] = 'Скорость / длительность скольжения',
      ['Slugger'] = '«Крушила»',
      ['Small Plasma Bolt'] = 'Малый заряд плазмы',
      ['Smoke'] = '«Дымовая»',
      ['Smokescreen'] = 'Дымовая завеса',
      ['Sniper Scope 10x'] = 'Снайперский прицел (10х)',
      ['Sniper Scope 10x Helghast'] = 'Снайперский прицел (10х)',
      ['Solo Silo'] = 'Одиночная пусковая шахта',
      ['Spear'] = 'Копье',
      ['Speargun'] = 'Гарпун',
      ['Speed while aiming (m/s)'] = 'Скорость при прицеливании (м/с)',
      ['Spotting range (m)'] = 'Дальность обнаружения (м)',
      ['Spread (horizontal)'] = 'Разброс (по горизонтали)',
      ['Spread (vertical)'] = 'Разброс (по вертикали)',
      ['Spread area (m)'] = 'Площадь разброса (м)',
      ['Spread multiplier (horizontal)'] = 'Множитель разброса (по горизонтали)',
      ['Spread multiplier (vertical)'] = 'Множитель разброса (по вертикали)',
      ['Sprint speed (m/s)'] = 'Скорость спринта (м/с)',
      ['Sprint speed, out of stamina (m/s)'] = 'Скорость спринта без выносливости (м/с)',
      ['Sprinting empties it in (s)'] = 'Спринт расходует её за (с)',
      ['StA-11 SMG'] = 'StA-11 Пистолет-пулемет',
      ['StA-52 Assault Rifle'] = 'StA-52 Штурмовая винтовка',
      ['StA-X3 W.A.S.P. Launcher'] = 'StA-X3 Ракетомет W.A.S.P.',
      ['Stage '] = 'Этап ',
      ['Stagger force'] = 'Сила ошеломления',
      ['Stalwart'] = '«Доблесть»',
      ['Stamina'] = 'Выносливость',
      ['Standard Drum'] = 'Стандартный барабанный магазин',
      ['Standard Heatsink'] = 'Стандартный радиатор',
      ['Standard Plasma Container'] = 'Стандартный контейнер для плазмы',
      ['Starting charges'] = 'Заряды в начале',
      ['Starting count'] = 'Количество в начале',
      ['Starting heatsinks'] = 'Радиаторы в начале',
      ['Starting magazines'] = 'Магазины в начале',
      ['Starting rounds'] = 'Патроны в начале',
      ['Starts at heat'] = 'Начинается при нагреве',
      ['Stationary Shroud'] = 'Неподвижный покров',
      ['Stim Pistol'] = 'Стим-пистолет',
      ['Stoker'] = 'Топка',
      ['Stops you while firing'] = 'Останавливает при стрельбе',
      ['Stratagem'] = 'Стратагема',
      ['Stratagems'] = 'Стратагемы',
      ['Stun'] = '«Оглушающая»',
      ['Stun (large)'] = 'Оглушение (сильное)',
      ['Stun (massive)'] = 'Оглушение (огромное)',
      ['Stun (medium)'] = 'Оглушение (среднее)',
      ['Stun (small)'] = 'Оглушение (слабое)',
      ['Stun Baton'] = 'Оглушающая дубинка',
      ['Stun Lance'] = 'Оглушающее копье',
      ['Stun rounds'] = 'Оглушающие боеприпасы',
      ['Stun rounds fire (id)'] = 'Выстрел оглушающими (id)',
      ['Supplementary Adrenaline'] = 'Добавки-адреналин',
      ['Supply FRV'] = 'МТР снабжения',
      ['Supply Pack'] = '«Рюкзак: боеприпасы»',
      ['Support'] = 'Поддерж.',
      ['Support reload speed'] = 'Перезарядка оружия поддержки',
      ['Support weapon drop; the weapon itself is under Support.'] = 'Сброс оружия поддержки; само оружие — во вкладке «Поддержка».',
      ['Suppressor'] = 'Подавитель',
      ['Sure?'] = 'Уверены?',
      ['Surviving lethal damage'] = 'Выживание при смертельном уроне',
      ['Sway multiplier'] = 'Множитель колебания',
      ['Sweeper'] = 'Чистильщик',
      ['Swim speed (m/s)'] = 'Скорость плавания (м/с)',
      ['TD-110 Maelstrom'] = 'TD-110 Водоворот',
      ['TD-220 Bastion MK XVI'] = 'TD-220 Mk-XVI «БАСТИОН»',
      ['TED-63 Dynamite'] = 'TED-63 Динамит',
      ['THROWABLE'] = 'МЕТАТЕЛЬНОЕ',
      ['TM-1 Lure Mine'] = 'TM-1 Мина-приманка',
      ['TX-41 Sterilizer'] = 'TX-41 Стерилизатор',
      ['Tabs shown'] = 'Показывать вкладки',
      ['Talon'] = 'Коготь',
      ['Target search interval, max (s)'] = 'Интервал поиска цели, макс. (с)',
      ['Target search interval, min (s)'] = 'Интервал поиска цели, мин. (с)',
      ['Tenderizer'] = '«Размягчитель»',
      ['Tesla Tower'] = '«Тесла-башня»',
      ['Tested releases only.'] = 'Только проверенные релизы.',
      ['That did not work; see the log.'] = 'Не получилось; см. журнал.',
      ['The Arbitrator\'s underbarrel shotgun, not the rifle itself.'] = 'Подствольный дробовик «Третейского судьи», а не сама винтовка.',
      ['The Defender SEAF soldiers carry. Not yours.'] = '«Защитник» солдат ВССЗ. Не ваш.',
      ['The EAT-17 SEAF soldiers carry. Not yours.'] = 'EAT-17 солдат ВССЗ. Не ваш.',
      ['The MG-43 SEAF soldiers carry. Not yours.'] = 'MG-43 солдат ВССЗ. Не ваш.',
      ['The One-Two\'s underbarrel launcher, not the rifle. Fires the GP-31\'s grenade.'] = 'Подствольный гранатомет «Двоечки», а не винтовка. Стреляет гранатой GP-31.',
      ['The SMG you carry. Its underbarrel flamer is listed separately.'] = 'Пистолет-пулемет, который вы носите. Его подствольный огнемет указан отдельно.',
      ['The Scythe you carry.'] = '«Коса», которую вы носите.',
      ['The Stoker\'s underbarrel flamer, not the SMG itself.'] = 'Подствольный огнемет «Топки», а не сам пистолет-пулемет.',
      ['The armor passives could not be stacked'] = 'Не удалось объединить пассивные эффекты брони',
      ['The charge backpack, the charge and its blast. Cooldown: Stratagems tab.'] = 'Рюкзак с зарядом, сам заряд и его взрыв. Перезарядка: вкладка «Стратагемы».',
      ['The flamethrower you carry.'] = 'Огнемет, который вы носите.',
      ['The game holds at most 2048 rounds in a magazine.'] = 'Игра вмещает в магазин не более 2048 патронов.',
      ['The game\'s own files are already in place.'] = 'Исходные файлы игры уже на месте.',
      ['The game\'s own files are back. Your values stay saved here (Install puts them in again).'] = 'Исходные файлы игры возвращены. Ваши значения сохранены здесь («Установить в игру» вернёт их в игру).',
      ['The game\'s own files are in place. Close the game, then Install to play with your values.'] = 'Сейчас стоят исходные файлы игры. Закройте игру и нажмите «Установить в игру», чтобы играть с вашими значениями.',
      ['The one you carry.'] = 'То, что вы носите.',
      ['The one you carry. The CQC-20 Breaching Hammer is listed under Support.'] = 'То, что вы носите. CQC-20 Штурмовой молот — во вкладке «Поддержка».',
      ['The one you carry. The CQC-72 support version is listed under Support.'] = 'То, что вы носите. Версия поддержки CQC-72 — во вкладке «Поддержка».',
      ['The pistol you carry. The One-Two\'s launcher is listed under the One-Two.'] = 'Пистолет, который вы носите. Гранатомет «Двоечки» указан у «Двоечки».',
      ['The recharge time is 0: set it above 0 first.'] = 'Время восстановления равно 0: сначала задайте больше 0.',
      ['The rifle you carry. The grenade launcher is listed separately.'] = 'Винтовка, которую вы носите. Гранатомет указан отдельно.',
      ['The rifle you carry. The underbarrel shotgun is listed separately.'] = 'Винтовка, которую вы носите. Подствольный дробовик указан отдельно.',
      ['The support hammer delivered by hellpod. The game data files it next to the Machete.'] = 'Молот поддержки, доставляемый Адской капсулой. В данных игры он лежит рядом с Мачете.',
      ['The support weapon. The CQC-73 is listed under Secondary.'] = 'Оружие поддержки. CQC-73 — во вкладке «Дополнительное».',
      ['Thermite'] = '«Термитная»',
      ['Throw range'] = 'Дальность броска',
      ['Throw spread (degrees)'] = 'Разброс броска (град.)',
      ['Throw velocity, max (m/s)'] = 'Скорость броска, макс. (м/с)',
      ['Throw velocity, min (m/s)'] = 'Скорость броска, мин. (м/с)',
      ['Throwable'] = 'Метательное',
      ['Throwable launching is supported in solo missions only.'] = 'Запуск метательного работает только в одиночных миссиях.',
      ['Throwables'] = 'Метательное',
      ['Throwing Knife'] = 'Метательный нож',
      ['Time between bombs (s)'] = 'Время между бомбами (с)',
      ['Time between salvos (s)'] = 'Время между залпами (с)',
      ['Time between shells (s)'] = 'Время между снарядами (с)',
      ['Top left hatch'] = 'Верхний левый люк',
      ['Top right hatch'] = 'Верхний правый люк',
      ['Torcher'] = '«Сжигатель»',
      ['Tracer rounds'] = 'Трассирующие боеприпасы',
      ['Tracking speed'] = 'Скорость слежения',
      ['Trigger delay (s)'] = 'Задержка срабатывания (с)',
      ['True Grit'] = 'Железная хватка',
      ['Tube Reddot 2x'] = 'Трубчатый коллиматор (2x)',
      ['Turn speed at cruise'] = 'Скорость поворота на крейсерской',
      ['Turn speed at slowest'] = 'Скорость поворота на минимальной',
      ['Turn speed, horizontal (deg/s)'] = 'Скорость поворота, по горизонтали (град./с)',
      ['Turn speed, vertical (deg/s)'] = 'Скорость поворота, по вертикали (град./с)',
      ['Turret'] = 'Турель',
      ['Type the name: Enter keeps it, Esc cancels. The game sees these keys too, so name presets from a menu.'] = 'Введите имя: Enter — сохранить, Esc — отмена. Игра тоже видит эти клавиши, поэтому называйте пресеты из меню.',
      ['Type the percent (%d-%d): Enter sets it, Esc cancels.'] = 'Введите процент (%d-%d): Enter — задать, Esc — отмена.',
      ['Type the value: Enter sets it, Esc cancels. Values out of range are set to the nearest allowed one.'] = 'Введите значение: Enter — задать, Esc — отмена. Значения вне диапазона заменяются ближайшим допустимым.',
      ['Type to search: Enter keeps the results, Esc clears the search. The game sees these keys too.'] = 'Введите запрос: Enter — оставить результаты, Esc — очистить поиск. Игра тоже видит эти клавиши.',
      ['Ultimatum'] = 'Ультиматум',
      ['Uncharged'] = 'Без заряда',
      ['Uncharged explosion'] = 'Взрыв без заряда',
      ['Uncharged shot'] = 'Выстрел без заряда',
      ['Underbarrel'] = 'Подствольник',
      ['Unflinching'] = 'Непоколебимый',
      ['Unlock unused items'] = 'Разблокировать скрытое',
      ['Unsafe warp: damage to you'] = 'Небезопасный варп: урон вам',
      ['Unsafe warp: explosion'] = 'Небезопасный варп: взрыв',
      ['Up'] = 'Вверх',
      ['Up/Down choose a stat, Left/Right change it (Shift: bigger steps), click a value or press Enter to type it,'] = 'Вверх/Вниз — выбор параметра, Влево/Вправо — изменение (Shift: крупный шаг), щелкните значение или нажмите Enter для ввода,',
      ['Up/Down choose, Enter loads, Insert makes a new one, Shift+Insert saves into it, F2 renames, Del deletes.'] = 'Вверх/Вниз — выбор, Enter — загрузить, Insert — новый, Shift+Insert — сохранить в него, F2 — переименовать, Del — удалить.',
      ['Update channel'] = 'Канал обновлений',
      ['Updates'] = 'Обновления',
      ['Urchin'] = 'Озорник',
      ['Uses per mission'] = 'Применений за миссию',
      ['Uses per rearm'] = 'Применений за перевооружение',
      ['VEHICLE'] = 'ТЕХНИКА',
      ['VG-70 Variable'] = 'VG-70 Изменяемый',
      ['Variable'] = 'Изменяемый',
      ['Vehicle'] = 'Техника',
      ['Vehicle. The weapons it carries are listed under it.'] = 'Техника. Ее оружие указано под ней.',
      ['Velocity'] = 'Скорость',
      ['Velocity (m/s)'] = 'Скорость (м/с)',
      ['Verdict'] = '«Вердикт»',
      ['Vertical Grip'] = 'Вертикальная рукоять',
      ['Vertical Grip 45 Degree'] = 'Вертикальная рукоять под 45 градусов',
      ['Vertical Grip Advanced'] = 'Улучшенная вертикальная рукоять',
      ['Vertical Grip Flashlight'] = 'Вертикальная рукоять с фонариком',
      ['Veto'] = 'Вето',
      ['Volatile Plasma Bolt'] = 'Заряд нестабильной плазмы',
      ['W.A.S.P. Launcher'] = 'Ракетомет W.A.S.P.',
      ['WEAPON STATS'] = 'ХАРАКТЕРИСТИКИ ОРУЖИЯ',
      ['WIND-UP'] = 'РАСКРУТКА',
      ['Walk / run speed'] = 'Скорость ходьбы / бега',
      ['Walk speed (m/s)'] = 'Скорость шага (м/с)',
      ['Walking backwards (multiplier)'] = 'Ходьба назад (множитель)',
      ['Walking speed (m/s)'] = 'Скорость ходьбы (м/с)',
      ['Warp Pack'] = 'Варп-ранец',
      ['Warp distance (m)'] = 'Дальность варпа (м)',
      ['Warp pack'] = 'Варп-ранец',
      ['Warrant'] = 'Ордер',
      ['Weapon stats'] = 'Характеристики оружия',
      ['Wind-down time (s)'] = 'Время замедления (с)',
      ['Wind-down time, released (s)'] = 'Время замедления после отпускания (с)',
      ['Wind-up'] = 'Раскрутка',
      ['Wind-up time (s)'] = 'Время раскрутки (с)',
      ['Your changes are off: turn them on in Settings to edit.'] = 'Ваши изменения выключены: включите их в Настройках, чтобы редактировать.',
      ['Your changes are off: turn them on in Settings to load a preset'] = 'Ваши изменения выключены: включите их в Настройках, чтобы загрузить пресет',
      ['Your values are not in the game yet: close the game, then Install.'] = 'Ваши значения ещё не в игре: закройте игру и нажмите «Установить в игру».',
      ['also the second firing mode\'s shot (the same projectile)'] = 'также выстрел второго режима (тот же снаряд)',
      ['clip'] = 'обойма',
      ['damage: the same as the other rounds (Damage above)'] = 'урон: как у остальных выстрелов («Урон» выше)',
      ['direct hit: the same as the first mode\'s (Damage above)'] = 'прямое попадание: как в первом режиме («Урон» выше)',
      ['its own. - / + : fire another weapon\'s'] = 'свой. - / + : стрелять снарядом другого оружия',
      ['loaded into an empty weapon, from your spare rounds'] = 'заряжается в пустое оружие из запасных патронов',
      ['min charge'] = 'мин. заряд',
      ['no shrapnel'] = 'без осколков',
      ['none (no explosion)'] = 'нет (без взрыва)',
      ['none (no projectile)'] = 'нет (без снаряда)',
      ['normal projectile'] = 'обычный снаряд',
      ['overcharge'] = 'перезаряд',
      ['panels, mines per panel: lower only (more than the default crashes the game)'] = 'секции, мины на секцию: только уменьшать (больше значения по умолчанию — вылет игры)',
      ['shared with'] = 'общее с',
      ['speedloader'] = 'скорозарядник',
      ['stage 1: partial charge shot, stages 2-3: full charge shot'] = 'этап 1: выстрел с частичным зарядом, этапы 2-3: выстрел с полным зарядом',
      ['stage 1: uncharged shot, stages 2-3: charged shot'] = 'этап 1: выстрел без заряда, этапы 2-3: заряженный выстрел',
      ['the game\'s tiers: 10 small arms, 20 HMG, 30 autocannon, 40 Strider, 50 orbital, 60 Hellbomb, 250 never'] = 'уровни игры: 10 стрелковое, 20 тяжелый пулемет, 30 автопушка, 40 Страйдер, 50 орбитальный удар, 60 Адская бомба, 250 никогда',
      ['the shot fired from this heat on, and what it does to you'] = 'выстрел начиная с этого нагрева и его действие на вас',
      ['the spare ammo in its backpack; read when the backpack is called in'] = 'запас боеприпасов в его рюкзаке; читается при вызове рюкзака',
    },
    lower = {
      ['100kg bomb'] = 'Бомба (100 кг)',
      ['100kg bomb mk2'] = 'Бомба Mk2 (100 кг)',
      ['100kg bomb mk3'] = 'Бомба Mk3 (100 кг)',
      ['100kg cluster bomb'] = 'Кластерная бомба (100кг)',
      ['10g birdshot'] = 'Дробь 10 кал.',
      ['10g bugshot'] = 'Противожучиные боеприпасы 10 кал.',
      ['10g dual sabot'] = 'Двойной снаряд с поддоном 10 кал.',
      ['10g flechettes'] = 'Флешетты 10 кал.',
      ['10g fragmentation'] = 'Осколочные 10 кал.',
      ['10g high velocity sabot'] = 'Высокоскоростной снаряд с поддоном 10 кал.',
      ['10g liberty fire'] = 'Огонь свободы 10 кал.',
      ['10g magnum'] = 'Магнум 10 кал.',
      ['10g magnum triball'] = 'Магнум с тремя шариками 10 кал.',
      ['10g rifled slugs'] = 'Нарезные боеприпасы 10 кал.',
      ['10g sabot'] = 'Снаряд с поддоном 10 кал.',
      ['10g scatter shot'] = 'Боеприпасы для дробовика 10 кал.',
      ['10g stun rounds'] = 'ОГЛУШАЮЩИЕ БОЕПРИПАСЫ 10 кал.',
      ['10g tri-ball'] = 'С тремя шариками 10 кал.',
      ['10g. duckbill'] = '10g. Утконос',
      ['10g. full choke'] = '10g. Полный чок',
      ['10g. half choke'] = '10g. Получок',
      ['110mm airburst cannon round'] = 'Артиллерийский выстрел с подрывом в воздухе 110 мм',
      ['110mm airburst cannon round mk2'] = 'Артиллерийский выстрел с подрывом в воздухе Mk2 110 мм',
      ['110mm e.m.s. cannon round'] = 'ЭМ-артиллерийский выстрел 110 мм',
      ['110mm e.m.s. cannon round mk2'] = 'ЭМ-артиллерийский выстрел Mk2 110 мм',
      ['110mm e.m.s. cannon round mk3'] = 'ЭМ-артиллерийский выстрел Mk3 110 мм',
      ['110mm gas cannon round'] = 'Газовый артиллерийский выстрел 110 мм',
      ['110mm standard rocket'] = 'Стандартная ракета 110 мм',
      ['110mm standard rocket mk2'] = 'Стандартная ракета Mk2 110 мм',
      ['12.5mm bchp rifle rounds'] = 'Боеприпасы BCHP для винтовки 12,5 мм',
      ['12.5mm eit rounds'] = 'Боеприпасы EIT 12,5 мм',
      ['12.5mm standard rifle rounds'] = 'Стандартные боеприпасы для винтовки 12,5 мм',
      ['120mm he cannon round'] = 'ОФ-артиллерийский выстрел 120 мм',
      ['12g birdshot'] = 'Дробь 12 кал.',
      ['12g buckshot'] = 'Картечь 12 кал.',
      ['12g bugshot'] = 'Противожучиные боеприпасы 12 кал.',
      ['12g flechettes'] = 'Флешетты 12 кал.',
      ['12g liberty fire'] = 'Огонь свободы 12 кал.',
      ['12g magnum'] = 'Магнум 12 кал.',
      ['12g magnum triball'] = 'Магнум с тремя шариками 12 кал.',
      ['12g scatter shot'] = 'Боеприпасы для дробовика 12 кал.',
      ['12g tri-ball'] = 'С тремя шариками 12 кал.',
      ['12g. duckbill'] = '12g. Утконос',
      ['12g. full choke'] = '12g. Полный чок',
      ['12g. half choke'] = '12g. Получок',
      ['12mm. compensator'] = '12mm. Компенсатор',
      ['12mm. flash hider'] = '12mm. Пламегаситель',
      ['12mm. muzzle break'] = '12mm. Дульный тормоз',
      ['12x25mm explosive'] = 'Разрывные 12x25 мм',
      ['12x25mm full metal jacket'] = 'С цельнометаллической оболочкой 12x25 мм',
      ['12x25mm high velocity'] = 'Высокоскоростные 12x25 мм',
      ['12x25mm hollow point'] = 'Экспансивные 12x25 мм',
      ['12x25mm plasma'] = 'Плазменные 12x25 мм',
      ['12x25mm ripper'] = 'Жнец 12x25 мм',
      ['12x25mm thermite'] = 'Термитные 12x25 мм',
      ['12x25mm toxic'] = 'Ядовитые 12x25 мм',
      ['13x40mm full metal jacket'] = 'С цельнометаллической оболочкой 13х40 мм',
      ['13x40mm hollow point'] = 'Экспансивные 13х40 мм',
      ['13x40mm magnum'] = 'Магнум 13х40 мм',
      ['13x40mm penetrator'] = 'Проникающие 13х40 мм',
      ['13x40mm ripper'] = 'Жнец 13х40 мм',
      ['15x100mm emp-rounds'] = 'ЭМ-боеприпасы 15x100 мм',
      ['15x100mm fragmentation'] = 'Осколочные 15x100 мм',
      ['15x100mm high explosive'] = 'Фугасные 15x100 мм',
      ['15x100mm high velocity'] = 'Высокоскоростные 15x100 мм',
      ['15x100mm plasma'] = 'Плазменные 15x100 мм',
      ['15x100mm standard rocket'] = 'Стандартная ракета 15x100 мм',
      ['15x100mm thermite'] = 'Термитные 15x100 мм',
      ['15x100mm toxic'] = 'Ядовитые 15x100 мм',
      ['20mm aphet rounds'] = 'Бронебойно-фугасные снаряды 20 мм',
      ['20mm flak rounds'] = 'Зенитный снаряд 20 мм',
      ['20mm he cannon'] = 'ОФ пушка 20 мм',
      ['20mm hvap rounds'] = 'Бронебойные подкалиберные боеприпасы 20 мм',
      ['23mm he cannon'] = 'ОФ пушка 23 мм',
      ['30mm aphe cannon'] = 'Бронебойно-фугасная пушка 30 мм',
      ['380mm he cannon round'] = 'ОФ-артиллерийский выстрел 380 мм',
      ['40-k meltagun'] = '40-K Плавкопушка',
      ['40mm aphe cannon'] = 'Бронебойно-фугасная пушка 40 мм',
      ['40mm flak cannon'] = 'Зенитная пушка 40 мм',
      ['40mm he grenade'] = 'ОФ граната 40 мм',
      ['40mm he mortar'] = 'ОФ МИНОМЕТ40 мм',
      ['40mm heat grenade'] = 'Кумулятивная граната 40 мм',
      ['40mm proximity grenade'] = 'Неконтактная граната 40 мм',
      ['5,5mm. compensator'] = '5,5mm. Компенсатор',
      ['5,5mm. flash hider'] = '5,5mm. Пламегаситель',
      ['5,5mm. muzzle break'] = '5,5mm. Дульный тормоз',
      ['5.5x50mm devastator'] = 'Разрушитель 5,5x50 мм',
      ['5.5x50mm double power'] = 'Двойной мощности 5,5x50 мм',
      ['5.5x50mm explosive'] = 'Разрывные 5,5x50 мм',
      ['5.5x50mm full metal jacket'] = 'С цельнометаллической оболочкой 5,5x50 мм',
      ['5.5x50mm high velocity'] = 'Высокоскоростные 5,5x50 мм',
      ['5.5x50mm hollow-point'] = 'Экспансивные 5,5x50 мм',
      ['5.5x50mm penetrator'] = 'Проникающие 5,5x50 мм',
      ['5.5x50mm ripper'] = 'Жнец 5,5x50 мм',
      ['5.5x50mm self propelled'] = 'Самодвижущиеся 5,5x50 мм',
      ['5.5x50mm subsonic'] = 'Дозвуковые 5,5x50 мм',
      ['5.5x50mm super uranium core'] = 'С суперурановым сердечником 5,5x50 мм',
      ['500kg bomb'] = 'Бомба (500 кг)',
      ['500kg bomb mk2'] = 'Бомба Mk2 (500 кг)',
      ['500kg bomb mk3'] = 'Бомба Mk3 (500 кг)',
      ['66mm missile'] = 'Ракета 66 мм',
      ['66mm missile mk2'] = 'Ракета Mk2 66 мм',
      ['70mm laser-guided missile'] = 'Ракета с лазерным наведением 70 мм',
      ['70mm laser-guided missile mk2'] = 'Ракета с лазерным наведением Mk2 70 мм',
      ['70mm standard rocket'] = 'Стандартная ракета 70 мм',
      ['75mm heat grenade'] = 'Кумулятивная граната 75 мм',
      ['85mm heat grenade'] = 'Кумулятивная граната 85 мм',
      ['85mm heat grenade mk2'] = 'Кумулятивная граната Mk2 85 мм',
      ['85mm high-explosive grenade'] = 'Осколочно-фугасная граната 85 мм',
      ['85mm high-explosive grenade mk2'] = 'Осколочно-фугасная граната MK2 85 мм',
      ['8mm. compensator'] = '8mm. Компенсатор',
      ['8mm. flash hider'] = '8mm. Пламегаситель',
      ['8mm. muzzle break'] = '8mm. Дульный тормоз',
      ['8x60mm airburst'] = 'С подрывом в воздухе 8х60 мм',
      ['8x60mm devastator'] = 'Разрушитель 8х60 мм',
      ['8x60mm double power'] = 'Двойной мощности 8х60 мм',
      ['8x60mm explosive'] = 'Разрывные 8х60 мм',
      ['8x60mm full metal jacket'] = 'С цельнометаллической оболочкой 8х60 мм',
      ['8x60mm high velocity'] = 'Высокоскоростные 8х60 мм',
      ['8x60mm liberty fire'] = 'Огонь свободы 8х60 мм',
      ['8x60mm penetrator'] = 'Проникающие 8х60 мм',
      ['8x60mm sniper armour piercing'] = 'Снайперские бронебойные 8х60 мм',
      ['8x60mm subsonic'] = 'Дозвуковые 8х60 мм',
      ['8x60mm super uranium core'] = 'С суперурановым сердечником 8х60 мм',
      ['9mm. compensator'] = '9mm. Компенсатор',
      ['9mm. flash hider'] = '9mm. Пламегаситель',
      ['9mm. muzzle break'] = '9mm. Дульный тормоз',
      ['9x20mm explosive'] = 'Разрывные 9x20 мм',
      ['9x20mm full metal jacket'] = 'С цельнометаллической оболочкой 9x20 мм',
      ['9x20mm high velocity'] = 'Высокоскоростные 9x20 мм',
      ['9x20mm hollow point'] = 'Экспансивные 9x20 мм',
      ['9x20mm plasma'] = 'Плазменные 9x20 мм',
      ['9x20mm ripper'] = 'Жнец 9x20 мм',
      ['9x20mm thermite'] = 'Термитные 9x20 мм',
      ['9x20mm toxic'] = 'Ядовитые 9x20 мм',
      ['9x70mm full metal jacket'] = 'С цельнометаллической оболочкой 9x70 мм',
      ['9x70mm high velocity'] = 'Высокоскоростные 9x70 мм',
      ['9x70mm penetrator'] = 'Проникающие 9x70 мм',
      ['9x70mm self propelled'] = 'Самодвижущиеся 9x70 мм',
      ['9x70mm sniper armour piercing'] = 'Снайперские бронебойные 9x70 мм',
      ['9x70mm socom assassin'] = 'Спецназ «Убийца» 9x70 мм',
      ['9x70mm super uranium core'] = 'С суперурановым сердечником 9x70 мм',
      ['a/ac-8 autocannon sentry'] = 'A/AC-8 «Турель с автопушкой»',
      ['a/arc-3 tesla tower'] = 'A/ARC-3 «Тесла-башня»',
      ['a/flam-40 flame sentry'] = 'A/FLAM-40 Турель-огнемет',
      ['a/g-16 gatling sentry'] = 'A/G-16 «Турель Гатлинга»',
      ['a/gm-17 gas mortar sentry'] = 'A/GM-17 Турель с газовым минометом',
      ['a/las-98 laser sentry'] = 'A/LAS-98 Лазерная турель',
      ['a/m-12 mortar sentry'] = 'A/M-12 «Турель с минометом»',
      ['a/m-23 ems mortar sentry'] = 'A/M-23 «Турель с ЭМ-минометом»',
      ['a/mg-43 machine gun sentry'] = 'A/MG-43 «Пулеметная турель»',
      ['a/mls-4x rocket sentry'] = 'A/MLS-4X «Ракетная турель»',
      ['ac-8 autocannon'] = 'AC-8 «Автопушка»',
      ['accelerator rifle'] = 'Акселераторная винтовка',
      ['acclimated'] = 'Акклиматизированный',
      ['adjudicator'] = '«Эксперт»',
      ['adreno-defibrillator'] = 'Адрено-дефибрилятор',
      ['advanced filtration'] = 'Продвинутая фильтрация',
      ['airburst rocket launcher'] = '«Ракетница с подрывом в воздухе»',
      ['amendment'] = 'Поправка',
      ['amw-20 apex'] = 'AMW-20 «Апогей»',
      ['angled foregrip'] = 'Угловая рукоять',
      ['angled foregrip advanced'] = 'Улучшенная угловая рукоять',
      ['angled foregrip with laser'] = 'Угловая рукоять с лазерным прицелом',
      ['anti-air missile'] = 'Ракета ПВО',
      ['anti-materiel rifle'] = '«Крупнокалиберная винтовка»',
      ['anti-tank emplacement'] = 'Противотанковое орудие',
      ['anti-tank seeker'] = 'Противотанковый искатель',
      ['apex'] = '«Апогей»',
      ['apw-1 anti-materiel rifle'] = 'APW-1 «Крупнокалиберная винтовка»',
      ['ar-11 arbitrator'] = 'AR-11 Третейский судья',
      ['ar-2 coyote'] = 'AR-2 Койот',
      ['ar-23 liberator'] = 'AR-23 «Освободитель»',
      ['ar-23a liberator carbine'] = 'AR-23A Карабин «Освободитель»',
      ['ar-23c liberator concussive'] = 'AR-23C «Сотрясающий освободитель»',
      ['ar-23l liberator legacy'] = 'AR-23L «Классический освободитель»',
      ['ar-23p liberator penetrator'] = 'AR-23P «Пробойный освободитель»',
      ['ar-32 pacifier'] = 'AR-32 Усмиритель',
      ['ar-59 suppressor'] = 'AR-59 Подавитель',
      ['ar-61 tenderizer'] = 'AR-61 «Размягчитель»',
      ['ar/gl-21 one-two'] = 'AR/GL-21 Двоечка',
      ['arbitrator'] = 'Третейский судья',
      ['arc'] = 'Дуга',
      ['arc thrower'] = '«Дуговой метатель»',
      ['arc-12 blitzer'] = 'ARC-12 «Налетчик»',
      ['arc-3 arc thrower'] = 'ARC-3 «Дуговой метатель»',
      ['assault rifle'] = 'Штурмовая винтовка',
      ['autocannon'] = '«Автопушка»',
      ['autocannon sentry'] = '«Турель с автопушкой»',
      ['b-1 supply pack'] = 'B-1 «Рюкзак: боеприпасы»',
      ['b-100 portable hellbomb'] = 'B-100 Переносная Адская бомба',
      ['b/flam-80 cremator'] = 'B/FLAM-80 Крематорий',
      ['ballistic padding'] = 'Баллистическая подкладка',
      ['ballistic shield backpack'] = '«Рюкзак: баллистический щит»',
      ['bastion mk xvi'] = 'Mk-XVI «Бастион»',
      ['belt-fed grenade launcher'] = 'Ленточный гранатомет',
      ['blitzer'] = '«Налетчик»',
      ['blunt-force mitigation'] = 'Уменьшение дробящего урона',
      ['bolt pistol'] = 'Болтострел',
      ['br-14 adjudicator'] = 'BR-14 «Эксперт»',
      ['breacher'] = 'Прорывник',
      ['breaching hammer'] = 'Штурмовой молот',
      ['break-action shotgun'] = 'Дробовик-переломка',
      ['breaker'] = '«Крушитель»',
      ['breaker incendiary'] = '«Зажигательный крушитель»',
      ['breaker spray&pray'] = '«Крушитель ураган»',
      ['breakthrough exosuit'] = 'Экзокостюм «Прорыв»',
      ['bullet storm'] = '«Шквал пуль»',
      ['bushwhacker'] = '«Партизан»',
      ['caltrops'] = 'Проволочные силки',
      ['cb-9 exploding crossbow'] = 'CB-9 «Взрывной арбалет»',
      ['censor'] = 'Цензор',
      ['cluster bomb'] = 'КЛАСТЕРНАЯ БОМБА',
      ['combat hatchet'] = 'Боевой топорик',
      ['combat scope 4x'] = 'Боевой прицел (4х)',
      ['commando'] = '«Коммандос»',
      ['concussive padding (grenadier)'] = 'Противовзрывная подкладка, гренадер',
      ['concussive padding (hazmat)'] = 'Противовзрывная подкладка, химзащита',
      ['concussive padding (reinforced)'] = 'Противовзрывная подкладка, усиленная',
      ['constitution'] = '«Конституция»',
      ['contact mine'] = 'Контактная мина',
      ['cookout'] = '«Барбекю»',
      ['coyote'] = 'Койот',
      ['cqc-1 one true flag'] = 'CQC-1 Один истинный флаг',
      ['cqc-19 stun lance'] = 'CQC-19 Оглушающее копье',
      ['cqc-2 saber'] = 'CQC-2 Сабля',
      ['cqc-20 breaching hammer'] = 'CQC-20 Штурмовой молот',
      ['cqc-30 stun baton'] = 'CQC-30 Оглушающая дубинка',
      ['cqc-42 machete'] = 'CQC-42 Мачете',
      ['cqc-5 combat hatchet'] = 'CQC-5 Боевой топорик',
      ['cqc-72 entrenchment tool'] = 'CQC-72 Орудие окапывания',
      ['cqc-73 entrenchment tool'] = 'CQC-73 Орудие окапывания',
      ['cqc-9 defoliation tool'] = 'CQC-9 Дефолиатор',
      ['cremator'] = 'Крематорий',
      ['crisper'] = '«Фритюр»',
      ['dagger'] = '«Кинжал»',
      ['dbs-2 double freedom'] = 'DBS-2 Двойная свобода',
      ['de-escalator'] = 'Деэскалатор',
      ['deadeye'] = 'Меткий стрелок',
      ['defender'] = 'Защитник',
      ['defoliation tool'] = 'Дефолиатор',
      ['democracy protects'] = 'Демократия защищает',
      ['desert stormer'] = 'Пустынный штурмовик',
      ['diligence'] = '«Рвение»',
      ['diligence counter sniper'] = '«Рвение антиснайпер»',
      ['directional shield'] = 'Щит направленного действия',
      ['dominator'] = '«Угнетатель»',
      ['double freedom'] = 'Двойная свобода',
      ['double-edge sickle'] = 'Обоюдоострый серп',
      ['drum magazine'] = 'Барабанный магазин',
      ['dune walker sniper scope 10x'] = 'Снайперский прицел (10х)',
      ['dynamite'] = 'Динамит',
      ['e/at-12 anti-tank emplacement'] = 'E/AT-12 Противотанковое орудие',
      ['e/gl-21 grenadier battlement'] = 'E/GL-21 Амбразура гранатометчика',
      ['e/mg-101 hmg emplacement'] = 'E/MG-101 «Огневая позиция: тяжелый пулемет»',
      ['eagle 110mm rocket pods'] = '«Орел: 110-мм ракетные блоки»',
      ['eagle 500kg bomb'] = '«Орел: бомба (500 кг)»',
      ['eagle airstrike'] = '«Орел: воздушный налет»',
      ['eagle cluster bomb'] = '«Орел: кластерная бомба»',
      ['eagle gas airstrike'] = '«Орел: газовый налет»',
      ['eagle napalm airstrike'] = '«Орел: авиаудар напалмом»',
      ['eagle smoke strike'] = '«Орел: дымовая завеса»',
      ['eagle strafing run'] = '«Орел: бреющий полет»',
      ['eat-17 expendable anti-tank'] = 'EAT-17 «Одноразовый бронебой»',
      ['eat-411 leveller'] = 'EAT-411 Уравнитель',
      ['eat-700 expendable napalm'] = 'EAT-700 Одноразовый напалм',
      ['electrical conduit'] = 'Электропроводник',
      ['emancipator exosuit'] = 'Экзокостюм «Благодетель»',
      ['ems mortar sentry'] = '«Турель с ЭМ-минометом»',
      ['engineering kit'] = 'Инженерный комплект',
      ['entrenchment tool'] = 'Орудие окапывания',
      ['epoch'] = 'Эпоха',
      ['eruptor'] = '«Извергатель»',
      ['evictor'] = 'Вытеснитель',
      ['exo-45 patriot exosuit'] = 'EXO-45 Экзокостюм «Патриот»',
      ['exo-49 emancipator exosuit'] = 'EXO-49 Экзокостюм «Благодетель»',
      ['exo-51 lumberer exosuit'] = 'EXO-51 Экзокостюм «Лесоруб»',
      ['exo-55 breakthrough exosuit'] = 'EXO-55 Экзокостюм «Прорыв»',
      ['expendable anti-tank'] = '«Одноразовый бронебой»',
      ['expendable napalm'] = 'Одноразовый напалм',
      ['exploding crossbow'] = '«Взрывной арбалет»',
      ['extended magazine'] = 'Увеличенный магазин',
      ['extra padding'] = 'Экстра-уплотнение',
      ['faf-14 spear'] = 'FAF-14 Копье',
      ['feet first'] = 'Вперед ногами',
      ['flam-40 flamethrower'] = 'FLAM-40 «Огнемет»',
      ['flam-66 torcher'] = 'FLAM-66 «Сжигатель»',
      ['flame sentry'] = 'Турель-огнемет',
      ['flames'] = 'Горючая смесь',
      ['flames mk2'] = 'Горючая смесь Mk2',
      ['flamethrower'] = '«Огнемет»',
      ['flashlight'] = 'Фонарик',
      ['fortified'] = 'Укрепление',
      ['frag'] = '«Осколочная»',
      ['g-10 incendiary'] = 'G-10 «Зажигательная»',
      ['g-109 urchin'] = 'G-109 Озорник',
      ['g-11 caltrops'] = 'G-11 Проволочные силки',
      ['g-12 high explosive'] = 'G-12 «Фугасная»',
      ['g-123 thermite'] = 'G-123 «Термитная»',
      ['g-13 incendiary impact'] = 'G-13 Зажигательная ударная',
      ['g-142 pyrotech'] = 'G-142 Пиротех',
      ['g-16 impact'] = 'G-16 «Ударная»',
      ['g-23 stun'] = 'G-23 «Оглушающая»',
      ['g-3 smoke'] = 'G-3 «Дымовая»',
      ['g-31 arc'] = 'G-31 Дуга',
      ['g-4 gas'] = 'G-4 Газовая',
      ['g-48 giga grenade'] = 'G-48 Гигаграната',
      ['g-50 seeker'] = 'G-50 Искатель',
      ['g-6 frag'] = 'G-6 «Осколочная»',
      ['g-60 anti-tank seeker'] = 'G-60 Противотанковый искатель',
      ['g-7 pineapple'] = 'G-7 Лимонка',
      ['g-8 immolation'] = 'G-8 Испепелитель',
      ['g-89 smokescreen'] = 'G-89 Дымовая завеса',
      ['g/40-k melta mine'] = 'G/40-K Плавкомина',
      ['g/sh-39 shield'] = 'G/SH-39 Щит',
      ['gallant'] = '«Кавалер»',
      ['gas'] = 'Газовая',
      ['gas mortar sentry'] = 'Турель с газовым минометом',
      ['gatling sentry'] = '«Турель Гатлинга»',
      ['giga grenade'] = 'Гигаграната',
      ['gl-15 evictor'] = 'GL-15 Вытеснитель',
      ['gl-21 grenade launcher'] = 'GL-21 «Гранатомет»',
      ['gl-28 belt-fed grenade launcher'] = 'GL-28 Ленточный гранатомет',
      ['gl-52 de-escalator'] = 'GL-52 Деэскалатор',
      ['gp-20 ultimatum'] = 'GP-20 Ультиматум',
      ['gp-31 grenade pistol'] = 'GP-31 «Пистолет-гранатомет»',
      ['gr-8 recoilless rifle'] = 'GR-8 «Безоткатная винтовка»',
      ['grenade launcher'] = '«Гранатомет»',
      ['grenade pistol'] = '«Пистолет-гранатомет»',
      ['grenadier battlement'] = 'Амбразура гранатометчика',
      ['gunner frv'] = 'МТР «Стрелок»',
      ['gunslinger'] = 'Стрелок',
      ['halt'] = 'Стоп',
      ['heavy machine gun'] = '«Тяжелый пулемет»',
      ['high capacity heatsink'] = 'Высокоемкий радиатор',
      ['high dissipation heatsink'] = 'Высокоэффективный радиатор',
      ['high explosive'] = '«Фугасная»',
      ['high-velocity shrapnel'] = 'Высокоскоростной снаряд со шрапнелью',
      ['hmg emplacement'] = '«Огневая позиция: тяжелый пулемет»',
      ['homing anti-air missile'] = 'Самонаводящаяся ракета ПВО',
      ['homing ground missile'] = 'Самонаводящаяся ракета «воздух-земля»',
      ['homing ground missile mk2'] = 'Самонаводящаяся ракета «воздух-земля» Mk2',
      ['hot-shot marksman rifle'] = 'Марксманская винтовка «Лихач»',
      ['hover pack'] = 'Ранец для парения',
      ['hyena'] = 'Гиена',
      ['immolation'] = 'Испепелитель',
      ['impact'] = '«Ударная»',
      ['incendiary'] = '«Зажигательная»',
      ['incendiary impact'] = 'Зажигательная ударная',
      ['incinerator frv'] = 'Огнеметная МТР',
      ['inflammable'] = 'Огнеопасный',
      ['integrated explosives'] = 'Встроенная взрывчатка',
      ['iron sights'] = 'Механический прицел',
      ['jar-5 dominator'] = 'JAR-5 «Угнетатель»',
      ['jump pack'] = '«Реактивный ранец»',
      ['k-2 throwing knife'] = 'K-2 Метательный нож',
      ['kinetic displacement mitigation'] = 'Кинетическое демпфирование',
      ['knight'] = 'Рыцарь',
      ['large plasma bolt'] = 'Большой заряд плазмы',
      ['larger plasma container'] = 'Увеличенный контейнер для плазмы',
      ['las-12 sai'] = 'LAS-12 Сай',
      ['las-13 trident'] = 'LAS-13 «Трезубец»',
      ['las-16 sickle'] = 'LAS-16 «Серп»',
      ['las-17 double-edge sickle'] = 'LAS-17 Обоюдоострый серп',
      ['las-22 shear'] = 'LAS-22 Ножницы',
      ['las-44 nova'] = 'LAS-44 «Нова»',
      ['las-5 scythe'] = 'LAS-5 «Коса»',
      ['las-58 talon'] = 'LAS-58 Коготь',
      ['las-7 dagger'] = 'LAS-7 «Кинжал»',
      ['las-98 laser cannon'] = 'LAS-98 «Лазерная пушка»',
      ['las-99 quasar cannon'] = 'LAS-99 Пушка «Квазар»',
      ['laser'] = 'Лазер',
      ['laser cannon'] = '«Лазерная пушка»',
      ['laser sentry'] = 'Лазерная турель',
      ['laser sight'] = 'Лазерный прицел',
      ['laser sight flashlight'] = 'Лазерный прицел с фонариком',
      ['laser. standard prism'] = 'Стандартная призма',
      ['leveller'] = 'Уравнитель',
      ['liberator'] = '«Освободитель»',
      ['liberator carbine'] = 'Карабин «Освободитель»',
      ['liberator concussive'] = '«Сотрясающий освободитель»',
      ['liberator legacy'] = '«Классический освободитель»',
      ['liberator penetrator'] = '«Пробойный освободитель»',
      ['lift-182 warp pack'] = 'LIFT-182 Варп-ранец',
      ['lift-850 jump pack'] = 'LIFT-850 «Реактивный ранец»',
      ['lift-860 hover pack'] = 'LIFT-860 Ранец для парения',
      ['loyalist'] = 'Верный',
      ['lumberer exosuit'] = 'Экзокостюм «Лесоруб»',
      ['lure mine'] = 'Мина-приманка',
      ['m-1000 maxigun'] = 'M-1000 Максиган',
      ['m-102 gunner frv'] = 'M-102 МТР «Стрелок»',
      ['m-103 supply frv'] = 'M-103 МТР снабжения',
      ['m-104 incinerator frv'] = 'M-104 Огнеметная МТР',
      ['m-105 stalwart'] = 'M-105 «Доблесть»',
      ['machete'] = 'Мачете',
      ['machine gun'] = '«Пулемет»',
      ['machine gun sentry'] = '«Пулеметная турель»',
      ['maelstrom'] = 'Водоворот',
      ['maxigun'] = 'Максиган',
      ['med-kit'] = 'Аптечка',
      ['medium plasma bolt'] = 'Средний заряд плазмы',
      ['melta mine'] = 'Плавкомина',
      ['meltagun'] = 'Плавкопушка',
      ['mg-206 heavy machine gun'] = 'MG-206 «Тяжелый пулемет»',
      ['mg-43 machine gun'] = 'MG-43 «Пулемет»',
      ['mgx-42 bullet storm'] = 'MGX-42 «Шквал пуль»',
      ['missile pistol'] = 'Ракетный пистолет',
      ['mist'] = '«Дымка»',
      ['mls-4x commando'] = 'MLS-4X «Коммандос»',
      ['mortar sentry'] = '«Турель с минометом»',
      ['mp-98 knight'] = 'MP-98 Рыцарь',
      ['ms-11 solo silo'] = 'MS-11 Одиночная пусковая шахта',
      ['napalm bomb'] = 'Напалмовая бомба',
      ['napalm bomb mk2'] = 'Напалмовая бомба Mk2',
      ['napalm bomb mk3'] = 'Напалмовая бомба Mk3',
      ['nova'] = '«Нова»',
      ['nuke'] = 'Ядерная бомба',
      ['ombudsman'] = 'Омбудсмен',
      ['one true flag'] = 'Один истинный флаг',
      ['one-two'] = 'Двоечка',
      ['orbital 120mm he barrage'] = '«Орбитальный залп 120-мм ОФ»',
      ['orbital 380mm he barrage'] = '«Орбитальный залп 380-мм ОФ»',
      ['orbital airburst strike'] = '«Орбитальная воздушная бомба»',
      ['orbital ems strike'] = '«Орбитальный ЭМ-удар»',
      ['orbital gas strike'] = '«Орбитальный газовый удар»',
      ['orbital gatling barrage'] = '«Орбитальный залп Гатлинга»',
      ['orbital laser'] = '«Орбитальный лазер»',
      ['orbital napalm barrage'] = '«Орбитальный удар напалмом»',
      ['orbital precision strike'] = '«Орбитальный высокоточный удар»',
      ['orbital railcannon strike'] = '«Орбитальный рельсотронный залп»',
      ['orbital smoke strike'] = '«Орбитальная дымовая завеса»',
      ['orbital walking barrage'] = '«Орбитальный огневой вал»',
      ['oxygenator'] = 'Аэратор',
      ['p-11 stim pistol'] = 'P-11 Стим-пистолет',
      ['p-113 verdict'] = 'P-113 «Вердикт»',
      ['p-19 redeemer'] = 'P-19 «Избавитель»',
      ['p-2 peacemaker'] = 'P-2 «Миротворец»',
      ['p-33 missile pistol'] = 'P-33 Ракетный пистолет',
      ['p-34 breacher'] = 'P-34 Прорывник',
      ['p-35 re-educator'] = 'P-35 Реформатор',
      ['p-4 senator'] = 'P-4 Сенатор',
      ['p-41 ombudsman'] = 'P-41 Омбудсмен',
      ['p-44 mist'] = 'P-44 «Дымка»',
      ['p-69 veto'] = 'P-69 Вето',
      ['p-72 crisper'] = 'P-72 «Фритюр»',
      ['p-92 warrant'] = 'P-92 Ордер',
      ['p/40-k bolt pistol'] = 'P/40-K Болтострел',
      ['pacifier'] = 'Усмиритель',
      ['patriot exosuit'] = 'Экзокостюм «Патриот»',
      ['peacemaker'] = '«Миротворец»',
      ['peak physique'] = 'Пик формы',
      ['pineapple'] = 'Лимонка',
      ['plas-1 scorcher'] = 'PLAS-1 «Поджигатель»',
      ['plas-101 purifier'] = 'PLAS-101 «Очиститель»',
      ['plas-15 loyalist'] = 'PLAS-15 Верный',
      ['plas-39 accelerator rifle'] = 'PLAS-39 Акселераторная винтовка',
      ['plas-45 epoch'] = 'PLAS-45 Эпоха',
      ['portable hellbomb'] = 'Переносная Адская бомба',
      ['punisher'] = '«Каратель»',
      ['punisher plasma'] = '«Плазменный каратель»',
      ['purifier'] = '«Очиститель»',
      ['pyrotech'] = 'Пиротех',
      ['quasar cannon'] = 'Пушка «Квазар»',
      ['r-2 amendment'] = 'R-2 Поправка',
      ['r-2124 constitution'] = 'R-2124 «Конституция»',
      ['r-36 eruptor'] = 'R-36 «Извергатель»',
      ['r-4 hyena'] = 'R-4 Гиена',
      ['r-40 sightliner'] = 'R-40 «Целенаводчик»',
      ['r-6 deadeye'] = 'R-6 Меткий стрелок',
      ['r-63 diligence'] = 'R-63 «Рвение»',
      ['r-63cs diligence counter sniper'] = 'R-63CS «Рвение антиснайпер»',
      ['r-72 censor'] = 'R-72 Цензор',
      ['r/40-k hot-shot marksman rifle'] = 'R/40-K Марксманская винтовка «Лихач»',
      ['rail cannon round'] = 'Выстрел рельсотрона',
      ['railgun'] = '«Рельсотрон»',
      ['railgun round'] = 'Снаряд рельсотрона',
      ['railgun stun round'] = 'Оглушающий снаряд рельсотрона',
      ['rapid heatsink'] = 'Быстрый радиатор',
      ['re-educator'] = 'Реформатор',
      ['recoilless rifle'] = '«Безоткатная винтовка»',
      ['redeemer'] = '«Избавитель»',
      ['reduced signature'] = 'Уменьшенный след',
      ['reinforced epaulettes'] = 'Армированные эполеты',
      ['reprimand'] = 'Взыскание',
      ['rl-77 airburst rocket launcher'] = 'RL-77 «Ракетница с подрывом в воздухе»',
      ['rock solid'] = 'Кремень',
      ['rocket sentry'] = '«Ракетная турель»',
      ['rs-422 railgun'] = 'RS-422 «Рельсотрон»',
      ['s-11 speargun'] = 'S-11 Гарпун',
      ['sai'] = 'Сай',
      ['scorcher'] = '«Поджигатель»',
      ['scout'] = 'Разведчик',
      ['scythe'] = '«Коса»',
      ['secondary'] = 'дополнительное',
      ['seeker'] = 'Искатель',
      ['senator'] = 'Сенатор',
      ['servo-assisted'] = 'Сервопривод',
      ['sg-20 halt'] = 'SG-20 Стоп',
      ['sg-22 bushwhacker'] = 'SG-22 «Партизан»',
      ['sg-225 breaker'] = 'SG-225 «Крушитель»',
      ['sg-225ie breaker incendiary'] = 'SG-225IE «Зажигательный крушитель»',
      ['sg-225sp breaker spray&pray'] = 'SG-225SP «Крушитель ураган»',
      ['sg-451 cookout'] = 'SG-451 «Барбекю»',
      ['sg-8 punisher'] = 'SG-8 «Каратель»',
      ['sg-88 break-action shotgun'] = 'SG-88 Дробовик-переломка',
      ['sg-8p punisher plasma'] = 'SG-8P «Плазменный каратель»',
      ['sg-8s slugger'] = 'SG-8S «Крушила»',
      ['sg-97 sweeper'] = 'SG-97 Чистильщик',
      ['sh-20 ballistic shield backpack'] = 'SH-20 «Рюкзак: баллистический щит»',
      ['sh-32 shield generator pack'] = 'SH-32 «Генератор щита»',
      ['sh-51 directional shield'] = 'SH-51 Щит направленного действия',
      ['shear'] = 'Ножницы',
      ['shield'] = 'Щит',
      ['shield generator pack'] = '«Генератор щита»',
      ['short magazine'] = 'Короткий магазин',
      ['shrapnel'] = 'Шрапнель',
      ['sickle'] = '«Серп»',
      ['siege-ready'] = 'К осаде готов',
      ['sightliner'] = '«Целенаводчик»',
      ['slugger'] = '«Крушила»',
      ['small plasma bolt'] = 'Малый заряд плазмы',
      ['smg'] = 'ПИСТОЛЕТ-ПУЛЕМЕТ',
      ['smg-203 gallant'] = 'SMG-203 «Кавалер»',
      ['smg-32 reprimand'] = 'SMG-32 Взыскание',
      ['smg-37 defender'] = 'SMG-37 Защитник',
      ['smg-72 pummeler'] = 'SMG-72 «Трамбовщик»',
      ['smg/flam-34 stoker'] = 'SMG/FLAM-34 Топка',
      ['smoke'] = '«Дымовая»',
      ['smokescreen'] = 'Дымовая завеса',
      ['sniper scope 10x'] = 'Снайперский прицел (10х)',
      ['sniper scope 10x helghast'] = 'Снайперский прицел (10х)',
      ['solo silo'] = 'Одиночная пусковая шахта',
      ['spear'] = 'Копье',
      ['speargun'] = 'Гарпун',
      ['sta-11 smg'] = 'StA-11 Пистолет-пулемет',
      ['sta-52 assault rifle'] = 'StA-52 Штурмовая винтовка',
      ['sta-x3 w.a.s.p. launcher'] = 'StA-X3 Ракетомет W.A.S.P.',
      ['stalwart'] = '«Доблесть»',
      ['standard drum'] = 'Стандартный барабанный магазин',
      ['standard heatsink'] = 'Стандартный радиатор',
      ['standard plasma container'] = 'Стандартный контейнер для плазмы',
      ['stationary shroud'] = 'Неподвижный покров',
      ['stim pistol'] = 'Стим-пистолет',
      ['stoker'] = 'Топка',
      ['stun'] = '«Оглушающая»',
      ['stun baton'] = 'Оглушающая дубинка',
      ['stun lance'] = 'Оглушающее копье',
      ['supplementary adrenaline'] = 'Добавки-адреналин',
      ['supply frv'] = 'МТР снабжения',
      ['supply pack'] = '«Рюкзак: боеприпасы»',
      ['support'] = 'поддержка',
      ['suppressor'] = 'Подавитель',
      ['sweeper'] = 'Чистильщик',
      ['talon'] = 'Коготь',
      ['td-110 maelstrom'] = 'TD-110 Водоворот',
      ['td-220 bastion mk xvi'] = 'TD-220 Mk-XVI «БАСТИОН»',
      ['ted-63 dynamite'] = 'TED-63 Динамит',
      ['tenderizer'] = '«Размягчитель»',
      ['tesla tower'] = '«Тесла-башня»',
      ['thermite'] = '«Термитная»',
      ['throwing knife'] = 'Метательный нож',
      ['tm-1 lure mine'] = 'TM-1 Мина-приманка',
      ['torcher'] = '«Сжигатель»',
      ['true grit'] = 'Железная хватка',
      ['tube reddot 2x'] = 'Трубчатый коллиматор (2x)',
      ['tx-41 sterilizer'] = 'TX-41 Стерилизатор',
      ['ultimatum'] = 'Ультиматум',
      ['unflinching'] = 'Непоколебимый',
      ['urchin'] = 'Озорник',
      ['variable'] = 'Изменяемый',
      ['verdict'] = '«Вердикт»',
      ['vertical grip'] = 'Вертикальная рукоять',
      ['vertical grip 45 degree'] = 'Вертикальная рукоять под 45 градусов',
      ['vertical grip advanced'] = 'Улучшенная вертикальная рукоять',
      ['veto'] = 'Вето',
      ['vg-70 variable'] = 'VG-70 Изменяемый',
      ['volatile plasma bolt'] = 'Заряд нестабильной плазмы',
      ['w.a.s.p. launcher'] = 'Ракетомет W.A.S.P.',
      ['warp pack'] = 'Варп-ранец',
      ['warrant'] = 'Ордер',
    },
    patterns = {
      { '^(.-) SHRAPNEL$', '%1: ОСКОЛКИ' },
      { '^(.-) EXPLOSION ID$', '%1: ID ВЗРЫВА' },
      { '^projectile (%d+) %(not in this game build%)$', 'снаряд %1 (нет в этой сборке игры)' },
      { '^explosion (%d+) %(not in this game build%)$', 'взрыв %1 (нет в этой сборке игры)' },
      { '^No explosion (.+) in the game%.$', 'В игре нет взрыва %1.' },
      { '^each piece is (.+)$', 'каждый осколок: %1' },
      { '^sets off: (.+)$', 'вызывает: %1' },
      { '^Set off by: (.+)$', 'Срабатывает от: %L1' },
      { '^Fired by: (.+)$', 'Стреляет: %L1' },
      { '^(%*? ?)Status #(%d+)$', '%1Статус #%2' },
      { '^(%*? ?)Status #(%d+) · (.+)$', '%1Статус #%2 · %3' },
      { '^(%*? ?)Explosion #(%d+)$', '%1Взрыв #%2' },
      { '^(%*? ?)Explosion #(%d+) · (.+)$', '%1Взрыв #%2 · %3' },
      { '^(%*? ?)Projectile #(%d+)$', '%1Снаряд #%2' },
      { '^(%*? ?)Projectile #(%d+) · (.+)$', '%1Снаряд #%2 · %3' },
      { '^Your values are installed %((%d+) game files%)%. Close the game before installing%.$', 'Ваши значения установлены (файлов игры: %1). Перед установкой закрывайте игру.' },
      { '^Installing: preparing (.+) %((%d+) of (%d+)%)%.%.%.$', 'Установка: подготовка %1 (%2 из %3)...' },
      { '^Not installed: (.+) could not be prepared %((.+)%)%. Nothing was changed%.$', 'Не установлено: не удалось подготовить %1 (%2). Ничего не изменено.' },
      { '^Not installed: (.+)$', 'Не установлено: %1' },
      { '^Installed %((%d+) game files changed%)%. Start the game to play with your values%.$', 'Установлено (изменено файлов игры: %1). Запустите игру, чтобы играть с вашими значениями.' },
      { '^Installed %((%d+) game files changed, (%d+) back to the original%)%. Start the game to play with your values%.$', 'Установлено (изменено файлов игры: %1, возвращено исходных: %2). Запустите игру, чтобы играть с вашими значениями.' },
      { '^Not restored: (.+)$', 'Не возвращено: %1' },
      { '^Update failed: (.+)%. The release page has it: (.+)$', 'Обновление не удалось: %1. Его можно скачать на странице релиза: %2' },
      { '^Update failed: (.+)%. Nothing was changed%.$', 'Обновление не удалось: %1. Ничего не изменено.' },
      { '^Update to (.+)$', 'Обновить до %1' },
      { '^Updating: downloading (.+)%.%.%.$', 'Обновление: загрузка %1...' },
      { '^Updating: installing (.+)%.%.%.$', 'Обновление: установка %1...' },
      { '^Updated to (.+)%.$', 'Обновлено до %1.' },
      { '^Add a passive to (.+)$', 'Добавить пассивный эффект к %1' },
      { '^Not installed: the armor passives could not be stacked %((.+)%)%. Nothing was changed%.$', 'Не установлено: не удалось объединить пассивные эффекты брони (%1). Ничего не изменено.' },
      { '^Heat level (%d+)$', 'Уровень нагрева %1' },
      { '^(.+); ammo type shared with (.+)$', '%1; тип боеприпасов общий с: %L2' },
      { '^fires: (.+)%. The rows above stay its own$', 'стреляет: %1. Строки выше остаются его собственными' },
      { '^fires: (.+)$', 'стреляет: %1' },
      { '^loading: (.+)$', 'загрузка: %1' },
      { '^projectile (%d+)$', 'снаряд %1' },
      { '^Preset (%d+)$', 'Пресет %1' },
      { '^Saved (.+) preset (%d+) %((%d+) changed value%(s%)%)$', 'Сохранен пресет %2 для %1 (изменено значений: %3)' },
      { '^(.+) preset (%d+) is empty$', 'Пресет %2 для %1 пуст' },
      { '^Loaded (.+) preset (%d+) %((%d+) value%(s%) not applied%)$', 'Загружен пресет %2 для %1 (не применено значений: %3)' },
      { '^Loaded (.+) preset (%d+)$', 'Загружен пресет %2 для %1' },
      { '^Cleared (.+) preset (%d+)$', 'Очищен пресет %2 для %1' },
      { '^Empty name: kept "(.+)"$', 'Пустое имя: оставлено «%1»' },
      { '^Named it "(.+)"$', 'Назван «%1»' },
      { '^All (%d+) presets are in use: delete one first$', 'Все пресеты (%1) заняты: сначала удалите один' },
      { '^Saved (%d+) changed value%(s%) as a new preset%. Type its name, Enter keeps it%.$', 'Сохранено изменений: %1, как новый пресет. Введите имя, Enter — сохранить.' },
      { '^Saved (%d+) changed value%(s%) into "(.+)"$', 'Сохранено изменений: %1, в «%2»' },
      { '^Loaded "(.+)" %((%d+) value%(s%) not applied%)$', 'Загружен «%1» (не применено значений: %2)' },
      { '^Loaded "(.+)"$', 'Загружен «%1»' },
      { '^Deleted "(.+)"$', 'Удален «%1»' },
      { '^Again to overwrite "(.+)"$', 'Еще раз — перезаписать «%1»' },
      { '^Again to delete "(.+)"$', 'Еще раз — удалить «%1»' },
      { '^PgUp/PgDn change weapon, Del resets, Ctrl%+1%-5 loads a weapon preset, Ctrl%+Shift%+1%-5 saves one; (%d+) value%(s%) changed%.$', 'PgUp/PgDn — смена оружия, Del — сброс, Ctrl+1-5 — загрузить пресет оружия, Ctrl+Shift+1-5 — сохранить; изменено значений: %1.' },
      { '^Overwriting and deleting ask twice%. Changes apply at once and are saved; (%d+) value%(s%) changed%.$', 'Перезапись и удаление требуют подтверждения. Изменения применяются сразу и сохраняются; изменено значений: %1.' },
      { '^The panel now opens and closes with (.+)%.$', 'Теперь панель открывается и закрывается клавишей %1.' },
      { '^Saved as StatEditor\\preset_(%d+)%.txt %(copy it to share the set%)%.$', 'Сохранено как StatEditor\\preset_%1.txt (скопируйте файл, чтобы поделиться набором).' },
      { '^No grenade choice (.+) in this game build%.$', 'В этой версии игры нет гранаты под номером %1.' },
      { '^No projectile (.+) in the game%.$', 'В игре нет снаряда %1.' },
      { '^Now changed: (%d+) value%(s%)%. Loading a preset replaces every current change with it%.$', 'Сейчас изменено значений: %1. Загрузка пресета заменит все текущие изменения.' },
      { '^unknown (.+)$', 'неизвестно: %1' },
      { '^was (.+)$', 'было %1' },
      { '^(.+) to open/close$', '%1 — открыть/закрыть' },
      { '^rows (%d+)%-(%d+) of (%d+)$', 'строки %1-%2 из %3' },
      { '^Above (%d+)%% heat$', 'Нагрев выше %1%' },
      { '^ABOVE (%d+)%% HEAT$', 'НАГРЕВ ВЫШЕ %1%' },
      { '^Fire rate (%d+) %(RPM%)$', 'Скорострельность %1 (выстр./мин)' },
      { '^Modifier (%x+)$', 'Модификатор %1' },
      { '^(.+) %(SEAF%)$', '%1 (ВССЗ)' },
      { '^The (.+) SEAF soldiers carry%. Not yours%.$', '%1 солдат ВССЗ. Не ваш.' },
      { '^(.+): in the game files, not offered by it%.$', '%L1: есть в файлах игры, но не в самой игре.' },
      { '^shared with (.+) %+(%d+)$', 'общее с: %L1 и еще %2' },
      { '^shared with (.+)$', 'общее с: %L1' },
      { '^Reading the game\'s weapon tables%.%.%. %((%d+) of (%d+) found%)$', 'Чтение таблиц оружия игры... (найдено %1 из %2)' },
      { '^(%d+)%-(%d+) of (%d+) found$', '%1-%2 из %3 найденных' },
      { '^(%d+) found$', 'найдено: %1' },
      { '^(%d+)%-(%d+) of (%d+) listed$', '%1-%2 из %3' },
      { '^(%d+) listed$', 'всего: %1' },
      { '^(%d+)%-(%d+) of (%d+) %(max (%d+)%)$', '%1-%2 из %3 (макс. %4)' },
      { '^(%d+) %(max (%d+)%)$', '%1 (макс. %2)' },
      { '^(%d+) value%(s%) for (%d+) weapon%(s%) / stratagem%(s%):$', 'Значений: %1, оружия и стратагем: %2:' },
      { '^(%d+) value%(s%)$', 'значений: %1' },
      { '^On: your (%d+) change%(s%) are applied%.$', 'Вкл: ваши изменения применены (%1).' },
      { '^Off: the game\'s values everywhere; your (%d+) change%(s%) are kept for when you turn them on%.$', 'Выкл: везде значения игры; ваши изменения (%1) сохранены до включения.' },
      { '^%(untested%) Other players are in your game: arc chain length / split use the game\'s values%.$', '(не проверено) В вашей игре другие игроки: длина и разветвление цепи дуги берутся из игры.' },
      { '^%(untested%) On: your arc chain length / split apply with other players too %(arcs can stay on screen%)%.$', '(не проверено) Вкл: ваши длина и разветвление цепи дуги действуют и с другими игроками (дуги могут оставаться на экране).' },
      { '^%(untested%) Off: with other players, arc chain length / split use the game\'s values %(else arcs can stay on screen%)%.$', '(не проверено) Выкл: с другими игроками длина и разветвление цепи дуги берутся из игры (иначе дуги могут оставаться на экране).' },
      { '^%(untested%) Arc chains: player count unavailable: .+; your values stay%.$', '(не проверено) Цепи дуги: число игроков недоступно; ваши значения сохраняются.' },
      { '^Also changes %((%d+)%):$', 'Также меняет (%1):' },
      { '^%+ (%d+) more$', '+ еще %1' },
      { '^%+(%d+) more$', '+еще %1' },
      { '^(.+) applied per hit$', '%1 за попадание' },
      { '^(.+) applied per blast$', '%1 за взрыв' },
      { '^(.+) duration %(s%)$', '%1: длительность (с)' },
      { '^every (.+) source shares these %(other weapons, strikes, hazards, enemies%)$', 'общее для всех источников (%1): другое оружие, удары, опасности, враги' },
      { '^every (.+) source shares this %(other weapons, grenades, strikes%)$', 'общее для всех источников (%1): другое оружие, гранаты, удары' },
      { '^explosion: also the (.+)\'s$', 'взрыв общий с: %1' },
      { '^damage: the same as the (.+)\'s %(above%)$', 'урон как у (выше): %1' },
      { '^also the (.+)\'s damage$', 'урон общий с: %1' },
      { '^direct hit: also the (.+) shot\'s$', 'прямое попадание общее с выстрелом: %1' },
      { '^direct hit: see the (.+) shot$', 'прямое попадание: см. выстрел (%1)' },
      { '^Stage (%d+) charge time %(s%)$', 'Этап %1: время зарядки (с)' },
      { '^Stage (%d+)$', 'Этап %1' },
      { '^(.+) multiplier, min charge$', 'Множитель (%1), мин. заряд' },
      { '^(.+) multiplier, overcharge$', 'Множитель (%1), перезаряд' },
      { '^(.+), min charge$', '%1, мин. заряд' },
      { '^(.+), overcharge$', '%1, перезаряд' },
      { '^(.+) durable$', '%1: прочность' },
      { '^(.+) health$', '%1: здоровье' },
      { '^(.+) armor$', '%1: броня' },
      { '^(.+) damage$', '%1: урон' },
      { '^Guard Dog backpack: the drone and the gun it carries%. (.+)$', 'Рюкзак «Сторожевой пес»: дрон и его оружие. %1' },
      { '^(.+) stratagem %((.+)%)%.$', 'Стратагема: %1 (%2).' },
      { '^Mounted on the (.+), (.+)%.$', 'Установлено на: %1, %2.' },
      { '^Mounted on the (.+)%.$', 'Установлено на: %1.' },
      { '^(.+): Left arm$', '%1: левая рука' },
      { '^(.+): Right arm$', '%1: правая рука' },
      { '^(.+): Main gun$', '%1: основное орудие' },
      { '^(.+): Driver gun$', '%1: орудие водителя' },
      { '^(.+): Turret$', '%1: турель' },
      { '^(.+): Gun$', '%1: орудие' },
      { '^(.+): Rack$', '%1: стойка' },
      { '^(.+): Weapon (%d+)$', '%1: оружие %2' },
      { '^(.+), ([A-Z][^%.,;:]+)%.$', '%1, %2.' },
      { '^Muzzle brake %((.+)%)$', 'Дульный тормоз (%1)' },
      { '^Muzzle%. Only the (.+) comes with it%.$', 'Дуло. Есть только у: %1.' },
      { '^(.+)%. Its modifiers apply to every weapon fitted with it%.$', '%1. Его модификаторы действуют на все оружие, где он установлен.' },
      { '^(.+)%. Its modifiers apply to every weapon loaded with it%.$', '%1. Его модификаторы действуют на все оружие, заряженное им.' },
      { '^(.+) %(alternate%)$', '%1 (альтернативный)' },
      { '^Rounds per (.+) %(empty%)$', 'Патронов: %1 (в пустое оружие)' },
      { '^Demolition force, stage (%d+)$', 'Сила разрушения, этап %1' },
      { '^Demolition force to destroy it %(direct hits%)$', 'Сила разрушения для уничтожения (прямые попадания)' },
      { '^Demolition force to destroy it$', 'Сила разрушения для уничтожения' },
      { '^Status (%d+)$', 'Статус %1' },
      { '^Passive (%d+)$', 'Пассивный эффект %1' },
      { '^Stat (%d+)$', 'Параметр %1' },
      { '^Part (%d+)$', 'Часть %1' },
      { '^Weapon (%d+)$', 'Оружие %1' },
    },
    prefix = {
      { 'PgUp/PgDn change weapon, Del resets, Ctrl+1-5 loads a weapon preset, Ctrl+Shift+1-5 saves one; ', 'PgUp/PgDn — смена оружия, Del — сброс, Ctrl+1-5 — загрузить пресет оружия, Ctrl+Shift+1-5 — сохранить; ' },
      { 'Overwriting and deleting ask twice. Changes apply at once and are saved; ', 'Перезапись и удаление требуют подтверждения. Изменения применяются сразу и сохраняются; ' },
      { 'The panel now opens and closes with ', 'Теперь панель открывается и закрывается клавишей ' },
      { 'Saved as StatEditor\\preset_', 'Сохранено как StatEditor\\preset_' },
      { 'Arc chains: player count ', 'Цепи дуги: число игроков ' },
      { 'No grenade choice ', 'Нет гранаты под номером ' },
      { 'No projectile ', 'Нет снаряда ' },
      { 'Also changes (', 'Также меняет (' },
      { 'Now changed: ', 'Сейчас изменено: ' },
      { '(untested) ', '(не проверено) ' },
      { 'unknown ', 'неизвестно: ' },
      { 'was ', 'было ' },
    },
    suffix = {
      { ' value(s). Loading a preset replaces every current change with it.', ' знач. Загрузка пресета заменит все текущие изменения.' },
      { ' change(s) are kept for when you turn them on.', ' изм. сохранены до включения.' },
      { ': in the game files, not offered by it.', ': есть в файлах игры, но не в самой игре.' },
      { '.txt (copy it to share the set).', '.txt (скопируйте файл, чтобы поделиться набором).' },
      { ' weapon(s) / stratagem(s):', ' оружия и стратагем:' },
      { ' change(s) are applied.', ' изм. применены.' },
      { '; your values stay.', '; ваши значения сохраняются.' },
      { ' value(s) changed.', ' знач. изменено.' },
      { ' charge time (s)', ': время зарядки (с)' },
      { ' to open/close', ' — открыть/закрыть' },
      { ', min charge', ', мин. заряд' },
      { ', overcharge', ', перезаряд' },
      { ' value(s)', ' знач.' },
      { ' found)', ' найдено)' },
      { ' listed', ' всего' },
      { ' found', ' найдено' },
      { ' more', ' еще' },
    },
  },
}
if rawget(_G, MOD.global) then return end

-- Weapons: name, loadout slot, entity hash (from HD2Runtime's capability catalogs), variant note,
-- projectile set by the default attachments (when they set one).
local WEAPONS = {
    { 'AR-11 Arbitrator', 'Primary', 'A8A91EB54892B6B2', 'The rifle you carry. The underbarrel shotgun is listed separately.' },
    { 'AR-11 Arbitrator (underbarrel shotgun)', 'Primary', 'B9C209B4F99B5335', 'The Arbitrator\'s underbarrel shotgun, not the rifle itself.' },
    { 'AR-2 Coyote', 'Primary', '84354339522C932D', '' },
    { 'AR-23 Liberator', 'Primary', '968211C0033DCE64', '' },
    { 'AR-23A Liberator Carbine', 'Primary', 'A7EE1EBF58FCDF1F', '' },
    { 'AR-23C Liberator Concussive', 'Primary', 'CF5F176E0E322BE1', '' },
    { 'AR-23L Liberator Legacy', 'Primary', 'B80951732A5F58F4', '' },
    { 'AR-23P Liberator Penetrator', 'Primary', '43CB1033961A2276', '' },
    { 'AR-32 Pacifier', 'Primary', 'BC29613666DF696B', '' },
    { 'AR-59 Suppressor', 'Primary', '708EA298C82093D0', '' },
    { 'AR-61 Tenderizer', 'Primary', 'CE063AA33D95A812', '' },
    { 'AR/GL-21 One-Two', 'Primary', 'A955C4EA6F6D4203', 'The rifle you carry. The grenade launcher is listed separately.' },
    { 'AR/GL-21 One-Two (grenade launcher)', 'Primary', '02CD7321CD8445F5', 'The One-Two\'s underbarrel launcher, not the rifle. Fires the GP-31\'s grenade.' },
    { 'ARC-12 Blitzer', 'Primary', '076DD5D4F4360204', '' },
    { 'BR-14 Adjudicator', 'Primary', '5FECAB819F96A3E8', '' },
    { 'CB-9 Exploding Crossbow', 'Primary', 'F49227A0630A3F7F', '' },
    { 'DBS-2 Double Freedom', 'Primary', '72170A55A1F37FF1', '' },
    { 'FLAM-66 Torcher', 'Primary', '4FB0F8C02F55C82B', '' },
    { 'GL-15 Evictor', 'Primary', '006E44327BB953FE', '' },
    { 'JAR-5 Dominator', 'Primary', '80F1A156D9FA1E36', '' },
    { 'LAS-12 Sai', 'Primary', 'C85F576D5E086147', '' },
    { 'LAS-13 Trident', 'Primary', '3C86E871923F3970', '' },
    { 'LAS-16 Sickle', 'Primary', '8645F167B3C813A2', '' },
    { 'LAS-17 Double-Edge Sickle', 'Primary', '295BEB26DC4F8FF1', '' },
    { 'LAS-22 Shear', 'Primary', '7E3145A5BAA4B948', 'Not offered by the game: a laser built on the Scythe. Settings: Unlock LAS-22 Shear.' },
    { 'LAS-5 Scythe', 'Primary', '27EE1ED8F6FB6356', 'The Scythe you carry.' },
    { 'M7S SMG', 'Primary', 'BE70EE0D8D44028E', '' },
    { 'M90A Shotgun', 'Primary', '90DDC374F4E3D756', '' },
    { 'MA5C Assault Rifle', 'Primary', '4DBD74F49C8FFC13', '' },
    { 'MP-98 Knight', 'Primary', '9571CA51F0DAF35B', '' },
    { 'PLAS-1 Scorcher', 'Primary', 'EEA5E3CEF1E12C14', '' },
    { 'PLAS-101 Purifier', 'Primary', 'FB3A19078694708A', '' },
    { 'PLAS-39 Accelerator Rifle', 'Primary', '30061F91AF477F5E', '' },
    { 'R-2 Amendment', 'Primary', '0F83639AB8C86165', '' },
    { 'R-2124 Constitution', 'Primary', '7B75E5132FFD4CA6', '' },
    { 'R-36 Eruptor', 'Primary', 'B6AFF2195568767F', '' },
    { 'R-4 Hyena', 'Primary', 'E5796355A8FD67E0', '' },
    { 'R-40 Sightliner', 'Primary', '41F2DEF484634B59', '' },
    { 'R-6 Deadeye', 'Primary', 'E6D932BE83729076', '' },
    { 'R-63 Diligence', 'Primary', '03E67A19B07C6523', '' },
    { 'R-63CS Diligence Counter Sniper', 'Primary', '4C786785C79D44E7', '' },
    { 'R-72 Censor', 'Primary', 'F0338468DCDB6A6C', '' },
    { 'R/40-K Hot-Shot Marksman Rifle', 'Primary', '1ABBFF60D26BA391', '' },
    { 'SG-20 Halt', 'Primary', '4E310B1FE4C52B52', '' },
    { 'SG-225 Breaker', 'Primary', '46183B50961D1328', '' },
    { 'SG-225IE Breaker Incendiary', 'Primary', 'C12A34F375BD5A87', '' },
    { 'SG-225SP Breaker Spray&Pray', 'Primary', '5EBAEA70C0D060B9', '' },
    { 'SG-451 Cookout', 'Primary', 'D323DE60855898AC', '' },
    { 'SG-8 Punisher', 'Primary', '41EAC4A03987FAA0', '' },
    { 'SG-8P Punisher Plasma', 'Primary', '05D8D8C073B9D502', '' },
    { 'SG-8S Slugger', 'Primary', '4F749E2EE26F532D', '' },
    { 'SG-97 Sweeper', 'Primary', 'DCD1C835407EF7BA', '' },
    { 'SMG-203 Gallant', 'Primary', '186EA95DE7306B1A', '' },
    { 'SMG-32 Reprimand', 'Primary', '94BD931B5FB4EE95', '' },
    { 'SMG-37 Defender', 'Primary', '4E4A613EB9BF5C24', 'The one you carry.' },
    { 'SMG-37 Defender (SEAF)', 'Primary', 'CA4BBEF63C869C18', 'The Defender SEAF soldiers carry. Not yours.' },
    { 'SMG-72 Pummeler', 'Primary', '0807AEA5217E4767', '' },
    { 'SMG/FLAM-34 Stoker', 'Primary', '8A307BD1811A5FE9', 'The SMG you carry. Its underbarrel flamer is listed separately.' },
    { 'SMG/FLAM-34 Stoker (underbarrel flamer)', 'Primary', '992B6F65A5BAB53D', 'The Stoker\'s underbarrel flamer, not the SMG itself.' },
    { 'StA-11 SMG', 'Primary', '4BA41B6F9F405CC2', '' },
    { 'StA-52 Assault Rifle', 'Primary', 'CDF28BE026BB7D84', '' },
    { 'VG-70 Variable', 'Primary', 'F992CE97577C8A7F', '' },
    { 'CQC-19 Stun Lance', 'Secondary', 'E3B6AEDD07FCB464', '' },
    { 'CQC-2 Saber', 'Secondary', 'FCD8A6E67EAC635A', '' },
    { 'CQC-30 Stun Baton', 'Secondary', '52CDBFBACA3CB397', '' },
    { 'CQC-42 Machete', 'Secondary', '792D5D2A340FD6E6', 'The one you carry. The CQC-20 Breaching Hammer is listed under Support.' },
    { 'CQC-5 Combat Hatchet', 'Secondary', '75816077C139C850', '' },
    { 'CQC-73 Entrenchment Tool', 'Secondary', '7E1F76163C667E4B', 'The one you carry. The CQC-72 support version is listed under Support.' },
    { 'GP-20 Ultimatum', 'Secondary', '9EB160830321BFD6', '' },
    { 'GP-31 Grenade Pistol', 'Secondary', '52E4334E6A128CAF', 'The pistol you carry. The One-Two\'s launcher is listed under the One-Two.' },
    { 'LAS-58 Talon', 'Secondary', '416D053372C4E433', '' },
    { 'LAS-7 Dagger', 'Secondary', '7B06196E90154C88', '' },
    { 'M6C/SOCOM Pistol', 'Secondary', '4D58C77087B774C5', '' },
    { 'P-11 Stim Pistol', 'Secondary', 'D6B1FB05B9109353', '' },
    { 'P-113 Verdict', 'Secondary', '1A437158E1B8D2A1', '' },
    { 'P-19 Redeemer', 'Secondary', '3575AABC5F1F9326', '' },
    { 'P-2 Peacemaker', 'Secondary', '05E4E5C2DB6E44A2', '' },
    { 'P-33 Missile Pistol', 'Secondary', '14D5D4506056C7A4', '' },
    { 'P-34 Breacher', 'Secondary', 'E91F569C2AD8AF01', '' },
    { 'P-35 Re-Educator', 'Secondary', '0B882808C6F498E8', '' },
    { 'P-4 Senator', 'Secondary', '8D3D52A3B2F19402', '' },
    { 'P-41 Ombudsman (variant 2)', 'Secondary', 'BDE1F2534280300D', 'Another copy of this weapon, not identified yet.' },
    { 'P-44 Mist', 'Secondary', '027DEC442CC26A90', '' },
    { 'P-69 Veto', 'Secondary', 'C780BCD79547DA0F', '' },
    { 'P-72 Crisper', 'Secondary', '3F92BA65EF65CCA9', '' },
    { 'P-92 Warrant', 'Secondary', 'CF8934FF6567A42D', '' },
    { 'P/40-K Bolt Pistol', 'Secondary', 'DBB6C961C59FADC1', '' },
    { 'PLAS-15 Loyalist', 'Secondary', 'AA69A60D74A3EC54', '' },
    { 'SG-22 Bushwhacker', 'Secondary', '2B28E17FFED05F7C', '' },
    { '40-K Meltagun', 'Support', '6CFCC7F8801A0266', '' },
    { 'AC-8 Autocannon', 'Support', 'A8CFFB316F0B5C5F', '' },
    { 'AMW-20 Apex', 'Support', 'B814EECE17533BC4', '' },
    { 'APW-1 Anti-Materiel Rifle', 'Support', '89C5493E08CA4207', '' },
    { 'ARC-3 Arc Thrower', 'Support', '96DE9CD50F7306E6', '' },
    { 'B/FLAM-80 Cremator', 'Support', '78A8185F63A70795', 'The flamethrower you carry.' },
    { 'B/MD C4 Pack', 'Support', '9B75217D8312DD67', 'The charge backpack, the charge and its blast. Cooldown: Stratagems tab.' },
    { 'CQC-1 One True Flag', 'Support', 'B0F1B354BA1D38D8', '' },
    { 'CQC-20 Breaching Hammer', 'Support', '5F3EC9BDA2BD8553', 'The support hammer delivered by hellpod. The game data files it next to the Machete.' },
    { 'CQC-72 Entrenchment Tool', 'Support', 'E85E623F93F96FB3', 'The support weapon. The CQC-73 is listed under Secondary.' },
    { 'CQC-9 Defoliation Tool', 'Support', 'BF4CFD2AEABFB5A4', '' },
    { 'EAT-17 Expendable Anti-Tank', 'Support', '80932FA0ED6901D3', 'The one you carry.' },
    { 'EAT-17 Expendable Anti-Tank (SEAF)', 'Support', '5C54E81A4AAA31FC', 'The EAT-17 SEAF soldiers carry. Not yours.' },
    { 'EAT-411 Leveller', 'Support', '7617642765AC38C7', '' },
    { 'EAT-700 Expendable Napalm', 'Support', 'B2B5E0D185605F9E', '' },
    { 'FAF-14 Spear', 'Support', '25AA2FD4643CF4EE', '' },
    { 'FLAM-40 Flamethrower', 'Support', '39AB99895147A3BF', '' },
    { 'GL-21 Grenade Launcher', 'Support', '02EECD0B1FA49630', '' },
    { 'GL-28 Belt-Fed Grenade Launcher', 'Support', '88C2D09AD85A7C9F', '' },
    { 'GL-52 De-Escalator', 'Support', 'FE3B29B2CFA63F9B', '' },
    { 'GR-8 Recoilless Rifle', 'Support', '9F80D67A12A7E40F', '' },
    { 'LAS-44 Nova', 'Support', '73D84EAAE8C75342', '' },
    { 'LAS-98 Laser Cannon', 'Support', 'D54B9505C0F72873', 'The one you carry.' },
    { 'LAS-98 Laser Cannon (crewed mount)', 'Support', '1980D92B619FF5FE', 'A mounted cannon with a seat, dropped by hellpod. Not the one you carry.' },
    { 'LAS-99 Quasar Cannon', 'Support', '35A61296619CC47E', '' },
    { 'M-1000 Maxigun', 'Support', '43A58CB89CFA197C', '' },
    { 'M-105 Stalwart', 'Support', 'A6A735ACCB4A327F', 'The one you carry.' },
    { 'M-105 Stalwart (mounted)', 'Support', 'B43235DBD493750C', 'A mounted copy. Not the one you carry.' },
    { 'M-105 Stalwart (mounted, AI-aimed 1)', 'Support', 'B9606C5AAB32C3C2', 'A mounted copy aimed by AI. Not the one you carry.' },
    { 'M-105 Stalwart (mounted, AI-aimed 2)', 'Support', 'D53EE03481AE73FD', 'A mounted copy aimed by AI. Not the one you carry.' },
    { 'MG-206 Heavy Machine Gun', 'Support', '2152D5147B0AC418', 'The one you carry.' },
    { 'MG-206 Heavy Machine Gun (mounted B)', 'Support', 'CD00BDC1149C2928', 'A mounted copy run by AI (emplacement-style). Not the one you carry.' },
    { 'MG-43 Machine Gun', 'Support', '11C27D3BABB38956', 'The one you carry.' },
    { 'MG-43 Machine Gun (SEAF)', 'Support', '587878FB76F4B9B1', 'The MG-43 SEAF soldiers carry. Not yours.' },
    { 'MGX-42 Bullet Storm', 'Support', 'B16C9D490AA59B77', '' },
    { 'MLS-4X Commando', 'Support', '5990123D142B16CB', '' },
    { 'MS-11 Solo Silo', 'Support', 'DDDB2910FF2B24E9', '' },
    { 'PLAS-45 Epoch', 'Support', 'E8D5F49AD7780E54', '' },
    { 'RL-77 Airburst Rocket Launcher', 'Support', '26E40437EA275296', '' },
    { 'RS-422 Railgun', 'Support', '2E9D0BDC48B09E60', '' },
    { 'S-11 Speargun', 'Support', '3828E2051AA9E897', '' },
    { 'SG-88 Break-Action Shotgun', 'Support', '52071F49263415E4', '' },
    { 'StA-X3 W.A.S.P. Launcher', 'Support', 'CC786F6491FE7E65', '' },
    { 'TX-41 Sterilizer', 'Support', '88F61AFFF48AC8A4', '' },
    { 'A/AC-8 Autocannon Sentry', 'Stratagems', '54D86057F5DACFB9', 'Sentry: its cooldown, its body, then its weapon.' },
    { 'A/ARC-3 Tesla Tower', 'Stratagems', '74599E56F72F9D7E', 'Sentry: its cooldown, its body, then its weapon.' },
    { 'A/FLAM-40 Flame Sentry', 'Stratagems', '820CC3BAFE962858', 'Sentry: its cooldown, its body, then its weapon.' },
    { 'A/G-16 Gatling Sentry', 'Stratagems', 'EF85D6CF58E31D70', 'Sentry: its cooldown, its body, then its weapon.' },
    { 'A/GM-17 Gas Mortar Sentry', 'Stratagems', '299C0D3DFD2F0994', 'Sentry: its cooldown, its body, then its weapon.' },
    { 'A/LAS-98 Laser Sentry', 'Stratagems', '56070F36CFFFA8A8', 'Sentry: its cooldown, its body, then its weapon.' },
    { 'A/M-12 Mortar Sentry', 'Stratagems', '51A0812E3BCE2D74', 'Sentry: its cooldown, its body, then its weapon.' },
    { 'A/M-23 EMS Mortar Sentry', 'Stratagems', 'B2053A1838092F8B', 'Sentry: its cooldown, its body, then its weapon.' },
    { 'A/MG-43 Machine Gun Sentry', 'Stratagems', '37CDE43876BA26BB', 'Sentry: its cooldown, its body, then its weapon.' },
    { 'A/MLS-4X Rocket Sentry', 'Stratagems', '37079568DC86E9C6', 'Sentry: its cooldown, its body, then its weapon.' },
    { 'E/AT-12 Anti-Tank Emplacement', 'Stratagems', '2B11C9E4980EC479', 'Emplacement: its cooldown, its body, then its weapon.' },
    { 'E/GL-21 Grenadier Battlement', 'Stratagems', '1D5943301A29C940', 'Emplacement: its cooldown, its body, then its weapon.' },
    { 'E/MG-101 HMG Emplacement', 'Stratagems', '0E977C49DB7604F9', 'Emplacement: its cooldown, its body, then its weapon.' },
    { 'G-10 Incendiary', 'Throwables', '04653AB33F3FFB44', '' },
    { 'G-109 Urchin', 'Throwables', '3FA94F58F596BC0B', '' },
    { 'G-11 Caltrops', 'Throwables', '2968DEBA6D6C2F09', '' },
    { 'G-12 High Explosive', 'Throwables', '6B11FC757618C57E', '' },
    { 'G-123 Thermite', 'Throwables', 'C5C05FCB5747C799', '' },
    { 'G-13 Incendiary Impact', 'Throwables', 'EB725C39FC38B87C', '' },
    { 'G-142 Pyrotech', 'Throwables', '03F31CAF3A7D8F4E', '' },
    { 'G-16 Impact', 'Throwables', '7686544F539BB9B7', '' },
    { 'G-23 Stun', 'Throwables', '0080869506299773', '' },
    { 'G-3 Smoke', 'Throwables', '5DE8FD02A05B4B0A', '' },
    { 'G-31 Arc', 'Throwables', 'DB922A7AFC42894B', '' },
    { 'G-4 Gas', 'Throwables', '0416984F4922757B', '' },
    { 'G-48 Giga Grenade', 'Throwables', '46333FC9E3D4BD34', '' },
    { 'G-50 Seeker', 'Throwables', '2D398D1EC35E0838', '' },
    { 'G-6 Frag', 'Throwables', '4CE9EAB785A79B7B', '' },
    { 'G-60 Anti-Tank Seeker', 'Throwables', '8E325C933E55BF62', '' },
    { 'G-7 Pineapple', 'Throwables', '075B19B068FB1045', '' },
    { 'G-8 Immolation', 'Throwables', '5C14F27759DD3BE0', '' },
    { 'G-89 Smokescreen', 'Throwables', 'DAB81B0D80B511C7', '' },
    { 'G/40-K Melta Mine', 'Throwables', 'EE4C107B941AB7F4', '' },
    { 'G/SH-39 Shield', 'Throwables', 'C91FB921947AD273', '' },
    { 'K-2 Throwing Knife', 'Throwables', 'F7B35A9C5AE340B6', '' },
    { 'TED-63 Dynamite', 'Throwables', '14368DC8784220B0', '' },
    { 'TM-1 Lure Mine', 'Throwables', 'A20683199DFC19E8', '' },
}

-- Stratagems: id, name, family, payload entities, records { kind (P projectile / X explosion /
-- D damage), record id, section label } (from HD2Runtime's stratagem graphs).
local STRATAGEMS = {
    { 774795224, '40-K Meltagun', 'support', { '4E52F730432CDB1E', '73F8498BFFDCF415' }, {  } },
    { 875551083, 'AC-8 Autocannon', 'support', { '5F41C4DCABE95421', '73F8498BFFDCF415' }, {  } },
    { 3082503125, 'AMW-20 Apex', 'support', { '77BB9410010B0F6E', '73F8498BFFDCF415' }, {  } },
    { 2207713849, 'APW-1 Anti-Materiel Rifle', 'support', { '891ADA7D553B69DB', '73F8498BFFDCF415' }, {  } },
    { 992079466, 'ARC-3 Arc Thrower', 'support', { '4CF9D9B3F6813F52', '73F8498BFFDCF415' }, {  } },
    { 2271469939, 'B/FLAM-80 Cremator', 'support', { 'CA4F3FC268F449D5', '73F8498BFFDCF415' }, {  } },
    { 3748434442, 'B/MD C4 Pack', 'support', { '0AC9CDDBE8C64851', '73F8498BFFDCF415' }, {  } },
    { 2265180087, 'CQC-1 One True Flag', 'support', { 'EB95609DCBAD53FE', '73F8498BFFDCF415' }, {  } },
    { 3330450692, 'CQC-20 Breaching Hammer', 'support', { '8DB8B823889324F9', '73F8498BFFDCF415' }, {  } },
    { 3572024208, 'CQC-9 Defoliation Tool', 'support', { '7FA006885812A756', '73F8498BFFDCF415' }, {  } },
    { 3413606544, 'EAT-17 Expendable Anti-Tank', 'support', { '0DC7A18342B62BEC', '73F8498BFFDCF415' }, {  } },
    { 2934950455, 'EAT-411 Leveller', 'support', { '8A9E543022C18092', '73F8498BFFDCF415' }, {  } },
    { 1813634375, 'EAT-700 Expendable Napalm', 'support', { '20AAFC3A504D2E5F', '73F8498BFFDCF415' }, {  } },
    { 1979913877, 'Eagle 110mm Rocket Pods', 'eagle', { '397792815583DA29' }, { { 'P', 84, 'Projectile' }, { 'D', 258, 'Direct hit' }, { 'X', 229, 'Blast radius' }, { 'D', 414, 'Blast' } } },
    { 4119049995, 'Eagle 500kg Bomb', 'eagle', { 'E44B691DC039A505' }, { { 'P', 243, 'Projectile' }, { 'D', 261, 'Direct hit' }, { 'X', 193, 'Blast radius' }, { 'D', 432, 'Blast' }, { 'X', 277, 'Burst radius' }, { 'D', 465, 'Burst' } } },
    { 1238358532, 'Eagle Airstrike', 'eagle', { '2EA01CB1676ACA29' }, { { 'P', 173, 'Projectile' }, { 'D', 244, 'Direct hit' }, { 'X', 194, 'Blast radius' }, { 'D', 433, 'Blast' } } },
    { 3656370131, 'Eagle Cluster Bomb', 'eagle', { '9D4F7CB4EB34515D' }, { { 'P', 291, 'Projectile' }, { 'D', 244, 'Direct hit' }, { 'X', 419, 'Burst radius' }, { 'D', 399, 'Burst' }, { 'P', 133, 'Shrapnel projectile' }, { 'D', 39, 'Shrapnel direct hit' }, { 'X', 162, 'Shrapnel blast radius' } } },
    { 4196275240, 'Eagle Gas Airstrike', 'eagle', { 'DBB286AD7ED9DF96' }, { { 'P', 192, 'Projectile' }, { 'D', 244, 'Direct hit' }, { 'X', 331, 'Blast radius' }, { 'D', 402, 'Blast' } } },
    { 2040137691, 'Eagle Napalm Airstrike', 'eagle', { '27BB558C893383CC' }, { { 'P', 143, 'Projectile' }, { 'D', 244, 'Direct hit' }, { 'X', 360, 'Blast radius' }, { 'D', 401, 'Blast' } } },
    { 1685231450, 'Eagle Smoke Strike', 'eagle', { '1B3BCADABC7EF8D6' }, { { 'P', 132, 'Projectile' }, { 'D', 244, 'Direct hit' }, { 'X', 75, 'Blast radius' } } },
    { 2808191861, 'Eagle Strafing Run', 'eagle', { '23A60681DD4383EC' }, { { 'P', 17, 'Projectile' }, { 'D', 228, 'Direct hit' }, { 'X', 50, 'Blast radius' }, { 'D', 377, 'Blast' } } },
    { 3923676543, 'FAF-14 Spear', 'support', { 'C57F85252B7D853B', '73F8498BFFDCF415' }, {  } },
    { 1432571981, 'FLAM-40 Flamethrower', 'support', { 'E90F771A36FB441E', '73F8498BFFDCF415' }, {  } },
    { 3343676429, 'GL-21 Grenade Launcher', 'support', { '20225DEE487C9F5F', '73F8498BFFDCF415' }, {  } },
    { 512147393, 'GL-28 Belt-Fed Grenade Launcher', 'support', { 'B7791DA91F13488C', '73F8498BFFDCF415' }, {  } },
    { 153819019, 'GL-52 De-Escalator', 'support', { '2F67BF9C4F560C02', '73F8498BFFDCF415' }, {  } },
    { 1298599997, 'GR-8 Recoilless Rifle', 'support', { 'DDEE9646723E09D3', '73F8498BFFDCF415' }, {  } },
    { 4146034362, 'LAS-44 Nova', 'support', { '2BECC6299FA6BD20', '73F8498BFFDCF415' }, {  } },
    { 2822568285, 'LAS-98 Laser Cannon', 'support', { 'FDE262593307CA2F', '73F8498BFFDCF415' }, {  } },
    { 2625074523, 'LAS-99 Quasar Cannon', 'support', { '67AC082FF6D142F3', '73F8498BFFDCF415' }, {  } },
    { 3455841218, 'M-1000 Maxigun', 'support', { '73B63D637973C7A4', '73F8498BFFDCF415' }, {  } },
    { 14345846, 'M-105 Stalwart', 'support', { '31C4DD88C1450282', '73F8498BFFDCF415' }, {  } },
    { 533318241, 'MG-206 Heavy Machine Gun', 'support', { '0FD8B759412815DD', '73F8498BFFDCF415' }, {  } },
    { 458198946, 'MG-43 Machine Gun', 'support', { '94C5114EBA59AA21', '73F8498BFFDCF415' }, {  } },
    { 3288352984, 'MGX-42 Bullet Storm', 'support', { 'C87555EED1E9F092', '73F8498BFFDCF415' }, {  } },
    { 2232989803, 'MLS-4X Commando', 'support', { 'A0E691598F32932F', '73F8498BFFDCF415' }, {  } },
    { 1337271929, 'MS-11 Solo Silo', 'support', { 'DE18775FA447A9BF', 'FBE75EC44E7C9A50' }, {  } },
    { 1063322614, 'Orbital 120mm HE Barrage', 'orbital', { '2D3BD00B1ED411B1' }, { { 'P', 197, 'Round 1 projectile' }, { 'D', 272, 'Direct hit' }, { 'X', 213, 'Round 1 blast radius' }, { 'D', 457, 'Blast' }, { 'P', 139, 'Rounds 2, 3 projectile' }, { 'X', 177, 'Rounds 2, 3 blast radius' } } },
    { 3108516875, 'Orbital 380mm HE Barrage', 'orbital', { 'EF66B417EDC3B1D6' }, { { 'P', 82, 'Round 1 projectile' }, { 'D', 273, 'Direct hit' }, { 'X', 301, 'Round 1 blast radius' }, { 'D', 456, 'Blast' }, { 'P', 270, 'Rounds 2, 3 projectile' }, { 'X', 94, 'Rounds 2, 3 blast radius' } } },
    { 1560416221, 'Orbital Airburst Strike', 'orbital', { '75B131DC1DDC02D5' }, { { 'P', 160, 'Projectile' }, { 'D', 271, 'Direct hit' }, { 'X', 380, 'Blast radius' }, { 'D', 399, 'Blast' }, { 'P', 12, 'Shrapnel projectile' }, { 'D', 199, 'Shrapnel direct hit' }, { 'X', 106, 'Shrapnel blast radius' } } },
    { 1280711447, 'Orbital EMS Strike', 'orbital', { '55F3747B8C27AEF6' }, { { 'P', 76, 'Projectile' }, { 'D', 271, 'Direct hit' }, { 'X', 188, 'Blast radius' }, { 'D', 463, 'Blast' } } },
    { 3193297673, 'Orbital Gas Strike', 'orbital', { '05F3C83A91075766' }, { { 'P', 200, 'Projectile' }, { 'D', 271, 'Direct hit' }, { 'X', 82, 'Blast radius' }, { 'D', 459, 'Blast' } } },
    { 2084654169, 'Orbital Gatling Barrage', 'orbital', { '2F257B91037AC421' }, { { 'P', 79, 'Round 1 projectile' }, { 'D', 228, 'Direct hit' }, { 'X', 266, 'Round 1 blast radius' }, { 'D', 377, 'Round 1 blast' }, { 'P', 43, 'Rounds 2, 3, 4 projectile' } } },
    { 970450596, 'Orbital Laser', 'orbital', { 'EC3575E7A93793BB' }, { { 'D', 525, 'Laser damage' } } },
    { 2902516083, 'Orbital Napalm Barrage', 'orbital', { 'A16AB4FF66AE6970' }, { { 'P', 238, 'Round 1 projectile' }, { 'D', 275, 'Direct hit' }, { 'X', 63, 'Round 1 blast radius' }, { 'D', 276, 'Blast' }, { 'P', 242, 'Rounds 2, 3 projectile' }, { 'X', 74, 'Rounds 2, 3 blast radius' } } },
    { 3523620028, 'Orbital Precision Strike', 'orbital', { 'C897C0D84448AB2C' }, { { 'P', 102, 'Projectile' }, { 'D', 274, 'Direct hit' }, { 'X', 343, 'Blast radius' }, { 'D', 458, 'Blast' } } },
    { 2744472229, 'Orbital Railcannon Strike', 'orbital', { 'AC129AA2DB5EABC9' }, { { 'P', 282, 'Projectile' }, { 'D', 277, 'Direct hit' }, { 'X', 52, 'Burst radius' }, { 'D', 455, 'Burst' } } },
    { 3713568312, 'Orbital Smoke Strike', 'orbital', { 'DA76A06325E692C9' }, { { 'P', 251, 'Projectile' }, { 'D', 271, 'Direct hit' }, { 'X', 75, 'Blast radius' } } },
    { 3279813377, 'Orbital Walking Barrage', 'orbital', { 'CB7F154719F331EC' }, { { 'P', 82, 'Round 1 projectile' }, { 'D', 273, 'Direct hit' }, { 'X', 301, 'Round 1 blast radius' }, { 'D', 456, 'Blast' }, { 'P', 270, 'Rounds 2, 3 projectile' }, { 'X', 94, 'Rounds 2, 3 blast radius' } } },
    { 4261593827, 'PLAS-45 Epoch', 'support', { '46B9E3BE0AE9972E', '73F8498BFFDCF415' }, {  } },
    { 2007887745, 'RL-77 Airburst Rocket Launcher', 'support', { 'CA6E81E2B3E22B18', '73F8498BFFDCF415' }, {  } },
    { 3078242205, 'RS-422 Railgun', 'support', { 'B62620AE2CD89F49', '73F8498BFFDCF415' }, {  } },
    { 336693041, 'S-11 Speargun', 'support', { '5CAF553BA7EA1429', '73F8498BFFDCF415' }, {  } },
    { 890972990, 'StA-X3 W.A.S.P. Launcher', 'support', { '0A60397B7409995E', '73F8498BFFDCF415' }, {  } },
    { 4152191751, 'TX-41 Sterilizer', 'support', { 'BBD57DF3E5B15ED8', '73F8498BFFDCF415' }, {  } },
}

-- ================================================================ SHODAN Stat Editor
-- An in-game panel for the weapon stats the game keeps in its settings tables: damage,
-- durable damage, armour penetration, demolition / stagger / push force, projectiles per
-- shot, projectile velocity / drag / penetration slowdown, fire rate, magazines / rounds,
-- recoil, spread, sway, ergonomics, heat and cool-down times, for every weapon in WEAPONS. Changes are written to the
-- live tables at once and saved to StatEditor/config.txt, which is applied on the next
-- start as soon as the tables are found (a few seconds after launch, on the title screen).
--
-- The tables are found by the shared scan (below), then parsed whole: keyed tables map a
-- weapon's entity hash to its record, row tables map a row id to its row. A weapon's damage
-- comes through its projectile: rounds record (+64), default attachment, or fire mode (+0) -> projectile row
-- (+60) -> damage row; a beam weapon's through its beam: beam component (+0 beam type) -> beam
-- row (+12) -> damage row; a flame / gas weapon's through its spray component (+200), a melee
-- weapon's through its melee component (+12) -> damage row; an arc weapon's through its arc
-- component (+0 arc type) -> arc row (+36) -> damage row. A damage row's status effects (+44: 4 x type, strength) name the burn / gas damage row
-- (status row +44). Explosive projectiles name their explosion rows (radii). Several weapons can share one projectile or damage row; the panel says
-- so, because editing it changes all of them.

-- SHODAN Stat Editor Offline (a desktop program that runs this file against the game's data files while the
-- game is closed) sets SHODAN_OFFLINE: the panel is then the program's window, always open, with its own log.
MOD.offline = rawget(_G, 'SHODAN_OFFLINE') ~= nil

local HEADER_BYTES = 24
local MAX_PAYLOAD = 64 * 1024 * 1024
local MEM_COMMIT, MEM_PRIVATE, MEM_FREE = 0x1000, 0x20000, 0x10000
local PAGE_READONLY, PAGE_READWRITE = 0x02, 0x04

local state = {
    title = MOD.title, version = MOD.version, phase = 'starting', status = 'starting',
    frame = 0, tables = 0, weapons = 0, applied = 0, refused = 0, ui_errors = 0,
    writes = 0,   -- goes up on every value this mod writes: other mods editing the same tables can watch it
}
rawset(_G, MOD.global, state)

-- ---------------------------------------------------------------- byte helpers
local function u32_bytes(value)
    value = value % 4294967296
    return string.char(value % 256,
                       math.floor(value / 256) % 256,
                       math.floor(value / 65536) % 256,
                       math.floor(value / 16777216) % 256)
end

local function u32(blob, offset)
    local a, b, c, d = blob:byte(offset + 1, offset + 4)
    if not d then return nil end
    return a + b * 256 + c * 65536 + d * 16777216
end

-- Independent decoder: bits -> number, so read-back checks never share code with the encoder.
local function bits_to_f32(bits)
    local sign = 1
    if bits >= 2147483648 then sign = -1; bits = bits - 2147483648 end
    local exp = math.floor(bits / 8388608)
    local mant = bits - exp * 8388608
    if exp == 255 then return mant == 0 and sign * math.huge or 0 / 0 end
    if exp == 0 then return mant == 0 and sign * 0.0 or sign * mant * 2 ^ -149 end
    return sign * (1 + mant / 8388608) * 2 ^ (exp - 127)
end

local NEEDLE = 'LDLD' .. u32_bytes(1)

-- ---------------------------------------------------------------- windows api
local ffi_ok, ffi = pcall(require, 'ffi')
local api = nil
local f32_bytes = nil
local REGION_TYPE = MOD.global .. 'Region'

local function build_api()
    for _, declaration in ipairs({
        'void *GetCurrentProcess(void);',
        'int ReadProcessMemory(void *process, const void *address, void *buffer, size_t size, size_t *read);',
        'int WriteProcessMemory(void *process, void *address, const void *buffer, size_t size, size_t *written);',
        'size_t VirtualQuery(const void *address, void *region, size_t size);',
        'int VirtualProtect(void *address, size_t size, uint32_t new_protection, uint32_t *old_protection);',
        'int CreateDirectoryA(const char *path, void *security);',
        'uint32_t GetLastError(void);',
        'int QueryPerformanceCounter(int64_t *count);',
        'int QueryPerformanceFrequency(int64_t *frequency);',
        'int K32QueryWorkingSetEx(void *process, void *entries, uint32_t size);',
        'int32_t NtQueryVirtualMemory(void *process, const void *address, int information_class, void *information, size_t size, size_t *returned);',
        'int32_t NtWriteVirtualMemory(void *process, void *address, const void *buffer, size_t size, size_t *written);',
    }) do
        pcall(ffi.cdef, declaration)
    end
    pcall(ffi.cdef, [[typedef struct {
        void *base; void *allocation_base; uint32_t allocation_protection;
        uint16_t partition; uint16_t reserved; size_t size;
        uint32_t state; uint32_t protection; uint32_t type;
    } ]] .. REGION_TYPE .. ';')

    local kernel = ffi.load('kernel32')
    local query = ffi.cast('size_t (*)(const void *, void *, size_t)', kernel.VirtualQuery)
    local virtual_protect = ffi.cast('int (*)(void *, size_t, uint32_t, uint32_t *)', kernel.VirtualProtect)
    local process = kernel.GetCurrentProcess()
    local region = ffi.new(REGION_TYPE .. '[1]')
    local region_size = ffi.sizeof(region[0])
    local counter = ffi.new('size_t[1]')

    local self = {}

    function self.read(address, size)
        if size <= 0 then return nil end
        local buffer = ffi.new('uint8_t[?]', size)
        if kernel.ReadProcessMemory(process, ffi.cast('const void *', address),
                                    buffer, size, counter) == 0 then return nil end
        if tonumber(counter[0]) ~= size then return nil end
        return ffi.string(buffer, size)
    end

    function self.query(address)
        if query(ffi.cast('const void *', address), region, region_size) ~= region_size then
            return nil
        end
        local base = tonumber(ffi.cast('uintptr_t', region[0].base))
        local size = tonumber(region[0].size)
        if not base or not size or size <= 0 then return nil end
        return { base = base, size = size, state = region[0].state,
                 protection = region[0].protection, kind = region[0].type }
    end

    -- VirtualQuery and WriteProcessMemory cost time in proportion to the size of the memory
    -- region they land in (about 3 ms per GB), and the game has regions of several GB. The
    -- pack therefore never asks about whole regions: allocations are stepped over with
    -- NtQueryVirtualMemory's region information (constant cost), single pages are checked
    -- with QueryWorkingSetEx (constant cost; guard pages and paged-out pages count as not
    -- readable, so they are never touched), and writes go through NtWriteVirtualMemory.
    local ntdll = ffi.load('ntdll')
    local allocation_info = ffi.new('uint64_t[6]')
    local returned = ffi.new('size_t[1]')
    local pages = ffi.new('uint64_t[64]')   -- (address, attributes) pairs, 32 pages at most

    -- Allocation holding `address`: base, size, true; or, for free memory: base, size, false.
    function self.allocation(address)
        if ntdll.NtQueryVirtualMemory(process, ffi.cast('const void *', address), 3,
                                      allocation_info, 48, returned) == 0 then
            local base, size = tonumber(allocation_info[0]), tonumber(allocation_info[2])
            if base and size and size > 0 then return base, size, true end
        end
        if query(ffi.cast('const void *', address), region, region_size) ~= region_size
            or region[0].state ~= MEM_FREE then return nil end
        return tonumber(ffi.cast('uintptr_t', region[0].base)), tonumber(region[0].size), false
    end

    -- Protection of each of `count` pages from `address` (page aligned; at most 32) when the
    -- page is present in memory and private to the game, else false.
    function self.pages(address, count)
        for k = 0, count - 1 do pages[2 * k], pages[2 * k + 1] = address + k * 4096, 0 end
        if kernel.K32QueryWorkingSetEx(process, pages, count * 16) == 0 then return nil end
        local result = {}
        for k = 0, count - 1 do
            local attributes = tonumber(pages[2 * k + 1] % 65536)
            local valid, shared = attributes % 2 == 1, attributes >= 32768
            result[k + 1] = valid and not shared and math.floor(attributes / 16) % 2048 or false
        end
        return result
    end

    function self.readable(address)
        local protection = self.pages(address - address % 4096, 1)
        protection = protection and protection[1]
        return protection == PAGE_READWRITE or protection == PAGE_READONLY
    end

    local function writable_fast(address, size)
        local first, last = address - address % 4096, (address + size - 1) - (address + size - 1) % 4096
        local protection = self.pages(first, (last - first) / 4096 + 1)
        if not protection then return false end
        for _, p in ipairs(protection) do if p ~= PAGE_READWRITE then return false end end
        return true
    end

    function self.write(address, bytes)
        if #bytes <= 0 then return false end
        if writable_fast(address, #bytes) then
            return ntdll.NtWriteVirtualMemory(process, ffi.cast('void *', address), bytes, #bytes, counter) == 0
                   and tonumber(counter[0]) == #bytes
        end
        -- rare: read-only or paged-out page; the full check below
        local info = self.query(address)
        if not info or info.state ~= MEM_COMMIT or info.kind ~= MEM_PRIVATE
            or address < info.base or address + #bytes > info.base + info.size
            or (info.protection ~= PAGE_READONLY and info.protection ~= PAGE_READWRITE) then
            return false
        end
        local old_protection = ffi.new('uint32_t[1]')
        local changed = info.protection == PAGE_READONLY
        if changed and virtual_protect(ffi.cast('void *', address), #bytes,
                                       PAGE_READWRITE, old_protection) == 0 then
            return false
        end
        local wrote = kernel.WriteProcessMemory(process, ffi.cast('void *', address),
                                                bytes, #bytes, counter) ~= 0
                      and tonumber(counter[0]) == #bytes
        local restored = not changed or virtual_protect(
            ffi.cast('void *', address), #bytes, old_protection[0], old_protection) ~= 0
        return wrote and restored
    end

    local ticks, frequency = ffi.new('int64_t[1]'), ffi.new('int64_t[1]')
    kernel.QueryPerformanceFrequency(frequency)
    local per_second = tonumber(frequency[0])
    function self.now()   -- seconds, high resolution (os.clock only ticks every millisecond)
        kernel.QueryPerformanceCounter(ticks)
        return tonumber(ticks[0]) / per_second
    end

    function self.address_of(text)
        local ok, value = pcall(function()
            return tonumber(ffi.cast('uintptr_t', ffi.cast('const char *', text)))
        end)
        if ok then return value end
        return nil
    end

    function self.mkdir(path)
        return kernel.CreateDirectoryA(path, nil) ~= 0 or kernel.GetLastError() == 183
    end

    return self
end

-- ---------------------------------------------------------------- shared scan (the hub)
-- One scan serves every mod of the pack. The game keeps its settings tables at the start of
-- their memory allocations, most of them packed back to back in one long chain, so the hub
-- reads 16 bytes at the start of each allocation, then walks every chain it found from one
-- table header to the next. Passes repeat every PASS_DELAY seconds until every mod has its
-- records (tables are written late in startup); only if something is still missing after
-- FALLBACK_SECONDS does it sweep all memory as a last resort. All of it runs in slices of at
-- most FRAME_BUDGET seconds per frame (handing one table to one mod is the largest single
-- step), and the hub logs its most expensive frame.
local HUB_NAME, HUB_VERSION = 'SHODAN_EDITOR_HUB', 1
local HUB_LOG = 'SHODANStatEditorScan.log'
local START_FRAME = 120
local FRAME_BUDGET = 0.0007   -- plus at most one step past it: about 1 ms in the worst frame
local PASS_DELAY = 0.5
local FALLBACK_SECONDS = 180
local SWEEP_CHUNK = 65536
local ADDRESS_LIMIT = 0x7FFFFFFF0000
local LUA_HEAP_LIMIT = 0x80000000   -- below this, only Lua-heap copies (LuaJIT without GC64)

local function new_hub(api, skip_low)
    local hub = { version = HUB_VERSION, clients = {}, frame = 0, phase = 'starting', passes = 0,
                  chains = {}, chain_list = {}, worst = 0, total = 0, busy_frames = 0 }
    local lines = {}
    local cursor, enumerated, walk_index, walk_at, seen = 0, false, 1, nil, {}
    local queue, queued = {}, 0   -- hand-offs waiting: one mod and one table per step
    local started, resume, swept = nil, 0, false

    local hub_log_dirty = false
    local function hub_log(message)
        if #lines < 200 then
            lines[#lines + 1] = string.format('[frame %d, %.1f s] %s', hub.frame,
                started and (api.now() - started) or 0, message)
        end
        hub_log_dirty = true
    end

    local function write_hub_log()
        hub_log_dirty = false
        pcall(function()
            local base = os.getenv('LOCALAPPDATA')
            if not base or base == '' then return end
            for _, part in ipairs({ 'CowboyBingus', 'Helldivers2', 'Logs' }) do
                base = base .. '/' .. part
                api.mkdir(base)
            end
            local handle = io.open(base .. '/' .. HUB_LOG, 'wb')
            if not handle then return end
            local names = {}
            for _, client in ipairs(hub.clients) do names[#names + 1] = client.name end
            handle:write(table.concat({
                'SHODAN Stat Editor - shared scan',
                'mods: ' .. table.concat(names, ', '),
                string.format('phase: %s; passes %d; chains %d; worst frame %.2f ms; total %.1f ms over %d frames',
                              hub.phase, hub.passes, #hub.chain_list, hub.worst * 1000, hub.total * 1000,
                              hub.busy_frames),
                '',
            }, '\r\n') .. '\r\n' .. table.concat(lines, '\r\n') .. '\r\n')
            handle:close()
        end)
    end

    local function needy()
        for _, client in ipairs(hub.clients) do
            if client.searching() then return true end
        end
        return false
    end

    local function add_chain(address)
        if hub.chains[address] then return end
        hub.chains[address] = true
        hub.chain_list[#hub.chain_list + 1] = address
    end

    -- Reads one table header; hands the table to the mods that want it. Returns the payload
    -- size (to step to the next table of a chain) or nil when there is no table here.
    local function dispatch(address)
        if skip_low and address < LUA_HEAP_LIMIT then return nil end
        local header = api.read(address, HEADER_BYTES)
        if not header or header:sub(1, 8) ~= NEEDLE then return nil end
        local kind, payload = u32(header, 8), u32(header, 12)
        if not payload or payload < 16 or payload > MAX_PAYLOAD then return nil end
        if not seen[address] then
            local takers = {}
            for _, client in ipairs(hub.clients) do
                if client.searching() and client.wants(kind, address) then takers[#takers + 1] = client end
            end
            if #takers > 0 then
                -- read the payload only, so our copy carries no header a sweep could find
                local blob = api.read(address + HEADER_BYTES, payload)
                if blob then
                    seen[address] = true
                    for _, client in ipairs(takers) do
                        queued = queued + 1
                        queue[queued] = { client, address, kind, payload, blob }
                    end
                end
            end
        end
        return payload
    end

    -- Hands queued tables to their mods, one per step. True once the queue is empty.
    local function drain(deadline)
        local done = 0
        while done < queued do
            done = done + 1
            local job = queue[done]
            queue[done] = nil
            pcall(job[1].handle, job[2], job[3], job[4], job[5])
            if done < queued and api.now() >= deadline then
                for k = done + 1, queued do queue[k - done], queue[k] = queue[k], nil end
                queued = queued - done
                return false
            end
        end
        queued = 0
        return true
    end

    local function begin_pass()
        hub.passes = hub.passes + 1
        cursor, enumerated, walk_index, walk_at, seen = 0, false, 1, nil, {}
        queue, queued = {}, 0
        hub.phase = 'pass'
    end

    -- Allocation starts: one allocation after the other (constant cost each, however large),
    -- 16 bytes read at the start when its first page is present and readable.
    local function enumerate(deadline)
        while cursor < ADDRESS_LIMIT do
            local base, size, allocated = api.allocation(cursor)
            if not base then cursor = ADDRESS_LIMIT break end
            cursor = math.max(base + size, cursor + 4096)
            if allocated and not (skip_low and base < LUA_HEAP_LIMIT) and api.readable(base) then
                local head = api.read(base, 16)
                if head then
                    if head:sub(5, 12) == NEEDLE then add_chain(base + 4)
                    elseif head:sub(1, 8) == NEEDLE then add_chain(base) end
                end
            end
            if api.now() >= deadline then return false end
        end
        return true
    end

    -- Chains: header to header; the next table follows its predecessor within 16 bytes.
    local function walk(deadline)
        while walk_index <= #hub.chain_list do
            if not drain(deadline) or api.now() >= deadline then return false end
            local at = walk_at or hub.chain_list[walk_index]
            local payload = dispatch(at)
            local next_at = nil
            if payload then
                local gap = api.read(at + HEADER_BYTES + payload, 24)
                if gap then
                    for skip = 0, 16, 4 do
                        if gap:sub(skip + 1, skip + 8) == NEEDLE then
                            next_at = at + HEADER_BYTES + payload + skip
                            break
                        end
                    end
                end
            end
            if next_at then walk_at = next_at
            else walk_index, walk_at = walk_index + 1, nil end
        end
        return drain(deadline)
    end

    -- Last resort: every present, readable page of every allocation, SWEEP_CHUNK at a time.
    -- The last bytes of each read are kept, so a header split across two reads is still seen.
    local sweep_cursor, sweep_region = 0, nil
    local function readable(protection)
        return protection == PAGE_READWRITE or protection == PAGE_READONLY
    end
    local function sweep(deadline)
        while true do
            if not drain(deadline) then return false end
            if not sweep_region then
                if sweep_cursor >= ADDRESS_LIMIT then return true end
                local base, size, allocated = api.allocation(sweep_cursor)
                if not base then return true end
                sweep_cursor = math.max(base + size, sweep_cursor + 4096)
                if allocated and not (skip_low and base < LUA_HEAP_LIMIT) then
                    sweep_region = { base = base, size = size, at = 0 }
                end
            else
                local r = sweep_region
                local start = r.base + r.at
                local count = math.floor(math.min(SWEEP_CHUNK, r.size - r.at) / 4096)
                local protection = count > 0 and api.pages(start, count)
                local k = 1
                while protection and k <= count do
                    if readable(protection[k]) then
                        local j = k
                        while j < count and readable(protection[j + 1]) do j = j + 1 end
                        local from = start + (k - 1) * 4096
                        local blob = api.read(from, (j - k + 1) * 4096)
                        if blob then
                            if r.tail and r.tail_end == from then blob, from = r.tail .. blob, from - #r.tail end
                            local position = 1
                            while true do
                                local hit = blob:find(NEEDLE, position, true)
                                if not hit then break end
                                pcall(dispatch, from + hit - 1)
                                position = hit + 1
                            end
                            r.tail, r.tail_end = blob:sub(-(#NEEDLE - 1)), from + #blob
                        end
                        k = j + 1
                    else
                        k = k + 1
                    end
                end
                r.at = r.at + math.max(count, 1) * 4096
                if r.at >= r.size then sweep_region = nil end
            end
            if api.now() >= deadline then return false end
        end
    end

    local function end_pass(final)
        for _, client in ipairs(hub.clients) do pcall(client.after_pass, hub.passes, final) end
        if not needy() then
            hub.phase = 'idle'
            hub_log(string.format('all mods have their records (pass %d, %d chains)', hub.passes, #hub.chain_list))
        elseif final then
            hub.phase = 'idle'
            hub_log('stopped: some records were not found, see the mods\' own logs')
        elseif not swept and api.now() - started >= FALLBACK_SECONDS then
            hub.phase, sweep_cursor, sweep_region, seen, queue, queued = 'sweep', 0, nil, {}, {}, 0
            hub_log('records still missing after ' .. FALLBACK_SECONDS .. ' s: sweeping all memory once')
        else
            hub.phase, resume = 'rest', api.now() + PASS_DELAY
        end
    end

    function hub.register(client)
        hub.clients[#hub.clients + 1] = client
    end

    function hub.wake()
        if hub.phase == 'idle' then
            started, swept = api.now(), false
            hub_log('a mod lost its table: scanning again')
            begin_pass()
        end
    end

    -- Log writes and upkeep take turns: at most one of them per frame across the pack.
    local turn_frame = 0
    function hub.turn()
        if turn_frame == hub.frame then return false end
        turn_frame = hub.frame
        return true
    end

    function hub.tick()
        hub.frame = hub.frame + 1
        if hub_log_dirty and (hub.phase == 'idle' or hub.phase == 'rest') and hub.turn() then write_hub_log() end
        if hub.frame < START_FRAME or hub.phase == 'idle' then return end
        local t0 = api.now()
        local deadline = t0 + FRAME_BUDGET
        if hub.phase == 'starting' then
            started = t0
            hub_log('scan started for ' .. #hub.clients .. ' mods')
            begin_pass()
        elseif hub.phase == 'rest' then
            if t0 < resume then return end
            begin_pass()
        end
        if hub.phase == 'pass' then
            if not enumerated then enumerated = enumerate(deadline) end
            if enumerated and walk(deadline) then end_pass(false) end
        elseif hub.phase == 'sweep' then
            if sweep(deadline) then
                swept = true
                end_pass(true)
            end
        end
        local cost = api.now() - t0
        hub.busy_frames, hub.total = hub.busy_frames + 1, hub.total + cost
        if cost > hub.worst then hub.worst = cost end
        if hub.phase == 'idle' then hub_log(string.format('done: worst frame %.2f ms, total %.1f ms over %d frames',
                                                          hub.worst * 1000, hub.total * 1000, hub.busy_frames)) end
    end

    return hub
end



local function hex(n) return string.format('0x%X', n) end

-- ---------------------------------------------------------------- files and log
local function data_dir(leaf)
    local base = os.getenv('LOCALAPPDATA')
    if not base or base == '' then return nil end
    -- offline: SHODAN\StatEditor (Logs inside), its own; in game: the loader's CowboyBingus\Helldivers2\<leaf>
    local parts = MOD.offline and { 'SHODAN', 'StatEditor', leaf ~= 'StatEditor' and leaf or nil } or { 'CowboyBingus', 'Helldivers2', leaf }
    for _, part in ipairs(parts) do
        base = base .. '/' .. part
        if not api.mkdir(base) then return nil end
    end
    return base
end

-- Saves write <file>.tmp, then swap it in (MoveFileExA: replace existing, write through), so a crash
-- mid-save leaves the old file whole (PR #10, Hung1510).
function MOD.write_text(path, text)
    local temp = path .. '.tmp'
    local handle = io.open(temp, 'wb')
    if not handle then return false, 'cannot open ' .. temp end
    local wrote, result = pcall(handle.write, handle, text)
    local closed, closing = pcall(handle.close, handle)
    if not (wrote and result and closed and closing) then
        pcall(os.remove, temp)
        return false, 'cannot write ' .. temp
    end
    if not MOD.move_file then
        pcall(ffi.cdef, 'int MoveFileExA(const char *from, const char *to, uint32_t flags);')
        MOD.move_file = ffi.load('kernel32').MoveFileExA
    end
    if MOD.move_file(temp, path, 9) == 0 then
        pcall(os.remove, temp)
        return false, 'cannot replace ' .. path
    end
    return true
end

function MOD.parse_number(text)
    local value = tonumber(text)
    if value and value == value and value > -math.huge and value < math.huge then return value end
    return nil
end

function MOD.lines_of(text)
    local at = 0
    return coroutine.wrap(function()
        for line in (text .. '\n'):gmatch('([^\n]*)\n') do
            at = at + 1
            coroutine.yield(at, (line:gsub('\r$', '')))
        end
    end)
end

local log_lines, log_counts, log_dirty = {}, {}, false
local MAX_LOG_LINES = 600

local function log(message)
    local count = (log_counts[message] or 0) + 1
    log_counts[message] = count
    if count > 3 or #log_lines >= MAX_LOG_LINES then return end
    local line = '[frame ' .. state.frame .. '] ' .. message
    if count == 3 then line = line .. ' (further repeats not logged)' end
    log_lines[#log_lines + 1] = line
    log_dirty = true
end

function MOD.skipped(file, at, line)
    log(file .. ': line ' .. at .. ' not understood: ' .. line:gsub('^%s+', ''):sub(1, 60))
end

local function flush_log()
    log_dirty = false
    pcall(function()
        local dir = data_dir('Logs')
        if not dir then return end
        local handle = io.open(dir .. '/' .. MOD.log, 'wb')
        if not handle then return end
        handle:write(table.concat({
            MOD.title .. ' v' .. MOD.version .. ' by ' .. MOD.author,
            'status: ' .. state.phase .. ' - ' .. state.status,
            'tables ' .. state.tables .. ', weapons ' .. state.weapons .. ', config values applied ' ..
                state.applied .. ', refused ' .. state.refused .. ', panel errors ' .. state.ui_errors,
            '',
        }, '\r\n') .. '\r\n' .. table.concat(log_lines, '\r\n') .. '\r\n')
        handle:close()
    end)
end

-- Crash trace: while `trace_left` > 0, each kind of engine call made by the panel is logged
-- and the log saved BEFORE the call, so a crash inside the engine leaves the call as the last line.
local trace_left, traced, draws = 3, {}, 0
local function step(name)
    if trace_left <= 0 or traced[name] then return end
    traced[name] = true
    log('draw ' .. (draws + 1) .. ': ' .. name)
    flush_log()
end

local function set_status(phase, status)
    state.phase, state.status = phase, status
    log(phase .. ': ' .. status)
end

-- ---------------------------------------------------------------- tables
local T_WEAPON, T_MAGAZINE, T_ROUNDS = 0x88E4DBB1, 0xFB8D88A3, 0x66081072
local T_FIRE, T_PROJECTILE, T_DAMAGE = 0x45171B68, 0xBD4042C2, 0xE0A72CF0
local T_BEAM_WEAPON, T_BEAM = 0xF0721C2C, 0xC5085606
local T_EXPLOSION, T_ORBITAL, T_STRATAGEM = 0x2AEA2592, 0x936A9C08, 0x30EB6399
local T_HEAT, T_SPRAY, T_STATUS, T_MELEE = 0x4C981CD9, 0x8E551126, 0xC63E0B22, 0xBBA9003F
-- later tables, in one local (the main chunk is at LuaJIT's 200-local limit)
local TYPES = { arc_weapon = 0xB87BA9ED, arc = 0xAFDF0267, health = 0xB3915DE3, sensor = 0x14729B6A, detector = 0xFF67A367,
                turret = 0x1EBA7593, custom = 0xEBA8F3D0, items = 0x1E604234, deltas = 0x683E604F,
                throwable = 0xAF16BCB5, explosive = 0xF5CF9B8C, sticky = 0x9AF175A4, passive = 0x63CE0FEB,
                vehicle = 0xEAEB2B0D, mount = 0x3845B1E0, shield = 0x5154DB66,
                rack = 0xA98BB156, charge = 0xEAC335A1, jumppack = 0x54270608, recharge = 0x1F42878E,
                warp = 0xA7813546, deposit = 0xC435BA85, package = 0x7A858691, reload = 0x991D454E,
                thrower = 0xA29A84D8, minefield = 0x74FEF89A, mine_spawner = 0x0697FED6, bombard = 0xCDBC43D8, eagle = 0x556FF68B,
                seeking = 0xBF3A6789, windup = 0x84CE7EEE, laser = 0x32528174, avatar = 0x40EF204C }
local KINDS = {
    [T_WEAPON] = { name = 'weapon', stride = 1232, keyed = true, layouts = { { stride = 1240 } } },
    [T_MAGAZINE] = { name = 'magazine', stride = 160, keyed = true },
    [T_ROUNDS] = { name = 'rounds', stride = 136, keyed = true },
    [T_FIRE] = { name = 'fire mode', stride = 616, keyed = true },
    [T_PROJECTILE] = { name = 'projectile', stride = 272 },
    [T_DAMAGE] = { name = 'damage', stride = 76, rows = {   -- id, label, offset, max, small / big step
        { 'damage', 'Damage', 4, 100000, 1, 10 }, { 'durable', 'Durable damage', 8, 100000, 1, 10 },
        { 'ap_direct', 'Armor pen. (direct)', 12, 10, 1, 1 }, { 'ap_slight', 'Armor pen. (slight angle)', 16, 10, 1, 1 },
        { 'ap_large', 'Armor pen. (large angle)', 20, 10, 1, 1 }, { 'ap_extreme', 'Armor pen. (extreme angle)', 24, 10, 1, 1 },
        { 'demolition', 'Demolition force', 28, 10000, 1, 10 }, { 'stagger', 'Stagger force', 32, 10000, 1, 10 },
        { 'push', 'Push force', 36, 10000, 1, 10 } } },
    [T_BEAM_WEAPON] = { name = 'beam weapon', stride = 120, keyed = true },
    [T_BEAM] = { name = 'beam', stride = 112 },
    [T_EXPLOSION] = { name = 'explosion', stride = 152, tail = true },
    [T_ORBITAL] = { name = 'orbital beam', stride = 552, keyed = true, layouts = { { stride = 568 } } },
    [T_HEAT] = { name = 'weapon heat', stride = 592, keyed = true },
    [T_SPRAY] = { name = 'spray weapon', stride = 224, keyed = true },
    -- explosions: melee weapons whose strike explodes, by entity -> explosion id (the Breaching
    -- Hammer's; no settings table links it, the game sets it off from the strike itself)
    [T_MELEE] = { name = 'melee weapon', stride = 192, keyed = true, explosions = { ['5F3EC9BDA2BD8553'] = 19 } },
    -- names: the status effects that deal damage, by type (the game's debug names Fire, Gas); game build 26088801
    -- (2026-10-22) put a new status at 32, the ones from there on moved up one
    [T_STATUS] = { name = 'status effect', stride = 160, tail = true,   -- 152 before game build 25988413
                   names = { [5] = 'Burning', [33] = 'Heavy burning', [43] = 'Gas', [44] = 'Gas' },
                   -- stuns deal no damage (no damage row of their own); the Illuminate one (42) no weapon applies
                   stuns = { [38] = 'Stun (small)', [39] = 'Stun (medium)', [40] = 'Stun (large)', [41] = 'Stun (massive)' } },
    [TYPES.arc_weapon] = { name = 'arc weapon', stride = 80, keyed = true },
    [TYPES.arc] = { name = 'arc', stride = 104 },
    [TYPES.health] = { name = 'health', stride = 22096, keyed = true,
        -- stratagem id -> sentry gun, for sentries whose stratagem drops a body the panel does not list
        -- (Laser Cannon Sentry, Tesla Tower, Defense Wall Grenade Launcher = the Grenadier Battlement)
        sentry_ids = { [0x393E6019] = '56070F36CFFFA8A8', [0x8F349F3B] = '74599E56F72F9D7E',
                       [0x93D3C05C] = '1D5943301A29C940' },
        -- the loadout's stratagem where a sentry has more than one (its cooldown is the one shown): the
        -- Rocket Sentry's payload is also called by an unlisted 0xC3386D38 (97.5 s vs 150 s)
        main_ids = { [0x2AC7580F] = true } },
    [TYPES.sensor] = { name = 'sensor', stride = 44, keyed = true },
    [TYPES.detector] = { name = 'detector', stride = 24, keyed = true },
    [TYPES.turret] = { name = 'turret', stride = 76, keyed = true, layouts = { { stride = 76, slack = 4 } } },
    -- attachments: each weapon's default ones (slot, item id: +0, 10 of them), the items (one table
    -- per group: +0 name, +8 id, +32 their deltas' resource), and the deltas: the values they set
    [TYPES.custom] = { name = 'weapon customization', stride = 4872, keyed = true, cache = {} },
    [TYPES.items] = { name = 'attachment items', stride = 88, tail = true, id_at = 8, groups = true, list = {} },
    [TYPES.deltas] = { name = 'attachment deltas', stride = 1 },
    -- throwables: carry counts and throw distance, their explosive (fuse, explosion), sticky (the knife's
    -- hit damage row; its records are followed by 4 bytes of padding)
    [TYPES.throwable] = { name = 'throwable', stride = 360, keyed = true },
    [TYPES.explosive] = { name = 'explosive', stride = 360, keyed = true },
    [TYPES.sticky] = { name = 'sticky', stride = 76, keyed = true, slack = 4 },
    -- one table per stratagem group (orbitals, eagles, backpacks, ...), rows keyed by the id at +4
    [T_STRATAGEM] = { name = 'stratagem', stride = 400, tail = true, id_at = 4, groups = true },
    -- armor passives (HelldiverCustomizationPassiveBonusSettings): one table per passive, all back to back
    [TYPES.passive] = { name = 'armor passive', stride = 1, groups = true, list = {} },
    -- vehicles (exosuits, FRVs, tanks): which entities are vehicles (VehicleComponentData), and what they
    -- carry (MountComponentData: 5 mounts of 24 bytes: +0 entity, +16 mount name)
    [TYPES.vehicle] = { name = 'vehicle', stride = 3704, keyed = true },
    [TYPES.mount] = { name = 'mount', stride = 120, keyed = true },
    -- energy shields (ShieldComponentData)
    [TYPES.shield] = { name = 'shield', stride = 344, keyed = true },
    -- hellpod racks (HellpodRackComponentData): a backpack stratagem's pod; 8 slots of 64 bytes, +0 the
    -- entity each carries
    [TYPES.rack] = { name = 'hellpod rack', stride = 568, keyed = true },
    -- charge weapons (WeaponChargeComponentData): 3 stages of 24 bytes (+0 charge time, +4 projectile),
    -- the multipliers the charge puts on the shot (+72: 6 pairs, at min charge / at overcharge), +208
    -- the overcharge limit. The plasma weapons fire their stages' projectiles, not the fire mode's.
    [TYPES.charge] = { name = 'weapon charge', stride = 216, keyed = true, MULTIPLIERS = {
        { 'speed', 'Velocity', 72 }, { 'damage', 'Damage', 80 }, { 'pen', 'Pen.', 88 }, { 'range', 'Range', 96 },
        { 'arc_splits', 'Arc splits', 104, arc = true }, { 'arc_chains', 'Arc chains', 112, arc = true } } },
    -- backpacks, by the entity a backpack stratagem's hellpod carries: jump / hover packs
    -- (JumppackComponentData, with RechargeComponentData), the Warp Pack (DisplacementComponentData)
    -- and charges (DepositComponentData: the Supply Pack's supplies, the Guard Dogs', the Hellbomb's;
    -- +24 a Guard Dog's drone entity)
    [TYPES.jumppack] = { name = 'jump pack', stride = 280, keyed = true },
    [TYPES.recharge] = { name = 'recharge', stride = 4, keyed = true },
    [TYPES.warp] = { name = 'warp pack', stride = 632, keyed = true },
    [TYPES.deposit] = { name = 'backpack charges', stride = 152, keyed = true },
}
-- LoadoutPackageComponentData: +8 the package the game loads for an entity in the loadout
KINDS[TYPES.package] = { name = 'loadout package', stride = 32, keyed = true }
-- WeaponReloadComponentData: +56 reload time (s); 0 on weapons whose magazine attachment sets it
-- (attachment component 113)
KINDS[TYPES.reload] = { name = 'reload', stride = 80, keyed = true }
-- WeaponWindUpComponentData (the M-1000 Maxigun, the G-16 Gatling): +0 wind-up seconds, +4 wind-down
-- seconds (HD2Runtime 0.24 research)
KINDS[TYPES.windup] = { name = 'wind-up', stride = 36, keyed = true }
-- minefields: the pod a minefield stratagem drops (ThrowerComponentData: 2 formations of 376 bytes, the
-- first throws the mines), the mines' own settings (MinefieldComponentData) and fixed fields
-- (MineSpawnerComponentData)
KINDS[TYPES.thrower] = { name = 'mine thrower', stride = 752, keyed = true }
KINDS[TYPES.minefield] = { name = 'minefield', stride = 44, keyed = true }
KINDS[TYPES.mine_spawner] = { name = 'mine spawner', stride = 32, keyed = true }
-- orbital barrages and strikes (BombardmentComponentData): +4 shells per salvo, +8 time between shells,
-- +24 salvos, +28 time between salvos, +36 spread area, +64 the shells' projectile pattern (8), +96
-- walking speed (the Walking Barrage)
KINDS[TYPES.bombard] = { name = 'bombardment', stride = 192, keyed = true }
-- Eagles (EagleComponentData): +16 payload (2 strafe, 4 rocket pods, 5 bombs), +20 drop pattern (fixes the
-- bomb count; not offered), +40 fire duration (guns, rockets), +44 time between bombs, +52 / +56 the shortest /
-- longest distance the jet starts its approach from (m), +76 its speed until it has fired (m/s), +108 run length (m)
KINDS[TYPES.eagle] = { name = 'eagle', stride = 152, keyed = true,
                       layouts = { { stride = 336, offsets = { [40] = 52, [44] = 56, [52] = 64, [56] = 68, [76] = 92, [108] = 124 } } } }
-- Seeking missiles (SeekingMissileComponentData; the MS-11 Solo Silo's missile): +12 guidance on after (s),
-- +28 guidance lost past this angle (deg), +56 / +60 movement / warhead on after (s; the silo's -1: by
-- its script, not offered), +64 max lifetime (s),
-- +68 launch, +72 minimum, +76 cruise speed, +80 acceleration, +88 / +92 turn speed at cruise / slowest.
-- Records of 272 bytes (FileDiver's layout ends at 252; 264 also fits the table, read off by 8 bytes).
KINDS[TYPES.seeking] = { name = 'seeking missile', stride = 272, keyed = true }
KINDS[TYPES.laser] = { name = 'laser designator', stride = 64, keyed = true }
-- AvatarComponentData (the helldiver's): its move info's speeds and stamina (offsets in MOVE)
KINDS[TYPES.avatar] = { name = 'avatar', stride = 852, keyed = true }
-- the tables the panel waits for (stratagem groups are taken as they come)
local KIND_ORDER = { T_WEAPON, T_MAGAZINE, T_ROUNDS, T_FIRE, T_PROJECTILE, T_DAMAGE, T_BEAM_WEAPON, T_BEAM,
                     T_EXPLOSION, T_ORBITAL, T_HEAT, T_SPRAY, T_STATUS, T_MELEE, TYPES.arc_weapon, TYPES.arc,
                     TYPES.health, TYPES.sensor, TYPES.detector, TYPES.turret, TYPES.custom, TYPES.deltas,
                     TYPES.throwable, TYPES.explosive, TYPES.sticky, TYPES.charge }

-- The deltas table: five arrays (pointer, count) head the payload: resource -> slot (u64, u32),
-- slot -> components (count, first), component (index, first delta, count), delta (offset in the
-- component, size, data offset), the data. Indexed by resource; `layout` keeps the arrays' offsets.
KINDS[TYPES.deltas].parse = function(blob, stride, spec, address)
    local at = {}
    for k = 0, 4 do
        local lo, hi = u32(blob, k * 16), u32(blob, k * 16 + 4)
        at[k] = lo and hi and lo + hi * 4294967296 - address - HEADER_BYTES
        if not at[k] or at[k] < 80 or at[k] >= #blob then return nil, 'delta layout does not match this build' end
    end
    local index, entries, count = {}, 0, u32(blob, 8) or 0
    if at[0] + count * 16 > #blob then return nil, 'delta layout does not match this build' end
    for k = 0, count - 1 do
        local key = blob:sub(at[0] + k * 16 + 1, at[0] + k * 16 + 8)
        if key ~= string.rep('\0', 8) then index[key] = u32(blob, at[0] + k * 16 + 8); entries = entries + 1 end
    end
    spec.layout = at
    return index, entries
end

-- Armor passive: +0 passive id, +4 name, +8 icon, +16 modifiers (pointer, count: 16 bytes each: id,
-- type 0 set / 1 add / 2 multiply / 3 seconds, value f32 +8, text), +32 weapon stat modifiers (pointer,
-- count: 12 bytes each: stat, f32, value f32 +8). The index: its id and where each value is.
KINDS[TYPES.passive].parse = function(blob, stride, spec, address)
    local id, mcount, scount = u32(blob, 0), u32(blob, 24), u32(blob, 40)
    if not (id and mcount and scount) or id > 1000 or mcount > 32 or scount > 32 or u32(blob, 28) ~= 0 or u32(blob, 44) ~= 0 then
        return nil, 'passive layout does not match this build'
    end
    local function at(ptr, count, size)
        if count == 0 then return 0 end
        local lo, hi = u32(blob, ptr), u32(blob, ptr + 4)
        local o = lo and hi and lo + hi * 4294967296 - address - HEADER_BYTES
        if not o or o < 48 or o + count * size > #blob then return nil end
        return o
    end
    local mo, so = at(16, mcount, 16), at(32, scount, 12)
    if not mo or not so then return nil, 'passive layout does not match this build' end
    local index = { id = id, mods = {}, stats = {} }
    for k = 0, mcount - 1 do
        index.mods[k + 1] = { id = u32(blob, mo + k * 16), type = u32(blob, mo + k * 16 + 4), offset = mo + k * 16 + 8 }
    end
    for k = 0, scount - 1 do index.stats[k + 1] = { stat = u32(blob, so + k * 12), offset = so + k * 12 + 8 } end
    return index, mcount + scount
end
KINDS[TYPES.passive].group_key = function(blob) return 'armor passive ' .. u32(blob, 0) end
-- names by passive id, as the armory shows them (matched to the wiki by their values)
KINDS[TYPES.passive].NAMES = {
    [1] = 'Extra Padding', [2] = 'Scout', [3] = 'Fortified', [5] = 'Electrical Conduit', [6] = 'Engineering Kit',
    [7] = 'Med-Kit', [8] = 'Servo-Assisted', [9] = 'Democracy Protects', [10] = 'Reinforced Epaulettes',
    [11] = 'Inflammable', [12] = 'Peak Physique', [13] = 'Advanced Filtration', [14] = 'Unflinching',
    [15] = 'Acclimated', [16] = 'Siege-Ready', [17] = 'Integrated Explosives', [18] = 'Gunslinger',
    [19] = 'Adreno-Defibrillator', [20] = 'Ballistic Padding', [21] = 'Desert Stormer', [31] = 'Feet First',
    [32] = 'Reduced Signature', [33] = 'Rock Solid', [34] = 'Supplementary Adrenaline',
    [35] = 'Concussive Padding (Reinforced)', [36] = 'Concussive Padding (Grenadier)',
    [37] = 'Concussive Padding (Hazmat)', [38] = 'Oxygenator', [39] = 'Kinetic Displacement Mitigation',
    [40] = 'Blunt-Force Mitigation', [41] = 'True Grit', [42] = 'Stationary Shroud' }
-- modifier labels by id (from the wiki's text for each passive, in the passive's own order)
KINDS[TYPES.passive].MODS = {
    [0xAFAE3B47] = '+ Armor rating', [0x26C969A1] = 'Throw range',
    [0x86A99BB9] = 'Limb health', [0xC36935A9] = 'Recoil crouching / prone',
    [0xF6FA9626] = '+ Throwables (start, max)', [0x2875F44A] = '+ Stims (start, max)',
    [0x93EB16A7] = '+ Stim duration (s)', [0x4BDF39C4] = 'Arc damage taken',
    [0x4DF29271] = 'Fire damage taken', [0xFBF54A40] = 'Limb injury avoidance',
    [0x25A59469] = 'Impact damage taken', [0xB5A50096] = 'Fire/gas/acid/arc damage taken',
    [0x1F98D152] = 'Explosive damage taken', [0x6E99CCE5] = 'Gas damage taken',
    [0xCB814D05] = 'Surviving lethal damage', [0xA68930C2] = 'Chest bleeding damage',
    [0xCC530B21] = 'Primary reload speed', [0x33C9C713] = 'Ammo capacity',
    [0x2559B40D] = 'Melee damage', [0x11A3C04C] = 'Knockdown chance',
    [0x2CFAECA3] = 'Chest damage taken', [0xCD79A687] = 'Walk / run speed',
    [0xF6D67313] = 'Slide speed / duration', [0xAF8B7112] = 'Noise',
    [0x432A7993] = 'Point of interest range', [0xB62B4AFD] = 'Leg injury immunity (1 on)',
    [0xC8CCB6FA] = '+ Ergonomics', [0x54A69284] = 'Explodes after death (s)',
    [0xB4F88129] = 'Secondary reload speed', [0xAD5289FE] = 'Secondary draw speed',
    [0x22035F3C] = 'Secondary recoil', [0x73734D67] = 'Flinch (0 prevents it)',
    [0x21A7BA64] = 'Marker radar scan every (s)', [0x35F17BEC] = 'Support reload speed',
    [0xA189ADB6] = '+ Stamina when hit', [0x14ECCE15] = 'Enemy detection range',
    -- Stationary Shroud (game build 25988413): aiming sway (three values, JOINED below), and the concealment while
    -- still and crouched / prone
    [0x33235131] = 'Aiming sway',
    [0x776A91FF] = 'Concealment when still, crouched / prone' }
-- modifiers the game describes as one (only the last carries the armory's text): one row writes them all, by
-- the id of the one with the text
KINDS[TYPES.passive].JOINED = { [0xF0B70521] = 0x33235131, [0x0FF508EB] = 0x33235131, [0x33235131] = 0x33235131 }
-- the weapon stat modifiers some passives also carry, by stat
KINDS[TYPES.passive].STATS = {
    [11] = 'Flinch', [12] = 'Ammo capacity', [13] = 'Primary reload speed', [14] = 'Support reload speed',
    [15] = 'Secondary reload speed', [16] = 'Secondary draw speed', [17] = 'Secondary recoil' }

-- kind -> { payload = size, index = key -> payload offset, entries = n, copies = { block address },
-- type = table type }; each stratagem group is under its own key (listed in stratagem_groups)
local tables, parsed_blocks, stratagem_groups = {}, {}, {}

-- Keyed table: bucket array (u64 entity hash, u32 record index, u32 0) holding exactly twice as
-- many buckets as entities, then fixed-stride records. Record bytes can look like buckets, so
-- every candidate bucket count is checked and exactly one must fit. Other mods can add entities
-- to the free buckets later (a new weapon or soldier), which breaks the twice rule (or makes a
-- wrong count fit it), so the count that fits is the one where every key sits where the game
-- looks it up (hash % buckets, then the next buckets up to the first empty one); the twice rule
-- alone is the fallback.
local function parse_keyed(blob, stride, spec)
    local MAX_UNINDEXED_RECORDS, ZERO8 = 2, string.rep('\0', 8)
    local slack = spec and spec.slack or 0   -- padding after the records
    local total, count, live, top, offset = #blob, 0, 0, -1, 0
    local candidates, twice = {}, {}
    local function empty(k) return u32(blob, k * 16) == 0 and u32(blob, k * 16 + 4) == 0 end
    local function placed(buckets)
        local wrap = 4294967296 % buckets
        for k = 0, buckets - 1 do
            if not empty(k) then
                local at = ((u32(blob, k * 16 + 4) % buckets) * wrap + u32(blob, k * 16)) % buckets
                while at ~= k do
                    if empty(at) then return false end
                    at = (at + 1) % buckets
                end
            end
        end
        return true
    end
    while offset + 16 <= total do
        local slot, pad = u32(blob, offset + 8), u32(blob, offset + 12)
        if pad ~= 0 or slot > 100000 then break end
        count = count + 1
        if u32(blob, offset) ~= 0 or u32(blob, offset + 4) ~= 0 then
            live = live + 1
            if slot > top then top = slot end
        end
        offset = offset + 16
        local array = total - count * 16 - slack
        if count <= 2 * live and array > 0 and array % stride == 0 then
            local records = array / stride
            if records > top and records <= live + MAX_UNINDEXED_RECORDS then
                candidates[#candidates + 1] = count
                if count == 2 * live then twice[#twice + 1] = count end
            end
        end
    end
    local fits = {}
    for _, n in ipairs(candidates) do if placed(n) then fits[#fits + 1] = n end end
    if #fits ~= 1 then fits = twice end
    if #fits ~= 1 then return nil, #fits .. ' layouts fit (need exactly 1)' end
    local buckets, index, entries = fits[1], {}, 0
    for k = 0, buckets - 1 do
        local key = blob:sub(k * 16 + 1, k * 16 + 8)
        if key ~= ZERO8 and not index[key] then
            index[key] = buckets * 16 + u32(blob, k * 16 + 8) * stride
            entries = entries + 1
        end
    end
    return index, entries
end

-- Row table: u64 descriptor, u32 row count, u32 0, then rows that carry a u32 id (at +0
-- unless `id_at`), then (`tail`) the strings and arrays the rows point to.
local function parse_rows(blob, stride, spec)
    local rows = u32(blob, 8)
    local size = rows and 16 + rows * stride
    if not rows or u32(blob, 12) ~= 0 or not (size == #blob or (spec and spec.tail and size <= #blob)) then
        return nil, 'row table size does not match this build'
    end
    local index, entries = {}, 0
    for row = 0, rows - 1 do
        local id = u32(blob, 16 + row * stride + (spec and spec.id_at or 0))
        if index[id] == nil then index[id] = 16 + row * stride; entries = entries + 1 end
    end
    return index, entries
end

-- Destruction (issue #44): what destroys a unit outright, by demolition force, apart from its health.
--   DestructionSettings: one table per unit (1641, back to back): 3 levels of 48 bytes: +0 effects (pointer,
--     count), +16 the tier (pointer to its template), +24 its type, +32 / +40 the same for direct hits
--     (type 0: none).
--   DestructionTemplates: (pointer, count), then templates of 16 bytes: +0 type, +4 demolition threshold
--     (1 small arms 10, 2 HMG / grenades 20, 3 autocannon / recoilless 30, 4 Strider / Eagle rockets 40,
--     5 orbital 50, 6 Hellbomb 60, 9 scripted 250). Another table of this type holds no templates.
--   DestructionHashMap: (pointer, count), then buckets of (u64 entity, u64 its settings' number); the
--     settings are numbered in the order they lie in memory.
--   HealthComponentData +21984: the type a unit applies to itself when its health runs out.
-- A level's row offers the tiers (OFFER) and writes the template pointer and type together, as the game
-- builds them; the health's type follows the level it named.
TYPES.destruction, TYPES.destruction_map, TYPES.destruction_tiers = 0xD6A11545, 0x49795156, 0xFB45E243
KINDS[TYPES.destruction] = { name = 'destruction', stride = 1, found = {}, OFFER = { 1, 2, 3, 4, 5, 6, 9 }, DEATH = 21984 }
KINDS[TYPES.destruction_map] = { name = 'destruction map', stride = 16 }
KINDS[TYPES.destruction_tiers] = { name = 'destruction tiers', stride = 16 }

-- (pointer, count) at +0: the array's payload offset (16, right after) and its count, or nil
KINDS[TYPES.destruction].array_at = function(blob, address)
    local lo, hi, count = u32(blob, 0), u32(blob, 4), u32(blob, 8)
    local at = lo and hi and lo + hi * 4294967296 - address - HEADER_BYTES
    if at ~= 16 or not count or u32(blob, 12) ~= 0 then return nil end
    return at, count
end

KINDS[TYPES.destruction_map].parse = function(blob, stride, spec, address)
    local at, count = KINDS[TYPES.destruction].array_at(blob, address)
    if not at or at + count * 16 > #blob then return nil, 'destruction map layout does not match this build' end
    local index, entries, ZERO8 = {}, 0, string.rep('\0', 8)
    for k = 0, count - 1 do
        local key = blob:sub(at + k * 16 + 1, at + k * 16 + 8)
        if key ~= ZERO8 then index[key] = u32(blob, at + k * 16 + 8); entries = entries + 1 end
    end
    return index, entries
end

KINDS[TYPES.destruction_tiers].parse = function(blob, stride, spec, address)
    local at, count = KINDS[TYPES.destruction].array_at(blob, address)
    local fits = at and count >= 10 and count <= 64 and at + count * 16 <= #blob
    for k = 0, fits and count - 1 or -1 do
        if u32(blob, at + k * 16) ~= k then fits = false break end
    end
    if not fits then
        parsed_blocks[address] = true   -- the other table of this type: not looked at again
        return nil, 'not the demolition tiers'
    end
    local index = {}
    for k = 0, count - 1 do index[k] = at + k * 16 end
    return index, count
end

-- The settings tables, once the map has as many as were found (in memory order): one table entry whose
-- block is the first; a unit's fields are at its own table's offset from there.
KINDS[TYPES.destruction].ready = function()
    local spec, map = KINDS[TYPES.destruction], tables[TYPES.destruction_map]
    if tables[TYPES.destruction] then return true end
    if not (map and tables[TYPES.destruction_tiers]) then return false end
    if #spec.found ~= map.entries then
        if not spec.told then spec.told = true; log('destruction: ' .. #spec.found .. ' settings for ' .. map.entries .. ' units; not editable') end
        return false
    end
    table.sort(spec.found)
    local head = api.read(spec.found[1], HEADER_BYTES)
    if not head then return false end
    tables[TYPES.destruction] = { payload = u32(head, 12), index = {}, entries = #spec.found, copies = { spec.found[1] },
                                  type = TYPES.destruction }
    log('destruction: ' .. #spec.found .. ' unit settings')
    return true
end

-- A level's demolition threshold from its 12 bytes (template pointer, type), nil unless the pointer is that
-- type's template
KINDS[TYPES.destruction].threshold = function(b)
    local tiers = tables[TYPES.destruction_tiers]
    if not tiers or not b or #b ~= 12 then return nil end
    local rel = tiers.index[u32(b, 8)]
    local rec = rel and tiers.copies[1] + HEADER_BYTES + rel
    if not rec or u32(b, 0) + u32(b, 4) * 4294967296 ~= rec then return nil end
    return KINDS[TYPES.destruction].at(rec + 4)
end

KINDS[TYPES.destruction].at = function(address)
    local b = api.read(address, 4)
    return b and #b == 4 and u32(b, 0) or nil
end

-- The bytes for a threshold: the tier with exactly it, else the next one in the direction of the change
-- (from the level's current one), nil past the last
KINDS[TYPES.destruction].bytes = function(f, value, now)
    local spec, tiers = KINDS[TYPES.destruction], tables[TYPES.destruction_tiers]
    local best, pick = nil, nil
    for _, t in ipairs(spec.OFFER) do
        local rec = tiers.index[t] and tiers.copies[1] + HEADER_BYTES + tiers.index[t]
        local th = rec and spec.at(rec + 4)
        if th and math.abs(th - value) < 0.5 then best, pick = th, t break end
        if th and now and value > now and th >= value and (not best or th < best) then best, pick = th, t end
        if th and now and value < now and th <= value and (not best or th > best) then best, pick = th, t end
    end
    if not pick then return nil end
    local rec = tiers.copies[1] + HEADER_BYTES + tiers.index[pick]
    return u32_bytes(rec % 4294967296) .. u32_bytes(math.floor(rec / 4294967296)) .. u32_bytes(pick)
end

local function have_all_tables()
    for _, kind in ipairs(KIND_ORDER) do
        if not tables[kind] then return false end
    end
    return true
end

-- ---------------------------------------------------------------- fields
-- A field is one value in one table record: kind, payload offset, storage, plausible range.
-- Fields are shared between weapons when their records are (projectile and damage rows).
local fields = {}       -- key -> field
local defaults = {}     -- key -> value before this mod first wrote it

local function field_at(kind, offset, storage, limit)
    local key = kind .. ':' .. offset
    local f = fields[key]
    if not f then
        f = { key = key, kind = kind, offset = offset, storage = storage, limit = limit, users = {} }
        fields[key] = f
    end
    return f
end

-- One value, read through a fixed buffer (api.read allocates one per call; the panel reads
-- a few hundred values when it resolves every weapon).
local peek_kernel, peek_process, peek_buffer, peek_count = nil, nil, nil, nil
local function peek4(address)
    if not peek_buffer then
        peek_kernel = ffi.load('kernel32')
        peek_process = peek_kernel.GetCurrentProcess()
        peek_buffer, peek_count = ffi.new('uint8_t[4]'), ffi.new('size_t[1]')
    end
    if peek_kernel.ReadProcessMemory(peek_process, ffi.cast('const void *', address), peek_buffer, 4, peek_count) == 0
       or tonumber(peek_count[0]) ~= 4 then return nil end
    return peek_buffer[0] + peek_buffer[1] * 256 + peek_buffer[2] * 65536 + peek_buffer[3] * 16777216
end

local function read_field(f)
    if f.storage == 'virtual' then   -- a value the editor keeps itself (no table field)
        if f.value == nil then return f.default end
        return f.value
    end
    local entry = tables[f.kind]
    if not entry then return nil end
    if f.storage == 'tier' then   -- a destruction level: its template pointer and type, read as the threshold
        return KINDS[TYPES.destruction].threshold(api.read(entry.copies[1] + HEADER_BYTES + f.offset, 12))
    end
    if f.storage == 'grenade' then
        return KINDS[TYPES.throwable].read_entity(api.read(entry.copies[1] + HEADER_BYTES + f.offset, 8))
    end
    if f.storage == 'flag' then   -- a bool byte
        local b = api.read(entry.copies[1] + HEADER_BYTES + f.offset, 1)
        b = b and b:byte()
        return b and b <= 1 and b or nil
    end
    local bits = peek4(entry.copies[1] + HEADER_BYTES + f.offset)
    if not bits then return nil end
    local value = bits
    if f.storage == 'f32' then value = bits_to_f32(bits) end
    if value ~= value or value < (f.signed and -f.limit or 0) or value > f.limit then return nil end   -- implausible: layout moved
    return value
end

local function encode(f, value)
    if f.storage == 'grenade' then return KINDS[TYPES.throwable].entity_bytes(value) end
    if f.storage == 'f32' then return f32_bytes(value) end
    if f.storage == 'flag' then return value >= 0.5 and string.char(1) or string.char(0) end
    return u32_bytes(math.floor(value + 0.5))
end

local function default_of(f)
    if defaults[f.key] == nil then defaults[f.key] = read_field(f) end
    return defaults[f.key]
end

-- Writes every copy of the table; read back, or rolled back.
local function write_field(f, value)
    if f.storage == 'virtual' then
        default_of(f)
        f.value = value
        state.writes = state.writes + 1
        return true
    end
    local entry = tables[f.kind]
    if not entry then return false, 'table not found' end
    if read_field(f) == nil then return false, 'current value implausible' end
    if type(value) == 'number' and not MOD.parse_number(value) then return false, 'not a finite number' end
    default_of(f)
    if f.most and value > f.most then value = f.most end
    local bytes, done = nil, {}
    if f.storage == 'tier' then bytes = KINDS[TYPES.destruction].bytes(f, value, read_field(f))
    else bytes = encode(f, value) end
    if not bytes then return false, f.storage == 'tier' and 'no demolition tier there' or 'unknown grenade selection' end
    if f.storage == 'grenade' and value ~= 0 then
        local ok, why = KINDS[TYPES.throwable].ensure_launch()
        if not ok then return false, why end
        ok, why = KINDS[TYPES.throwable].ensure_assets(value)
        if not ok then return false, why end
    end
    for _, block in ipairs(entry.copies) do
        local at = block + HEADER_BYTES + f.offset
        local before = api.read(at, #bytes)
        if not before then
            for _, undo in ipairs(done) do api.write(undo[1], undo[2]) end
            return false, 'read failed at ' .. hex(at)
        end
        done[#done + 1] = { at, before }
        if not api.write(at, bytes) or api.read(at, #bytes) ~= bytes then
            for _, undo in ipairs(done) do api.write(undo[1], undo[2]) end
            return false, 'write failed at ' .. hex(at)
        end
    end
    state.writes = state.writes + 1
    if f.storage == 'grenade' then KINDS[TYPES.throwable].rearm() end
    if f.storage == 'tier' and f.death then write_field(f.death, u32(bytes, 8)) end   -- the health's type follows
    return true
end

-- ---------------------------------------------------------------- weapons
-- Stat rows. A row edits one or more fields of a weapon (recoil rows move drift and climb
-- together). `small`/`big` are the step sizes; `max` bounds what the panel lets you set.
local weapons, by_hash = {}, {}

local function hash_key(hex16)
    local hi, lo = tonumber(hex16:sub(1, 8), 16), tonumber(hex16:sub(9, 16), 16)
    return u32_bytes(lo) .. u32_bytes(hi)
end

for _, w in ipairs(WEAPONS) do
    local weapon = { name = w[1], slot = w[2], hash = w[3], note = w[4] or '', key = hash_key(w[3]),
                     rows = {}, by_id = {} }
    weapons[#weapons + 1] = weapon
    by_hash[w[3]] = weapon
end

-- Stable saved selector IDs. Append new entries; never reorder. These are entities,
-- not ProjectileType IDs. Knife and shield are not grenade donors.
KINDS[TYPES.throwable].grenade_hashes = {
    '04653AB33F3FFB44', '3FA94F58F596BC0B', '6B11FC757618C57E', 'C5C05FCB5747C799',
    'EB725C39FC38B87C', '03F31CAF3A7D8F4E', '7686544F539BB9B7', '0080869506299773',
    '5DE8FD02A05B4B0A', 'DB922A7AFC42894B', '0416984F4922757B', '46333FC9E3D4BD34',
    '2D398D1EC35E0838', '4CE9EAB785A79B7B', '8E325C933E55BF62', '075B19B068FB1045',
    '5C14F27759DD3BE0', 'DAB81B0D80B511C7', 'EE4C107B941AB7F4', '14368DC8784220B0',
    'A20683199DFC19E8',
}
KINDS[TYPES.throwable].grenade_hosts = {
    ['02CD7321CD8445F5'] = true, -- One-Two underbarrel
    ['006E44327BB953FE'] = true, -- Evictor
    ['9EB160830321BFD6'] = true, -- Ultimatum
    ['52E4334E6A128CAF'] = true, -- Grenade Pistol
    ['02EECD0B1FA49630'] = true, -- GL-21
    ['88C2D09AD85A7C9F'] = true, -- Belt-Fed GL
    ['FE3B29B2CFA63F9B'] = true, -- De-Escalator
    ['1D5943301A29C940'] = true, -- Grenadier Battlement
}

KINDS[TYPES.throwable].prepare_grenades = function()
    local spec = KINDS[TYPES.throwable]
    spec.choices, spec.by_id, spec.by_entity = { { id = 0, label = 'Normal projectile' } }, {}, {}
    spec.known = {}   -- every donor, offered or not: a launcher still holding one reads as it (and resets)
    for id, hash in ipairs(spec.grenade_hashes) do
        local w = by_hash[hash]
        if w then spec.known[w.key] = id end
        if w and tables[TYPES.throwable] and tables[TYPES.throwable].index[w.key]
           and tables[TYPES.explosive] and tables[TYPES.explosive].index[w.key] then
            local shot = { id = id, key = w.key, label = w.name }
            spec.by_id[id], spec.by_entity[w.key] = shot, id
            spec.choices[#spec.choices + 1] = shot
        end
    end
end

KINDS[TYPES.throwable].read_entity = function(bytes)
    if bytes == string.rep('\0', 8) then return 0 end
    local spec = KINDS[TYPES.throwable]
    return bytes and (spec.by_entity and spec.by_entity[bytes] or spec.known and spec.known[bytes])
end

KINDS[TYPES.throwable].entity_bytes = function(id)
    if id == 0 then return string.rep('\0', 8) end
    local shot = KINDS[TYPES.throwable].by_id and KINDS[TYPES.throwable].by_id[id]
    return shot and shot.key
end

KINDS[TYPES.throwable].step = function(id, n)
    local list = KINDS[TYPES.throwable].choices or {}
    for at, shot in ipairs(list) do
        if shot.id == id then return list[math.max(1, math.min(#list, at + n))].id end
    end
    return id
end

local function add_row(weapon, section, id, label, storage, parts, min, max, small, big)
    local row = { section = section, id = id, label = label, storage = storage, parts = parts,
                  min = min, max = max, small = small, big = big }
    weapon.rows[#weapon.rows + 1] = row
    for _, part in ipairs(parts) do
        weapon.by_id[part.id] = part
        part.row = part.row or row
        part.field.users[#part.field.users + 1] = weapon
    end
    return row
end

local function part(id, kind, offset, storage, limit)
    return { id = id, field = field_at(kind, offset, storage, limit) }
end

local function read_text(address)
    local bytes = address and address > 65536 and api.read(address, 96)
    local text = bytes and bytes:match('^([^%z]*)%z')
    if not text or #text < 3 or text:find('[^\32-\126]') then return nil end
    return text
end

-- Attachment items, per group table (`prepare`, once): their names, in table order, and lines: the
-- items of one weapon line, listed together, each starting at a new family ('Rifle 5,5x50mm.') or a
-- 'Standard' item. `words`: an item's deltas, 'component:offset' -> payload offset in the deltas, for
-- magazine (component 5) and heat (266) values and the weapon's stat bonuses (236, +956: 8 of type,
-- value); `mods`: where an item's stat modifiers are, type -> value (0 ergonomics, added; the rest
-- multiply: 1 sway, 2 / 4 recoil horizontal / vertical, 10 / 12 recoil climb, 14 / 16 spread, each followed by
-- its 'Alt' twin, 3 / 5 / ...: WeaponStatModifierType; MODS: their rows).
KINDS[TYPES.items].prepare = function(t)
    if t.lines then return end
    t.lines, t.order, t.names, t.labels = {}, {}, {}, {}
    local top, line, last = t.copies[1] + HEADER_BYTES, 0, nil
    for k = 0, (peek4(top + 8) or 0) - 1 do
        local r = 16 + k * 88
        local lo, hi = peek4(top + r), peek4(top + r + 4)
        local label = read_text(lo and hi and lo + hi * 4294967296) or ''
        local name = label:lower()
        local family = name:match('^([^%.]+)%.') or name:match('^(%S+ %S+)') or name
        if family ~= last or name:find('standard') then line = line + 1 end
        last, t.lines[r], t.order[#t.order + 1], t.names[r] = family, line, r, name
        t.labels[r] = label:gsub('%a+', function(word)
            if #word <= 2 or word ~= word:upper() or word:find('^MK') then return word end
            return word:sub(1, 1) .. word:sub(2):lower()
        end)
    end
end

KINDS[TYPES.items].find = function(id)
    for _, group in ipairs(id and id ~= 0 and KINDS[TYPES.items].list or {}) do
        local t = tables[group]
        if t and t.index[id] then KINDS[TYPES.items].prepare(t); return t, t.index[id] end
    end
end

-- Game build 25988413 (2026-10-20) renumbered the components (weapon 236 -> 239, heat 266 -> 269, reload
-- 113 -> 114, projectile 321 -> 324) and moved the weapon's stat bonuses 8 bytes on (its records grew): `words`
-- names them as before.
KINDS[TYPES.items].RENUMBERED = { [239] = 236, [269] = 266, [114] = 113, [324] = 321,
                                  [236] = false, [266] = false, [113] = false, [321] = false }
KINDS[TYPES.items].words = function(t, r)
    local deltas, at, out = tables[TYPES.deltas], KINDS[TYPES.deltas].layout, {}
    local renumbered = KINDS[T_WEAPON].stride == 1240 and KINDS[TYPES.items].RENUMBERED
    local slot = deltas and at and deltas.index[api.read(t.copies[1] + HEADER_BYTES + r + 32, 8) or '']
    if not slot then return out end
    local d = deltas.copies[1] + HEADER_BYTES
    local count, first = peek4(d + at[1] + slot * 8), peek4(d + at[1] + slot * 8 + 4)
    for c = first or 0, (first or 0) + (count or 0) - 1 do
        local comp = peek4(d + at[2] + c * 12)
        if renumbered and renumbered[comp] ~= nil then comp = renumbered[comp] end
        if comp == 5 or comp == 266 or comp == 236 or comp == 113 then
            local fd, nd = peek4(d + at[2] + c * 12 + 4), peek4(d + at[2] + c * 12 + 8)
            for x = fd, fd + nd - 1 do
                local offset, size, data = peek4(d + at[3] + x * 12), peek4(d + at[3] + x * 12 + 4), peek4(d + at[3] + x * 12 + 8)
                if renumbered and comp == 236 and offset >= 488 then offset = offset - 8 end
                for w = 0, size - 4, 4 do
                    if (comp ~= 236 or (offset + w >= 956 and offset + w < 1020)) and (comp ~= 113 or offset + w == 56) then
                        out[comp .. ':' .. (offset + w)] = at[4] + data + w
                    end
                end
            end
        end
    end
    return out
end

KINDS[TYPES.items].mods = function(words)
    local d, out = tables[TYPES.deltas].copies[1] + HEADER_BYTES, {}
    for e = 0, 7 do
        local kind, value = words['236:' .. (956 + e * 8)], words['236:' .. (960 + e * 8)]
        local type = kind and value and peek4(d + kind)
        if type and type < 18 and not out[type] then out[type] = value end
    end
    return out
end

KINDS[TYPES.items].MODS = {
    { 0, 'ergonomics', 'Ergonomics bonus', -100, 100, 1, 5 },
    { 1, 'sway', 'Sway multiplier', 0, 50, 0.05, 0.25 },
    { 2, 'recoil_h', 'Recoil multiplier (horizontal)', 0, 50, 0.05, 0.25 },
    { 4, 'recoil_v', 'Recoil multiplier (vertical)', 0, 50, 0.05, 0.25 },
    { 10, 'climb_h', 'Climb multiplier (horizontal)', 0, 50, 0.05, 0.25 },
    { 12, 'climb_v', 'Climb multiplier (vertical)', 0, 50, 0.05, 0.25 },
    { 14, 'spread_h', 'Spread multiplier (horizontal)', 0, 50, 0.05, 0.25 },
    { 16, 'spread_v', 'Spread multiplier (vertical)', 0, 50, 0.05, 0.25 },
}

-- An attachment's stat modifier rows on `entry` (`mods`: type -> where its value is in the deltas), ids
-- `pre` .. stat. A multiplier's 'Alt' twin (the next type: recoil, climb and spread have one) moves with it.
KINDS[TYPES.items].mod_rows = function(entry, section, pre, mods)
    for _, m in ipairs(KINDS[TYPES.items].MODS) do
        local offset = mods[m[1]]
        if offset then
            local f = field_at(TYPES.deltas, offset, 'f32', 1000)
            f.signed = m[4] < 0
            local parts = { { id = pre .. m[2], field = f } }
            local alt = m[1] >= 2 and mods[m[1] + 1]
            if alt then parts[2] = { id = pre .. m[2] .. '_alt', field = field_at(TYPES.deltas, alt, 'f32', 1000) } end
            add_row(entry, section, pre .. m[2], m[3], 'f32', parts, m[4], m[5], m[6], m[7])
        end
    end
end

-- The projectile a weapon's default attachments give its fire mode (+0), when they set one (the P-2
-- Peacemaker's and P-19 Redeemer's ammo type): component 321, offset 0, 4 bytes; the last slot wins.
-- Also returns where that value sits in the deltas (payload offset).
KINDS[TYPES.custom].projectile = function(key)
    local custom, spec, deltas, at = tables[TYPES.custom], KINDS[TYPES.items], tables[TYPES.deltas], KINDS[TYPES.deltas].layout
    local row = custom and deltas and at and custom.index[key]
    if not row then return nil end
    local base, d, out, out_at = custom.copies[1] + HEADER_BYTES + row, deltas.copies[1] + HEADER_BYTES, nil, nil
    local renumbered = KINDS[T_WEAPON].stride == 1240 and spec.RENUMBERED
    for s = 0, 8 do
        local t, r = spec.find(peek4(base + s * 8 + 4))
        local slot = t and deltas.index[api.read(t.copies[1] + HEADER_BYTES + r + 32, 8) or '']
        if slot then
            local count, first = peek4(d + at[1] + slot * 8) or 0, peek4(d + at[1] + slot * 8 + 4) or 0
            local value, value_at = nil, nil
            for c = first, first + count - 1 do
                local comp = peek4(d + at[2] + c * 12)
                if renumbered and renumbered[comp] ~= nil then comp = renumbered[comp] end
                if not value and comp == 321 then
                    local fd, nd = peek4(d + at[2] + c * 12 + 4) or 0, peek4(d + at[2] + c * 12 + 8) or 0
                    for x = fd, fd + nd - 1 do
                        if peek4(d + at[3] + x * 12) == 0 and peek4(d + at[3] + x * 12 + 4) == 4 then
                            value_at = at[4] + (peek4(d + at[3] + x * 12 + 8) or 0)
                            value = peek4(d + value_at)
                            break
                        end
                    end
                end
            end
            if value and value > 0 then out, out_at = value, value_at end
        end
    end
    return out, out_at
end

-- Where a weapon's default attachments set its rounds feeds' projectiles (the SG-20 Halt's ammo type
-- and alternate ammo type, the SG-8 Punisher's and P-4 Senator's ammo type): a 4-byte delta at offset
-- 64 or 68 that holds the rounds record's own value there (`own`: offset -> projectile id), on any
-- component. Returns offset -> where each sits in the deltas (payload offset); the last slot wins.
KINDS[TYPES.custom].feeds = function(key, own)
    local custom, spec, deltas, at = tables[TYPES.custom], KINDS[TYPES.items], tables[TYPES.deltas], KINDS[TYPES.deltas].layout
    local row = custom and deltas and at and custom.index[key]
    local out = {}
    if not row then return out end
    local base, d = custom.copies[1] + HEADER_BYTES + row, deltas.copies[1] + HEADER_BYTES
    for s = 0, 8 do
        local t, r = spec.find(peek4(base + s * 8 + 4))
        local slot = t and deltas.index[api.read(t.copies[1] + HEADER_BYTES + r + 32, 8) or '']
        if slot then
            local count, first = peek4(d + at[1] + slot * 8) or 0, peek4(d + at[1] + slot * 8 + 4) or 0
            for c = first, first + count - 1 do
                local comp = peek4(d + at[2] + c * 12)
                local fd, nd = peek4(d + at[2] + c * 12 + 4) or 0, peek4(d + at[2] + c * 12 + 8) or 0
                for x = fd, fd + nd - 1 do
                    local offset, size = peek4(d + at[3] + x * 12) or 0, peek4(d + at[3] + x * 12 + 4) or 0
                    local data = at[4] + (peek4(d + at[3] + x * 12 + 8) or 0)
                    for w = 0, size - 4, 4 do
                        local value = peek4(d + data + w)
                        if own[offset + w] and value == own[offset + w] then out[offset + w] = data + w end
                    end
                end
            end
        end
    end
    return out
end

-- A weapon's magazine attachments (its slot 5 line: magazines, heatsinks, canisters) set magazine,
-- reload and heat values of their own over the weapon's, and modify its stats. For the weapon entity
-- `key`: { items = the line's attachments, the one it comes with first: { id, name, default (true for
-- that one), words ('component:offset' -> payload offset in the deltas of each value it sets), mods
-- (type -> its stat modifiers) } }. The weapon's line: the items listed with its default one.
-- Weapons whose other magazines are a line of their own: weapon -> that line's name. The AR-59
-- Suppressor comes with the Liberator's Extended; its Short and Drum are 'whisper' ones.
KINDS[TYPES.custom].LINES = { [hash_key('708EA298C82093D0')] = 'whisper rifle 5,5x50mm.' }

local function attachments(key)
    local cache = KINDS[TYPES.custom].cache
    if cache[key] ~= nil then return cache[key] end
    cache[key] = false
    local custom, spec = tables[TYPES.custom], KINDS[TYPES.items]
    local row = custom and tables[TYPES.deltas] and KINDS[TYPES.deltas].layout and custom.index[key]
    if not row then return false end
    local base, fitted = custom.copies[1] + HEADER_BYTES + row, {}
    for slot = 0, 9 do
        local kind = peek4(base + slot * 8)
        if kind then fitted[kind] = peek4(base + slot * 8 + 4) end
    end
    local out, t, mine = { items = {} }, spec.find(fitted[5])
    local also = KINDS[TYPES.custom].LINES[key]
    for _, r in ipairs(t and t.order or {}) do
        local listed = also and (r == mine or t.names[r]:sub(1, #also) == also) or (not also and t.lines[r] == t.lines[mine])
        if listed then
            local words = spec.words(t, r)
            local mods, any = spec.mods(words), false
            for word in pairs(words) do
                if word:find('^236:') then words[word] = nil else any = true end
            end
            if any or next(mods) then
                local top = t.copies[1] + HEADER_BYTES
                local item = { id = peek4(top + r + 8) or 0, name = MOD.item_names[peek4(top + r + 16) or 0] or t.labels[r],
                               default = r == mine, words = words, mods = mods }
                table.insert(out.items, item.default and 1 or #out.items + 1, item)
            end
        end
    end
    cache[key] = out
    return out
end

-- The Attachments tab: every optic, underbarrel and muzzle with an ergonomics, sway, recoil or spread modifier,
-- as an entry of its own (they apply to every weapon fitted with it). A Custom muzzle brake is one weapon's
-- own (the Penetrator's, the Adjudicator's, ...): named after the weapon that comes with it (no designation).
-- Ammunition types (slot 6, and 7: a weapon's alternate load) take the game's names (MOD.item_names, by the
-- item's text id at +16), else their own ('Shotgun 10g. Buckshot' -> '10g Buckshot').
KINDS[TYPES.items].build = function()
    for k = #weapons, 1, -1 do
        if weapons[k].attachment then by_hash[weapons[k].hash] = nil; table.remove(weapons, k) end
    end
    local spec, list = KINDS[TYPES.items], {}
    local kinds = { [1] = 'Underbarrel', [2] = 'Optic', [4] = 'Muzzle', [6] = 'Ammunition', [7] = 'Alternate ammunition' }
    local custom, owner = tables[TYPES.custom], {}
    for _, w in ipairs(weapons) do
        local row = custom and w.key and not w.stratagem and custom.index[w.key]
        for slot = 0, row and 9 or -1 do
            local at = custom.copies[1] + HEADER_BYTES + row + slot * 8
            local id = peek4(at) == 4 and peek4(at + 4)
            if id and id ~= 0 and not owner[id] then owner[id] = w.name end
        end
    end
    for _, group in ipairs(spec.list) do
        local t = tables[group]
        spec.prepare(t)
        local top = t.copies[1] + HEADER_BYTES
        for _, r in ipairs(t.order) do
            local lo, hi, n = peek4(top + r + 48), peek4(top + r + 52), peek4(top + r + 56)
            local slot = lo and hi and n and n > 0 and n < 8 and peek4(lo + hi * 4294967296)
            local mods = kinds[slot] and spec.mods(spec.words(t, r))
            local any = false
            for _, m in ipairs(spec.MODS) do any = any or (mods and mods[m[1]] ~= nil) end
            local id = peek4(top + r + 8)
            local hash = any and string.format('FFFFFFFF%08X', id)
            local own = t.names[r]:find('custom') and owner[id]
            local name = own and ('Muzzle brake (' .. own:gsub('^%S*%d%S*%s+', '') .. ')') or t.labels[r]
            if slot == 6 or slot == 7 then
                name = MOD.item_names[peek4(top + r + 16) or 0]
                       or t.labels[r]:gsub(' [Aa]lternate$', ''):gsub('^%a[%a%-]* ', ''):gsub('%. ', ' ', 1)
                if slot == 7 then name = name .. ' (alternate)' end
            end
            if hash and not by_hash[hash] then
                list[#list + 1] = { name = name, slot = 'Attachments', hash = hash, rows = {}, by_id = {},
                                    note = own and ('Muzzle. Only the ' .. own .. ' comes with it.')
                                           or slot >= 6 and (kinds[slot] .. '. Its modifiers apply to every weapon loaded with it.')
                                           or (kinds[slot] .. '. Its modifiers apply to every weapon fitted with it.'),
                                    attachment = { mods = mods, order = slot == 2 and 1 or slot == 1 and 2 or slot == 4 and 3 or 4 } }
                by_hash[hash] = list[#list]
            end
        end
    end
    table.sort(list, function(a, b)
        if a.attachment.order ~= b.attachment.order then return a.attachment.order < b.attachment.order end
        return a.name:lower() < b.name:lower()
    end)
    for _, entry in ipairs(list) do weapons[#weapons + 1] = entry end
    log('attachments: ' .. #list .. ' with ergonomics, sway, recoil or spread modifiers listed')
end

KINDS[TYPES.passive].build = function()
    for k = #weapons, 1, -1 do
        if weapons[k].passive then by_hash[weapons[k].hash] = nil; table.remove(weapons, k) end
    end
    -- the helldiver (offline), first on the Armors tab
    local A = KINDS[TYPES.avatar]
    local key = hash_key(A.ENTITY)
    if MOD.offline and not by_hash[A.ENTITY] and ((tables[TYPES.health] and tables[TYPES.health].index[key])
                                                  or (tables[TYPES.avatar] and tables[TYPES.avatar].index[key])) then
        by_hash[A.ENTITY] = { name = 'Helldiver', slot = 'Armors', hash = A.ENTITY, key = key, rows = {}, by_id = {}, player = true,
                              note = 'Every helldiver in your game. Restore the game\'s files before joining other players\' lobbies.' }
        weapons[#weapons + 1] = by_hash[A.ENTITY]
    end
    local spec, list = KINDS[TYPES.passive], {}
    for _, group in ipairs(spec.list) do
        local index = tables[group].index
        local hash = string.format('FFFFFFFE%08X', index.id)
        if index.id ~= 0 and not by_hash[hash] then
            list[#list + 1] = { name = spec.NAMES[index.id] or ('Passive ' .. index.id), slot = 'Armors', hash = hash,
                                key = hash_key(hash), rows = {}, by_id = {}, passive = group,
                                note = 'Shared by every armor with this passive. Multipliers: 1 = no change.' }
            by_hash[hash] = list[#list]
        end
    end
    table.sort(list, function(a, b) return a.name:lower() < b.name:lower() end)
    for _, entry in ipairs(list) do weapons[#weapons + 1] = entry end
    log('armor passives: ' .. #list .. ' listed')
end

-- The helldiver: its health component (main health +0, each named zone's health +232; zones of 552 bytes from +520,
-- the name at +96) and its avatar's move info (MOVE: section, id, label, offset, max, small / big step).
KINDS[TYPES.avatar].ENTITY = '4D1C334D294DFA97'   -- content/fac_helldivers/cha_avatar/avatar_helldiver
KINDS[TYPES.avatar].ZONES = { [0x8C5570C9] = 'Head', [0xAA1DB0B0] = 'Body', [0x1880288E] = 'Left arm',
                              [0xB6F2BAF5] = 'Right arm', [0x64A3FA1D] = 'Left leg', [0x87B05FF4] = 'Right leg' }
KINDS[TYPES.avatar].MOVE = {
    { 'Movement', 'walk', 'Walk speed (m/s)', 12, 50, 0.1, 0.5 }, { 'Movement', 'jog', 'Jog speed (m/s)', 16, 50, 0.1, 0.5 },
    { 'Movement', 'sprint', 'Sprint speed (m/s)', 20, 50, 0.1, 0.5 },
    { 'Movement', 'sprint_exerted', 'Sprint speed, out of stamina (m/s)', 24, 50, 0.1, 0.5 },
    { 'Movement', 'aim', 'Speed while aiming (m/s)', 8, 50, 0.1, 0.5 },
    { 'Movement', 'crouch_walk', 'Crouched walk speed (m/s)', 32, 50, 0.1, 0.5 },
    { 'Movement', 'crouch_jog', 'Crouched jog speed (m/s)', 36, 50, 0.1, 0.5 },
    { 'Movement', 'crouch_sprint', 'Crouched sprint speed (m/s)', 40, 50, 0.1, 0.5 },
    { 'Movement', 'crouch_aim', 'Crouched speed while aiming (m/s)', 28, 50, 0.1, 0.5 },
    { 'Movement', 'prone', 'Prone speed (m/s)', 44, 50, 0.1, 0.5 }, { 'Movement', 'swim', 'Swim speed (m/s)', 48, 50, 0.1, 0.5 },
    { 'Movement', 'reversing', 'Walking backwards (multiplier)', 4, 10, 0.05, 0.25 },
    { 'Stamina', 'sprint_drain', 'Sprinting empties it in (s)', 52, 3600, 1, 5 },
    { 'Stamina', 'jog_drain', 'Jogging empties it in (s)', 56, 3600, 1, 10 },
    { 'Stamina', 'recover_stand', 'Refills standing in (s)', 60, 600, 0.5, 2 },
    { 'Stamina', 'recover_crouch', 'Refills crouched in (s)', 64, 600, 0.5, 2 },
    { 'Stamina', 'recover_prone', 'Refills prone in (s)', 68, 600, 0.5, 2 },
    { 'Stamina', 'recover_delay', 'Refill starts after (s)', 72, 60, 0.1, 0.5 },
    { 'Stamina', 'cost_jump', 'Jump cost (share of stamina)', 76, 1, 0.05, 0.1 },
    { 'Stamina', 'cost_dive', 'Dive cost (share of stamina)', 80, 1, 0.05, 0.1 } }
KINDS[TYPES.avatar].resolve = function(entry)
    local A, ht, at = KINDS[TYPES.avatar], tables[TYPES.health], tables[TYPES.avatar]
    local h = ht and ht.index[entry.key]
    if h then
        add_row(entry, 'Health', 'health', 'Health', 'u32', { part('health', TYPES.health, h, 'u32', 10000000) }, 1, 100000, 5, 25)
        local top = ht.copies[1] + HEADER_BYTES
        for z = 0, 37 do
            local base = h + 520 + z * 552
            local label = A.ZONES[peek4(top + base + 96) or 0]
            if label then
                local id = 'zone' .. z .. '_health'
                add_row(entry, 'Body parts', id, label .. ' health', 'u32',
                        { part(id, TYPES.health, base + 232, 'u32', 10000000) }, 1, 100000, 5, 25)
            end
        end
    end
    local m = at and at.index[entry.key]
    if m then
        for _, f in ipairs(A.MOVE) do
            add_row(entry, f[1], f[2], f[3], 'f32', { part(f[2], TYPES.avatar, m + f[4], 'f32', 100000) }, 0, f[5], f[6], f[7])
        end
    end
end

-- A passive's rows: each modifier (named, or by its id), then its weapon stat modifiers.
KINDS[TYPES.passive].resolve = function(entry)
    local spec, t = KINDS[TYPES.passive], tables[entry.passive]
    if not t then return end
    --        type: min, max, small step, big step
    local RANGE = { [0] = { 0, 10, 1, 1 }, [1] = { 0, 1000, 0.5, 5 }, [2] = { 0, 10, 0.05, 0.25 }, [3] = { 0, 600, 0.5, 2 } }
    local joined = {}   -- a modifier the game describes with another -> that one's row
    for k, m in ipairs(t.index.mods) do
        local r = RANGE[m.type]
        if m.id ~= 0 and r then
            local id = string.format('mod_%08X', m.id)
            if entry.by_id[id] then id = id .. '_' .. k end
            local p, with = part(id, entry.passive, m.offset, 'f32', 100000), spec.JOINED[m.id]
            local row = with and joined[with .. '_' .. m.type]
            if row then
                row.parts[#row.parts + 1] = p
                entry.by_id[id], p.row = p, row
                p.field.users[#p.field.users + 1] = entry
            else
                row = add_row(entry, 'Passive', id, spec.MODS[with or m.id] or string.format('Modifier %08X', m.id), 'f32',
                              { p }, r[1], r[2], r[3], r[4])
                if with then joined[with .. '_' .. m.type] = row end
            end
        end
    end
    for _, st in ipairs(t.index.stats) do
        local id = 'stat_' .. st.stat
        if not entry.by_id[id] then
            add_row(entry, 'Weapon stats', id, spec.STATS[st.stat] or ('Stat ' .. st.stat), 'f32',
                    { part(id, entry.passive, st.offset, 'f32', 100000) }, 0, 10, 0.05, 0.25)
        end
    end
end

-- Adds a damage row's stats (the first `count`, default all) to `entry`, ids `prefix` .. stat id.
-- `what` names the damage / durable rows ('Explosion' -> 'Explosion damage'); `strike`: steps of 10 / 100 for those.
local function damage_rows(entry, section, prefix, drow, what, count, strike)
    local first
    for k = 1, count or 9 do
        local r = KINDS[T_DAMAGE].rows[k]
        local id, named = prefix .. r[1], k <= 2
        local row = add_row(entry, section, id, (named and what) and (what .. ' ' .. r[2]:lower()) or r[2], 'u32',
                            { part(id, T_DAMAGE, drow + r[3], 'u32', 1000000) }, 0, r[4],
                            (named and strike) and 10 or r[5], (named and strike) and 100 or r[6])
        first = first or row
    end
    return first
end

-- Adds the rows of the gun whose entity hash is `key` (8 bytes) to `weapon` (a weapon, or a
-- stratagem whose payload is a gun: sentries, emplacements).
-- The status effects damage row `drow` applies that deal damage (fire from flamers, incendiary rounds
-- and grenades, gas) or stun: how much each hit applies (`per`: 'hit', 'blast'), then the status's damage
-- row (none for a stun) and duration (every source of that status shares them). Ids: `prefix` .. 'status<type>_' .. stat.
-- The status effects a hit can be given (issue #24): the ones player weapons already apply, by this build's type
-- number (StatusEffectSettings rows, told apart by their durations), with a usual strength (written when an empty
-- slot gets one). DamageInfo +44 + 8n: 4 slots of { type u32, strength f32 }, packed from the first.
MOD.status = { choices = {
    { 5, 'Burning', 3 }, { 33, 'Heavy burning', 50 }, { 6, 'Fire panic', 3 }, { 68, 'Flamethrower slow', 1 },
    { 38, 'Stun (small)', 10 }, { 39, 'Stun (medium)', 50 }, { 40, 'Stun (large)', 25 },
    { 43, 'Gas', 100 }, { 45, 'Gas confusion', 100 }, { 44, 'Gas (Sterilizer)', 1 }, { 46, 'Gas confusion (Sterilizer)', 1 },
}, by = {} }
for n, c in ipairs(MOD.status.choices) do MOD.status.by[c[1]] = { n = n, type = c[1], name = c[2], strength = c[3] } end
function MOD.status.name(kind)
    if kind == 0 then return 'none' end
    return MOD.status.by[kind] and MOD.status.by[kind].name or KINDS[T_STATUS].stuns[kind] or ('status ' .. kind)
end
-- the next / previous choice (n steps; 0: none, before the first)
function MOD.status.step(current, n)
    local at = MOD.status.by[current] and MOD.status.by[current].n or 0
    local to = math.max(0, math.min(#MOD.status.choices, at + n))
    return to == 0 and 0 or MOD.status.choices[to][1]
end
-- why slot `row.slot` of `row.drow` can't take `target` (a gap in the slots, a status not offered), or nil
function MOD.status.refused(row, target)
    if target ~= 0 and not MOD.status.by[target] and target ~= default_of(row.parts[1].field) then
        return 'Status effect ' .. tostring(target) .. ' is not one player weapons apply.'
    end
    local function at(i) return i >= 0 and i <= 3 and read_field(field_at(T_DAMAGE, row.drow + 44 + i * 8, 'u32', 100000)) or 0 end
    if target ~= 0 and row.slot > 0 and at(row.slot - 1) == 0 then
        return 'Give status effect ' .. row.slot .. ' first (the game reads them in order).'
    end
    if target == 0 and at(row.slot + 1) ~= 0 then
        return 'Clear status effect ' .. (row.slot + 2) .. ' first (the game reads them in order).'
    end
end

local function status_rows(entry, section, prefix, drow, per)
    local strength_of = {}   -- slot -> its named strength row
    for i = 0, 3 do
        local kind = read_field(field_at(T_DAMAGE, drow + 44 + i * 8, 'u32', 100000))
        if not kind or kind == 0 then break end
        local srow = tables[T_STATUS] and tables[T_STATUS].index[kind]
        local sid = srow and read_field(field_at(T_STATUS, srow + 44, 'u32', 100000))
        local qrow = sid and sid > 0 and tables[T_DAMAGE] and tables[T_DAMAGE].index[sid]
        local stun = srow and not qrow and KINDS[T_STATUS].stuns[kind]
        if qrow or stun then
            local name, key = stun or KINDS[T_STATUS].names[kind] or ('Status ' .. kind), prefix .. 'status' .. kind
            strength_of[i] = add_row(entry, section, key .. '_strength', name .. ' applied per ' .. per, 'f32',
                                     { part(key .. '_strength', T_DAMAGE, drow + 48 + i * 8, 'f32', 100000) }, 0, 1000, 0.1, 1)
            local first = qrow and damage_rows(entry, name, key .. '_', qrow, name, 6)   -- no forces: a status has none
            local duration = add_row(entry, name, key .. '_duration', name .. ' duration (s)', 'f32',
                                     { part(key .. '_duration', T_STATUS, srow + 40, 'f32', 100000) }, 0, 600, 0.5, 5)
            local by = qrow and '(other weapons, strikes, hazards, enemies)' or '(other weapons, grenades, strikes)'
            ;(first or duration).note = 'every ' .. name:lower() .. ' source shares ' .. (qrow and 'these ' or 'this ') .. by
        end
    end
    -- which status each slot applies: the used ones and the next empty one
    local used = 0
    for i = 0, 3 do
        local f = field_at(T_DAMAGE, drow + 44 + i * 8, 'u32', 100000)
        if (default_of(f) or 0) ~= 0 or (read_field(f) or 0) ~= 0 then used = i + 1 end
    end
    local own = section == 'Damage' and 'Status effects' or ('Status effects (' .. section .. ')')
    for i = 0, math.min(3, used) do
        local id = prefix .. 'slot' .. (i + 1)
        local row = add_row(entry, own, id, 'Status effect ' .. (i + 1) .. ' (choice)', 'u32',
                            { part(id, T_DAMAGE, drow + 44 + i * 8, 'u32', 100000) }, 0, 100000, 1, 1)
        row.choice, row.drow, row.slot = 'status', drow, i
        row.label_of = function() return 'Applies: ' .. MOD.status.name(read_field(row.parts[1].field) or 0) end
        if i == 0 then row.note = 'what each hit applies; the slots go in order' end
        row.strength = strength_of[i] or add_row(entry, own, id .. '_strength', 'Status effect ' .. (i + 1) .. ' strength per ' .. per,
                                                 'f32', { part(id .. '_strength', T_DAMAGE, drow + 48 + i * 8, 'f32', 100000) }, 0, 1000, 0.1, 1)
    end
end

-- A charge weapon's shots, when its stages name projectiles (the plasma weapons: Loyalist and
-- Purifier fire one projectile uncharged and another charged, the Epoch one at partial and another
-- at full charge; a stage without one fires `fired`, the fire mode's). In stage order: { id, prow,
-- stage, last (stages it fires at), name, prefix: '' for the fire mode's projectile, so its ids stay
-- those of a plain weapon, else 'c<stage>_' }. nil when every stage fires the fire mode's projectile.
KINDS[TYPES.charge].shots = function(at, fired)
    local list, by = {}, {}
    for s = 1, 3 do
        local id = default_of(field_at(TYPES.charge, at + (s - 1) * 24 + 4, 'u32', 100000))
        if id == 0 then id = fired end
        local prow = id and id > 0 and tables[T_PROJECTILE] and tables[T_PROJECTILE].index[id]
        if prow then
            if not by[id] then by[id] = { id = id, prow = prow, stage = s }; list[#list + 1] = by[id] end
            by[id].last = s
        end
    end
    if #list == 0 or (#list == 1 and list[1].id == fired) then return nil end
    -- a first stage that fires at once (0.01 s) is the uncharged shot
    local quick = (default_of(field_at(TYPES.charge, at, 'f32', 100000)) or 1) < 0.1
    local names = #list == 2 and (quick and { 'Uncharged', 'Charged' } or { 'Partial charge', 'Full charge' })
    for k, shot in ipairs(list) do
        shot.name = names and names[k] or (#list == 1 and 'Charged' or ('Stage ' .. shot.stage))
        shot.prefix = shot.id == fired and '' or ('c' .. shot.stage .. '_')
    end
    return list
end

local function resolve_gun(weapon, key)
    local function record(kind)
        local entry = tables[kind]
        return entry and entry.index[key]
    end
    -- its magazine attachments, each with rows of its own (KINDS[TYPES.items].item_rows); a magazine /
    -- reload / heat value of the weapon's own record ('component:offset') has a row while one of them
    -- leaves it to the record (or it has none)
    local ok, links = pcall(attachments, key)
    if not ok then log('attachments of ' .. weapon.name .. ': ' .. tostring(links)) end
    local items = ok and weapon.key == key and links and links.items or {}
    local function kept(word)
        for _, item in ipairs(items) do
            if not item.words[word] then return true end
        end
        return #items == 0
    end
    -- the projectile it fires: the rounds record's (+64), else its default ammo type's (an attachment
    -- delta on the fire mode's +0, put there when the weapon spawns: Peacemaker, Redeemer), else the fire
    -- mode's (+0). Read as the game had them (the Projectile swap row writes them all; the stat rows stay
    -- the weapon's own). `sources`: those fields, with the charge stages' (below), for that row.
    local sources = {}
    local function source(id, kind, offset, always)
        local f = field_at(kind, offset, 'u32', 100000)
        local own = default_of(f)
        if own and (own > 0 or always) then sources[#sources + 1] = { id = id, field = f, own = own } end
        return own
    end
    local projectile = nil
    local rounds, fire = record(T_ROUNDS), record(T_FIRE)
    if rounds then projectile = source('proj_rounds', T_ROUNDS, rounds + 64) end
    local feed2 = nil
    if weapon.key == key then
        local _, at = KINDS[TYPES.custom].projectile(key)
        local own = at and source('proj_ammo', TYPES.deltas, at)
        if (projectile == nil or projectile == 0) and own and own > 0 then projectile = own end
        -- its ammo types (attachments) set the rounds feeds when it spawns: the swap writes them too
        if rounds then
            local alt = default_of(field_at(T_ROUNDS, rounds + 68, 'u32', 100000))
            local feeds = KINDS[TYPES.custom].feeds(key, { [64] = projectile, [68] = alt })
            if feeds[64] then source('proj_ammo_feed1', TYPES.deltas, feeds[64]) end
            feed2 = feeds[68] and field_at(TYPES.deltas, feeds[68], 'u32', 100000)
        end
    end
    if fire then
        -- (also when it names none: its ammo type does, and the fire mode then takes the swapped one)
        local own = source('proj_fire', T_FIRE, fire, true)
        if projectile == nil or projectile == 0 then projectile = own end
    end
    local prow = projectile and projectile > 0 and tables[T_PROJECTILE] and tables[T_PROJECTILE].index[projectile]
    -- charge weapons whose stages fire their own projectiles: those, not the fire mode's
    local charge = record(TYPES.charge)
    local shots = charge and KINDS[TYPES.charge].shots(charge, projectile)
    if shots then prow = nil end
    for s = 1, charge and 3 or 0 do source('proj_c' .. s, TYPES.charge, charge + (s - 1) * 24 + 4) end
    local drow = nil
    if prow then
        local id = read_field(field_at(T_PROJECTILE, prow + 60, 'u32', 100000))
        drow = id and tables[T_DAMAGE] and tables[T_DAMAGE].index[id]
    end
    -- beam weapons: beam component (+0 beam type) -> beam row (+12) -> damage row
    local beam = not drow and record(T_BEAM_WEAPON)
    if beam then
        local kind = read_field(field_at(T_BEAM_WEAPON, beam, 'u32', 100000))
        local brow = kind and tables[T_BEAM] and tables[T_BEAM].index[kind]
        local id = brow and read_field(field_at(T_BEAM, brow + 12, 'u32', 100000))
        drow = id and tables[T_DAMAGE] and tables[T_DAMAGE].index[id]
    end
    -- flame and gas weapons: spray component (+200 damage row), damage per flame / gas hit
    local spray = not drow and record(T_SPRAY)
    if spray then
        local id = read_field(field_at(T_SPRAY, spray + 200, 'u32', 100000))
        drow = id and tables[T_DAMAGE] and tables[T_DAMAGE].index[id]
    end
    -- melee weapons: melee component (+12 damage row), damage per strike
    local melee = not drow and record(T_MELEE)
    if melee then
        local id = read_field(field_at(T_MELEE, melee + 12, 'u32', 100000))
        drow = id and tables[T_DAMAGE] and tables[T_DAMAGE].index[id]
    end
    -- arc weapons: arc component (+0 arc type, +4 fire rate) -> arc row (+8 range, +28 chain
    -- length, +32 chain split, +36 damage row)
    local arc = not drow and record(TYPES.arc_weapon)
    local arow = nil
    if arc then
        local kind = read_field(field_at(TYPES.arc_weapon, arc, 'u32', 100000))
        arow = kind and tables[TYPES.arc] and tables[TYPES.arc].index[kind]
        local id = arow and read_field(field_at(TYPES.arc, arow + 36, 'u32', 100000))
        drow = id and tables[T_DAMAGE] and tables[T_DAMAGE].index[id]
    end
    weapon.projectile, weapon.damage_row = prow and projectile or nil, nil
    local main_from = #weapon.rows + 1   -- the shot's rows (direct hit, projectile, explosions): main_from..main_to
    if drow then
        weapon.damage_row = true
        damage_rows(weapon, 'Damage', '', drow)
    end
    if drow then status_rows(weapon, 'Damage', '', drow, 'hit') end
    local damage_to = #weapon.rows
    if arow then
        add_row(weapon, 'Arc', 'arc_range', 'Range (m)', 'f32', { part('arc_range', TYPES.arc, arow + 8, 'f32', 100000) },
                0, 1000, 1, 5)
        add_row(weapon, 'Arc', 'arc_chain', 'Chain length', 'u32', { MOD.solo(part('arc_chain', TYPES.arc, arow + 28, 'u32', 1000)) },
                0, 20, 1, 1)
        add_row(weapon, 'Arc', 'arc_split', 'Chain split', 'u32', { MOD.solo(part('arc_split', TYPES.arc, arow + 32, 'u32', 1000)) },
                0, 20, 1, 1)
        local rate = read_field(field_at(TYPES.arc_weapon, arc + 4, 'f32', 100000))
        if rate and rate > 0 then
            add_row(weapon, 'Fire', 'arc_rpm', 'Fire rate (RPM)', 'f32', { part('arc_rpm', TYPES.arc_weapon, arc + 4, 'f32', 100000) },
                    1, 6000, 1, 10)
        end
    end
    local blasts = {}
    -- the ids of rows from..to, taken by `prefix` .. their id past `listed` (its prefix): another shot's
    -- for the same memory (listed once), kept so saved values and presets that name them still apply
    local function alias_rows(from, to, listed, prefix)
        weapon.aliases = weapon.aliases or {}
        for k = from, to do
            for _, p in ipairs(weapon.rows[k].parts) do
                if p.id:sub(1, #listed) == listed then
                    local alias = prefix .. p.id:sub(#listed + 1)
                    if not weapon.by_id[alias] then weapon.by_id[alias], weapon.aliases[alias] = p, p.id end
                end
            end
        end
    end
    local exploded = {}   -- explosion row -> { from, to, prefix } once listed
    local blast_hits = {}   -- an explosion's damage row -> { from, to, prefix, section } once listed
    -- a projectile's rows (ids `idp` .. stat) in `section`, and its explosions, to add after it: on
    -- impact (+144) and on expiry (+156, when another one) -> explosion row (+4 damage row, +16 inner,
    -- +20 outer, +24 shockwave radius), in `xsection` ('Explosion', or the shot's)
    local function projectile_rows(p, idp, section, xsection)
        local function proj(id, label, offset, max, small, big)
            add_row(weapon, section, idp .. id, label, 'f32', { part(idp .. id, T_PROJECTILE, p + offset, 'f32', 100000) },
                    0, max, small, big)
        end
        add_row(weapon, section, idp .. 'pellets', 'Projectiles per shot', 'u32',
                { part(idp .. 'pellets', T_PROJECTILE, p + 28, 'u32', 1000) }, 1, 100, 1, 5)
        if idp == '' and weapon.missile then
            KINDS[TYPES.seeking].flight(weapon, weapon.missile, KINDS[TYPES.seeking].steered(weapon))
        else
            proj('velocity', 'Velocity (m/s)', 32, 100000, 10, 100)
            proj('drag', 'Drag factor', 40, 100, 0.05, 0.5)
            proj('gravity', 'Gravity factor', 44, 100, 0.05, 0.5)
        end
        proj('pen_slowdown', 'Penetration slowdown', 64, 100, 0.05, 0.25)
        local impact = read_field(field_at(T_PROJECTILE, p + 144, 'u32', 100000))
        local expiry = read_field(field_at(T_PROJECTILE, p + 156, 'u32', 100000))
        -- the explosions it sets off, as choices (+144 on impact, +156 on expiry; 0: none), and its fuse: above 0
        -- it goes off this close to a target (+148, a flak fuse) and this long after the hit (+152). The
        -- explosion rows below stay the game's own explosion's: another one's are on the Records tab.
        local idsec = section .. ' explosion id'
        local function blast_id(id, label, offset)
            local row = add_row(weapon, idsec, idp .. id, label, 'u32', { part(idp .. id, T_PROJECTILE, p + offset, 'u32', 100000) },
                                0, 100000, 1, 10)
            row.choice = 'explosion'
            return row
        end
        local impact_row = impact and blast_id('impact_explosion', 'Impact explosion (id)', 144)
        if impact_row then
            impact_row.note = function() return 'sets off: ' .. MOD.records.label(T_EXPLOSION, read_field(impact_row.parts[1].field)) end
        end
        if impact and impact > 0 then
            for _, f in ipairs({ { 'fuse_proximity', 'Blast proximity (m)', 148, 200, 0.1, 1 },
                                 { 'fuse_delay', 'Blast delay (s)', 152, 30, 0.05, 0.5 } }) do
                add_row(weapon, idsec, idp .. f[1], f[2], 'f32', { part(idp .. f[1], T_PROJECTILE, p + f[3], 'f32', 100000) },
                        0, f[4], f[5], f[6])
            end
        end
        if expiry then blast_id('expiry_explosion', 'Expiry explosion (id)', 156) end
        local first = #blasts
        if impact and impact > 0 then blasts[#blasts + 1] = { id = impact, prefix = idp .. 'blast', section = xsection, damage = true } end
        if expiry and expiry > 0 and expiry ~= impact then
            blasts[#blasts + 1] = { id = expiry, prefix = idp .. 'expiry', section = #blasts > first and (xsection .. ' (expiry)') or xsection,
                                    damage = true }
        end
    end
    local function explosion_rows()
        for _, blast in ipairs(blasts) do
            local xrow = tables[T_EXPLOSION] and tables[T_EXPLOSION].index[blast.id]
            local before = xrow and exploded[xrow]
            if before then   -- another shot's explosion too (the same one in game): listed once
                alias_rows(before.from, before.to, before.prefix, blast.prefix)
                local first = weapon.rows[before.from]
                if first then first.note = first.note or ('explosion: also the ' .. blast.section:gsub(' ?[Ee]xplosion.*$', ''):lower() .. "'s") end
            elseif xrow then
                local from = #weapon.rows + 1
                local id = blast.damage and read_field(field_at(T_EXPLOSION, xrow + 4, 'u32', 100000))
                local qrow = id and id > 0 and tables[T_DAMAGE] and tables[T_DAMAGE].index[id]
                local shared = qrow and blast_hits[qrow]
                if shared then   -- another explosion's damage too (StA-X3 W.A.S.P.'s modes): listed once
                    alias_rows(shared.from, shared.to, shared.prefix, blast.prefix .. '_')
                elseif qrow then
                    damage_rows(weapon, blast.section, blast.prefix .. '_', qrow, 'Explosion')
                    blast_hits[qrow] = { from = from, to = #weapon.rows, prefix = blast.prefix .. '_', section = blast.section }
                end
                local radii = #weapon.rows + 1
                for _, r in ipairs({ { 'inner', 'Inner radius (m)', 16 }, { 'outer', 'Outer radius (m)', 20 },
                                     { 'shockwave', 'Shockwave radius (m)', 24 } }) do
                    local rid = blast.prefix .. '_' .. r[1]
                    add_row(weapon, blast.section, rid, r[2], 'f32', { part(rid, T_EXPLOSION, xrow + r[3], 'f32', 100000) }, 0, 200, 0.1, 1)
                end
                -- the shrapnel it throws: the projectile every piece is (+84, a choice: its own flight, damage and
                -- explosion) and how many (+80)
                MOD.records.shrapnel_rows(weapon, blast.section == 'Explosion' and 'Shrapnel' or (blast.section .. ' shrapnel'),
                                          blast.prefix .. '_shrapnel', xrow)
                -- the arc it makes (explosion +120 arc type -> arc row: +8 range, +28 chain length, +32 chain
                -- split, +36 damage row), as a throwable's: the GL-52 De-Escalator's grenade
                local arc = tables[TYPES.arc] and tables[TYPES.arc].index[read_field(field_at(T_EXPLOSION, xrow + 120, 'u32', 100000)) or -1]
                if arc then
                    local section, pre = blast.section == 'Explosion' and 'Arc' or (blast.section .. ' arc'), blast.prefix .. '_arc_'
                    add_row(weapon, section, pre .. 'range', 'Range (m)', 'f32', { part(pre .. 'range', TYPES.arc, arc + 8, 'f32', 100000) },
                            0, 1000, 1, 5)
                    add_row(weapon, section, pre .. 'chain', 'Chain length', 'u32', { MOD.solo(part(pre .. 'chain', TYPES.arc, arc + 28, 'u32', 1000)) },
                            0, 20, 1, 1)
                    add_row(weapon, section, pre .. 'split', 'Chain split', 'u32', { MOD.solo(part(pre .. 'split', TYPES.arc, arc + 32, 'u32', 1000)) },
                            0, 20, 1, 1)
                    local aid = read_field(field_at(TYPES.arc, arc + 36, 'u32', 100000))
                    local arow = aid and tables[T_DAMAGE] and tables[T_DAMAGE].index[aid]
                    if arow then
                        damage_rows(weapon, section, pre, arow, 'Arc')
                        status_rows(weapon, section, pre, arow, 'hit')
                    end
                end
                if shared and weapon.rows[radii] then
                    weapon.rows[radii].note = 'damage: the same as the ' .. shared.section:lower() .. "'s (above)"
                    local first = weapon.rows[shared.from]
                    if first then first.note = first.note or ('also the ' .. blast.section:lower() .. "'s damage") end
                end
                exploded[xrow] = { from = from, to = #weapon.rows, prefix = blast.prefix }
            end
        end
        blasts = {}
    end
    weapon.missile = fire and KINDS[TYPES.seeking].fired(fire)
    if prow then projectile_rows(prow, '', 'Projectile', 'Explosion') end
    -- a melee strike's explosion (Breaching Hammer), with its damage row (explosion +4)
    local strike = melee and weapon.key == key and KINDS[T_MELEE].explosions[weapon.hash]
    if strike then blasts[#blasts + 1] = { id = strike, prefix = 'blast', section = 'Explosion', damage = true } end
    explosion_rows()
    local main_to = #weapon.rows
    -- each shot of a charge weapon: its direct hit and projectile, then its explosion. A direct hit a
    -- later shot shares with an earlier one (Loyalist, Purifier: one damage row) is listed once, under
    -- the earlier shot; the later shot's ids for it stay as aliases (weapon.aliases: id -> listed id),
    -- so saved values and presets that name them still apply.
    local hits = {}
    for _, shot in ipairs(shots or {}) do
        local section = shot.name .. ' shot'
        local id = read_field(field_at(T_PROJECTILE, shot.prow + 60, 'u32', 100000))
        local qrow = id and tables[T_DAMAGE] and tables[T_DAMAGE].index[id]
        local before = qrow and hits[qrow]
        if before then
            weapon.aliases = weapon.aliases or {}
            for _, listed in ipairs(before.ids) do
                local alias = shot.prefix .. listed:sub(#before.prefix + 1)
                weapon.by_id[alias], weapon.aliases[alias] = weapon.by_id[listed], listed
            end
            before.first.note = before.first.note or ('direct hit: also the ' .. shot.name:lower() .. ' shot\'s')
        elseif qrow then
            local from = #weapon.rows + 1
            local first = damage_rows(weapon, section, shot.prefix, qrow)
            status_rows(weapon, section, shot.prefix, qrow, 'hit')
            local ids = {}
            for k = from, #weapon.rows do
                for _, p in ipairs(weapon.rows[k].parts) do ids[#ids + 1] = p.id end
            end
            hits[qrow] = { name = shot.name, first = first, prefix = shot.prefix, ids = ids }
        end
        local from = #weapon.rows + 1
        projectile_rows(shot.prow, shot.prefix, section, shot.name .. ' explosion')
        if before and weapon.rows[from] then
            weapon.rows[from].note = 'direct hit: see the ' .. before.name:lower() .. ' shot'
        end
        explosion_rows()
    end
    -- the second firing mode's projectile (fire mode +576: the Autocannon's flak, the Recoilless Rifle's HE),
    -- read as the game had it: its direct hit, projectile and explosions, ids 'm2_' .. stat
    local second = fire and weapon.key == key and default_of(field_at(T_FIRE, fire + 576, 'u32', 100000))
    local srow = second and second > 0 and tables[T_PROJECTILE] and tables[T_PROJECTILE].index[second]
    -- The same projectile as the first mode's (StA-X3 W.A.S.P.'s artillery mode): not listed again; a
    -- direct hit or explosion the two share: listed once (the 'm2_' ids stay as aliases).
    if srow and srow == prow then
        alias_rows(main_from, main_to, '', 'm2_')
        local first = weapon.rows[main_from]
        if first then first.note = first.note or "also the second firing mode's shot (the same projectile)" end
    elseif srow then
        local id = read_field(field_at(T_PROJECTILE, srow + 60, 'u32', 100000))
        local qrow = id and tables[T_DAMAGE] and tables[T_DAMAGE].index[id]
        local from = #weapon.rows + 1
        if qrow and qrow == drow then
            alias_rows(main_from, damage_to, '', 'm2_')
        elseif qrow then
            damage_rows(weapon, 'Second mode', 'm2_', qrow)
            status_rows(weapon, 'Second mode', 'm2_', qrow, 'hit')
        end
        projectile_rows(srow, 'm2_', 'Second mode', 'Second mode explosion')
        if qrow and qrow == drow and weapon.rows[from] then
            weapon.rows[from].note = "direct hit: the same as the first mode's (Damage above)"
        end
        explosion_rows()
    end
    -- its second ammo type and tracer rounds (KINDS[T_ROUNDS].extra): their direct hit (a tracer's
    -- is the round's own: not listed again), projectile and explosions, ids 'a2_' / 't_' .. stat
    local extra = weapon.key == key and prow and KINDS[T_ROUNDS].extra(rounds, record(T_MAGAZINE), projectile)
    for _, shot in ipairs(extra or {}) do
        if shot.field then shot.delta = feed2 end
    end
    for _, shot in ipairs(extra or {}) do
        if shot.prow then
            local id = read_field(field_at(T_PROJECTILE, shot.prow + 60, 'u32', 100000))
            local qrow = id and tables[T_DAMAGE] and tables[T_DAMAGE].index[id]
            local from = #weapon.rows + 1
            if qrow and qrow ~= drow then
                damage_rows(weapon, shot.name, shot.prefix, qrow)
                status_rows(weapon, shot.name, shot.prefix, qrow, 'hit')
            end
            projectile_rows(shot.prow, shot.prefix, shot.name, shot.name .. ' explosion')
            -- a status's shared rows (its own section) after the shot's, not between them
            local own, shared = {}, {}
            for k = from, #weapon.rows do
                local r = weapon.rows[k]
                if r.section == shot.name then own[#own + 1] = r else shared[#shared + 1] = r end
                weapon.rows[k] = nil
            end
            for _, r in ipairs(own) do weapon.rows[#weapon.rows + 1] = r end
            for _, r in ipairs(shared) do weapon.rows[#weapon.rows + 1] = r end
            if qrow == drow and weapon.rows[from] then
                weapon.rows[from].note = 'damage: the same as the other rounds (Damage above)'
            end
            explosion_rows()
        end
    end
    -- the charge: its stages' times, the overcharge limit, and the multipliers it puts on the shot
    if charge then
        local function cf(offset) return field_at(TYPES.charge, charge + offset, 'f32', 100000) end
        local note = nil
        if shots then
            local said = {}
            for _, shot in ipairs(shots) do
                said[#said + 1] = (shot.last > shot.stage and ('stages ' .. shot.stage .. '-' .. shot.last) or ('stage ' .. shot.stage))
                                  .. ': ' .. shot.name:lower() .. ' shot'
            end
            note = table.concat(said, ', ')
        end
        for s = 1, 3 do
            local row = add_row(weapon, 'Charge', 'charge_' .. s, 'Stage ' .. s .. ' charge time (s)', 'f32',
                                { part('charge_' .. s, TYPES.charge, charge + (s - 1) * 24, 'f32', 100000) }, 0, 600, 0.05, 0.25)
            if s == 1 then row.note = note end
        end
        local limit = default_of(cf(208))
        if limit and limit > 0 then
            add_row(weapon, 'Charge', 'charge_limit', 'Overcharge limit (s)', 'f32',
                    { part('charge_limit', TYPES.charge, charge + 208, 'f32', 100000) }, 0, 600, 0.05, 0.25)
        end
        for _, m in ipairs(KINDS[TYPES.charge].MULTIPLIERS) do
            if not m.arc or record(TYPES.arc_weapon) then
                for k, at in ipairs({ { '_min', ', min charge' }, { '_max', ', overcharge' } }) do
                    local id = 'mul_' .. m[1] .. at[1]
                    add_row(weapon, 'Charge', id, m[2] .. ' multiplier' .. at[2], 'f32',
                            { (m.arc and MOD.solo or MOD.same)(part(id, TYPES.charge, charge + m[3] + (k - 1) * 4, 'f32', 100000)) },
                            0, 100, 0.05, 0.25)
                end
            end
        end
    end
    if fire then
        local rates, values = {}, {}
        for n, offset in ipairs({ 4, 8, 12 }) do
            local f = field_at(T_FIRE, fire + offset, 'f32', 100000)
            local v = read_field(f)
            if v and v > 0 then rates[#rates + 1] = { n = n, offset = offset } end
            values[n] = default_of(f)
        end
        -- settings of one value (Maxigun, Bullet Storm, SG-88: all three; LAS-44 Nova: two, the first 0): no
        -- rate to pick in game, so one row writes them all (its first part is the default setting, the one the
        -- game fires at)
        local same = #rates > 1
        for _, rate in ipairs(rates) do same = same and values[rate.n] == values[rates[1].n] end
        if same then
            local parts = {}
            for _, rate in ipairs(rates) do
                local id = ({ 'rpm_1', 'rpm', 'rpm_3' })[rate.n]
                table.insert(parts, rate.n == 2 and 1 or #parts + 1, part(id, T_FIRE, fire + rate.offset, 'f32', 100000))
            end
            add_row(weapon, 'Fire', parts[1].id, 'Fire rate (RPM)', 'f32', parts, 1, 6000, 10, 50)
            rates = {}
        end
        for k, rate in ipairs(rates) do
            local id = ({ 'rpm_1', 'rpm', 'rpm_3' })[rate.n]
            local label = #rates == 1 and 'Fire rate (RPM)' or ('Fire rate ' .. k .. ' (RPM)')
            add_row(weapon, 'Fire', id, label, 'f32', { part(id, T_FIRE, fire + rate.offset, 'f32', 100000) }, 1, 6000, 10, 50)
        end
    end
    local magazine, heat = record(T_MAGAZINE), record(T_HEAT)
    local reload = (magazine or rounds or heat) and record(TYPES.reload)
    -- heat weapons (lasers, Quasar): +84/+88/+92 heatsinks, +96 overheat threshold, +100 heat it
    -- recovers to after an overheat, +116/+120 heat per shot / second, +128 cooling per second,
    -- +140 cooling per second while overheated, +144 (byte) overheat needs a new heatsink
    local sinks = heat and read_field(field_at(T_HEAT, heat + 144, 'u32', 4294967295))
    sinks = sinks and sinks % 256 ~= 0
    local function item_section(item)
        return #items == 1 and 'Ammo' or item.name   -- (the one it comes with first)
    end
    -- The magazine (`ammo`), else the reload and heat rows of the weapon's own record (`item` nil), or of
    -- one of its magazine attachments: the values it sets, ids 'item<id>_<stat>', in a section of its own.
    -- `hidden`: the record's ids whose rows its attachments took over (id -> 'component:offset').
    local hidden = {}
    local function stock(item, ammo)
        local pre = item and string.format('item%08X_', item.id) or ''
        -- the field a row edits (nil: no row); `base`: where a value is read from (the attachment's, else the
        -- record's; the record's rows read the attachment it comes with)
        local function get(id, word, kind, offset, storage, limit)
            if item then return item.words[word] and field_at(TYPES.deltas, item.words[word], storage, limit) end
            if kept(word) then return field_at(kind, offset, storage, limit) end
            hidden[id] = word
        end
        local function base(word, kind, offset, storage, limit)
            local from = item or (items[1] and items[1].default and items[1])
            local at = from and from.words[word]
            return at and field_at(TYPES.deltas, at, storage, limit) or field_at(kind, offset, storage, limit)
        end
        local function row(section, id, label, storage, f, min, max, small, big)
            if not f then return nil end
            return add_row(weapon, item and item_section(item) or section, pre .. id, label, storage,
                           { { id = pre .. id, field = f } }, min, max, small, big)
        end
        if ammo then
            -- a vehicle's gun that has no spare magazines and holds none (the exosuits' arms, the Incinerator
            -- FRV's flamer) never reloads: spare magazines would start a reload the game does not finish
            -- (issue #31: a crash once the animation ends), so it has neither those rows nor a reload time
            if weapon.mounted and magazine and not item then
                weapon.sealed = default_of(field_at(T_MAGAZINE, magazine + 140, 'u32', 100000)) == 0
                                and default_of(field_at(T_MAGAZINE, magazine + 148, 'u32', 100000)) == 0
            end
            -- the game keeps at most 2048 rounds in a magazine (more drops to 2048 at the first shot): rows stop
            -- there, and going past it says why (row.limit)
            for _, m in ipairs(magazine and { { 'capacity', 'Magazine size', 136, 1, 2048, 10 },
                                              not weapon.sealed and { 'mags_start', 'Starting magazines', 140, 0, 999, 5 } or nil,
                                              not weapon.sealed and { 'mags_supply', 'Magazines from supply', 144, 0, 999, 5 } or nil,
                                              not weapon.sealed and { 'mags_max', 'Max spare magazines', 148, 0, 999, 5 } or nil } or {}) do
                local r = row('Ammo', m[1], m[2], 'u32', get(m[1], '5:' .. m[3], T_MAGAZINE, magazine + m[3], 'u32', 100000), m[4], m[5], 1, m[6])
                if r and m[1] == 'capacity' then r.limit = 'The game holds at most 2048 rounds in a magazine.' end
            end
            return
        end
        -- reload time: the weapon's own (+56), or its magazine's (an attachment sets it over the weapon's 0).
        -- The game scales the reload animation to it; 0: the animation's own length, which the tables do
        -- not hold: shown as that length where it is known (MOD.reload_seconds, row.zero)
        local rf = reload and get('reload_time', '113:56', TYPES.reload, reload + 56, 'f32', 1000)
        local rt = rf and default_of(rf)
        local known = rt == 0 and not item and MOD.reload_seconds[weapon.hash]
        if rt and rt >= 0 and rt < 1000 and not weapon.sealed then
            local r = row('Ammo', 'reload_time', (rt > 0 or known) and 'Reload time (s)' or 'Reload time (s; 0 = animation length)',
                          'f32', rf, 0, 60, 0.1, 0.5)
            if r and known then r.zero = known end
        end
        -- +1: you can move while reloading; off on the weapons that hold you still (the Autocannon, MG-43...):
        -- a row there only (not on vehicle guns: you are not walking)
        if reload and not item and not weapon.mounted
           and default_of(field_at(TYPES.reload, reload + 1, 'flag', 1)) == 0 then
            add_row(weapon, 'Ammo', 'reload_move', 'Move while reloading', 'flag',
                    { part('reload_move', TYPES.reload, reload + 1, 'flag', 1) }, 0, 1, 1, 1)
        end
        if not heat then return end
        local function hf(id, offset) return get(id, '266:' .. offset, T_HEAT, heat + offset, 'f32', 1000000) end
        local function hb(offset) return base('266:' .. offset, T_HEAT, heat + offset, 'f32', 1000000) end
        if sinks then
            for _, k in ipairs({ { 'heatsinks_start', 'Starting heatsinks', 84 }, { 'heatsinks_supply', 'Heatsinks from supply', 88 },
                                 { 'heatsinks_max', 'Max spare heatsinks', 92 } }) do
                row('Ammo', k[1], k[2], 'u32', get(k[1], '266:' .. k[3], T_HEAT, heat + k[3], 'u32', 100000), 0, 999, 1, 5)
            end
        end
        row('Heat', 'heat_capacity', 'Overheat threshold', 'f32', hf('heat_capacity', 96), 0, 100000, 1, 10)
        for _, g in ipairs({ { 'heat_shot', 'Heat per shot', 116 }, { 'heat_second', 'Heat per second firing', 120 } }) do
            local v = read_field(hb(g[3]))
            if v and v > 0 then row('Heat', g[1], g[2], 'f32', hf(g[1], g[3]), 0, 100000, 0.1, 1) end
        end
        -- cool-down times: the heat to shed over the cooling rate; setting a time sets the rate
        local capacity, recover = hb(96), hb(100)
        local function span(recovered, read)
            local c, r = read(capacity), recovered and read(recover) or 0
            return c and r and c - r
        end
        local function cool(id, label, offset, recovered)
            local s = span(recovered, read_field)
            local r = s and s > 0 and row('Heat', id, label, 'f32', hf(id, offset), 0.1, 3600, 0.5, 5)
            if not r then return end
            r.span = function() return span(recovered, read_field) end
            r.span_default = function() return span(recovered, default_of) end
        end
        cool('heat_cool', 'Cool-down time, full heat (s)', 128, false)
        if not sinks then cool('heat_cool_overheated', 'Cool-down time after overheat (s)', 140, true) end
        -- wind-up (Sickles, Scythe, Quasar...): +148 the charge it needs to fire, +152 the charge gained
        -- per second holding the trigger, +156 lost per second once let go; times: that charge over the rate
        local needed = hb(148)
        local function wind(id, label, offset)
            local c = read_field(needed)
            local r = c and c > 0 and row('Wind-up', id, label, 'f32', hf(id, offset), 0.01, 3600, 0.05, 0.25)
            if not r then return end
            r.span = function() return read_field(needed) end
            r.span_default = function() return default_of(needed) end
        end
        wind('windup', 'Wind-up time (s)', 152)
        wind('winddown', 'Wind-down time, released (s)', 156)
    end
    stock(nil, true)
    if rounds then
        add_row(weapon, 'Ammo', 'rounds_capacity', 'Rounds loaded', 'f32',
                { part('rounds_capacity', T_ROUNDS, rounds + 72, 'f32', 100000) }, 1, 999, 1, 5)
        local function rnd(id, label, offset)
            add_row(weapon, 'Ammo', id, label, 'u32', { part(id, T_ROUNDS, rounds + offset, 'u32', 100000) }, 0, 9999, 1, 10)
        end
        rnd('rounds_start', 'Starting rounds', 88)
        rnd('rounds_supply', 'Rounds from supply', 84)
        rnd('rounds_max', 'Max spare rounds', 80)
        -- +92 rounds added per reload (a clip: Autocannon 5, Veto 6; else 1, a shell at a time); +96 a reload
        -- is allowed below this many rounds left (f32; 0: below the capacity)
        add_row(weapon, 'Ammo', 'rounds_per_reload', 'Rounds per reload', 'u32',
                { part('rounds_per_reload', T_ROUNDS, rounds + 92, 'u32', 100000) }, 1, 999, 1, 5)
        local clip = not MOD.offline and key == weapon.key and KINDS[T_ROUNDS].CLIPS[weapon.hash]   -- (live only)
        if clip then
            local f = field_at(T_ROUNDS, 'clip' .. rounds, 'virtual', 100000)
            f.default, f.rounds = clip.count, rounds
            local row = add_row(weapon, 'Ammo', 'rounds_per_clip', 'Rounds per ' .. clip.name .. ' (empty)', 'u32',
                                { { id = 'rounds_per_clip', field = f } }, 1, 999, 1, 5)
            row.note = 'loaded into an empty weapon, from your spare rounds'
        end
        if (read_field(field_at(T_ROUNDS, rounds + 96, 'f32', 100000)) or 0) > 0 then
            add_row(weapon, 'Ammo', 'reload_below', 'Reload allowed below (rounds)', 'f32',
                    { part('reload_below', T_ROUNDS, rounds + 96, 'f32', 100000) }, 1, 999, 1, 5)
        end
    end
    stock(nil, false)
    if heat then
        -- heat levels (+0: 3 of 24 bytes: +0 heat it starts at, +4 projectile fired from there on, +20
        -- status effect put on the shooter: its damage row, status row +44). The LAS-17 Double-Edge
        -- Sickle's damage ramp and self-damage; below the first level it fires the fire mode's projectile.
        local top = default_of(field_at(T_HEAT, heat + 96, 'f32', 1000000))
        for k = 1, 3 do
            local at = heat + (k - 1) * 24
            local from = default_of(field_at(T_HEAT, at, 'f32', 1000000))
            local pid = from and from > 0 and source('proj_h' .. k, T_HEAT, at + 4)
            local prow = pid and tables[T_PROJECTILE] and tables[T_PROJECTILE].index[pid]
            local did = prow and read_field(field_at(T_PROJECTILE, prow + 60, 'u32', 100000))
            local qrow = did and tables[T_DAMAGE] and tables[T_DAMAGE].index[did]
            if qrow then
                local id = 'heatlvl' .. k .. '_'
                local section = top and top > 0 and string.format('Above %d%% heat', math.floor(from / top * 100 + 0.5))
                                or ('Heat level ' .. k)
                local first = add_row(weapon, section, id .. 'at', 'Starts at heat', 'f32',
                                      { part(id .. 'at', T_HEAT, at, 'f32', 1000000) }, 0, 100000, 1, 10)
                first.note = 'the shot fired from this heat on, and what it does to you'
                damage_rows(weapon, section, id, qrow)
                local kind = read_field(field_at(T_HEAT, at + 20, 'u32', 100000))
                local srow = kind and kind > 0 and tables[T_STATUS] and tables[T_STATUS].index[kind]
                local sid = srow and read_field(field_at(T_STATUS, srow + 44, 'u32', 100000))
                local hurt = sid and sid > 0 and tables[T_DAMAGE] and tables[T_DAMAGE].index[sid]
                if hurt then
                    add_row(weapon, section, id .. 'self', 'Damage to you', 'u32',
                            { part(id .. 'self', T_DAMAGE, hurt + 4, 'u32', 1000000),
                              part(id .. 'self_durable', T_DAMAGE, hurt + 8, 'u32', 1000000) }, 0, 100000, 1, 10)
                    for i = 0, 3 do
                        if read_field(field_at(T_DAMAGE, hurt + 44 + i * 8, 'u32', 100000)) == 5 then
                            add_row(weapon, section, id .. 'self_burn', 'Burning applied to you', 'f32',
                                    { part(id .. 'self_burn', T_DAMAGE, hurt + 48 + i * 8, 'f32', 100000) }, 0, 1000, 0.1, 1)
                        end
                    end
                end
            end
        end
    end
    -- each magazine attachment: its magazine, reload and heat values, then its stat modifiers (ergonomics
    -- bonus, ...); its rows change only that attachment (and every weapon that can fit it)
    for _, item in ipairs(items) do
        stock(item, true)
        stock(item, false)
        KINDS[TYPES.items].mod_rows(weapon, item_section(item), string.format('item%08X_', item.id), item.mods)
    end
    -- a value saved under a row its attachments took over ('capacity': once every magazine's) goes to theirs
    for id, word in pairs(hidden) do
        weapon.legacy = weapon.legacy or {}
        weapon.legacy[id] = {}
        for _, item in ipairs(items) do
            if item.words[word] then weapon.legacy[id][#weapon.legacy[id] + 1] = string.format('item%08X_', item.id) .. id end
        end
    end
    local data = record(T_WEAPON)
    if data then
        local function w(id, offset) return part(id, T_WEAPON, data + offset, 'f32', 100000) end
        add_row(weapon, 'Handling', 'recoil_h', 'Recoil (horizontal)', 'f32', { w('recoil_dh', 0), w('recoil_ch', 28) }, 0, 2000, 1, 5)
        add_row(weapon, 'Handling', 'recoil_v', 'Recoil (vertical)', 'f32', { w('recoil_dv', 4), w('recoil_cv', 32) }, 0, 2000, 1, 5)
        add_row(weapon, 'Handling', 'spread_h', 'Spread (horizontal)', 'f32', { w('spread_h', 84) }, 0, 5000, 1, 10)
        add_row(weapon, 'Handling', 'spread_v', 'Spread (vertical)', 'f32', { w('spread_v', 88) }, 0, 5000, 1, 10)
        add_row(weapon, 'Handling', 'sway', 'Sway multiplier', 'f32', { w('sway', 104) }, 0, 100, 0.1, 0.5)
        add_row(weapon, 'Handling', 'ergonomics', 'Ergonomics', 'f32', { w('ergonomics', 356) }, 0, 1000, 1, 5)
        MOD.spin_rows(weapon, data, record(TYPES.windup))
    end
    if weapon.key == key and weapon.slot == 'Support' then
        local pack = KINDS[TYPES.rack].pack(key)
        if pack then KINDS[TYPES.jumppack].backpack(weapon, pack, true) end
    end
    if weapon.key == key then
        KINDS[T_PROJECTILE].swap_row(weapon, sources, shots, fire, extra)
        KINDS[TYPES.throwable].grenade_row(weapon, fire)
    end
end

-- ---------------------------------------------------------------- stratagems
-- A stratagem's definition row (found live, in whichever group table holds its id): +16 debug
-- name (pointer), +80 uses (0xFFFFFFFF = unlimited), +104 cooldown, +152 payload entity list
-- (pointer, count at +160). Strikes add the projectile / explosion / damage records they use
-- (STRATAGEMS, by record id); a payload that is a gun (sentries, emplacements) adds its stats.
local EAGLE_REARM = 3837064536
local FAMILY_ORDER = { orbital = 1, eagle = 2, support = 9 }
local FAMILY_NOTE = { orbital = 'Orbital strike.', eagle = 'Eagle strike. The rearm time is shared by every Eagle.',
                      support = 'Support weapon drop; the weapon itself is under Support.' }

local function id_hex(id) return string.format('%08X%08X', 0, id) end

-- The entities that share `key`'s loadout package: a support weapon's hellpod rack and what it
-- carries (the C4 Pack: its detonator, the charge, the charge backpack).
KINDS[TYPES.package].kin = function(key)
    local t = tables[TYPES.package]
    local at = t and t.index[key]
    local blob = at and api.read(t.copies[1] + HEADER_BYTES, t.payload)
    if not blob or #blob ~= t.payload then return {} end
    local package, out = blob:sub(at + 9, at + 16), {}
    for other, off in pairs(t.index) do
        if other ~= key and blob:sub(off + 9, off + 16) == package then out[#out + 1] = other end
    end
    return out
end

-- The backpack a support weapon's hellpod carries with it (its ammo backpack: Autocannon, Recoilless,
-- Spear, W.A.S.P., Maxigun, Cremator, Belt-Fed GL, Airburst): a rack holding only the weapon and one
-- entity with charges (not a crate of several weapons and supply packs).
KINDS[TYPES.rack].pack = function(key)
    local rt, dt = tables[TYPES.rack], tables[TYPES.deposit]
    if not rt or not dt then return nil end
    local empty = string.rep('\0', 8)
    for _, at in pairs(rt.index) do
        local slots = api.read(rt.copies[1] + HEADER_BYTES + at, 512)
        local has, pack, other = false, nil, false
        for s = 0, slots and #slots == 512 and 7 or -1 do
            local k = slots:sub(s * 64 + 1, s * 64 + 8)
            if k == key then has = true
            elseif dt.index[k] and (pack == nil or pack == k) then pack = k
            elseif k ~= empty then other = true end
        end
        if has and pack and not other then return pack end
    end
end

-- A support weapon you place rather than fire (the C4 Pack: its entity is the charge, which has no
-- weapon record but an explosive one).
KINDS[TYPES.package].placed = function(key)
    return not (tables[T_WEAPON] and tables[T_WEAPON].index[key]) and tables[TYPES.explosive] ~= nil
           and tables[TYPES.explosive].index[key] ~= nil
end

-- A sentry's or emplacement's body, when its gun has no health of its own: the entity that mounts the
-- gun and has health (the Grenadier Battlement's). nil: the gun is the body.
KINDS[TYPES.health].body = function(gun)
    local ht, mt = tables[TYPES.health], tables[TYPES.mount]
    if not ht or not mt or ht.index[gun] then return nil end
    for holder, at in pairs(mt.index) do
        local mounts = ht.index[holder] and api.read(mt.copies[1] + HEADER_BYTES + at, 120)
        for m = 0, mounts and 4 or -1 do
            if mounts:sub(m * 24 + 1, m * 24 + 8) == gun then return holder end
        end
    end
end

-- 'BACKPACK. GUARD DOG (Drone)' -> 'backpack', 'Guard Dog (Drone)'
local function pretty(debug_name)
    local family, rest = debug_name:match('^%s*([^%.]+)%.%s*(.+)$')
    rest = (rest or debug_name):gsub('%a+', function(word)
        if #word <= 2 or word ~= word:upper() or not word:find('[AEIOUY]') then return word end
        return word:sub(1, 1) .. word:sub(2):lower()
    end)
    return (family or 'other'):lower(), rest
end

-- Several vehicles of a kind in a loadout (Settings, on by default): a stratagem's flags (StratagemInfo +260)
-- carry its vehicle kind, 0x00100000 exosuit, 0x00200000 FRV, 0x00400000 tank, and the loadout takes one
-- stratagem of each kind; on clears those bits (in memory), off puts them back. `original`: by stratagem
-- id, the flags as the game had them (kept across rescans).
MOD.vehicles = { on = true, original = {}, defs = {}, BITS = 1048576 }
function MOD.vehicles.collect(defs)
    local V = MOD.vehicles
    V.defs = {}
    for id, def in pairs(defs) do
        local flags = V.original[id] or peek4(def.at + 260)
        if flags and math.floor(flags / V.BITS) % 8 ~= 0 then
            V.original[id] = flags
            V.defs[#V.defs + 1] = { kind = def.kind, off = def.off, flags = flags }
        end
    end
    V.apply()
end
function MOD.vehicles.apply()
    local V = MOD.vehicles
    for _, d in ipairs(V.defs) do
        local want = V.on and d.flags - (math.floor(d.flags / V.BITS) % 8) * V.BITS or d.flags
        local t = tables[d.kind]
        for _, copy in ipairs(t and t.copies or {}) do
            local at = copy + HEADER_BYTES + d.off + 260
            if peek4(at) ~= want then api.write(at, u32_bytes(want)) end
        end
    end
end

local function build_stratagems()
    for k = #weapons, 1, -1 do
        if weapons[k].stratagem or weapons[k].mounted then by_hash[weapons[k].hash] = nil; table.remove(weapons, k) end
    end
    -- A Guard Dog, from its stratagem's payloads: its hellpod rack carries the backpack (first slot, +0),
    -- whose charges (DepositComponentData) name the drone (+24); the drone's first mount (+0) is its gun.
    -- Returns { drone = key, gun = key or nil }, or nil when no payload leads to a drone.
    local function drone_of(keys)
        local rt, dt, mt = tables[TYPES.rack], tables[TYPES.deposit], tables[TYPES.mount]
        if not rt or not dt then return nil end
        local function entity(t, at)
            local k = api.read(t.copies[1] + HEADER_BYTES + at, 8)
            if k and #k == 8 and (u32(k, 0) ~= 0 or u32(k, 4) ~= 0) then return k end
        end
        for _, key in ipairs(keys) do
            local rack = rt.index[key]
            local pack = rack and entity(rt, rack)
            local deposit = pack and dt.index[pack]
            local drone = deposit and entity(dt, deposit + 24)
            if drone then
                local mount = mt and mt.index[drone]
                return { drone = drone, gun = mount and entity(mt, mount) }
            end
        end
    end
    local guns, sentries = {}, {}
    for _, w in ipairs(weapons) do
        if w.key then guns[w.key] = true end
        if w.slot == 'Stratagems' then
            w.sentry_defs = {}
            local body = KINDS[TYPES.health].body(w.key)
            sentries[w.key] = w
            if body then sentries[body] = w end
        end
    end
    local defs = {}
    for _, group in ipairs(stratagem_groups) do
        local entry = tables[group]
        for id, off in pairs(entry.index) do
            if not defs[id] then defs[id] = { kind = group, off = off, at = entry.copies[1] + HEADER_BYTES + off } end
        end
    end
    MOD.vehicles.collect(defs)
    local list, known = {}, {}
    local function add(id, name, family, payloads, nodes, def)
        local keys = {}
        if def then
            local head = api.read(def.at + 152, 12)
            local at, count = head and u32(head, 0) + u32(head, 4) * 4294967296, head and u32(head, 8)
            local blob = count and count > 0 and count <= 32 and api.read(at, 8 * count)
            for k = 1, blob and count or 0 do keys[#keys + 1] = blob:sub(8 * k - 7, 8 * k) end
        end
        for _, h in ipairs(payloads) do keys[#keys + 1] = hash_key(h) end
        -- a sentry's or emplacement's stratagem: its cooldown goes on the sentry's own entry
        local sentry = def and by_hash[KINDS[TYPES.health].sentry_ids[id] or '']
        for _, key in ipairs(keys) do sentry = sentry or sentries[key] end
        if sentry and sentry.sentry_defs then
            table.insert(sentry.sentry_defs, KINDS[TYPES.health].main_ids[id] and 1 or #sentry.sentry_defs + 1, def)
            local bits = peek4(def.at + 104)
            log(string.format('stratagem %s: cooldown on %s (%.1f s)', id_hex(id), sentry.name, bits and bits_to_f32(bits) or -1))
            return nil
        end
        local drone = family == 'backpack' and drone_of(keys) or nil
        -- a vehicle: the payload that is one (VehicleComponentData), of a 'VEHICLES.' stratagem (mission
        -- objects like the Bug Plug and the President's reward Patriot call vehicles in too: not listed)
        local vehicle, vt = nil, tables[TYPES.vehicle]
        for _, key in ipairs(keys) do
            if not vehicle and vt and vt.index[key] and family == 'vehicles' then vehicle = key end
        end
        if vehicle then
            local V = KINDS[TYPES.vehicle]
            name = V.ENTITIES[string.format('%08X%08X', u32(vehicle, 4), u32(vehicle, 0))] or V.TITLES[name] or name
        end
        local entry = { name = name, slot = vehicle and 'Mechas' or 'Stratagems', hash = id_hex(id),
                        note = vehicle and 'Vehicle. The weapons it carries are listed under it.' or FAMILY_NOTE[family] or '',
                        rows = {}, by_id = {},
                        stratagem = { id = id, family = family, def = def, payloads = keys, nodes = nodes, guns = guns,
                                      drone = drone, vehicle = vehicle } }
        list[#list + 1] = entry
        return entry
    end
    for _, s in ipairs(STRATAGEMS) do
        known[s[1]] = true
        add(s[1], s[2], s[3], s[4], s[5], defs[s[1]])
    end
    local named, total = 0, 0
    for id, def in pairs(defs) do
        total = total + 1
        local lo, hi = peek4(def.at + 16), peek4(def.at + 20)
        local text = not known[id] and id ~= EAGLE_REARM and lo and hi and read_text(lo + hi * 4294967296)
        if text then
            local family, name = pretty(text)
            name = family == 'backpack' and KINDS[TYPES.jumppack].TITLES[name] or name
            named = named + 1
            local entry = add(id, name, family, {}, {}, def)
            if entry and entry.stratagem.vehicle then
                log('vehicle ' .. entry.name .. ' (' .. text .. ', ' .. id_hex(id) .. '): entity ' ..
                    string.format('%08X%08X', u32(entry.stratagem.vehicle, 4), u32(entry.stratagem.vehicle, 0)))
            elseif entry then
                entry.note = family:sub(1, 1):upper() .. family:sub(2) .. ' stratagem (' .. text .. ').'
                local d = entry.stratagem.drone
                if d then
                    entry.note = 'Guard Dog backpack: the drone and the gun it carries. ' .. entry.note
                    local function hex8(k) return k and string.format('%08X%08X', u32(k, 4), u32(k, 0)) or 'none' end
                    log('guard dog ' .. entry.name .. ' (' .. id_hex(id) .. '): drone ' .. hex8(d.drone) .. ', gun ' .. hex8(d.gun))
                end
            end
        end
    end
    -- mission vehicles: by their first entity's hash
    for _, v in ipairs(KINDS[TYPES.vehicle].NATIVE) do
        local vt, keys = tables[TYPES.vehicle], {}
        for k = 3, #v do
            if vt and vt.index[hash_key(v[k])] then keys[#keys + 1] = hash_key(v[k]) end
        end
        if keys[1] then
            list[#list + 1] = { name = v[1], short = v[2], slot = 'Mechas', hash = v[3], rows = {}, by_id = {},
                                note = 'Vehicle. The weapons it carries are listed under it.',
                                stratagem = { family = 'vehicles', native = true, payloads = {}, nodes = {}, guns = {},
                                              vehicle = keys[1], twins = { unpack(keys, 2) } } }
        end
    end
    table.sort(list, function(a, b)
        local fa, fb = FAMILY_ORDER[a.stratagem.family] or 5, FAMILY_ORDER[b.stratagem.family] or 5
        if fa ~= fb then return fa < fb end
        if a.stratagem.family ~= b.stratagem.family then return a.stratagem.family < b.stratagem.family end
        return a.name:lower() < b.name:lower()
    end)
    -- the weapons each vehicle carries (its mounts), listed after it; one entry per weapon entity
    local MOUNTS = { [0x7BDEC47B] = 'Left arm', [0x47775624] = 'Right arm', [0x23CC0657] = 'Gun', [0xCB79FA57] = 'Main gun',
                     [0x409652FC] = 'Driver gun', [0x3ECFB64B] = 'Rack', [0x372F0418] = 'Turret' }
    local mt, mounted = tables[TYPES.mount], {}
    for _, entry in ipairs(list) do
        weapons[#weapons + 1] = entry
        by_hash[entry.hash] = entry
        local at = entry.stratagem.vehicle and mt and mt.index[entry.stratagem.vehicle]
        for m = 0, at and 4 or -1 do
            local base = mt.copies[1] + HEADER_BYTES + at + m * 24
            local lo, hi, label = peek4(base), peek4(base + 4), peek4(base + 16)
            local hash = lo and hi and (lo ~= 0 or hi ~= 0) and string.format('%08X%08X', hi, lo)
            local w = hash and mounted[hash]
            if w then
                w.note = w.note:gsub('%.$', '') .. ', ' .. entry.name .. '.'
            elseif hash and not by_hash[hash] then
                w = { name = (entry.short or entry.name) .. ': ' .. (MOUNTS[label or 0] or ('Weapon ' .. (m + 1))), slot = 'Mechas', hash = hash,
                      key = hash_key(hash), rows = {}, by_id = {}, mounted = true, note = 'Mounted on the ' .. entry.name .. '.' }
                mounted[hash] = w
                weapons[#weapons + 1] = w
                by_hash[hash] = w
            end
        end
    end
    log(string.format('stratagems: %d group table(s), %d definitions, %d listed (%d from the catalog, %d named in game)',
        #stratagem_groups, total, #list, #STRATAGEMS, named))
    for _, entry in ipairs(list) do entry.stratagem.rearm = defs[EAGLE_REARM] end
end

-- A sentry's or emplacement's body (issue #44), by its entity (`key`): health +0 (with each zone that has a
-- pool of its own the same size: the emplacements' one zone, 1000 of the HMG's 1000), the durable ratio
-- (+268, with the zones that have the same), then for each destruction level the demolition force that
-- destroys it (its tier; direct hits: the level's own when set).
KINDS[TYPES.destruction].body_rows = function(entry, key, section, prefix)
    local ht = tables[TYPES.health]
    local at = ht and ht.index[key]
    if not at then return end
    local zones = {}
    for z = 0, 37 do
        local base = at + 520 + z * 552
        if (KINDS[TYPES.destruction].at(ht.copies[1] + HEADER_BYTES + base + 96) or 0) ~= 0 then zones[#zones + 1] = { z, base } end
    end
    local function follow(id, offset, zone_offset, storage, limit)
        local parts = { part(prefix .. id, TYPES.health, at + offset, storage, limit) }
        local own = default_of(parts[1].field)
        for _, z in ipairs(zones) do
            local p = part(prefix .. id .. '_z' .. z[1], TYPES.health, z[2] + zone_offset, storage, limit)
            if own and default_of(p.field) == own then parts[#parts + 1] = p end
        end
        return parts
    end
    add_row(entry, section, prefix .. 'health', 'Health', 'u32', follow('health', 0, 232, 'u32', 1000000), 0, 100000, 5, 25)
    local durable = add_row(entry, section, prefix .. 'durable', 'Durable ratio (0-1)', 'f32', follow('durable', 268, 204, 'f32', 1),
                            0, 1, 0.05, 0.1)
    durable.note = "0: hits deal their normal damage, 1: their durable damage (the weapon's lower one)"
    local spec = KINDS[TYPES.destruction]
    local n = spec.ready() and tables[TYPES.destruction_map].index[key]
    local block = n and spec.found[n + 1]
    if not block then return end
    local base = block - spec.found[1]
    local death = field_at(TYPES.health, at + spec.DEATH, 'u32', 100)
    local levels = {}
    for level = 0, 2 do
        for _, o in ipairs({ 16, 32 }) do
            local f = field_at(TYPES.destruction, base + level * 48 + o, 'tier', 1000)
            local own = default_of(f)
            if own and own > 0 then
                local t = spec.at(tables[TYPES.destruction].copies[1] + HEADER_BYTES + base + level * 48 + o + 8)
                if t and t == default_of(death) then f.death = death end
                levels[#levels + 1] = { f = f, level = level, hit = o == 32 }
            end
        end
    end
    local stages = 0
    for _, l in ipairs(levels) do if not l.hit then stages = stages + 1 end end
    for k, l in ipairs(levels) do
        local id = prefix .. 'demolition' .. (l.level > 0 and l.level + 1 or '') .. (l.hit and '_hit' or '')
        local label = (stages > 1 and not l.hit) and ('Demolition force, stage ' .. (l.level + 1))
                      or ('Demolition force to destroy it' .. (l.hit and ' (direct hits)' or ''))
        local row = add_row(entry, section, id, label, 'u32', { { id = id, field = l.f } }, 1, 250, 10, 10)
        if k == 1 then row.note = 'the game\'s tiers: 10 small arms, 20 HMG, 30 autocannon, 40 Strider, 50 orbital, 60 Hellbomb, 250 never' end
    end
    if #levels > 0 then
        local t = {}
        for _, l in ipairs(levels) do t[#t + 1] = (l.hit and 'hit ' or 'level ') .. (l.level + 1) .. ' ' .. tostring(default_of(l.f)) end
        log('destruction: ' .. entry.name .. ' settings ' .. n .. ': ' .. table.concat(t, ', ') ..
            ', on death ' .. tostring(default_of(death)))
    end
end

-- A unit's own rows (a Guard Dog's drone, a sentry or emplacement): health +0, spotting range +0,
-- target search interval +0 / +4, turret turn speed +12 horizontal / +8 vertical, where it has them.
local function unit_rows(entry, key, section, prefix)
    local function unit(kind, id, label, offset, storage, max, small, big)
        local at = tables[kind] and tables[kind].index[key]
        if at then
            add_row(entry, section, prefix .. id, label, storage, { part(prefix .. id, kind, at + offset, storage, 1000000) },
                    0, max, small, big)
        end
    end
    if prefix == 'unit_' then KINDS[TYPES.destruction].body_rows(entry, key, section, prefix)
    else unit(TYPES.health, 'health', 'Health', 0, 'u32', 100000, 5, 25) end
    unit(TYPES.sensor, 'sight', 'Spotting range (m)', 0, 'f32', 1000, 1, 5)
    unit(TYPES.detector, 'search_min', 'Target search interval, min (s)', 0, 'f32', 60, 0.05, 0.25)
    unit(TYPES.detector, 'search_max', 'Target search interval, max (s)', 4, 'f32', 60, 0.05, 0.25)
    unit(TYPES.turret, 'turn_h', 'Turn speed, horizontal (deg/s)', 12, 'f32', 3600, 1, 10)
    unit(TYPES.turret, 'turn_v', 'Turn speed, vertical (deg/s)', 8, 'f32', 3600, 1, 10)
end

-- A vehicle's rows (by its entity, `key`): its health component: health +0 (i32), armor +280 (the
-- default zone's), then each damageable zone (38 of 552 bytes from +520; +96 name, 0: unused; +216 armor,
-- +232 health, -1: none). Zones are named from MOD.vehicle_parts (by the name's hash), else numbered.
-- twins: the same vehicle's other entities (the GATER's two), written along.
KINDS[TYPES.vehicle].rows = function(entry, key, twins)
    local t = tables[TYPES.health]
    local at = t and t.index[key]
    if not at then return end
    local top = t.copies[1] + HEADER_BYTES
    local others = {}
    for _, k in ipairs(twins or {}) do others[#others + 1] = t.index[k] end
    local function parts(id, offset, storage, limit)
        local out = { part(id, TYPES.health, at + offset, storage, limit) }
        for n, o in ipairs(others) do out[#out + 1] = part(id .. '_' .. (n + 1), TYPES.health, o + offset, storage, limit) end
        return out
    end
    add_row(entry, 'Vehicle', 'health', 'Health', 'u32', parts('health', 0, 'u32', 10000000), 0, 1000000, 50, 500)
    add_row(entry, 'Vehicle', 'armor', 'Armor', 'u32', parts('armor', 280, 'u32', 100), 0, 10, 1, 1)
    -- regeneration (issue #73, tested in game by its reporter): health per second +4 and its rate in the
    -- regeneration phase +20, written together; it starts this long after the last damage +12 (all 0 on
    -- vehicles). Damaged parts heal; a destroyed one (a wheel) stays destroyed: that state is not in the file
    local regen_parts = parts('regen', 4, 'f32', 1000000)
    for _, p in ipairs(parts('regen_phase', 20, 'f32', 1000000)) do regen_parts[#regen_parts + 1] = p end
    local regen = add_row(entry, 'Vehicle', 'regen', 'Regeneration (health/s)', 'f32', regen_parts, 0, 100000, 5, 50)
    regen.note = 'damaged parts heal; destroyed parts stay destroyed'
    add_row(entry, 'Vehicle', 'regen_delay', 'Regeneration delay after damage (s)', 'f32',
            parts('regen_delay', 12, 'f32', 3600), 0, 600, 0.1, 1)
    local n = 0
    for z = 0, 37 do
        local base = 520 + z * 552
        local name = peek4(top + at + base + 96)
        if name and name ~= 0 then
            n = n + 1
            local label = MOD.vehicle_parts[name] or ('Part ' .. n)
            local id = 'zone' .. z
            local health = read_field(field_at(TYPES.health, at + base + 232, 'u32', 10000000))
            if health then
                add_row(entry, 'Body parts', id .. '_health', label .. ' health', 'u32',
                        parts(id .. '_health', base + 232, 'u32', 10000000), 0, 1000000, 10, 100)
            end
            add_row(entry, 'Body parts', id .. '_armor', label .. ' armor', 'u32',
                    parts(id .. '_armor', base + 216, 'u32', 100), 0, 10, 1, 1)
        end
    end
end

-- names: by the stratagem's debug name (as `pretty` gives it), or by the vehicle's entity (exosuits whose
-- debug names do not say which they are); MOUNTS: a mount's label by its name
KINDS[TYPES.vehicle].TITLES = {
    ['Bastion(tank)'] = 'TD-220 Bastion MK XVI', ['Storm(tank)'] = 'TD-110 Maelstrom',
    ['Fast Recon Vehicle (FRV)'] = 'M-102 Gunner FRV', ['Fast Recon Vehicle (Ramming Flamethrower)'] = 'M-104 Incinerator FRV',
    ['Fast Recon Vehicle (Resupply Auto Turret)'] = 'M-103 Supply FRV', ['Combat Walker Lumberer'] = 'EXO-51 Lumberer Exosuit',
    ['Combat Walker Breakthrough'] = 'EXO-55 Breakthrough Exosuit', ['Combat Walker Emancipator'] = 'EXO-49 Emancipator Exosuit',
    ['Combat Walker Patriot'] = 'EXO-45 Patriot Exosuit' }
KINDS[TYPES.vehicle].ENTITIES = { ['79E4B3D2DA5E45E3'] = 'EXO-45 Patriot Exosuit', ['C2D449ECF7FACAB1'] = 'EXO-49 Emancipator Exosuit' }
-- vehicles no stratagem calls in (mission vehicles): { name, short name (its weapons'), its entities } (the GATER: two
-- identical ones)
KINDS[TYPES.vehicle].NATIVE = { { 'Ground All-Terrain Extraction Rig (GATER)', 'GATER', '0801B6B3C5D12EBC', '423FF97D57AB04F5' } }

-- The player's shields, by the entity listed (a stratagem's payload, a throwable): the energy shield
-- (ShieldComponentData: +0 radius, +76 capacity, +88 recharge delay, +92 recharge delay once broken,
-- +96 recharge rate, +100 charge it comes back with) and the bodies with health (health component:
-- health +0, armor +280, durable ratio +268 and each named zone's +204).
KINDS[TYPES.shield].OF = {
    ['12C8D71AC3897A5C'] = { shield = '12C8D71AC3897A5C' },                                         -- SH-32 Shield Generator Pack
    ['A4E796F84801B40A'] = { shield = 'B56FA3F5510000AB',                                           -- SH-51 Directional Shield
                             bodies = { { 'A4E796F84801B40A', 'Backpack' }, { 'B56FA3F5510000AB', 'Shield emitter' } } },
    ['967ED15E0BAE363B'] = { bodies = { { '967ED15E0BAE363B', 'Ballistic shield' } } },            -- SH-20 Ballistic Shield Backpack
    ['ED13DDC480EC6910'] = { shield = 'ED13DDC480EC6910', bodies = { { 'ED13DDC480EC6910', 'Generator' } } },   -- FX-12 Relay
    ['C91FB921947AD273'] = { shield = '1B9AC59697006337' },                                         -- G/SH-39 Shield
    ['1B9AC59697006337'] = { shield = '1B9AC59697006337' },
}
KINDS[TYPES.shield].rows = function(entry, hex)
    local of = KINDS[TYPES.shield].OF[hex]
    if not of then return false end
    local st, ht = tables[TYPES.shield], tables[TYPES.health]
    local at = of.shield and st and st.index[hash_key(of.shield)]
    if at then
        local function r(id, label, offset, max, small, big)
            add_row(entry, 'Shield', id, label, 'f32', { part(id, TYPES.shield, at + offset, 'f32', 1000000) }, 0, max, small, big)
        end
        r('shield_capacity', 'Shield capacity', 76, 1000000, 50, 250)
        if (read_field(field_at(TYPES.shield, at, 'f32', 1000)) or 0) > 0 then r('shield_radius', 'Radius (m)', 0, 200, 0.1, 1) end
        r('shield_delay', 'Recharge delay (s)', 88, 600, 1, 5)
        r('shield_broken', 'Recharge delay once broken (s)', 92, 600, 1, 5)
        r('shield_rate', 'Recharge rate (per s)', 96, 1000000, 10, 50)
        r('shield_restart', 'Charge when it comes back', 100, 1000000, 10, 50)
    end
    for k, b in ipairs(of.bodies or {}) do
        local hat = ht and ht.index[hash_key(b[1])]
        if hat then
            local p = 'body' .. k .. '_'
            add_row(entry, b[2], p .. 'health', 'Health', 'u32', { part(p .. 'health', TYPES.health, hat, 'u32', 10000000) }, 0, 1000000, 50, 250)
            add_row(entry, b[2], p .. 'armor', 'Armor', 'u32', { part(p .. 'armor', TYPES.health, hat + 280, 'u32', 100) }, 0, 10, 1, 1)
            if (read_field(field_at(TYPES.health, hat + 268, 'f32', 1)) or 0) > 0 then
                local parts = { part(p .. 'durable', TYPES.health, hat + 268, 'f32', 1) }
                for z = 0, 37 do
                    local base = hat + 520 + z * 552
                    if (peek4(ht.copies[1] + HEADER_BYTES + base + 96) or 0) ~= 0 then
                        parts[#parts + 1] = part(p .. 'durable_z' .. z, TYPES.health, base + 204, 'f32', 1)
                    end
                end
                add_row(entry, b[2], p .. 'durable', 'Durable ratio (0-1)', 'f32', parts, 0, 1, 0.05, 0.1)
            end
        end
    end
    return true
end

-- A backpack's rows, by the entity its hellpod carries (`key`, 8 bytes):
--   jump / hover pack: recharge +0 (RechargeComponentData); +156 > 0: hovers (6 s climb gate; -1 on jump
--     packs). Each pack gets only the fields its flight code reads (HD2Runtime 0.30.3 research): the Jump
--     Pack its launch force +0 (x (1 - t^2) over the launch duration +24), forward share of it +32, the
--     boost after it (duration +40; its force +36 is capped by the game at 2.5 x speed per second, so not
--     offered) and mid-air steering +60 (both packs); the Hover Pack (skips the launch) its hover speed +176,
--     horizontal acceleration +160 / +164 (blended over a zero-width speed range: always written together),
--     fuel rates +200 / +204, climb speed (+196 with +180), climb acceleration +168 and climb time limit +156
--   Warp Pack: explosion +56 (set off by an unsafe warp), warp distance +120, reach up +128 / down +132,
--     heat: safe below +140, unsafe above +144, per warp +148, cooling per second +152; injuries of an
--     unsafe warp: 12 of 24 bytes from +160 (+0 body part, +4 damage): head, 2 arms, 2 legs
--   charges: +0 capacity, +4 at the start (-1: full), +8 from resupply
-- backpack stratagems' names, by their debug names (as `pretty` gives them)
KINDS[TYPES.jumppack].TITLES = {
    ['Jumppack Backpack'] = 'LIFT-850 Jump Pack', ['Hoverpack Backpack'] = 'LIFT-860 Hover Pack',
    ['Displacement Backpack'] = 'LIFT-182 Warp Pack', ['Supply Backpack'] = 'B-1 Supply Pack',
    ['Hellbomb'] = 'B-100 Portable Hellbomb', ['Generator Pack'] = 'SH-32 Shield Generator Pack',
    ['Ballistic Shield Backpack'] = 'SH-20 Ballistic Shield Backpack', ['Directional Energy Shield'] = 'SH-51 Directional Shield',
    ['Guard Dog (Drone)'] = 'AX/AR-23 "Guard Dog"', ['Laser Rifle (Drone)'] = 'AX/LAS-5 "Guard Dog" Rover',
    ['Guard Dog Gas Projector (Drone)'] = 'AX/TX-13 "Guard Dog" Dog Breath',
    ['Guard Dog Flamethrower (Drone)'] = 'AX/FLAM-75 "Guard Dog" Hot Dog', ['Guard Dog (Drone) Stun'] = 'AX/ARC-3 "Guard Dog" K-9' }
KINDS[TYPES.jumppack].backpack = function(entry, key, ammo)
    if entry.backpack then return end
    entry.backpack = true
    local function at(kind)
        local t = tables[kind]
        return t and t.index[key]
    end
    local function r(section, id, label, kind, offset, storage, max, small, big, parts)
        add_row(entry, section, id, label, storage, parts or { part(id, kind, offset, storage, 1000000) }, 0, max, small, big)
    end
    local jump, recharge = at(TYPES.jumppack), at(TYPES.recharge)
    if jump then
        local hover = (read_field(field_at(TYPES.jumppack, jump + 156, 'f32', 1000000)) or -1) > 0
        local section = hover and 'Hover pack' or 'Jump pack'
        if recharge then r(section, 'bp_recharge', 'Recharge time (s)', TYPES.recharge, recharge, 'f32', 600, 0.5, 2) end
        if not hover then
            r(section, 'bp_launch', 'Launch force', TYPES.jumppack, jump, 'f32', 1000, 1, 5)
            r(section, 'bp_takeoff', 'Launch duration (s)', TYPES.jumppack, jump + 24, 'f32', 5, 0.05, 0.25)
            r(section, 'bp_forward', 'Forward share of the launch (0-1)', TYPES.jumppack, jump + 32, 'f32', 1, 0.05, 0.1)
            r(section, 'bp_landing_time', 'Boost after the launch (s)', TYPES.jumppack, jump + 40, 'f32', 10, 0.05, 0.25)
        end
        r(section, 'bp_steer', 'Mid-air steering force', TYPES.jumppack, jump + 60, 'f32', 200, 0.5, 2)
        -- hover fuel is the recharge meter: each second hovering adds 1 + a fuel rate (+200 holding height,
        -- +204 at 8 m/s vertical speed) seconds to it, and the pack cuts out once it is full; times: the
        -- recharge time over 1 + that rate, kept when the recharge time changes (+156 only gates climbing)
        local tank = recharge and hover and field_at(TYPES.recharge, recharge, 'f32', 1000000)
        if tank then
            local keeps = {}
            local function fuel(id, label, offset)
                local p = part(id, TYPES.jumppack, jump + offset, 'f32', 1000000)
                p.field.signed = true
                local row = add_row(entry, section, id, label, 'f32', { p }, 0.1, 3600, 0.5, 2)
                row.span, row.span_default = function() return read_field(tank) end, function() return default_of(tank) end
                row.rate_plus = 1
                keeps[#keeps + 1] = row
            end
            fuel('bp_hover_fuel', 'Hover time, holding height (s)', 200)
            fuel('bp_climb_fuel', 'Hover time, full-speed climb (s)', 204)
            for _, row in ipairs(entry.rows) do
                if row.id == 'bp_recharge' then row.keeps = keeps end
            end
        end
        if hover then
            r(section, 'bp_hover_speed', 'Hover speed (m/s)', TYPES.jumppack, jump + 176, 'f32', 50, 0.5, 2)
            -- agility: how fast the hover speeds up toward the movement input; its two ends of a zero-width
            -- speed range must stay equal (one alone divides by zero), so the second follows the first
            local agility = add_row(entry, section, 'bp_agility', 'Hover agility (acceleration)', 'f32',
                { part('bp_agility', TYPES.jumppack, jump + 160, 'f32', 1000000),
                  part('bp_agility_high', TYPES.jumppack, jump + 164, 'f32', 1000000) }, 0.1, 200, 0.5, 2)
            agility.lead = true
            -- climbing: the speed nears the end of the vertical speed range +196 (the acceleration +168 fades to
            -- +172 = 0 there; the climb target +180 sits above it), so the row shows +196 and scales +180 with it
            local climb = add_row(entry, section, 'bp_climb_speed', 'Climb speed (m/s)', 'f32',
                { part('bp_climb_speed', TYPES.jumppack, jump + 196, 'f32', 1000000),
                  part('bp_climb_target', TYPES.jumppack, jump + 180, 'f32', 1000000) }, 0.5, 50, 0.5, 2)
            climb.lead = true
            r(section, 'bp_climb_accel', 'Climb acceleration', TYPES.jumppack, jump + 168, 'f32', 200, 0.5, 2)
            -- +156 > 0 marks a hover pack, so it stays above 0
            add_row(entry, section, 'bp_climb_time', 'Climb time limit (s)', 'f32',
                { part('bp_climb_time', TYPES.jumppack, jump + 156, 'f32', 1000000) }, 0.5, 600, 0.5, 2)
        end
    end
    local warp = at(TYPES.warp)
    if warp then
        local function w(id, label, offset, max, small, big)
            r('Warp pack', id, label, TYPES.warp, warp + offset, 'f32', max, small, big)
        end
        w('bp_warp_range', 'Warp distance (m)', 120, 1000, 0.5, 5)
        w('bp_warp_up', 'Reach upward (m)', 128, 100, 0.1, 1)
        w('bp_warp_down', 'Reach downward (m)', 132, 100, 0.1, 1)
        w('bp_warp_heat', 'Heat per warp (%)', 148, 100, 1, 5)
        w('bp_warp_cool', 'Cooling (% per s)', 152, 100, 0.5, 2)
        w('bp_warp_safe', 'Safe below heat (%)', 140, 100, 1, 5)
        w('bp_warp_unsafe', 'Injures you above heat (%)', 144, 100, 1, 5)
        local function hurt(id, label, list)
            local parts = {}
            for k, n in ipairs(list) do
                local o = warp + 160 + n * 24 + 4
                parts[k] = part(k == 1 and id or (id .. '_' .. k), TYPES.warp, o, 'f32', 1000000)
            end
            if read_field(parts[1].field) then
                r('Unsafe warp: damage to you', id, label, nil, nil, 'f32', 10000, 1, 5, parts)
            end
        end
        hurt('bp_warp_head', 'Head', { 0 })
        hurt('bp_warp_arms', 'Each arm', { 1, 2 })
        hurt('bp_warp_legs', 'Each leg', { 3, 4 })
        local id = read_field(field_at(TYPES.warp, warp + 56, 'u32', 100000))
        local xrow = id and id > 0 and tables[T_EXPLOSION] and tables[T_EXPLOSION].index[id]
        if xrow then
            local section = 'Unsafe warp: explosion'
            local qrow = read_field(field_at(T_EXPLOSION, xrow + 4, 'u32', 100000))
            qrow = qrow and qrow > 0 and tables[T_DAMAGE] and tables[T_DAMAGE].index[qrow]
            if qrow then
                damage_rows(entry, section, 'bp_warp_x_', qrow)
                status_rows(entry, section, 'bp_warp_x_', qrow, 'blast')
            end
            for _, f in ipairs({ { 'inner', 'Inner radius (m)', 16 }, { 'outer', 'Outer radius (m)', 20 },
                                 { 'shockwave', 'Shockwave radius (m)', 24 } }) do
                r(section, 'bp_warp_x_' .. f[1], f[2], T_EXPLOSION, xrow + f[3], 'f32', 200, 0.1, 1)
            end
        end
    end
    local deposit = at(TYPES.deposit)
    if deposit and ammo then
        -- a support weapon's ammo backpack: the spare rockets / magazines it reloads from, or the rounds
        -- a belt-fed weapon fires from it
        local first = add_row(entry, 'Backpack', 'bp_ammo', 'Ammo carried', 'u32',
                              { part('bp_ammo', TYPES.deposit, deposit, 'u32', 1000000) }, 0, 100000, 1, 10)
        first.note = 'the spare ammo in its backpack; read when the backpack is called in'
        local start = read_field(field_at(TYPES.deposit, deposit + 4, 'u32', 0xFFFFFFFF))
        if start and start ~= 0xFFFFFFFF then r('Backpack', 'bp_ammo_start', 'Ammo at the start', TYPES.deposit, deposit + 4, 'u32', 100000, 1, 10) end
        r('Backpack', 'bp_ammo_supply', 'Ammo from resupply', TYPES.deposit, deposit + 8, 'u32', 100000, 1, 10)
    elseif deposit then
        r('Backpack', 'bp_charges', 'Charges', TYPES.deposit, deposit, 'u32', 999, 1, 5)
        local start = read_field(field_at(TYPES.deposit, deposit + 4, 'u32', 0xFFFFFFFF))
        if start and start < 1000 then r('Backpack', 'bp_charges_start', 'Starting charges', TYPES.deposit, deposit + 4, 'u32', 999, 1, 5) end
        r('Backpack', 'bp_charges_supply', 'Charges from resupply', TYPES.deposit, deposit + 8, 'u32', 999, 1, 5)
    end
end

-- A minefield stratagem's rows, by its pod (`key`): thrower (formation 1): +40 panels, +44 mines per panel,
-- +248 arming time, +260 / +264 throw velocity min / max, +280 spread (degrees); spawner: +8 / +12 field
-- width / depth, +16 / +20 mines wide / deep, +24 position scatter; minefield: +8 trigger delay, +12 chain
-- reaction delay, +24 explosion (its damage and radii). true when `key` is one.
KINDS[TYPES.minefield].rows = function(entry, key)
    local function at(kind) return tables[kind] and tables[kind].index[key] end
    local thrower, spawner, mine = at(TYPES.thrower), at(TYPES.mine_spawner), at(TYPES.minefield)
    if entry.mines or not (thrower or spawner or mine) then return entry.mines end
    entry.mines = true
    local function r(section, id, label, kind, offset, storage, min, max, small, big)
        add_row(entry, section, id, label, storage, { part(id, kind, offset, storage, 1000000) }, min, max, small, big)
    end
    if thrower then
        -- the pod throws each mine from a node of its model (panel_<p>_mine_<m>): more panels or mines than
        -- it has crashes the game, so these only go down from the game's values
        -- (`most` caps every write, saved values and presets included)
        for _, c in ipairs({ { 'mine_panels', 'Panels', 40 }, { 'mine_per_panel', 'Mines per panel', 44 } }) do
            local f = field_at(TYPES.thrower, thrower + c[3], 'u32', 1000000)
            f.most = default_of(f) or 0
            local row = add_row(entry, 'Minefield', c[1], c[2], 'u32', { { id = c[1], field = f } }, 0, f.most, 1, 1)
            if c[3] == 40 then row.note = 'panels, mines per panel: lower only (more than the default crashes the game)' end
        end
        r('Minefield', 'mine_arming', 'Arming time (s)', TYPES.thrower, thrower + 248, 'f32', 0, 60, 0.1, 1)
        r('Minefield', 'mine_throw_min', 'Throw velocity, min (m/s)', TYPES.thrower, thrower + 260, 'f32', 0, 200, 0.5, 2)
        r('Minefield', 'mine_throw_max', 'Throw velocity, max (m/s)', TYPES.thrower, thrower + 264, 'f32', 0, 200, 0.5, 2)
        r('Minefield', 'mine_spread', 'Throw spread (degrees)', TYPES.thrower, thrower + 280, 'f32', 0, 360, 1, 5)
    end
    if spawner then
        r('Minefield', 'mine_wide', 'Mines wide', TYPES.mine_spawner, spawner + 16, 'u32', 1, 48, 1, 1)
        r('Minefield', 'mine_deep', 'Mines deep', TYPES.mine_spawner, spawner + 20, 'u32', 1, 48, 1, 1)
        r('Minefield', 'mine_width', 'Field width (m)', TYPES.mine_spawner, spawner + 8, 'f32', 0, 500, 1, 5)
        r('Minefield', 'mine_depth', 'Field depth (m)', TYPES.mine_spawner, spawner + 12, 'f32', 0, 500, 1, 5)
        r('Minefield', 'mine_scatter', 'Position scatter (m)', TYPES.mine_spawner, spawner + 24, 'f32', 0, 100, 0.5, 2)
    end
    if mine then
        r('Mine', 'mine_trigger', 'Trigger delay (s)', TYPES.minefield, mine + 8, 'f32', 0, 60, 0.05, 0.5)
        r('Mine', 'mine_chain', 'Chain reaction delay (s)', TYPES.minefield, mine + 12, 'f32', 0, 60, 0.05, 0.5)
        local id = read_field(field_at(TYPES.minefield, mine + 24, 'u32', 100000))
        local xrow = id and id > 0 and tables[T_EXPLOSION] and tables[T_EXPLOSION].index[id]
        if xrow then
            local section = 'Mine explosion'
            local q = read_field(field_at(T_EXPLOSION, xrow + 4, 'u32', 100000))
            q = q and q > 0 and tables[T_DAMAGE] and tables[T_DAMAGE].index[q]
            if q then
                damage_rows(entry, section, 'mine_x_', q)
                status_rows(entry, section, 'mine_x_', q, 'blast')
            end
            for _, f in ipairs({ { 'inner', 'Inner radius (m)', 16 }, { 'outer', 'Outer radius (m)', 20 },
                                 { 'shockwave', 'Shockwave radius (m)', 24 } }) do
                r(section, 'mine_x_' .. f[1], f[2], T_EXPLOSION, xrow + f[3], 'f32', 0, 200, 0.1, 1)
            end
        end
    end
    -- the pod itself (enemies go for it like a sentry): health, durable ratio, demolition force, armor +280
    if thrower then
        KINDS[TYPES.destruction].body_rows(entry, key, 'Deployer', 'pod_')
        local body = tables[TYPES.health] and tables[TYPES.health].index[key]
        if body then r('Deployer', 'pod_armor', 'Armor', TYPES.health, body + 280, 'u32', 0, 10, 1, 1) end
    end
    return true
end

-- Extra stratagem (issue #64): StratagemInfo +200 additional_stratagem, a stratagem type (+0) given along when
-- this one is in your loadout (the Eagles' is Eagle Rearm, so they are offered as extras only). The choices:
-- every stratagem the game has (mission and President's reward ones too: the Dark Fluid and Medic backpacks
-- work, tested), by name; 0: none. A choice that leads back to the stratagem is refused.
MOD.extra = { FAMILIES = { support = true, backpack = true, sentry = true, emplacements = true, orbital = true,
                           vehicles = true, eagle = true } }
function MOD.extra.choices()
    if MOD.extra.list then return MOD.extra.list, MOD.extra.by_type end
    local list, by_type, names = {}, {}, {}
    for _, w in ipairs(weapons) do
        local def, family = w.stratagem and w.stratagem.def, w.stratagem and w.stratagem.family
        if not w.stratagem and w.sentry_defs and w.sentry_defs[1] then def, family = w.sentry_defs[1], 'sentry' end
        local t = def and peek4(def.at)
        if t and t > 0 and not by_type[t] then
            -- (a second stratagem with a name, e.g. the President's reward Health Pack Rack: its family after it)
            local name = names[w.name] and (w.name .. ' (' .. family:sub(1, 1):upper() .. family:sub(2) .. ')') or w.name
            names[w.name] = true
            w.extra_id = t         -- (shown after its name in the list, for typing a choice in)
            by_type[t] = { type = t, name = name, def = def, family = family }
            list[#list + 1] = by_type[t]
        end
    end
    table.sort(list, function(a, b) return a.name:lower() < b.name:lower() end)
    for n, c in ipairs(list) do c.n = n end
    MOD.extra.list, MOD.extra.by_type = list, by_type
    return list, by_type
end
-- the next / previous choice by name for `def` (n steps; 0 sits before the first), skipping what it can't have
-- (itself, a loop); nil: none that way
function MOD.extra.step(def, current, n)
    local list, by_type = MOD.extra.choices()
    local at = current ~= 0 and by_type[current] and by_type[current].n or 0
    local to = math.max(0, math.min(#list, at + n))
    local dir = n > 0 and 1 or -1
    while to > 0 and to <= #list and MOD.extra.refused(def, list[to].type) do to = to + dir end
    if to > #list then return nil end
    return to <= 0 and 0 or list[to].type
end
-- why `target` can't be `def`'s extra (itself, or a chain of extras back to it), or nil
function MOD.extra.refused(def, target)
    local _, by_type = MOD.extra.choices()
    if target == 0 then return nil end
    if not by_type[target] then return 'No stratagem ' .. tostring(target) .. ' to choose.' end
    local own = peek4(def.at)
    -- (itself included: the game follows extras with no end, and crashes as the mission starts; tested)
    local t = target
    for _ = 1, 64 do
        if t == own then return 'That would make a loop of extra stratagems.' end
        local c = by_type[t]
        t = c and peek4(c.def.at + 200) or 0
        if not t or t == 0 then return nil end
    end
    return 'That would make a loop of extra stratagems.'
end
function MOD.extra.row(entry, def)
    local row = add_row(entry, 'Extra stratagem', 'extra', 'Extra stratagem (choice)', 'u32',
                        { part('extra', def.kind, def.off + 200, 'u32', 100000) }, 0, 100000, 1, 10)
    row.choice = 'stratagem'
    row.def = def
    -- the row shows the chosen stratagem's name (its number, shown in the list, is the value, for typing)
    row.label_of = function()
        local t = read_field(row.parts[1].field) or 0
        local _, by_type = MOD.extra.choices()
        if t == 0 then return 'None' end
        return by_type[t] and by_type[t].name or ('Stratagem ' .. t)
    end
    row.note = 'also in your loadout when you bring this one'
    row.after = { '- / + steps through the stratagems by name (-- / ++: 10 at a time).',
                  "Or type the number shown after a stratagem's name in the list; 0 = none.",
                  "It doesn't take a loadout slot, but the HUD's stratagem list can fill up." }
    row.after_h = #row.after * 16 + 6
end

-- Call-in (issue #43), StratagemInfo +84 spawn_time: the beacon's countdown before the delivery is sent (every
-- stratagem; ship upgrades take some off). The hellpod's fall (4.75 s), a Pelican's flight and an Eagle's are the
-- game's own; +96 extra_travel_time and +100 (vehicles 10.5) change neither (tested in game). With every ship
-- upgrade: the 380mm's countdown edit applies, the EAT's and the MG sentry's are skipped (tested).
function MOD.callin_rows(entry, defs)
    local parts = {}
    for k, def in ipairs(defs) do parts[k] = part(k == 1 and 'callin' or 'callin' .. k, def.kind, def.off + 84, 'f32', 100000) end
    local row = add_row(entry, 'Stratagem', 'callin', 'Countdown before delivery (s)', 'f32', parts, 0, 60, 0.5, 5)
    row.tip = { "The beacon's countdown before the delivery is sent.",
                "A hellpod lands this many seconds plus its 4.75 s fall after the beacon, so 0 is the fastest it gets.",
                'Ship upgrades that make support weapons and sentries launch at once skip it (tested).' }
end

local function resolve_stratagem(entry)
    local s = entry.stratagem
    local def = s.def
    if def then
        add_row(entry, 'Stratagem', 'cooldown', 'Cooldown (s)', 'f32',
                { part('cooldown', def.kind, def.off + 104, 'f32', 100000) }, 0, 10000, 1, 10)
        if read_field(field_at(def.kind, def.off + 80, 'u32', 999)) then
            add_row(entry, 'Stratagem', 'uses', s.family == 'eagle' and 'Uses per rearm' or 'Uses per mission', 'u32',
                    { part('uses', def.kind, def.off + 80, 'u32', 999) }, 0, 999, 1, 5)
        end
        if s.family ~= 'eagle' then MOD.callin_rows(entry, { def }) end
        if s.family ~= 'eagle' and MOD.extra.FAMILIES[s.family] then MOD.extra.row(entry, def) end
    end
    if s.family == 'eagle' and s.rearm then
        add_row(entry, 'Stratagem', 'rearm', 'Eagle rearm time (s)', 'f32',
                { part('rearm', s.rearm.kind, s.rearm.off + 104, 'f32', 100000) }, 0, 10000, 1, 10)
    end
    for _, key in ipairs(s.payloads) do
        local bomb = tables[TYPES.bombard] and tables[TYPES.bombard].index[key]
        if bomb then
            local function b(id, label, offset, storage, min, max, small, big)
                add_row(entry, 'Barrage', id, label, storage, { part(id, TYPES.bombard, bomb + offset, storage, 100000) }, min, max, small, big)
            end
            b('barrage_salvos', 'Salvos', 24, 'u32', 1, 100, 1, 5)
            b('barrage_shells', 'Shells per salvo', 4, 'u32', 1, 500, 1, 5)
            b('barrage_shell_gap', 'Time between shells (s)', 8, 'f32', 0, 60, 0.05, 0.25)
            b('barrage_salvo_gap', 'Time between salvos (s)', 28, 'f32', 0, 120, 0.5, 2)
            b('barrage_area', 'Spread area (m)', 36, 'f32', 0, 500, 1, 5)
            if (read_field(field_at(TYPES.bombard, bomb + 96, 'f32', 100000)) or 0) > 0 then
                b('barrage_speed', 'Walking speed (m/s)', 96, 'f32', 0, 100, 0.5, 2)
            end
            break
        end
        local eagle = tables[TYPES.eagle] and tables[TYPES.eagle].index[key]
        if eagle then
            local moved = KINDS[TYPES.eagle].offsets or {}
            local function e(id, label, offset, min, max, small, big, also)
                local parts = { part(id, TYPES.eagle, eagle + (moved[offset] or offset), 'f32', 100000) }
                if also then parts[2] = part(id .. '_2', TYPES.eagle, eagle + (moved[also] or also), 'f32', 100000) end
                return add_row(entry, 'Eagle', id, label, 'f32', parts, min, max, small, big)
            end
            local approach = e('eagle_approach', 'Approach distance (m)', 52, 0, 10000, 10, 100, 56)
            approach.tip = { 'How far away the jet starts its run. With its speed, it sets how long the Eagle takes to arrive.',
                             "The beacon's timer still counts down the usual time (tested)." }
            e('eagle_speed', 'Speed until it has fired (m/s)', 76, 0, 5000, 10, 50)
            local payload = read_field(field_at(TYPES.eagle, eagle + 16, 'u32', 100))
            if payload == 5 then e('eagle_bomb_gap', 'Time between bombs (s)', 44, 0, 10, 0.05, 0.25)
            else e('eagle_fire_time', 'Fire duration (s)', 40, 0, 30, 0.1, 0.5) end
            if (read_field(field_at(TYPES.eagle, eagle + (moved[108] or 108), 'f32', 100000)) or 0) > 0 then
                e('eagle_run_length', 'Run length (m)', 108, 0, 500, 1, 5)
            end
            break
        end
    end
    for _, key in ipairs(s.payloads) do
        local beam = tables[T_ORBITAL] and tables[T_ORBITAL].index[key]
        if beam then
            local function b(id, label, offset, min, max, small, big)
                add_row(entry, 'Orbital beam', id, label, 'f32', { part(id, T_ORBITAL, beam + offset, 'f32', 100000) }, min, max, small, big)
            end
            b('beam_duration', 'Duration (s)', 460, 0, 600, 1, 5)
            b('beam_speed', 'Tracking speed', 468, 0, 200, 1, 5)
            b('beam_radius', 'Search radius (m)', 472, 0, 500, 1, 10)
            b('beam_tick', 'Damage tick (s)', 480, 0.01, 10, 0.01, 0.05)
            break
        end
    end
    for _, node in ipairs(s.nodes) do
        local kind, record, section = node[1], node[2], node[3]
        if kind == 'P' then
            local row = tables[T_PROJECTILE] and tables[T_PROJECTILE].index[record]
            if row then
                local id = 'p' .. record .. '_velocity'
                add_row(entry, section, id, 'Velocity (m/s)', 'f32', { part(id, T_PROJECTILE, row + 32, 'f32', 100000) }, 0, 100000, 10, 100)
                id = 'p' .. record .. '_gravity'
                add_row(entry, section, id, 'Gravity factor', 'f32', { part(id, T_PROJECTILE, row + 44, 'f32', 100000) }, 0, 100, 0.05, 0.5)
            end
        elseif kind == 'X' then
            local row = tables[T_EXPLOSION] and tables[T_EXPLOSION].index[record]
            if row then
                for _, f in ipairs({ { 'inner', 'Inner radius (m)', 16 }, { 'outer', 'Outer radius (m)', 20 },
                                     { 'shockwave', 'Shockwave radius (m)', 24 } }) do
                    local id = 'x' .. record .. '_' .. f[1]
                    add_row(entry, section, id, f[2], 'f32', { part(id, T_EXPLOSION, row + f[3], 'f32', 10000) }, 0, 500, 0.5, 2)
                end
            end
        elseif kind == 'D' then
            local row = tables[T_DAMAGE] and tables[T_DAMAGE].index[record]
            if row then
                damage_rows(entry, section, 'd' .. record .. '_', row, nil, 9, true)
            end
        end
    end
    if s.vehicle then KINDS[TYPES.vehicle].rows(entry, s.vehicle, s.twins); return end
    -- a backpack (in its hellpod rack's first slot): its own rows; a shield (the Shield Generator Relay, a
    -- shield backpack)
    local rt = tables[TYPES.rack]
    for _, key in ipairs(s.payloads) do
        local rack = rt and rt.index[key]
        local carried = rack and api.read(rt.copies[1] + HEADER_BYTES + rack, 8)
        if carried and #carried == 8 then KINDS[TYPES.jumppack].backpack(entry, carried) end
        -- a minefield: the pod, or what the stratagem's hellpod carries
        for _, k in ipairs({ key, carried }) do KINDS[TYPES.minefield].rows(entry, k) end
        for _, k in ipairs({ key, carried }) do
            if KINDS[TYPES.shield].rows(entry, string.format('%08X%08X', u32(k, 4), u32(k, 0))) then return end
        end
    end
    -- a Guard Dog: its drone (health +0, spotting range +0, target search interval +0 / +4), then
    -- the gun it carries
    if s.drone then
        unit_rows(entry, s.drone.drone, 'Drone', 'drone_')
        if s.drone.gun then resolve_gun(entry, s.drone.gun) end
        return
    end
    -- the first payload that is a gun of its own (not a weapon listed elsewhere; strikes have
    -- their records above)
    for _, key in ipairs(s.payloads) do
        if not s.guns[key] and #s.nodes == 0 then
            local before = #entry.rows
            resolve_gun(entry, key)
            if #entry.rows > before then break end
        end
    end
end

-- Throwables: throwable component (+100 starting, +104 max, +108 from supply, +16 max throw
-- distance), explosive component (+0 mode: 0 timed, 3 timed then burning; +12 fuse; +36 explosion),
-- sticky component (+44 damage row: the throwing knife's hit). The explosion: its damage set,
-- statuses and radii, its arc (+120: G-31), its shrapnel (+80 count, +84 projectile) and the
-- shrapnel's own explosion (projectile +144: the Pineapple's bomblets). `placed`: a support weapon's
-- charge (the C4 Pack's), whose counts are its backpack's: only the throw distance, under 'Charge'.
local function resolve_throwable(entry, placed)
    local function record(kind)
        local t = tables[kind]
        return t and t.index[entry.key]
    end
    local function damage(id)
        return id and id > 0 and tables[T_DAMAGE] and tables[T_DAMAGE].index[id]
    end
    local th = record(TYPES.throwable)
    if th then
        for _, r in ipairs(placed and {} or { { 'throw_start', 'Starting count', 100 }, { 'throw_max', 'Max carried', 104 },
                                              { 'throw_supply', 'From supply', 108 } }) do
            add_row(entry, 'Throwable', r[1], r[2], 'u32', { part(r[1], TYPES.throwable, th + r[3], 'u32', 10000) }, 0, 999, 1, 5)
        end
        add_row(entry, placed and 'Charge' or 'Throwable', 'throw_distance', 'Max throw distance (m)', 'f32',
                { part('throw_distance', TYPES.throwable, th + 16, 'f32', 100000) }, 0, 200, 0.5, 5)
    end
    KINDS[TYPES.shield].rows(entry, entry.hash)   -- the G/SH-39's shield
    local sticky = record(TYPES.sticky)
    local hit = sticky and damage(read_field(field_at(TYPES.sticky, sticky + 44, 'u32', 100000)))
    if hit then
        damage_rows(entry, 'Damage', '', hit)
        status_rows(entry, 'Damage', '', hit, 'hit')
    end
    local ex = record(TYPES.explosive)
    if not ex then return end
    local function explosion(id, prefix, section, deep)
        local xrow = id and id > 0 and tables[T_EXPLOSION] and tables[T_EXPLOSION].index[id]
        if not xrow then return false end
        local qrow = damage(read_field(field_at(T_EXPLOSION, xrow + 4, 'u32', 100000)))
        if qrow then
            damage_rows(entry, section, prefix, qrow, section == 'Explosion' and 'Explosion' or nil)
            status_rows(entry, section, prefix, qrow, 'blast')
        end
        for _, r in ipairs({ { 'inner', 'Inner radius (m)', 16 }, { 'outer', 'Outer radius (m)', 20 },
                             { 'shockwave', 'Shockwave radius (m)', 24 } }) do
            add_row(entry, section, prefix .. r[1], r[2], 'f32', { part(prefix .. r[1], T_EXPLOSION, xrow + r[3], 'f32', 100000) }, 0, 200, 0.1, 1)
        end
        if not deep then return true end
        local arc = tables[TYPES.arc] and tables[TYPES.arc].index[read_field(field_at(T_EXPLOSION, xrow + 120, 'u32', 100000)) or -1]
        if arc then
            add_row(entry, 'Arc', 'arc_range', 'Range (m)', 'f32', { part('arc_range', TYPES.arc, arc + 8, 'f32', 100000) }, 0, 1000, 1, 5)
            add_row(entry, 'Arc', 'arc_chain', 'Chain length', 'u32', { MOD.solo(part('arc_chain', TYPES.arc, arc + 28, 'u32', 1000)) }, 0, 20, 1, 1)
            add_row(entry, 'Arc', 'arc_split', 'Chain split', 'u32', { MOD.solo(part('arc_split', TYPES.arc, arc + 32, 'u32', 1000)) }, 0, 20, 1, 1)
            local q = damage(read_field(field_at(TYPES.arc, arc + 36, 'u32', 100000)))
            if q then damage_rows(entry, 'Arc', 'arc_', q, 'Arc') end
        end
        local count = read_field(field_at(T_EXPLOSION, xrow + 80, 'u32', 100000))
        local pid = count and count > 0 and read_field(field_at(T_EXPLOSION, xrow + 84, 'u32', 100000))
        local prow = pid and pid > 0 and tables[T_PROJECTILE] and tables[T_PROJECTILE].index[pid]
        if prow then
            add_row(entry, 'Shrapnel', 'shrapnel_count', 'Shrapnel pieces', 'u32',
                    { part('shrapnel_count', T_EXPLOSION, xrow + 80, 'u32', 10000) }, 0, 500, 1, 5)
            local q = damage(read_field(field_at(T_PROJECTILE, prow + 60, 'u32', 100000)))
            if q then damage_rows(entry, 'Shrapnel', 'shrapnel_', q, 'Shrapnel') end
            add_row(entry, 'Shrapnel', 'shrapnel_velocity', 'Velocity (m/s)', 'f32',
                    { part('shrapnel_velocity', T_PROJECTILE, prow + 32, 'f32', 100000) }, 0, 100000, 10, 100)
            add_row(entry, 'Shrapnel', 'shrapnel_gravity', 'Gravity factor', 'f32',
                    { part('shrapnel_gravity', T_PROJECTILE, prow + 44, 'f32', 100000) }, 0, 100, 0.05, 0.5)
            explosion(read_field(field_at(T_PROJECTILE, prow + 144, 'u32', 100000)), 'bomblet_', 'Shrapnel explosion', false)
        end
        return true
    end
    local id = read_field(field_at(TYPES.explosive, ex + 36, 'u32', 100000))
    local mode = read_field(field_at(TYPES.explosive, ex, 'u32', 100000))
    local fuse = read_field(field_at(TYPES.explosive, ex + 12, 'f32', 100000))
    local has = id and id > 0 and tables[T_EXPLOSION] and tables[T_EXPLOSION].index[id]
    -- (on an impact throwable, mode 2, +12 is the earliest it goes off: the Urchin, the G-31 Arc)
    if has and (mode == 0 or mode == 2 or mode == 3) and fuse and fuse > 0 then
        local row = add_row(entry, 'Throwable', 'fuse', 'Fuse time (s)', 'f32', { part('fuse', TYPES.explosive, ex + 12, 'f32', 100000) }, 0, 60, 0.1, 1)
        if mode == 2 then row.note = 'goes off on impact, but not before this' end
    end
    -- a burning throwable (the Thermite): once the fuse is out, a timed status effect (+252: its effects
    -- from +256, lifetime +292) burns, then it explodes; it is removed +16 after going off (the burn +
    -- 0.25 s), so that follows the burn time
    if has and mode == 3 and (read_field(field_at(TYPES.explosive, ex + 256, 'u32', 100000)) or 0) > 0 then
        local burn = add_row(entry, 'Throwable', 'burn', 'Burn time (s)', 'f32',
                             { part('burn', TYPES.explosive, ex + 292, 'f32', 100000),
                               part('burn_removal', TYPES.explosive, ex + 16, 'f32', 100000) }, 0.1, 120, 0.5, 2)
        burn.lead = true
    end
    explosion(id, 'blast_', 'Explosion', true)
end

-- A missile's flight rows (`seek`: its SeekingMissile record), ids 'missile_' .. stat; `steered` false:
-- without the steering rows (turn speeds, target lost angle, guidance delay).
KINDS[TYPES.seeking].flight = function(weapon, seek, steered)
    for _, r in ipairs({
        { 'launch_speed', 'Launch speed (m/s)', 68, 2000, 5, 25 },
        { 'cruise_speed', 'Cruise speed (m/s)', 76, 2000, 5, 25 },
        { 'min_speed', 'Minimum speed (m/s)', 72, 2000, 5, 25 },
        { 'acceleration', 'Acceleration (m/s2)', 80, 10000, 10, 50 },
        { 'turn_cruise', 'Turn speed at cruise', 88, 100, 0.1, 1, true },
        { 'turn_slow', 'Turn speed at slowest', 92, 100, 0.1, 1, true },
        { 'lost_angle', 'Loses its target past (deg)', 28, 180, 1, 10, true },
        { 'lifetime', 'Max flight time (s)', 64, 600, 1, 5 },
        { 'guidance_after', 'Guidance on after (s)', 12, 60, 0.1, 0.5, true },
    }) do
        local id = 'missile_' .. r[1]
        if steered ~= false or not r[7] then
            add_row(weapon, 'Missile flight', id, r[2], 'f32', { part(id, TYPES.seeking, seek + r[3], 'f32', 1000000) }, 0, r[4], r[5], r[6])
        end
    end
end

-- A weapon that fires a missile: its fire mode's projectile entity (+40: spawned instead of a projectile;
-- the Patriot's rockets, Spear, Commando, W.A.S.P., Warrant...) with a SeekingMissile record: that record,
-- whose speeds it flies at (the projectile's velocity, drag and gravity are not used).
KINDS[TYPES.seeking].fired = function(fire)
    local ft, st = tables[T_FIRE], tables[TYPES.seeking]
    local entity = ft and st and api.read(ft.copies[1] + HEADER_BYTES + fire + 40, 8)
    return entity and #entity == 8 and st.index[entity] or nil
end

-- Whether a weapon steers its missile: a lock-on missile does; one that follows the aim (+0: 1) only
-- with the weapon's laser designator (the Commando's; the Patriot's rockets fly straight).
KINDS[TYPES.seeking].steered = function(weapon)
    local st, lt = tables[TYPES.seeking], tables[TYPES.laser]
    local mode = api.read(st.copies[1] + HEADER_BYTES + weapon.missile, 4)
    return mode ~= string.char(1, 0, 0, 0) or not lt or lt.index[weapon.key] ~= nil
end

-- The MS-11 Solo Silo (its entry is the missile, an explosive you place): the silo that holds it (the
-- hellpod rack carrying the missile's entity), its health (+0), armor (+280), regeneration per second (+4)
-- (its rack spawns 2 payloads, rack +556: not offered as a missile count), then the
-- missile's health and flight (SeekingMissileComponentData). Its ids stay 'charge_' for the missile's
-- health (saved before it had its own section). False: not a seeking missile.
KINDS[TYPES.seeking].silo_rows = function(weapon)
    local st = tables[TYPES.seeking]
    local seek = st and st.index[weapon.key]
    local rt, silo, rack = tables[TYPES.rack], nil, nil
    for holder, at in pairs(rt and rt.index or {}) do
        local slots = api.read(rt.copies[1] + HEADER_BYTES + at, 512)
        for k = 0, slots and #slots == 512 and 7 or -1 do
            if slots:sub(k * 64 + 1, k * 64 + 8) == weapon.key then silo, rack = holder, at end
        end
    end
    local ht = tables[TYPES.health]
    local body = silo and ht and ht.index[silo]
    if not (seek or body) then return false end
    if body then
        add_row(weapon, 'Silo', 'silo_health', 'Health', 'u32', { part('silo_health', TYPES.health, body, 'u32', 10000000) },
                0, 1000000, 50, 500)
        add_row(weapon, 'Silo', 'silo_armor', 'Armor', 'u32', { part('silo_armor', TYPES.health, body + 280, 'u32', 100) }, 0, 10, 1, 1)
        add_row(weapon, 'Silo', 'silo_regen', 'Regeneration (health/s)', 'f32',
                { part('silo_regen', TYPES.health, body + 4, 'f32', 1000000) }, 0, 10000, 1, 10)
    end
    unit_rows(weapon, weapon.key, 'Missile', 'charge_')
    if seek then KINDS[TYPES.seeking].flight(weapon, seek) end
    return true
end

local function resolve(weapon)
    weapon.rows, weapon.by_id, weapon.aliases, weapon.backpack, weapon.mines, weapon.legacy = {}, {}, nil, nil, nil, nil
    weapon.swaps = nil
    weapon.grenade_swap = nil
    if weapon.slot == 'Throwables' then resolve_throwable(weapon); return end
    -- a support weapon you place (the C4 Pack): the backpack that shares its loadout package (its
    -- charges), the charge (health, throw distance) and its explosion
    if weapon.slot == 'Support' and KINDS[TYPES.package].placed(weapon.key) then
        local dt = tables[TYPES.deposit]
        for _, k in ipairs(KINDS[TYPES.package].kin(weapon.key)) do
            if dt and dt.index[k] then KINDS[TYPES.jumppack].backpack(weapon, k) end
        end
        if not KINDS[TYPES.seeking].silo_rows(weapon) then unit_rows(weapon, weapon.key, 'Charge', 'charge_') end
        resolve_throwable(weapon, true)
        return
    end
    if weapon.passive then KINDS[TYPES.passive].resolve(weapon); return end
    if weapon.player then KINDS[TYPES.avatar].resolve(weapon); return end
    if weapon.stratagem then resolve_stratagem(weapon); return end
    if weapon.attachment then
        KINDS[TYPES.items].mod_rows(weapon, 'Attachment', '', weapon.attachment.mods)
        return
    end
    -- sentries and emplacements (listed as weapons on the Stratagems tab): their body, then their gun
    if weapon.slot == 'Stratagems' then
        local parts = {}
        for k, def in ipairs(weapon.sentry_defs or {}) do
            parts[k] = part(k == 1 and 'cooldown' or 'cooldown' .. k, def.kind, def.off + 104, 'f32', 100000)
        end
        if parts[1] then add_row(weapon, 'Stratagem', 'cooldown', 'Cooldown (s)', 'f32', parts, 0, 10000, 1, 10) end
        if weapon.sentry_defs[1] then MOD.callin_rows(weapon, weapon.sentry_defs) end
        if weapon.sentry_defs[1] then MOD.extra.row(weapon, weapon.sentry_defs[1]) end
        unit_rows(weapon, KINDS[TYPES.health].body(weapon.key) or weapon.key, weapon.name:find('^E/') and 'Emplacement' or 'Sentry', 'unit_')
    end
    resolve_gun(weapon, weapon.key)
end

-- The shots a weapon fires besides its projectile, read as the game had them: a second ammo type
-- (rounds +68 when not +64's: the SG-20 Halt's stun rounds, toggled in game; named for a stun it
-- applies) and a patterned magazine's other rounds (magazine +0 type 1, +4: 32 projectiles fired in
-- turn: the MG-43's and Bullet Storm's tracers, the machine gun sentries'). { id, prow, name, prefix,
-- field (the second ammo type's) or slots (the pattern's fields, every round's) }, nil when none.
KINDS[T_ROUNDS].extra = function(rounds, magazine, projectile)
    local list = {}
    local function prow_of(id) return id and id > 0 and tables[T_PROJECTILE] and tables[T_PROJECTILE].index[id] end
    local f = rounds and field_at(T_ROUNDS, rounds + 68, 'u32', 100000)
    local alt = f and default_of(f)
    if prow_of(alt) and alt ~= projectile then
        local did = read_field(field_at(T_PROJECTILE, prow_of(alt) + 60, 'u32', 100000))
        local drow = did and tables[T_DAMAGE] and tables[T_DAMAGE].index[did]
        local stun = nil
        for i = 0, 3 do
            local kind = drow and read_field(field_at(T_DAMAGE, drow + 44 + i * 8, 'u32', 100000))
            stun = stun or (kind and KINDS[T_STATUS].stuns[kind])
        end
        list[#list + 1] = { id = alt, prow = prow_of(alt), name = stun and 'Stun rounds' or 'Second ammo', prefix = 'a2_', field = f }
    end
    if magazine and default_of(field_at(T_MAGAZINE, magazine, 'u32', 100000)) == 1 then
        local slots, other = {}, nil
        for k = 0, 31 do
            local slot = field_at(T_MAGAZINE, magazine + 4 + k * 4, 'u32', 100000)
            local id = default_of(slot)
            if id and id > 0 then
                slots[#slots + 1] = slot
                if id ~= projectile then other = other or id end
            end
        end
        if prow_of(other) then
            list[#list + 1] = { id = other, prow = prow_of(other), name = 'Tracer rounds', prefix = 't_', slots = slots }
        elseif #slots > 0 then
            list[#list + 1] = { slots = slots }   -- every round its projectile: only the swap writes them
        end
    end
    return #list > 0 and list or nil
end

-- Projectile swap (the last row of a weapon that fires projectiles): one row writing every field the
-- weapon's projectile comes from (its rounds record, ammo type, fire mode, charge stages) with another
-- weapon's projectile. The stat rows above stay the weapon's own projectile's. Choices:
-- KINDS[T_PROJECTILE].choices, every listed weapon's own projectiles by name (built after resolving).
-- Weapons with a second firing mode (the "programmable ammo" weapon function: the Autocannon's flak,
-- the Recoilless Rifle's HE) fire the fire mode's +576 in it: a second swap row for that one. `extra`
-- (KINDS[T_ROUNDS].extra): a patterned magazine's rounds take the swapped projectile too (every one of
-- them), a second ammo type has its own row.
KINDS[T_PROJECTILE].swap_row = function(weapon, sources, shots, fire, extra)
    if #sources == 0 or not (weapon.projectile or shots) then return end
    local main = nil
    for _, src in ipairs(sources) do
        if shots and src.id == 'proj_c' .. shots[#shots].last then main = main or src end
        if not shots and src.own == weapon.projectile then main = main or src end
    end
    main = main or sources[1]
    local parts = { { id = main.id, field = main.field } }
    for _, src in ipairs(sources) do
        if src ~= main then parts[#parts + 1] = { id = src.id, field = src.field } end
    end
    local ammo = nil
    for _, shot in ipairs(extra or {}) do
        for k, slot in ipairs(shot.slots or {}) do parts[#parts + 1] = { id = 'proj_mag' .. k, field = slot } end
        if shot.field then ammo = shot end
    end
    local function swap(id, label, row_parts)
        local row = add_row(weapon, 'Projectile swap', id, label, 'u32', row_parts, 1, 100000, 1, 10)
        row.choice = true
        weapon.swaps = weapon.swaps or {}
        weapon.swaps[#weapon.swaps + 1] = row
        row.note = function(others)
            local spec, now, own = KINDS[T_PROJECTILE], read_field(row_parts[1].field), default_of(row_parts[1].field)
            local shot = spec.by_id and spec.by_id[now]
            local text = now == own and "its own. - / + : fire another weapon's"
                         or ('fires: ' .. (shot and shot.label or ('projectile ' .. tostring(now))) .. '. The rows above stay its own')
            if #others > 0 then text = text .. '; ammo type shared with ' .. table.concat(others, ', ', 1, math.min(2, #others)) end
            return text
        end
        return row
    end
    local row = swap('projectile', 'Projectile fired (id)', parts)
    local alt = fire and field_at(T_FIRE, fire + 576, 'u32', 100000)
    local second = alt and default_of(alt)
    if second and second > 0 then
        row = swap('projectile_2', 'Second mode fires (id)', { { id = 'projectile_2', field = alt } })
    else
        second = nil
    end
    if ammo then
        local id = 'projectile_' .. ammo.prefix:sub(1, -2)
        local row_parts = { { id = id, field = ammo.field } }
        if ammo.delta then row_parts[2] = { id = id .. '_ammo', field = ammo.delta } end
        row = swap(id, ammo.name .. ' fire (id)', row_parts)
    end
    -- under the last row: what a swap changes and what it keeps (drawn below it, `after_h` units)
    row.after = { "Swapping makes the shot the chosen weapon's, your edits to it included: damage,",
                  'armor penetration, forces, velocity, drag, gravity, pellets and explosions. Kept: this',
                  "weapon's fire rate, ammo, handling and heat. To tune the shot, edit the chosen weapon." }
    row.after_h = #row.after * 16 + 6
    weapon.own_shots = {}
    for _, shot in ipairs(shots or { { id = weapon.projectile } }) do
        weapon.own_shots[#weapon.own_shots + 1] = { id = shot.id, key = weapon.key,
            label = shots and (weapon.name .. ' (' .. shot.name:lower() .. ')') or weapon.name }
    end
    if second then weapon.own_shots[#weapon.own_shots + 1] = { id = second, key = weapon.key, label = weapon.name .. ' (second mode)' } end
    if ammo then
        weapon.own_shots[#weapon.own_shots + 1] = { id = ammo.id, key = weapon.key, label = weapon.name .. ' (' .. ammo.name:lower() .. ')' }
    end
end

-- The choices: every own projectile once (the first weapon's name, by name), in name order.
KINDS[T_PROJECTILE].list_choices = function()
    local list, by = {}, {}
    for _, w in ipairs(weapons) do
        for _, shot in ipairs(w.own_shots or {}) do
            if not by[shot.id] then by[shot.id] = shot; list[#list + 1] = shot end
        end
    end
    table.sort(list, function(a, b) return a.label:lower() < b.label:lower() end)
    KINDS[T_PROJECTILE].choices, KINDS[T_PROJECTILE].by_id = list, by
end

-- The projectile `n` choices on from `id` (from either end when `id` is not one).
KINDS[T_PROJECTILE].step = function(id, n)
    local list, at = KINDS[T_PROJECTILE].choices or {}, nil
    for k, shot in ipairs(list) do if shot.id == id then at = k end end
    if #list == 0 then return id end
    at = at or (n > 0 and 0 or #list + 1)
    return list[math.max(1, math.min(#list, at + n))].id
end

-- Records (CarbonAnime, PR #58): the projectile, explosion and status records themselves, by id. Their names: a
-- projectile's the game's name of its round (MOD.round_names), else the first weapon that fires it; an explosion's
-- the first weapon that sets it off, else the round that does; a status's its own (Burning, Gas, stuns).
MOD.records = { pages = {}, list = nil, cache = nil, KINDS = { T_PROJECTILE, T_EXPLOSION, T_STATUS },
                WORD = { [T_PROJECTILE] = 'Projectile', [T_EXPLOSION] = 'Explosion', [T_STATUS] = 'Status' },
                PREFIX = { [T_PROJECTILE] = 'F1', [T_EXPLOSION] = 'F2', [T_STATUS] = 'F3' } }
function MOD.records.ids(kind)
    local ids = {}
    for id in pairs(tables[kind] and tables[kind].index or {}) do
        if type(id) == 'number' and id > 0 then ids[#ids + 1] = id end
    end
    table.sort(ids)
    return ids
end
-- Who uses each record: shots (projectile id -> weapon names), blasts (explosion id -> weapon names), from the
-- weapons' rows (the record a row's field is in) and own shots; rounds (explosion id -> the name of the first named
-- round that sets it off). Built once per resolve.
function MOD.records.users()
    if MOD.records.cache then return MOD.records.cache end
    local shots, blasts, rounds = {}, {}, {}
    local function add(map, id, name)
        if not id or id <= 0 then return end
        local list = map[id] or {}
        map[id] = list
        for _, n in ipairs(list) do if n == name then return end end
        list[#list + 1] = name
    end
    local function locate(kind)
        local spots, stride = {}, KINDS[kind].stride
        for _, id in ipairs(MOD.records.ids(kind)) do spots[#spots + 1] = { at = tables[kind].index[id], id = id } end
        table.sort(spots, function(a, b) return a.at < b.at end)
        return function(offset)
            local lo, hi = 1, #spots
            while lo <= hi do
                local mid = math.floor((lo + hi) / 2)
                local spot = spots[mid]
                if offset < spot.at then hi = mid - 1
                elseif offset >= spot.at + stride then lo = mid + 1
                else return spot.id end
            end
        end
    end
    local shot_at, blast_at = locate(T_PROJECTILE), locate(T_EXPLOSION)
    for _, w in ipairs(weapons) do
        if #w.rows > 0 and not w.name:match('^%(') then   -- not the '(Not Used)' dummies
            for _, shot in ipairs(w.own_shots or {}) do add(shots, shot.id, w.name) end
            for _, row in ipairs(w.rows) do
                for _, q in ipairs(row.parts) do
                    if q.field.kind == T_PROJECTILE then add(shots, shot_at(q.field.offset), w.name)
                    elseif q.field.kind == T_EXPLOSION then add(blasts, blast_at(q.field.offset), w.name) end
                end
            end
        end
    end
    for _, id in ipairs(MOD.records.ids(T_PROJECTILE)) do
        local name, at = MOD.round_names and MOD.round_names[id], tables[T_PROJECTILE].index[id]
        for _, off in ipairs(name and { 144, 156 } or {}) do
            local x = read_field(field_at(T_PROJECTILE, at + off, 'u32', 100000))
            if x and x > 0 and not rounds[x] then rounds[x] = name end
        end
    end
    MOD.records.cache = { shots = shots, blasts = blasts, rounds = rounds }
    return MOD.records.cache
end
-- A record's name (English), or nil.
function MOD.records.name(kind, id)
    local u = MOD.records.users()
    if kind == T_PROJECTILE then return MOD.round_names and MOD.round_names[id] or (u.shots[id] or {})[1]
    elseif kind == T_EXPLOSION then return (u.blasts[id] or {})[1] or u.rounds[id] end
    if state.lang and state.lang() == 'zh-Hans' and MOD.status.by[id] then return MOD.status.by[id].name end
    return KINDS[T_STATUS].names[id] or KINDS[T_STATUS].stuns[id]
end
-- A choice's label in a note: '#12 · 10g Sabot' (the name in the panel's language), 'none (no explosion)'.
function MOD.records.label(kind, id)
    local what = kind == T_EXPLOSION and 'explosion' or 'projectile'
    if not id or id <= 0 then return 'none (no ' .. what .. ')' end
    if not (tables[kind] and tables[kind].index[id]) then return what .. ' ' .. id .. ' (not in this game build)' end
    local name = MOD.records.name(kind, id)
    return '#' .. id .. (name and (' · ' .. (state.tr and state.tr(name) or name)) or '')
end
-- The id `n` on from `id` among none (0) and every record of the kind (from either end when `id` is not one).
function MOD.records.step(kind, id, n)
    local list = MOD.records.ids(kind)
    table.insert(list, 1, 0)
    local at = nil
    for k, x in ipairs(list) do if x == id then at = k end end
    at = at or (n > 0 and 0 or #list + 1)
    return list[math.max(1, math.min(#list, at + n))]
end
-- A weapon page's explosion id sections ('Projectile explosion id', ...) last, below its projectile swap.
function MOD.records.ids_last(weapon)
    local rows, last = {}, {}
    for _, row in ipairs(weapon.rows) do
        local list = row.section:find(' explosion id$') and last or rows
        list[#list + 1] = row
    end
    for _, row in ipairs(last) do rows[#rows + 1] = row end
    weapon.rows = rows
end
-- An explosion's shrapnel rows (explosion row `xrow`, ids `pre` ..): the projectile every piece is, then how many.
function MOD.records.shrapnel_rows(entry, section, pre, xrow)
    local piece = add_row(entry, section, pre .. '_projectile', 'Shrapnel projectile (id)', 'u32',
                          { part(pre .. '_projectile', T_EXPLOSION, xrow + 84, 'u32', 100000) }, 0, 100000, 1, 10)
    piece.choice = 'shrapnel'
    piece.note = function()
        local id = read_field(piece.parts[1].field)
        return (id or 0) > 0 and ('each piece is ' .. MOD.records.label(T_PROJECTILE, id)) or 'no shrapnel'
    end
    add_row(entry, section, pre .. '_count', 'Shrapnel pieces', 'u32', { part(pre .. '_count', T_EXPLOSION, xrow + 80, 'u32', 10000) },
            0, 500, 1, 5)
end
-- A record page's rows (page.kind, page.id).
function MOD.records.rows(page)
    local kind, at = page.kind, tables[page.kind] and tables[page.kind].index[page.id]
    page.rows, page.by_id = {}, {}
    if not at then return end
    local function num(section, id, label, off, storage, max, small, big)
        add_row(page, section, id, label, storage, { part(id, kind, at + off, storage, 100000) }, 0, max, small, big)
    end
    local function hurt(off, section, what, count)
        local d = read_field(field_at(kind, at + off, 'u32', 100000))
        local drow = d and d > 0 and tables[T_DAMAGE] and tables[T_DAMAGE].index[d]
        if not drow then return end
        damage_rows(page, section, '', drow, what, count)
        if count == nil then status_rows(page, section, '', drow, what == 'Explosion' and 'blast' or 'hit') end
    end
    if kind == T_PROJECTILE then
        for _, r in ipairs({ { 'calibre', 'Calibre (mm)', 24, 'f32', 1000, 0.1, 1 }, { 'pellets', 'Projectiles per shot', 28, 'u32', 200, 1, 5 },
                             { 'velocity', 'Velocity (m/s)', 32, 'f32', 100000, 10, 100 }, { 'mass', 'Mass (kg)', 36, 'f32', 10000, 0.1, 1 },
                             { 'drag', 'Drag factor', 40, 'f32', 100, 0.05, 0.5 }, { 'gravity', 'Gravity factor', 44, 'f32', 100, 0.05, 0.5 },
                             { 'lifetime', 'Lifetime (s)', 56, 'f32', 1000, 0.1, 1 },
                             { 'pen_slowdown', 'Penetration slowdown', 64, 'f32', 100, 0.05, 0.25 } }) do
            num('Projectile', r[1], r[2], r[3], r[4], r[5], r[6], r[7])
        end
        hurt(60, 'Damage')
        local impact = add_row(page, 'Explosion id', 'impact_explosion', 'Impact explosion (id)', 'u32',
                               { part('impact_explosion', kind, at + 144, 'u32', 100000) }, 0, 100000, 1, 10)
        impact.choice = 'explosion'
        impact.note = function()
            return 'sets off: ' .. MOD.records.label(T_EXPLOSION, read_field(impact.parts[1].field))
        end
        num('Explosion id', 'fuse_proximity', 'Blast proximity (m)', 148, 'f32', 200, 0.1, 1)
        num('Explosion id', 'fuse_delay', 'Blast delay (s)', 152, 'f32', 30, 0.05, 0.5)
        local expiry = add_row(page, 'Explosion id', 'expiry_explosion', 'Expiry explosion (id)', 'u32',
                               { part('expiry_explosion', kind, at + 156, 'u32', 100000) }, 0, 100000, 1, 10)
        expiry.choice = 'explosion'
        num('Explosion id', 'arming', 'Arming distance (m)', 160, 'f32', 200, 0.1, 1)
        num('Explosion id', 'blast_angle', 'Blast angle (deg)', 136, 'f32', 180, 1, 10)
    elseif kind == T_EXPLOSION then
        hurt(4, 'Explosion', 'Explosion')
        for _, r in ipairs({ { 'inner', 'Inner radius (m)', 16 }, { 'outer', 'Outer radius (m)', 20 },
                             { 'shockwave', 'Shockwave radius (m)', 24 } }) do
            num('Radius', r[1], r[2], r[3], 'f32', 200, 0.1, 1)
        end
        num('Shape', 'cone', 'Cone angle (deg)', 28, 'f32', 360, 1, 10)
        num('Shape', 'shake', 'Camera shake radius (m)', 32, 'f32', 200, 0.1, 1)
        MOD.records.shrapnel_rows(page, 'Shrapnel', 'shrapnel', at)
    else
        local name = MOD.records.name(kind, page.id) or 'Status'
        hurt(44, name, name, 6)   -- no forces: a status has none
        num(name, 'duration', name .. ' duration (s)', 40, 'f32', 600, 0.5, 5)
    end
end
-- An unnamed record still needs something readable beside its number. Use the loaded
-- values as a description, without claiming to know which weapon or effect it belongs to.
function MOD.records.unnamed(page)
    local function value(id)
        local part = page.by_id[id]
        local v = part and default_of(part.field)
        return v and v == v and math.abs(v) < math.huge and v or nil
    end
    if page.kind == T_PROJECTILE then
        local calibre, damage, durable = value('calibre'), value('damage'), value('durable')
        if calibre and damage and durable then
            return string.format('Unnamed: %gmm; %g/%g damage', calibre, damage, durable)
        end
        return 'Unnamed projectile'
    elseif page.kind == T_EXPLOSION then
        local outer = value('outer')
        if outer then return string.format('Unnamed: %gm blast', outer) end
        return 'Unnamed explosion'
    end
    local duration = value('duration')
    return duration and string.format('Unnamed: %gs effect', duration) or 'Unnamed status effect'
end

-- A record page's title and note: 'Projectile #12 · 10g Sabot', 'Fired by: ...'.
function MOD.records.title(page)
    local name = MOD.records.name(page.kind, page.id)
    if not name and state.lang and state.lang() == 'zh-Hans' then name = MOD.records.unnamed(page) end
    page.name = MOD.records.WORD[page.kind] .. ' #' .. page.id .. (name and (' · ' .. name) or '')
    local u = MOD.records.users()
    local users = page.kind == T_PROJECTILE and u.shots[page.id] or page.kind == T_EXPLOSION and u.blasts[page.id]
    if page.kind == T_STATUS then page.note = ''
    elseif not users then page.note = 'Not used by any weapon or stratagem in this list.'
    else
        page.note = (page.kind == T_PROJECTILE and 'Fired by: ' or 'Set off by: ') .. table.concat(users, ', ', 1, math.min(3, #users)) ..
                    (#users > 3 and (', +' .. (#users - 3)) or '')
    end
end
-- The page of a record (built on first use; hash: 'F1' projectile / 'F2' explosion / 'F3' status + 14 hex digits).
function MOD.records.page(kind, id)
    local hash = string.format('%s%014X', MOD.records.PREFIX[kind], id)
    local page = MOD.records.pages[hash]
    if page then return page end
    if not (tables[kind] and tables[kind].index[id]) then return nil end
    page = { slot = 'Records', hash = hash, kind = kind, id = id, record = true }
    MOD.records.rows(page)
    MOD.records.title(page)
    MOD.records.pages[hash] = page
    return page
end
function MOD.records.find(hash)
    if type(hash) ~= 'string' or #hash ~= 16 then return nil end
    local mark, digits = hash:match('^(F[123])(%x+)$')
    if not mark then return nil end
    for kind, prefix in pairs(MOD.records.PREFIX) do
        if prefix == mark then return MOD.records.page(kind, tonumber(digits, 16)) end
    end
end
-- Every record page, projectiles, explosions then statuses, by id (the Records tab; built when first opened).
function MOD.records.all()
    if MOD.records.list then return MOD.records.list end
    local list = {}
    for _, kind in ipairs(MOD.records.KINDS) do
        for _, id in ipairs(MOD.records.ids(kind)) do
            local page = MOD.records.page(kind, id)
            if page and #page.rows > 0 then list[#list + 1] = page end
        end
    end
    MOD.records.list = list
    return list
end
-- After every resolve: who uses what again, and the pages built so far read again (a rescan moves the tables).
function MOD.records.refresh()
    MOD.records.cache, MOD.records.list = nil, nil
    for _, page in pairs(MOD.records.pages) do
        MOD.records.rows(page)
        MOD.records.title(page)
    end
end
-- a record page's values saved in config.txt or a preset: its page, built when first named
setmetatable(by_hash, { __index = function(_, hash) return MOD.records.find(hash) end })

-- ProjectileWeaponComponent +40 is a full 64-bit entity reference. Keep both
-- halves together through read/write/reset/presets; a Lua number cannot hold the hash.
-- Use the grenade entity and native release/activation lifecycle. Special grenade
-- behaviors still require gameplay validation; reference writes alone are insufficient.
KINDS[TYPES.throwable].grenade_row = function(weapon, fire)
    local spec = KINDS[TYPES.throwable]
    -- (offline: no row; a swapped grenade needs its assets loaded by the running game)
    if MOD.offline or not fire or not spec.grenade_hosts[weapon.hash] then return end
    local f = field_at(T_FIRE, fire + 40, 'grenade', #spec.grenade_hashes)
    if default_of(f) == nil then
        log('grenade swap: unknown original entity on ' .. weapon.name)
        return
    end
    spec.fields = spec.fields or {}
    spec.fields[f.key] = f
    local row = add_row(weapon, 'Grenade swap', 'grenade', 'Grenade fired (choice)', 'u32',
                        { { id = 'grenade', field = f } }, 0, #spec.grenade_hashes, 1, 10)
    row.choice = 'grenade'
    weapon.grenade_swap = row
    row.note = function()
        local id = f.pending_value or read_field(f)
        local shot = spec.by_id[id]
        return (f.pending_value and 'loading: ' or 'fires: ') .. (shot and shot.label or 'normal projectile')
    end
    row.after = { '0 = normal projectile; - / + selects a throwable grenade by name above.',
                  'Grenade selection takes priority over Projectile swap. Fire rate, ammo and handling stay.',
                  'Edit the grenade on Throwables to tune it. Assets load before selection applies.',
                  'Throwable launching is supported in solo missions only.' }
    row.after_h = #row.after * 16 + 6
end

-- Resolves weapons from `next` on until the deadline; true once all are done.
local function resolve_some(progress, deadline)
    if progress.next == 1 then
        for _, f in pairs(fields) do f.users = {} end
        KINDS[TYPES.custom].cache = {}
        KINDS[TYPES.throwable].prepare_grenades()
    end
    while progress.next <= #weapons do
        resolve(weapons[progress.next])
        MOD.records.ids_last(weapons[progress.next])
        progress.next = progress.next + 1
        if api.now() >= deadline then break end
    end
    if progress.next <= #weapons then return false end
    KINDS[T_PROJECTILE].list_choices()
    MOD.records.refresh()
    local usable, strats = 0, 0
    state.attachments, state.throwables, state.passives, state.vehicles = 0, 0, 0, 0
    for _, weapon in ipairs(weapons) do
        if #weapon.rows > 0 then
            if weapon.stratagem and weapon.stratagem.vehicle then state.vehicles = state.vehicles + 1
            elseif weapon.stratagem or weapon.mounted then strats = strats + (weapon.mounted and 0 or 1)
            elseif weapon.attachment then state.attachments = (state.attachments or 0) + 1
            elseif weapon.slot == 'Throwables' then state.throwables = (state.throwables or 0) + 1
            elseif weapon.passive then state.passives = state.passives + 1
            else usable = usable + 1 end
        end
    end
    state.weapons, state.stratagems = usable, strats
    return true
end

-- Other weapons whose values change along with this row.
local function shared_with(weapon, row)
    local names, seen = {}, { [weapon] = true }
    for _, p in ipairs(row.parts) do
        for _, other in ipairs(p.field.users) do
            if not seen[other] and (weapon.record or not other.record) then seen[other] = true; names[#names + 1] = other.name end
        end
    end
    return names
end

-- A time row (row.span) holds a rate; it shows and takes span / rate seconds.
local function as_time(span, rate)
    if span == nil or rate == nil or rate <= 0 then return nil end
    return span / rate
end

-- A row's value (the mean of its parts); default = true: the game's own value instead.
local function row_value(row, default)
    local get = default and default_of or read_field
    if row.choice == 'grenade' and not default and row.parts[1].field.pending_value ~= nil then
        return row.parts[1].field.pending_value
    end
    if row.choice or row.lead then return get(row.parts[1].field) end   -- lead: the others scale with it
    if row.span then
        local rate = get(row.parts[1].field)
        return as_time((default and row.span_default or row.span)(), rate and rate + (row.rate_plus or 0))
    end
    local sum = 0
    for _, p in ipairs(row.parts) do
        local v = get(p.field)
        if v == nil then return nil end
        sum = sum + v
    end
    if row.zero and sum == 0 then return row.zero end   -- 0 stands for that (a reload played as animated)
    return sum / #row.parts
end

-- ---------------------------------------------------------------- config
-- One line per changed value: <weapon hash> <stat> <value>   # weapon name
-- plus `hotkey <key>`. Written after every change, read once at start.
local overrides = {}    -- list of { hash, id, value }
local hotkey_name = 'F8'
local config_dirty_at = nil
-- The Settings page's choices, saved in config.txt with the changes. changes: apply the changes
-- (off: every value is the game's, the changes are kept); block_input: the game gets no keyboard /
-- mouse input while the panel is open; size: panel height, % of the screen's; side: 'left' / 'right';
-- opacity: background, %; remember: reopen on the last tab / weapon; lang: the panel's language, 'en'
-- or the id of a translation: fixed by the build (a language's release, MOD.lang), not a choice; offline (every
-- language built in) a choice, saved as 'lang'.
local settings = { changes = true, block_input = true, size = 80, side = 'right', opacity = 90,
                   remember = true, arc_mp = true, updates = 'ask', update_channel = 'releases', stacks = {}, own_off = {}, hidden = {}, lang = MOD.lang or MOD.offline and rawget(_G, 'SHODAN_OFFLINE_LANG') or 'en',
                   last_tab = nil, last_weapon = nil,
                   GITHUB = 'https://github.com/SHODAN-HORAI/SHODAN-Stat-Editor',
                   RANGE = { size = { 50, 100 }, opacity = { 10, 100 } } }

-- Translations (MOD.langs, built from lang/*.json): the panel's text by its English text, so every
-- branch still runs on English and config.txt / presets stay the same in every language. A lookup:
-- exact (and lower, the lowercased names sentences carry), '* ' + exact (a changed item), whole-sentence
-- patterns (numbers and names built at run time; %1-%4 are translated again, %L1 a ', ' list of them),
-- then prefix and suffix.
-- Each text is looked up once per language (the panel redraws often).
do
    local LANG = {}
    for _, l in ipairs(MOD.langs or {}) do   -- and by the upper / lower case English ('DAMAGE', sentences)
        LANG[l.id], l.upper = l, {}
        for e, t in pairs(l.exact) do
            l.upper[e:upper()] = l.upper[e:upper()] or t
            l.lower[e:lower()] = l.lower[e:lower()] or t
        end
    end
    settings.LANGS = LANG
    local tr_cache, tr_count = {}, 0
    local function translate(v, depth)
        local l = LANG[settings.lang]
        if not l or depth > (settings.lang == 'zh-Hans' and 6 or 3) then return v end
        local t = l.exact[v] or l.lower[v] or l.upper[v] or (settings.lang == 'zh-Hans' and l.lower[v:lower()])
        if t then return t end
        if v:sub(1, 2) == '* ' and l.exact[v:sub(3)] then return '* ' .. l.exact[v:sub(3)] end
        for _, p in ipairs(l.patterns) do
            local caps = { v:match(p[1]) }
            if caps[1] then
                return (p[2]:gsub('%%(L?)([1-9])', function(list, k)
                    local x = caps[tonumber(k)]
                    if not x or x == '' then return '' end
                    if list == '' then return translate(x, depth + 1) end
                    local out = {}   -- %L1: a ', ' list of names, each translated
                    for name in (x .. ', '):gmatch('(.-), ') do out[#out + 1] = translate(name, depth + 1) end
                    return table.concat(out, l.list or ', ')
                end))
            end
        end
        for _, p in ipairs(l.prefix) do
            if v:sub(1, #p[1]) == p[1] then v = p[2] .. v:sub(#p[1] + 1); break end
        end
        for _, p in ipairs(l.suffix) do
            if #v > #p[1] and v:sub(-#p[1]) == p[1] then return v:sub(1, #v - #p[1]) .. p[2] end
        end
        return v
    end
    if MOD.offline then   -- for the host's own text and fonts
        state.tr = function(v) return settings.tr(v) end
        state.lang = function() return settings.lang end
        state.updates = function() return settings.updates end   -- the host's updater: 'ask' or 'auto'
        state.update_channel = function() return settings.update_channel end   -- 'releases' or 'commits'
        state.stacks = function() return settings.stacks end   -- passive id -> { passive ids stacked on it }
        state.own_off = function() return settings.own_off end -- passive id -> true: its own effects left out
    end
    function settings.tr(v)
        if settings.lang == 'en' or not LANG[settings.lang] then return v end
        local cache = tr_cache[settings.lang]
        if not cache or tr_count > 5000 then cache, tr_count = {}, 0; tr_cache = { [settings.lang] = cache } end
        local t = cache[v]
        if not t then t = translate(v, 0); cache[v], tr_count = t, tr_count + 1 end
        return t
    end
end

-- unlocks: items the game has but does not offer, by id, on / off (settings.unlock, below). Each: config
-- name, a stratagem (its number in game.dll's stratagem list, key and record key in the item registry)
-- or equipment (model = entity hash high / low; template: the model, or key and class, of an item of
-- the same kind whose registry row a new row is copied from)
settings.UNLOCKS = {
    { id = 'incinerator', name = 'M-104 Incinerator FRV', config = 'incinerator_frv',
      strat = 135, key = 0xA9A97CD7, record = 0xDA0600D7 },
    { id = 'ombudsman', name = 'P-41 Ombudsman', config = 'unlock_ombudsman',
      model = { 0xBDE1F253, 0x4280300D }, template = { 0x05E4E5C2, 0xDB6E44A2 } },   -- template: P-2 Peacemaker
    { id = 'caltrops', name = 'G-11 Caltrops', config = 'unlock_caltrops',
      model = { 0x2968DEBA, 0x6D6C2F09 }, template = { 0x4CE9EAB7, 0x85A79B7B } },   -- template: G-6 Frag
    { id = 'shear', name = 'LAS-22 Shear', config = 'unlock_shear',   -- its key checked; template: the LAS-5 Scythe's key
      model = { 0x7E3145A5, 0xBAA4B948 }, key = 0x7DE53646, template_key = 0xE673DCC8, class = 1 },
}
settings.unlocks = {}
-- one switch for them all (Settings: "Unlock unused items"): on while any is (old configs saved each)
function settings.unlock_any()
    for _, item in ipairs(settings.UNLOCKS) do if settings.unlocks[item.id] then return true end end
    return false
end
function settings.unlock_all(on)
    for _, item in ipairs(settings.UNLOCKS) do settings.unlocks[item.id] = on end
end

local function config_path()
    local dir = data_dir('StatEditor')
    return dir and dir .. '/config.txt'
end

local function number_text(v)
    if math.abs(v - math.floor(v + 0.5)) < 1e-6 then return tostring(math.floor(v + 0.5)) end
    return (string.format('%.4f', v):gsub('0+$', ''):gsub('%.$', ''))
end

function settings.set_percent(name, value)
    local r = settings.RANGE[name]
    local v = math.floor(value + 0.5)
    settings[name] = math.max(r[1], math.min(r[2], v))
    return settings[name] ~= v
end

local function save_config()
    config_dirty_at = nil
    local path = config_path()
    if not path then return end
    local lines = {
        '# SHODAN Stat Editor settings. Changed through the in-game panel; applied at every start.',
        '# Lines: <weapon hash> <stat> <value>. Delete a line (or this file) to go back to the game\'s value.',
        '# The first lines are the Settings page\'s choices.',
        'hotkey ' .. hotkey_name,
    }
    local function onoff(v) return v and 'on' or 'off' end
    for _, line in ipairs({ 'changes ' .. onoff(settings.changes), 'block_input ' .. onoff(settings.block_input),
                            'panel_size ' .. settings.size, 'panel_side ' .. settings.side,
                            'panel_opacity ' .. settings.opacity,
                            'remember ' .. onoff(settings.remember),
                            'arc_chains_multiplayer ' .. onoff(settings.arc_mp) }) do
        lines[#lines + 1] = line
    end
    if MOD.offline then lines[#lines + 1] = 'lang ' .. settings.lang end
    if MOD.offline then
        lines[#lines + 1] = 'updates ' .. settings.updates
        lines[#lines + 1] = 'update_channel ' .. settings.update_channel
        -- passive_stack <passive id> <passive id>,<passive id>...: the passives stacked on it
        local ids, NAMES = {}, KINDS[TYPES.passive].NAMES
        for id in pairs(settings.stacks) do ids[#ids + 1] = id end
        table.sort(ids)
        for _, id in ipairs(ids) do
            local names = {}
            for k, other in ipairs(settings.stacks[id]) do names[k] = NAMES[other] or ('Passive ' .. other) end
            lines[#lines + 1] = 'passive_stack ' .. id .. ' ' .. table.concat(settings.stacks[id], ',') ..
                                '   # ' .. (NAMES[id] or ('Passive ' .. id)) .. ': ' .. table.concat(names, ', ')
        end
        -- passive_own <passive id> off: its own effects left out (only the passives stacked on it apply)
        ids = {}
        for id in pairs(settings.own_off) do ids[#ids + 1] = id end
        table.sort(ids)
        for _, id in ipairs(ids) do
            lines[#lines + 1] = 'passive_own ' .. id .. ' off   # ' .. (NAMES[id] or ('Passive ' .. id))
        end
    end
    lines[#lines + 1] = 'unlock_unused ' .. onoff(settings.unlock_any())
    lines[#lines + 1] = 'several_vehicles ' .. onoff(MOD.vehicles.on)
    -- hide_tabs <tab>,<tab>...: the tabs Settings > Tabs shown turned off
    local hidden = {}
    for tab in pairs(settings.hidden) do hidden[#hidden + 1] = tab end
    table.sort(hidden)
    if #hidden > 0 then lines[#lines + 1] = 'hide_tabs ' .. table.concat(hidden, ',') end
    if settings.remember and settings.last_tab then lines[#lines + 1] = 'last_tab ' .. settings.last_tab end
    if settings.remember and settings.last_weapon then lines[#lines + 1] = 'last_weapon ' .. settings.last_weapon end
    for _, o in ipairs(overrides) do
        local weapon = by_hash[o.hash]
        lines[#lines + 1] = o.hash .. ' ' .. o.id .. ' ' .. number_text(o.value) ..
                            (weapon and ('   # ' .. weapon.name) or '')
    end
    local ok, why = MOD.write_text(path, table.concat(lines, '\r\n') .. '\r\n')
    if not ok then log('could not write ' .. path .. ': ' .. why) end
end

local function load_config()
    local path = config_path()
    local handle = path and io.open(path, 'rb')
    if not handle then save_config(); return end
    local text = handle:read('*a') or ''
    handle:close()
    local count = 0
    for at, line in MOD.lines_of(text) do
        line = line:gsub('#.*$', '')
        local known = not line:find('%S')
        local key = line:match('^%s*hotkey%s+(%S+)')
        if key then hotkey_name = key; known = true end
        local name, value = line:match('^%s*([%a_]+)%s+(%S+)%s*$')
        local target, sources = line:match('^%s*passive_stack%s+(%d+)%s+([%d,]+)%s*$')
        if target and MOD.offline then
            local list, seen = {}, { [tonumber(target)] = true }
            for id in sources:gmatch('%d+') do
                id = tonumber(id)
                if not seen[id] then seen[id], list[#list + 1] = true, id end
            end
            settings.stacks[tonumber(target)] = #list > 0 and list or nil
            known = true
        end
        local own = line:match('^%s*passive_own%s+(%d+)%s+off%s*$')
        if own and MOD.offline then settings.own_off[tonumber(own)], known = true, true end
        if name == 'changes' or name == 'block_input' or name == 'remember' then
            settings[name] = value ~= 'off'
            known = true
        elseif name == 'check_updates' or name == 'updates' and value == 'off' then   -- test builds' (no Off now)
            known = true
        elseif name == 'update_channel' and (value == 'releases' or value == 'commits') then
            settings.update_channel = value
            known = true
        elseif name == 'updates' and (value == 'ask' or value == 'auto') then
            settings.updates = value
            known = true
        elseif name == 'arc_chains_multiplayer' then
            settings.arc_mp = value == 'on'
            known = true
        elseif (name == 'panel_size' or name == 'panel_opacity') and MOD.parse_number(value) then
            settings.set_percent(name:sub(7), MOD.parse_number(value))
            known = true
        elseif name == 'panel_side' and (value == 'left' or value == 'right') then
            settings.side = value
            known = true
        elseif name == 'lang' and MOD.offline and (value == 'en' or settings.LANGS[value]) then
            settings.lang = value
            known = true
        elseif name == 'panel_lang' then   -- the language choice of PR #52's build and of test builds: gone
            known = true                     -- (each language has its own release)
        elseif name == 'last_tab' then
            settings.last_tab = value
            known = true
        elseif name == 'hide_tabs' then
            for tab in value:gmatch('[^,%s]+') do settings.hidden[tab] = true end
            known = true
        elseif name == 'last_weapon' and value:find('^%x+$') and #value == 16 then
            settings.last_weapon = value:upper()
            known = true
        elseif name == 'several_vehicles' then
            MOD.vehicles.on = value ~= 'off'; MOD.vehicles.apply()
            known = true
        elseif name == 'unlock_unused' then
            settings.unlock_all(value == 'on')
            known = true
        elseif name then   -- last: any other name would stop here
            for _, item in ipairs(settings.UNLOCKS) do
                -- one line per item before the single switch: any on turns them all on (local test builds
                -- saved incinerator_frv 'off' / 'gunner' / 'supply')
                if name == item.config then
                    if value == 'on' then settings.unlock_all(true) end
                    known = true
                end
            end
        end
        local hash, id, amount = line:match('^%s*(%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x)%s+([%w_]+)%s+(%S+)')
        local parsed = hash and MOD.parse_number(amount)
        if parsed then
            overrides[#overrides + 1] = { hash = hash:upper(), id = id, value = parsed }
            count = count + 1
            known = true
        end
        if not known then MOD.skipped('config.txt', at, line) end
    end
    log('config: ' .. count .. ' value(s), hotkey ' .. hotkey_name .. (settings.changes and '' or ', changes OFF') ..
        ' (' .. path .. ')')
end

local function mark_config_dirty() config_dirty_at = api.now() + 0.75 end

-- Drops every override that writes the same memory as (hash, id), then optionally adds one.
local function set_override(weapon, p, value)
    local kept = {}
    for _, o in ipairs(overrides) do
        local other = by_hash[o.hash]
        local op = other and other.by_id[o.id]
        if not (op and op.field == p.field) and not (o.hash == weapon.hash and o.id == p.id) then
            kept[#kept + 1] = o
        end
    end
    if value ~= nil then kept[#kept + 1] = { hash = weapon.hash, id = p.id, value = value } end
    overrides = kept
    if p.field and p.field.storage == 'grenade' then MOD.queue_grenade(weapon, p, value) end
    mark_config_dirty()
end

-- The value to keep as a change: nil when it is the game's own.
local function unless_default(value, default)
    if default ~= nil and math.abs(value - default) < 1e-4 then return nil end
    return value
end

-- A row whose value is the span of time rows (row.keeps: the Hover Pack's recharge time, its fuel):
-- their times before it changes, then (keep_times) their rates rewritten so the times stay.
function MOD.times_of(row)
    if not row.keeps then return nil end
    local times = {}
    for n, k in ipairs(row.keeps) do times[n] = row_value(k) end
    return { rows = row.keeps, times = times }
end

function MOD.keep_times(weapon, keep)
    if not keep then return end
    for n, k in ipairs(keep.rows) do
        local span, p = k.span(), k.parts[1]
        if keep.times[n] and keep.times[n] > 0 and span and span > 0 then   -- (no time to keep at 0)
            local new, d = span / keep.times[n] - (k.rate_plus or 0), default_of(p.field)
            if d and math.abs(new - d) < 1e-4 then new = d end
            if write_field(p.field, new) then set_override(weapon, p, unless_default(new, d)) end
        end
    end
end

-- Wind-up weapons (the Maxigun): its wind-up / wind-down times (`spin`: its WeaponWindUp record), and
-- WeaponData +387 (`data`: its record), set on the Maxigun alone: it stops you while you fire (HD2Runtime 0.30)
function MOD.spin_rows(weapon, data, spin)
    if spin then
        for _, t in ipairs({ { 'spin_up', 'Wind-up time (s)', 0 }, { 'spin_down', 'Wind-down time (s)', 4 } }) do
            add_row(weapon, 'Wind-up', t[1], t[2], 'f32', { part(t[1], TYPES.windup, spin + t[3], 'f32', 3600) }, 0.01, 60, 0.05, 0.25)
        end
    end
    local still = part('stationary', T_WEAPON, data + 387, 'flag', 1)
    if default_of(still.field) == 1 then
        add_row(weapon, 'Handling', 'stationary', 'Stops you while firing', 'flag', { still }, 0, 1, 1, 1)
    end
end

-- The parts a saved id names: its own (a swap row's first: the whole row's, all one value, so a field
-- the row gained later follows a value saved without it: the SG-20 Halt's ammo types), else (an id saved
-- before the weapon's magazine attachments had rows of their own: 'capacity', once every magazine's)
-- each of theirs. nil: none.
function MOD.parts_of(weapon, id)
    local own = weapon.by_id[id]
    if own and own.row and own.row.choice and own.row.parts[1] == own then return own.row.parts end
    if own then return { own } end
    local out = {}
    for _, listed in ipairs(weapon.legacy and weapon.legacy[id] or {}) do out[#out + 1] = weapon.by_id[listed] end
    return out[1] and out or nil
end

-- For other mods: the game's own value of a stat, named as in config.txt (weapon hash, stat id), as
-- read at startup before this mod wrote anything. nil: no such weapon / stat, or its table not found.
function state.vanilla(hash, id)
    local weapon = type(hash) == 'string' and by_hash[hash:upper()]
    local p = weapon and type(id) == 'string' and weapon.by_id[id]
    return p and default_of(p.field) or nil
end

local pending = {}      -- config values not applied yet (tables still being written)
local apply_at = 1

-- Reuse the saved-value retry queue while a grenade's package loads. New selections,
-- reset and presets cancel older requests for the same field, including shared hosts.
function MOD.queue_grenade(weapon, p, value)
    apply_at = 1
    for n = #pending, 1, -1 do
        local o = pending[n]
        local other = by_hash[o.hash]
        local op = other and other.by_id[o.id]
        if op and op.field == p.field then table.remove(pending, n) end
    end
    p.field.pending_value = nil
    if settings.changes and value ~= nil and KINDS[TYPES.throwable].entity_bytes(value)
       and read_field(p.field) ~= value then
        p.field.pending_value = value
        pending[#pending + 1] = { hash = weapon.hash, id = p.id, value = value, after = api.now() + 1 }
    end
end

function MOD.clear_grenade_pending()
    for _, f in pairs(fields) do if f.storage == 'grenade' then f.pending_value = nil end end
end

-- Applies pending values until the deadline (the rest wait for the next call); true when the
-- whole list was gone through once. Values that could not be written yet are tried again
-- later (the table may still be filling), up to 30 times.
local function apply_config(deadline)
    while apply_at <= #pending do
        local o = pending[apply_at]
        local weapon = by_hash[o.hash]
        local parts = weapon and MOD.parts_of(weapon, o.id)
        local keep = false
        if o.after and api.now() < o.after then
            keep = true   -- a grenade choice still settling
        elseif not weapon then
            log('config: unknown weapon ' .. o.hash); state.refused = state.refused + 1
        elseif not parts then
            log('config: ' .. weapon.name .. ' has no stat ' .. o.id); state.refused = state.refused + 1
        else
            local ok, why = true, nil
            for _, p in ipairs(parts) do
                default_of(p.field)
                local done, failed = write_field(p.field, o.value)
                ok, why = ok and done, why or failed
            end
            if ok then
                for _, p in ipairs(parts) do
                    if p.field.storage == 'grenade' then p.field.pending_value = nil end
                end
                state.applied = state.applied + 1
                if parts[1].id ~= o.id then   -- saved under an old id: kept under the attachments' own from now on
                    set_override(weapon, { id = o.id }, nil)
                    for _, p in ipairs(parts) do set_override(weapon, p, unless_default(o.value, default_of(p.field))) end
                end
            else
                o.tries = (o.tries or 0) + 1
                keep = o.tries < 30
                if keep then
                    for _, p in ipairs(parts) do
                        if p.field.storage == 'grenade' then p.field.pending_value = o.value end
                    end
                end
                if not keep then
                    for _, p in ipairs(parts) do
                        if p.field.storage == 'grenade' then
                            p.field.pending_value = nil
                            -- the choice stays saved (tried again next start); say so, the row now shows the projectile
                            MOD.notify(weapon.name .. ': grenade not applied (' .. tostring(why) .. ')', 6)
                        end
                    end
                    log('config: ' .. weapon.name .. ' ' .. o.id .. ' not applied: ' .. why); state.refused = state.refused + 1
                end
            end
        end
        if keep then apply_at = apply_at + 1 else table.remove(pending, apply_at) end
        if deadline and api.now() >= deadline then break end
    end
    if apply_at <= #pending then return false end
    apply_at = 1
    return true
end

-- ---------------------------------------------------------------- scan client
-- Once the tables are in: resolve every weapon, then apply the saved values, a slice per frame.
local progress = nil

-- The lists built once every table is found: one step per frame (phase 'building'), so no frame
-- carries them all. Each step: { name, function, what failing means }.
local function become_ready(final)
    state.build_steps = {
        { 'stratagems', build_stratagems, 'stratagems: not listed: ' },
        { 'attachments', KINDS[TYPES.items].build, 'attachments: not listed: ' },
        { 'passives', KINDS[TYPES.passive].build, 'armor passives: not listed: ' },
    }
    set_status('building', 'listing stratagems, attachments and armor passives')
end

-- The next build step; once all are done, weapons are resolved and saved values applied.
function state.build_some()
    local build_steps = state.build_steps
    local step = table.remove(build_steps, 1)
    if step then
        local ok, why = pcall(step[2])
        if not ok then log(step[3] .. tostring(why)) end
        if #build_steps > 0 then return end
    end
    state.build_steps = nil
    progress = { next = 1 }
    pending, apply_at = {}, 1
    if settings.changes then
        for _, o in ipairs(overrides) do pending[#pending + 1] = { hash = o.hash, id = o.id, value = o.value } end
    end
    set_status('preparing', 'resolving weapons and applying saved values')
end

-- Every field's game value, read before this mod writes any: otherwise a field's default is read
-- when first needed, and holds another mod's value if one edited it first (an ammo mod's damage).
-- Reset, "was" and changes off then go back to the game's own value. Fields already read keep theirs.
function MOD.snapshot_defaults(progress, deadline)
    if not progress.keys then
        progress.keys, progress.read = {}, 1
        for key in pairs(fields) do progress.keys[#progress.keys + 1] = key end
    end
    local keys = progress.keys
    while progress.read <= #keys do
        default_of(fields[keys[progress.read]])
        progress.read = progress.read + 1
        if progress.read % 256 == 0 and api.now() >= deadline then return false end
    end
    return true
end

local function prepare(deadline)
    if not progress.resolved then
        if not resolve_some(progress, deadline) then return end
        progress.resolved = true
    end
    if not MOD.snapshot_defaults(progress, deadline) then return end
    if api.now() >= deadline or not apply_config(deadline) then return end
    progress = nil
    local missing = {}
    for _, kind in ipairs(KIND_ORDER) do
        if not tables[kind] then missing[#missing + 1] = KINDS[kind].name end
    end
    for _, w in ipairs(weapons) do
        if w.stratagem and not w.stratagem.def and not w.stratagem.native and #STRATAGEMS > 0 and w.stratagem.family ~= 'support' then
            log('stratagem ' .. w.name .. ' (' .. w.hash .. '): definition not found; cooldown not editable')
        elseif w.stratagem and w.stratagem.def and w.stratagem.nodes[1] == nil then
            local keys = {}
            for k, key in ipairs(w.stratagem.payloads) do keys[k] = string.format('%08X%08X', u32(key, 4), u32(key, 0)) end
            log('stratagem ' .. w.name .. ' (' .. w.hash .. '): ' .. #w.rows .. ' rows, payloads ' .. table.concat(keys, ' '))
        end
    end
    set_status('ready', state.weapons .. ' weapons, ' .. (state.throwables or 0) .. ' throwables, ' ..
               (state.stratagems or 0) .. ' stratagems, ' .. (state.vehicles or 0) .. ' vehicles, ' ..
               (state.attachments or 0) .. ' attachments and ' ..
               (state.passives or 0) .. ' armor passives editable; ' ..
               state.applied .. ' saved value(s) applied' ..
               (#pending > 0 and (', ' .. #pending .. ' waiting') or '') ..
               (#missing > 0 and ('; tables not found: ' .. table.concat(missing, ', ')) or ''))
end

local function searching() return state.phase == 'searching' end

local function wants(kind, address)
    return KINDS[kind] ~= nil and not parsed_blocks[address]
end

local function handle_table(address, kind, payload, blob)
    local spec = KINDS[kind]
    if not spec or parsed_blocks[address] then return end
    if spec.found then   -- one of many tables taken by address (the destruction settings)
        spec.found[#spec.found + 1] = address
        parsed_blocks[address] = true
        return
    end
    local parse = spec.parse or (spec.keyed and parse_keyed or parse_rows)
    local started = api.now()
    local index, info = parse(blob, spec.stride, spec, address)
    -- game build 25988413 (2026-10-20) changed some records: its layouts are tried after the first one, and the
    -- one that fits is kept (`offsets`: where fields moved, old offset -> new)
    for _, layout in ipairs(not index and spec.layouts or {}) do
        local was = { spec.stride, spec.slack, spec.offsets }
        spec.stride, spec.slack, spec.offsets = layout.stride, layout.slack, layout.offsets
        index, info = parse(blob, spec.stride, spec, address)
        if index then
            log(string.format('%s: layout of game build 25988413 (%d bytes a record)', spec.name, spec.stride))
            break
        end
        spec.stride, spec.slack, spec.offsets = was[1], was[2], was[3]
    end
    local took = (api.now() - started) * 1000
    if not index then
        log(spec.name .. ' table at ' .. hex(address) .. ' not usable yet: ' .. info)
        return
    end
    local table_type = kind
    if spec.groups then
        -- each group is its own table; copies of one group have its size and first row
        local list = kind == T_STRATAGEM and stratagem_groups or spec.list
        kind = spec.group_key and spec.group_key(blob)
               or ((kind == T_STRATAGEM and 'stratagems' or spec.name) .. ' ' .. payload .. ' ' .. (u32(blob, 16 + (spec.id_at or 0)) or 0))
        if not tables[kind] then list[#list + 1] = kind end
    end
    local entry = tables[kind]
    if entry and entry.payload ~= payload then
        log(spec.name .. ' table at ' .. hex(address) .. ' has another size; ignored')
        parsed_blocks[address] = true
        return
    end
    if not entry then
        entry = { payload = payload, index = index, entries = info, copies = {}, type = table_type }
        tables[kind] = entry
        state.tables = state.tables + 1
    end
    entry.copies[#entry.copies + 1] = address
    parsed_blocks[address] = true
    log(string.format('%s table at %s: %d entries (parsed in %.2f ms)', spec.name, hex(address), info, took))
end

local function after_pass(pass, final)
    if not searching() then return end
    if have_all_tables() or final then become_ready(final) end
end

-- The tables are still where they were (checked when the panel opens); if not, scan again.
local hub = nil
local function tables_intact()
    for kind, entry in pairs(tables) do
        for _, block in ipairs(entry.copies) do
            local header = api.read(block, HEADER_BYTES)
            if not header or header:sub(1, 8) ~= NEEDLE or u32(header, 8) ~= entry.type or u32(header, 12) ~= entry.payload then
                return false
            end
        end
    end
    return true
end

local function rescan()
    log('a settings table moved; scanning again')
    tables, parsed_blocks, stratagem_groups = {}, {}, {}
    KINDS[TYPES.items].list = {}
    KINDS[TYPES.passive].list = {}
    KINDS[TYPES.destruction].found, KINDS[TYPES.destruction].told = {}, nil
    state.tables = 0
    set_status('searching', 'a table moved; scanning again')
    if hub then hub.wake() end
end

-- ---------------------------------------------------------------- windows input
local user, own_pid = nil, nil
local point, rect, pid = nil, nil, nil

local function build_input()
    for _, declaration in ipairs({
        'void *GetForegroundWindow(void);',
        'uint32_t GetWindowThreadProcessId(void*,void*);',
        'uint32_t GetCurrentProcessId(void);',
        'int GetCursorPos(void*);',
        'int ScreenToClient(void*,void*);',
        'int GetClientRect(void*,void*);',
        'int16_t GetAsyncKeyState(int key);',
        'int16_t GetKeyState(int key);',
        'uint32_t MapVirtualKeyW(uint32_t code, uint32_t type);',
        'int ToUnicode(uint32_t vk, uint32_t scan, const uint8_t *state, uint16_t *text, int size, uint32_t flags);',
        'int ShowCursor(int show);',
        'int ClipCursor(const void *rect);',
        'int GetClipCursor(void *rect);',
        'void *GetModuleHandleA(const char *name);',
        'typedef struct { uint16_t page; uint16_t usage; uint32_t flags; void *target; } shodan_raw_device;',
        'uint32_t GetRegisteredRawInputDevices(shodan_raw_device *devices, uint32_t *count, uint32_t size);',
        'int RegisterRawInputDevices(const shodan_raw_device *devices, uint32_t count, uint32_t size);',
        'uint32_t GetCurrentThreadId(void);',
        'intptr_t GetWindowLongPtrW(void *window, int index);',
        'intptr_t SetWindowLongPtrW(void *window, int index, intptr_t value);',
        'void *GetProcAddress(void *module, const char *name);',
        'void *VirtualAlloc(void *address, size_t size, uint32_t type, uint32_t protect);',
        'int FlushInstructionCache(void *process, const void *address, size_t size);',
        'void *GetCurrentProcess(void);',
        'void *ShellExecuteW(void *window, const uint16_t *op, const uint16_t *file, const uint16_t *params, const uint16_t *dir, int show);',
        'int OpenClipboard(void *owner);',
        'int EmptyClipboard(void);',
        'void *SetClipboardData(uint32_t format, void *data);',
        'int CloseClipboard(void);',
        'void *GlobalAlloc(uint32_t flags, size_t bytes);',
        'void *GlobalLock(void *data);',
        'int GlobalUnlock(void *data);',
        'int MultiByteToWideChar(uint32_t page, uint32_t flags, const char *text, int bytes, uint16_t *wide, int chars);',
    }) do pcall(ffi.cdef, declaration) end
    user = ffi.load('user32')
    own_pid = ffi.load('kernel32').GetCurrentProcessId()
    point, rect, pid = ffi.new('int32_t[2]'), ffi.new('int32_t[4]'), ffi.new('uint32_t[1]')
end

local function focused_window()
    local window = user.GetForegroundWindow()
    if window == nil then return nil end
    if user.GetWindowThreadProcessId(window, ffi.cast('void *', pid)) == 0 or pid[0] ~= own_pid then return nil end
    return window
end

-- UTF-8 text as a zero-ended UTF-16 string (and its length in characters, the zero included)
function settings.wide(text)
    local kernel = ffi.load('kernel32')
    local n = kernel.MultiByteToWideChar(65001, 0, text, -1, nil, 0)
    local out = ffi.new('uint16_t[?]', math.max(1, n))
    kernel.MultiByteToWideChar(65001, 0, text, -1, out, n)
    return out, n
end

-- Opens a link or folder with Windows' default program (the browser, Explorer).
function settings.open(target)
    local ok = pcall(function()
        ffi.load('shell32').ShellExecuteW(nil, (settings.wide('open')), (settings.wide(target)), nil, nil, 1)
    end)
    return ok
end

-- Puts text on the clipboard.
function settings.copy(text)
    local kernel = ffi.load('kernel32')
    local wide, n = settings.wide(text)
    local data = kernel.GlobalAlloc(0x0002, n * 2)          -- GMEM_MOVEABLE
    if data == nil then return false end
    local at = kernel.GlobalLock(data)
    if at == nil then return false end
    ffi.copy(at, wide, n * 2)
    kernel.GlobalUnlock(data)
    if user.OpenClipboard(nil) == 0 then return false end
    user.EmptyClipboard()
    local ok = user.SetClipboardData(13, data) ~= nil      -- CF_UNICODETEXT
    user.CloseClipboard()
    return ok
end

local VK = { Up = 0x26, Down = 0x28, Left = 0x25, Right = 0x27, PageUp = 0x21, PageDown = 0x22,
             Delete = 0x2E, Shift = 0x10, Insert = 0x2D, Home = 0x24, End = 0x23, Pause = 0x13,
             ScrollLock = 0x91, Ctrl = 0x11, Enter = 0x0D, Backspace = 0x08, Escape = 0x1B }
for n = 1, 12 do VK['F' .. n] = 0x6F + n end
for n = 0, 9 do VK['Key' .. n] = 0x30 + n end

local function key_down(vk) return user.GetAsyncKeyState(vk) < 0 end

-- Typing (preset names): the keys that can make a character (space, digits, letters, numpad,
-- punctuation), turned into text by the player's keyboard layout with Shift, Caps Lock and
-- AltGr as they are. '#' is left out (it starts a comment in the preset files).
local TEXT_KEYS = { 0x20, 0xE2 }
for vk = 0x30, 0x39 do TEXT_KEYS[#TEXT_KEYS + 1] = vk end
for vk = 0x41, 0x5A do TEXT_KEYS[#TEXT_KEYS + 1] = vk end
for vk = 0x60, 0x6F do TEXT_KEYS[#TEXT_KEYS + 1] = vk end
for vk = 0xBA, 0xC0 do TEXT_KEYS[#TEXT_KEYS + 1] = vk end
for vk = 0xDB, 0xDF do TEXT_KEYS[#TEXT_KEYS + 1] = vk end
for _, vk in ipairs(TEXT_KEYS) do VK['T' .. vk] = vk end
local key_char
do
    local key_state, key_text = nil, nil

    local function utf8_char(c)
        if c < 0x80 then return string.char(c) end
        if c < 0x800 then return string.char(0xC0 + math.floor(c / 64), 0x80 + c % 64) end
        return string.char(0xE0 + math.floor(c / 4096), 0x80 + math.floor(c / 64) % 64, 0x80 + c % 64)
    end

    key_char = function(vk)
        if not key_state then key_state, key_text = ffi.new('uint8_t[256]'), ffi.new('uint16_t[4]') end
        ffi.fill(key_state, 256)
        for _, k in ipairs({ 0x10, 0x11, 0x12, 0xA0, 0xA1, 0xA2, 0xA3, 0xA4, 0xA5 }) do
            if key_down(k) then key_state[k] = 0x80 end
        end
        if user.GetKeyState(0x14) % 2 == 1 then key_state[0x14] = 1 end     -- Caps Lock on (low bit)
        key_state[vk] = 0x80
        -- flag 4: leaves the keyboard's own state (dead keys) alone
        if user.ToUnicode(vk, user.MapVirtualKeyW(vk, 0), key_state, key_text, 4, 4) ~= 1 then return nil end
        local c = key_text[0]
        if c < 32 or c == 35 or c == 127 or (c >= 0xD800 and c < 0xE000) then return nil end
        return utf8_char(c)
    end
end

-- ---------------------------------------------------------------- panel
local sr = nil          -- the engine (stingray)
-- page / fpage: the first row the weapon / full preset list shows (the lists scroll by rows)
local ui = { open = false, measured = {}, measures = 0, tab = 'Primary', page = 1, row = 1, scroll = 1, weapon = nil, hover = nil,
             gui = nil, world = nil, signature = nil, regions = {}, version = 0, errors = 0,
             wslot = 1, fslot = nil, fpage = 1, message = nil,   -- chosen weapon preset / full preset, status line
             editing = nil, confirm = nil,    -- a preset name being typed; an overwrite / delete to confirm
             search = { text = '', active = false },    -- the list's search (active: being typed)
             value = nil }   -- a value being typed: { n = row, weapon, text, fresh (the first key replaces it) }

-- the status line, for code above the panel's
function MOD.notify(text, seconds) ui.message = { text = text, till = api.now() + (seconds or 4) } end
local TABS = { 'Primary', 'Secondary', 'Support', 'Throwables', 'Stratagems', 'Mechas', 'Attachments', 'Armors', 'Records' }
-- the tabs Settings > Tabs shown leaves on
function settings.shown_tabs()
    local list = {}
    for _, tab in ipairs(TABS) do if not settings.hidden[tab] then list[#list + 1] = tab end end
    return list
end
local LIST_ROWS = 27
local W, H = 1000, 980       -- panel size in its own units

-- The weapons (or stratagems) of a tab; tab '?search': those of every tab whose name holds every
-- word of the search (any case). The Records tab: its records, and searching there searches them.
local function weapons_in(tab)
    local list, words = {}, nil
    if tab == '?search' then
        words = {}
        for word in ui.search.text:lower():gmatch('%S+') do words[#words + 1] = word end
    end
    if tab == 'Records' or words and ui.tab == 'Records' then
        for _, page in ipairs(MOD.records.all()) do
            local text, all = (page.name .. ' ' .. page.note):lower(), true
            for _, word in ipairs(words or {}) do
                if not text:find(word, 1, true) then all = false; break end
            end
            if all then list[#list + 1] = page end
        end
        return list
    end
    for _, weapon in ipairs(weapons) do
        if #weapon.rows > 0 and not settings.hidden[weapon.slot] then
            if words then
                local name, all = weapon.name:lower(), true
                for _, word in ipairs(words) do
                    if not name:find(word, 1, true) then all = false; break end
                end
                if all then list[#list + 1] = weapon end
            elseif weapon.slot == tab then
                list[#list + 1] = weapon
            end
        end
    end
    return list
end

-- (a value saved for a stat the weapon has no row for, e.g. one an update removed, stays saved, not shown)
local function modified(weapon)
    for _, o in ipairs(overrides) do
        if o.hash == weapon.hash and MOD.parts_of(weapon, o.id) then return true end
    end
    -- an armor passive with passives stacked on it (offline)
    local t = weapon.passive and tables[weapon.passive]
    return t ~= nil and (settings.stacks[t.index.id] ~= nil or settings.own_off[t.index.id] ~= nil)
end

-- Font: the game's UI font (the resource ids HD2 HUD Plus and DiverKit read from game.dll
-- of this build), else the engine's debug font.
local font = nil
local GAME_STAMP, FONT_RVA, ATLAS_RVA, MATERIAL_RVA = 0x6AB3B43F, 0x3772268, 0x3772EE8, 0x37C5478

local function resource_hex(bytes)
    if not bytes or #bytes ~= 8 or bytes == string.rep('\0', 8) then return nil end
    return string.format('%08x%08x', u32(bytes, 4), u32(bytes, 0))
end

-- The ids are read again for every new gui (the game can switch them), and nothing is bound
-- unless the engine says all three resources are loaded: binding a texture that is not there
-- crashes the game (Material.set_texture, seen in-game on 2026-09-28).
local DEBUG_FONT = 'core/performance_hud/debug'

local function read_font_ids()
    if state.font_ids then return state.font_ids end
    local base = ffi.load('kernel32').GetModuleHandleA('game.dll')
    if base == nil then return nil, 'game.dll not found' end
    base = tonumber(ffi.cast('uintptr_t', base))
    local dos = api.read(base, 64)
    local pe = dos and u32(dos, 60)
    local head = pe and api.read(base + pe, 16)
    if not head or head:sub(1, 4) ~= 'PE\0\0' or u32(head, 8) ~= GAME_STAMP then return nil, 'game.dll is another build' end
    local font_id = resource_hex(api.read(base + FONT_RVA, 8))
    local atlas_id = resource_hex(api.read(base + ATLAS_RVA, 8))
    local owner = api.read(base + MATERIAL_RVA, 8)
    local owner_at = owner and (u32(owner, 0) + u32(owner, 4) * 4294967296)
    local material_id = owner_at and owner_at ~= 0 and resource_hex(api.read(owner_at + 24, 8))
    if not (font_id and atlas_id and material_id) then return nil, 'font ids not set yet' end
    state.font_ids = { font = font_id, material = material_id, atlas = atlas_id }
    return state.font_ids
end

-- true / false when the engine answers, nil when it cannot be asked
local function loaded(kind, name)
    local can_get = sr.Application and rawget(sr.Application, 'can_get')
    if type(can_get) ~= 'function' then return nil end
    local ok, value = pcall(function()
        return can_get(kind, name:match('^%x+$') and #name == 16 and sr.IdString64.from_hex(name) or name)
    end)
    if not ok then return nil end
    return value == true
end

-- Picks the font for a new gui and binds it: for a panel language the game UI font has no glyphs
-- for (Chinese while the game runs in English), the game's own font for that language when loaded;
-- else the game UI font when all its parts are loaded, else the engine debug font when loaded,
-- else none (the panel is drawn without text).
local function choose_font(gui)
    local ids, why = read_font_ids()
    local function bind(font_id, atlas, text)
        step('Gui.material')
        local ink = sr.Gui.material(gui, sr.IdString64.from_hex(ids.material))
        if not ink then return nil end
        step('Material.set_texture')
        sr.Material.set_texture(ink, sr.IdString64.from_hex('88bac99b00000000'), sr.IdString64.from_hex(atlas))
        return { font = sr.IdString64.from_hex(font_id), material = sr.IdString64.from_hex(ids.material), text = text }
    end
    local l, lang_why = settings.LANGS[settings.lang], nil
    if ids and l and l.fonts then
        local own = false
        for _, f in ipairs(l.fonts) do own = own or f.font == ids.font end
        if not own and loaded('material', ids.material) then
            local said = {}
            for _, f in ipairs(l.fonts) do
                local ff, t = loaded('font', f.font), loaded('texture', f.atlas)
                local chosen = ff and t and bind(f.font, f.atlas, 'game ' .. l.id .. ' font ' .. f.font .. ' (atlas ' .. f.atlas .. ')')
                if chosen then return chosen end
                said[#said + 1] = string.format('font %s %s, texture %s %s', f.font, tostring(ff), f.atlas, tostring(t))
            end
            lang_why = l.id .. ' fonts not loaded: ' .. table.concat(said, '; ')
        end
    end
    if ids then
        local f, m, t = loaded('font', ids.font), loaded('material', ids.material), loaded('texture', ids.atlas)
        if f and m and t then
            local chosen = bind(ids.font, ids.atlas, 'game UI font ' .. ids.font .. ' (atlas ' .. ids.atlas .. ')'
                                .. (lang_why and '; ' .. lang_why or ''))
            if chosen then return chosen end
            why = 'no font material instance'
        else
            why = string.format('game UI font not loaded (font %s, material %s, texture %s)', tostring(f), tostring(m), tostring(t))
        end
    end
    if loaded('font', DEBUG_FONT) and loaded('material', DEBUG_FONT) then
        return { font = DEBUG_FONT, material = DEBUG_FONT, text = 'debug font (' .. why .. ')' }
    end
    return { text = 'no text: ' .. why .. '; debug font not loaded either' }
end

local function clear_gui()
    if ui.gui and ui.world then
        for _, w in ipairs(sr.Application.worlds() or {}) do
            if w == ui.world then pcall(sr.World.destroy_gui, ui.world, ui.gui) break end
        end
    end
    ui.gui, ui.world, ui.signature, ui.regions = nil, nil, nil, {}
end

local function fmt(v, storage)
    if v == nil then return '?' end
    if storage == 'flag' then return v >= 0.5 and 'On' or 'Off' end
    if storage == 'u32' then return tostring(math.floor(v + 0.5)) end
    if math.abs(v - math.floor(v + 0.5)) < 1e-4 then return tostring(math.floor(v + 0.5)) end
    if math.abs(v) < 1 then return (string.format('%.3f', v):gsub('0+$', '')) end
    return (string.format('%.2f', v):gsub('0+$', ''):gsub('%.$', ''))
end

local function step_of(row, value, big)
    local step = big and row.big or row.small
    if row.storage == 'f32' and value and value > 0 and value < row.small then
        step = 10 ^ math.floor(math.log10(value) + 1e-9)
        if big then step = step * 10 end
    end
    return step
end

local function select_weapon(weapon)
    ui.weapon = weapon
    ui.row, ui.scroll, ui.settings, ui.binding, ui.stack_pick = 1, 1, false, nil, nil
    if weapon and settings.remember and state.phase == 'ready' and settings.last_weapon ~= weapon.hash then
        settings.last_tab, settings.last_weapon = weapon.slot, weapon.hash
        mark_config_dirty()
    end
    if weapon then
        ui.tab = weapon.slot
        local list = weapons_in(ui.search.text ~= '' and '?search' or ui.tab)
        for n, w in ipairs(list) do
            if w == weapon and n < ui.page then ui.page = n
            elseif w == weapon and n >= ui.page + LIST_ROWS then ui.page = n - LIST_ROWS + 1 end
        end
    end
end

local function change(row, delta_sign, big, exact)
    local weapon = ui.weapon
    local current = row_value(row)
    if not weapon or current == nil then return end
    if not settings.changes then
        ui.message = { text = 'Your changes are off: turn them on in Settings to edit.', till = api.now() + 4 }
        return
    end
    if row.choice then
        if row.choice == 'grenade' then
            local spec = KINDS[TYPES.throwable]
            local target = exact and math.floor(exact + 0.5) or spec.step(current, delta_sign * (big and 10 or 1))
            if not spec.entity_bytes(target) then
                ui.message = { text = 'No grenade choice ' .. tostring(target) .. ' in this game build.', till = api.now() + 4 }
                return
            end
            local p = row.parts[1]
            if target ~= 0 and not exact then
                -- stepping through the list: applied once the choice settles, so only the grenade
                -- you stop on has its assets loaded (they stay loaded for the session)
                local ok, why = spec.ensure_launch()
                if ok then set_override(weapon, p, unless_default(target, default_of(p.field)))
                else ui.message = { text = why, till = api.now() + 4 } end
                ui.version = ui.version + 1
                return
            end
            local ok, why = write_field(p.field, target)
            if ok or why == 'grenade assets loading' then
                set_override(weapon, p, unless_default(target, default_of(p.field)))
            end
            if not ok then ui.message = { text = why, till = api.now() + 4 } end
            ui.version = ui.version + 1
            return
        end
        if row.choice == 'stratagem' then
            local target = exact and math.floor(exact + 0.5) or MOD.extra.step(row.def, current, delta_sign * (big and 10 or 1))
            if target == nil or target == current then return end
            local why = MOD.extra.refused(row.def, target)
            if why then ui.message = { text = why, till = api.now() + 4 }; return end
            local p = row.parts[1]
            local ok, err = write_field(p.field, target)
            if ok then set_override(weapon, p, unless_default(target, default_of(p.field)))
            else ui.message = { text = err, till = api.now() + 4 } end
            ui.version = ui.version + 1
            return
        end
        if row.choice == 'status' then
            local target = exact and math.floor(exact + 0.5) or MOD.status.step(current, delta_sign * (big and 10 or 1))
            if target == current then return end
            local why = MOD.status.refused(row, target)
            if why then ui.message = { text = why, till = api.now() + 4 }; return end
            local p = row.parts[1]
            local ok, err = write_field(p.field, target)
            if ok then
                set_override(weapon, p, unless_default(target, default_of(p.field)))
                -- a status with no strength does nothing: it gets the usual one
                local sp = row.strength and row.strength.parts[1]
                if target ~= 0 and sp and (read_field(sp.field) or 0) == 0 and MOD.status.by[target] then
                    if write_field(sp.field, MOD.status.by[target].strength) then
                        set_override(weapon, sp, unless_default(MOD.status.by[target].strength, default_of(sp.field)))
                    end
                end
            else ui.message = { text = err, till = api.now() + 4 } end
            ui.version = ui.version + 1
            return
        end
        if row.choice == 'explosion' or row.choice == 'shrapnel' then
            -- an explosion id, or the projectile shrapnel pieces are: none (0) or any record of this build
            local kind = row.choice == 'explosion' and T_EXPLOSION or T_PROJECTILE
            local target = exact and math.floor(exact + 0.5) or MOD.records.step(kind, current, delta_sign * (big and 10 or 1))
            if target ~= 0 and not (tables[kind] and tables[kind].index[target]) then
                ui.message = { text = (kind == T_EXPLOSION and 'No explosion ' or 'No projectile ') .. tostring(target) .. ' in the game.',
                               till = api.now() + 4 }
                return
            end
            if target == current then return end
            for _, p in ipairs(row.parts) do
                local d = default_of(p.field)
                local ok, why = write_field(p.field, target)
                if ok then set_override(weapon, p, unless_default(target, d))
                else log('write refused: ' .. weapon.name .. ' ' .. p.id .. ': ' .. why) end
            end
            ui.version = ui.version + 1
            return
        end
        -- a projectile swap: the next / previous weapon's projectile (++ / --: 10 on), or a typed id
        local target = exact and math.floor(exact + 0.5) or KINDS[T_PROJECTILE].step(current, delta_sign * (big and 10 or 1))
        if not (tables[T_PROJECTILE] and tables[T_PROJECTILE].index[target]) then
            ui.message = { text = 'No projectile ' .. tostring(target) .. ' in the game.', till = api.now() + 4 }
            return
        end
        if target == current then return end
        for _, p in ipairs(row.parts) do
            local d = default_of(p.field)
            local ok, why = write_field(p.field, target)
            if ok then set_override(weapon, p, unless_default(target, d))
            else log('write refused: ' .. weapon.name .. ' ' .. p.id .. ': ' .. why) end
        end
        ui.version = ui.version + 1
        return
    end
    local target = exact or current + delta_sign * step_of(row, current, big)
    if row.storage == 'u32' then target = math.floor(target + 0.5)
    else target = math.floor(target * 10000 + 0.5) / 10000 end
    if row.limit and delta_sign > 0 and current >= row.max then
        ui.message = { text = row.limit, till = api.now() + 4 }
    end
    target = math.max(row.min, math.min(row.max, target))
    if target == current then return end
    if row.span and not ((row.span() or 0) > 0) then   -- a time of nothing (the Hover Pack at recharge 0)
        ui.message = { text = 'The recharge time is 0: set it above 0 first.', till = api.now() + 4 }
        return
    end
    local keep = MOD.times_of(row)
    for _, p in ipairs(row.parts) do
        local v = read_field(p.field)
        default_of(p.field)
        local new = target
        if row.span then new = row.span() / target - (row.rate_plus or 0)
        elseif #row.parts > 1 then new = (current > 0) and v * target / current or target
        elseif row.zero and math.abs(target - row.zero) < 1e-4 and defaults[p.field.key] == 0 then new = 0 end
        local ok, why = write_field(p.field, new)
        local d = defaults[p.field.key]
        if ok then
            set_override(weapon, p, unless_default(new, d))
        else
            log('write refused: ' .. weapon.name .. ' ' .. p.id .. ': ' .. why)
        end
    end
    MOD.keep_times(weapon, keep)
    ui.version = ui.version + 1
end

-- Ends typing a value: keep = true sets it (out of the stat's range: the nearest end, and says so).
local function finish_value(keep)
    local edit = ui.value
    ui.value = nil
    if edit and edit.setting then
        local typed = keep and tonumber((edit.text:gsub(',', '.')))
        if not typed then return end
        local r = settings.RANGE[edit.setting]
        if settings.set_percent(edit.setting, typed) then
            ui.message = { text = string.format('%s can be %d%% to %d%%: set to %d%%.', edit.setting == 'size' and 'Panel size'
                                                or 'Background opacity', r[1], r[2], settings[edit.setting]), till = api.now() + 4 }
        end
        mark_config_dirty()
        ui.version = ui.version + 1
        return
    end
    local row = edit and keep and edit.weapon == ui.weapon and ui.weapon.rows[edit.n]
    local typed = row and tonumber((edit.text:gsub(',', '.')))
    if not typed then return end
    local rounded = row.storage == 'u32' and math.floor(typed + 0.5) or typed
    local target = math.max(row.min, math.min(row.max, rounded))
    change(row, 0, false, target)
    if target ~= rounded then
        local text = string.format('%s can be %s to %s: set to %s.', row.label, fmt(row.min, row.storage),
                                   fmt(row.max, row.storage), fmt(target, row.storage))
        if row.limit and rounded > row.max then text = row.limit .. ' Set to ' .. fmt(target, row.storage) .. '.' end
        ui.message = { text = text, till = api.now() + 4 }
    end
end

local function reset_row(weapon, row)
    local keep = MOD.times_of(row)
    for _, p in ipairs(row.parts) do
        local d = default_of(p.field)
        if d ~= nil then write_field(p.field, d) end
        set_override(weapon, p, nil)
    end
    MOD.keep_times(weapon, keep)
    ui.version = ui.version + 1
end

local function reset_weapon(weapon)
    for _, row in ipairs(weapon.rows) do reset_row(weapon, row) end
    local t = weapon.passive and tables[weapon.passive]   -- an armor passive: its stacked passives go too
    if t and (settings.stacks[t.index.id] or settings.own_off[t.index.id]) then
        settings.stacks[t.index.id], settings.own_off[t.index.id] = nil, nil
        state.writes = state.writes + 1
        mark_config_dirty()
    end
end

local function reset_all()
    apply_at = 1
    MOD.clear_grenade_pending()
    for n = #pending, 1, -1 do
        if pending[n].id == 'grenade' then table.remove(pending, n) end
    end
    for _, o in ipairs(overrides) do
        local weapon = by_hash[o.hash]
        local p = weapon and weapon.by_id[o.id]
        local d = p and default_of(p.field)
        if d ~= nil then write_field(p.field, d) end
    end
    overrides = {}
    mark_config_dirty()
    ui.version = ui.version + 1
end

function settings.set_changes(on)
    if settings.changes == on then return end
    settings.changes = on
    if on then
        pending, apply_at = {}, 1
        for _, o in ipairs(overrides) do
            pending[#pending + 1] = { hash = o.hash, id = o.id, value = o.value }
            local w = by_hash[o.hash]
            local p = w and w.by_id[o.id]
            if p and p.field.storage == 'grenade' then p.field.pending_value = o.value end
        end
        log('settings: changes on (' .. #pending .. ' value(s) applied again)')
    else
        pending = {}
        MOD.clear_grenade_pending()
        for _, o in ipairs(overrides) do
            local weapon = by_hash[o.hash]
            local p = weapon and weapon.by_id[o.id]
            local d = p and default_of(p.field)
            if d ~= nil then write_field(p.field, d) end
        end
        log('settings: changes off (' .. #overrides .. ' value(s) kept, the game\'s values written)')
    end
    mark_config_dirty()
    ui.version = ui.version + 1
end

-- ---------------------------------------------------------------- presets
-- Weapon presets: up to 5 per weapon (or stratagem), each every value of it that differs from
-- the game's, in StatEditor/weapon_presets.txt (<hash> <preset> <stat> <value>; "<hash>
-- <preset> -" is a preset saved with no changes). Full presets: up to 50, each a name and the
-- whole set of changes, in StatEditor/preset_NN.txt ("name <name>", then the config.txt lines,
-- so they can be shared).
local presets = { weapon_count = 5, full_count = 50, full = {} }   -- see below
do
    local WEAPON_PRESETS, FULL_PRESETS = presets.weapon_count, presets.full_count
    local HEX16 = string.rep('%x', 16)
    local weapon_presets = {}   -- weapon hash -> preset -> list of { id, value }
    local full_presets = presets.full   -- number -> { name, values = list of { hash, id, value } }
    local NAME_BYTES = 40

    local function say(text)
        ui.message = { text = text, till = api.now() + 4 }
        log(text)
    end

    local function preset_file(name)
        local dir = data_dir('StatEditor')
        return dir and dir .. '/' .. name
    end

    local function full_preset_file(n) return preset_file(string.format('preset_%02d.txt', n)) end

    local function write_lines(path, lines)
        local ok, why = MOD.write_text(path, table.concat(lines, '\r\n') .. '\r\n')
        if not ok then log('could not write ' .. tostring(path) .. ': ' .. why) end
        return ok
    end

    -- The file's lines without comments, or nil when there is no file.
    local function read_lines(path)
        local handle = path and io.open(path, 'rb')
        if not handle then return nil end
        local text = handle:read('*a') or ''
        handle:close()
        local out, numbers = {}, {}
        for at, line in MOD.lines_of(text) do
            line = line:gsub('#.*$', '')
            if line:find('%S') then out[#out + 1] = line; numbers[#out] = at end
        end
        return out, numbers
    end

    local function named(hash)
        local weapon = by_hash[hash]
        return weapon and ('   # ' .. weapon.name) or ''
    end

    local function save_weapon_presets()
        local path = preset_file('weapon_presets.txt')
        if not path then return end
        local lines = {
            '# SHODAN Stat Editor weapon presets (up to 5 per weapon), saved from the in-game panel.',
            '# Lines: <weapon hash> <preset 1-5> <stat> <value>; "-" marks a preset with no changes.',
        }
        local hashes = {}
        for hash in pairs(weapon_presets) do hashes[#hashes + 1] = hash end
        table.sort(hashes)
        for _, hash in ipairs(hashes) do
            for n = 1, WEAPON_PRESETS do
                local values = weapon_presets[hash][n]
                if values and #values == 0 then lines[#lines + 1] = hash .. ' ' .. n .. ' -' .. named(hash) end
                for _, v in ipairs(values or {}) do
                    lines[#lines + 1] = hash .. ' ' .. n .. ' ' .. v.id .. ' ' .. number_text(v.value) .. named(hash)
                end
            end
        end
        write_lines(path, lines)
    end

    local function save_full_preset(n)
        local path = full_preset_file(n)
        if not path then return end
        if not full_presets[n] then
            pcall(os.remove, path)
            -- where files cannot be removed, an emptied file says the preset was cleared
            if io.open(path, 'rb') then write_lines(path, { 'cleared' }) end
            return
        end
        local lines = {
            '# SHODAN Stat Editor preset. Load it from the Presets tab of the panel.',
            '# Lines: name <name>, then <weapon hash> <stat> <value> as in config.txt.',
            'name ' .. full_presets[n].name,
        }
        for _, o in ipairs(full_presets[n].values) do
            lines[#lines + 1] = o.hash .. ' ' .. o.id .. ' ' .. number_text(o.value) .. named(o.hash)
        end
        write_lines(path, lines)
    end

    local function load_presets()
        local count = 0
        local weapon_lines, weapon_numbers = read_lines(preset_file('weapon_presets.txt'))
        for i, line in ipairs(weapon_lines or {}) do
            local hash, n, rest = line:match('^%s*(' .. HEX16 .. ')%s+(%d+)%s+(.-)%s*$')
            n = tonumber(n)
            if hash and n and n >= 1 and n <= WEAPON_PRESETS then
                hash = hash:upper()
                weapon_presets[hash] = weapon_presets[hash] or {}
                local values = weapon_presets[hash][n]
                if not values then values = {}; weapon_presets[hash][n] = values; count = count + 1 end
                local id, amount = rest:match('^([%w_]+)%s+(%S+)$')
                local parsed = id and MOD.parse_number(amount)
                if parsed then
                    values[#values + 1] = { id = id, value = parsed }
                elseif rest ~= '-' then
                    MOD.skipped('weapon_presets.txt', weapon_numbers[i], line)
                end
            else
                MOD.skipped('weapon_presets.txt', weapon_numbers[i], line)
            end
        end
        local full = 0
        for n = 1, FULL_PRESETS do
            local lines, numbers = read_lines(full_preset_file(n))
            local preset = lines and { name = 'Preset ' .. n, values = {} }
            for i, line in ipairs(lines or {}) do
                if line:match('^%s*cleared') then preset = nil; break end
                local name = line:match('^%s*name%s+(.-)%s*$')
                local hash, id, amount = line:match('^%s*(' .. HEX16 .. ')%s+([%w_]+)%s+(%S+)')
                local parsed = hash and MOD.parse_number(amount)
                if name and name ~= '' then
                    preset.name = name:sub(1, NAME_BYTES)
                elseif parsed then
                    preset.values[#preset.values + 1] = { hash = hash:upper(), id = id, value = parsed }
                else
                    MOD.skipped(string.format('preset_%02d.txt', n), numbers[i], line)
                end
            end
            full_presets[n] = preset
            if preset then full = full + 1 end
        end
        log('presets: ' .. count .. ' weapon preset(s), ' .. full .. ' full preset(s)')
    end

    -- Every value of the weapon that differs from the game's, part by part: this mod's own value
    -- for it, so a value another mod changed on top (an ammo type) is not saved into the preset.
    local function weapon_changes(weapon)
        local mine = {}
        for _, o in ipairs(overrides) do
            local w = by_hash[o.hash]
            local p = w and w.by_id[o.id]
            if p then mine[p.field.key] = o.value end
        end
        local out = {}
        for _, row in ipairs(weapon.rows) do
            for _, p in ipairs(row.parts) do
                local v, d = p.field.pending_value or read_field(p.field), default_of(p.field)   -- a grenade still loading counts
                local own = mine[p.field.key]
                if own and v and d and math.abs(v - d) > 1e-4 then out[#out + 1] = { id = p.id, value = own } end
            end
        end
        return out
    end

    local function weapon_preset(weapon, n)
        return weapon and weapon_presets[weapon.hash] and weapon_presets[weapon.hash][n]
    end

    local function save_weapon_preset(weapon, n)
        local values = weapon_changes(weapon)
        weapon_presets[weapon.hash] = weapon_presets[weapon.hash] or {}
        weapon_presets[weapon.hash][n] = values
        save_weapon_presets()
        say('Saved ' .. weapon.name .. ' preset ' .. n .. ' (' .. #values .. ' changed value(s))')
        ui.version = ui.version + 1
    end

    -- The weapon takes the preset's values; everything the preset does not name goes back to the game's.
    local function load_weapon_preset(weapon, n)
        if not settings.changes then say('Your changes are off: turn them on in Settings to load a preset'); return end
        local values = weapon_preset(weapon, n)
        if not values then say(weapon.name .. ' preset ' .. n .. ' is empty'); return end
        local want, aliases = {}, weapon.aliases or {}
        for _, v in ipairs(values) do
            local id = aliases[v.id] or v.id
            local parts = MOD.parts_of(weapon, id)
            for _, p in ipairs(parts and parts[1].id ~= id and parts or {}) do   -- an old id: each attachment's
                if want[p.id] == nil then want[p.id] = v.value end
            end
            if not (parts and parts[1].id ~= id) and (want[id] == nil or id == v.id) then want[id] = v.value end
        end
        for _, row in ipairs(weapon.rows) do   -- a swap row: parts the preset does not name follow its first
            local first = row.choice and want[row.parts[1].id]
            for k = 2, first and #row.parts or 0 do
                if want[row.parts[k].id] == nil then want[row.parts[k].id] = first end
            end
        end
        local refused = 0
        for _, row in ipairs(weapon.rows) do
            for _, p in ipairs(row.parts) do
                local d = default_of(p.field)
                local target = want[p.id]
                if target == nil then target = d end
                want[p.id] = nil
                local current = read_field(p.field)
                local accepted = true
                if target ~= nil and current ~= nil and math.abs(current - target) > 1e-6 then
                    local ok, why = write_field(p.field, target)
                    accepted = ok or (p.field.storage == 'grenade' and why == 'grenade assets loading')
                    if not accepted then refused = refused + 1; log('preset refused: ' .. weapon.name .. ' ' .. p.id .. ': ' .. why) end
                end
                if target ~= nil and (accepted or p.field.storage ~= 'grenade') then
                    set_override(weapon, p, unless_default(target, d))
                end
            end
        end
        for id in pairs(want) do refused = refused + 1; log('preset: ' .. weapon.name .. ' has no stat ' .. id) end
        say('Loaded ' .. weapon.name .. ' preset ' .. n .. (refused > 0 and (' (' .. refused .. ' value(s) not applied)') or ''))
        ui.version = ui.version + 1
    end

    local function clear_weapon_preset(weapon, n)
        if not weapon_preset(weapon, n) then return end
        weapon_presets[weapon.hash][n] = nil
        if next(weapon_presets[weapon.hash]) == nil then weapon_presets[weapon.hash] = nil end
        save_weapon_presets()
        say('Cleared ' .. weapon.name .. ' preset ' .. n)
        ui.version = ui.version + 1
    end

    local function current_values()
        local values = {}
        for _, o in ipairs(overrides) do values[#values + 1] = { hash = o.hash, id = o.id, value = o.value } end
        return values
    end

    -- Preset numbers in use, in order.
    local function full_order()
        local order = {}
        for n = 1, FULL_PRESETS do if full_presets[n] then order[#order + 1] = n end end
        return order
    end

    -- The chosen preset (the first one when the chosen one is gone), or nil when there are none.
    local function chosen()
        if not full_presets[ui.fslot or 0] then ui.fslot = full_order()[1] end
        return ui.fslot
    end

    local function show(n)
        ui.fslot = n
        for k, m in ipairs(full_order()) do
            if m == n and k < ui.fpage then ui.fpage = k
            elseif m == n and k >= ui.fpage + LIST_ROWS then ui.fpage = k - LIST_ROWS + 1 end
        end
    end

    local function start_rename(n)
        if full_presets[n] then ui.editing = { n = n, text = full_presets[n].name, fresh = true } end
        ui.version = ui.version + 1
    end

    -- Enter / OK keeps the typed name, Esc / Cancel drops it.
    local function finish_rename(keep)
        local e = ui.editing
        ui.editing = nil
        ui.version = ui.version + 1
        if not (e and keep and full_presets[e.n]) then return end
        local name = e.text:gsub('[%c#]', ''):gsub('^%s+', ''):gsub('%s+$', '')
        if name == '' then say('Empty name: kept "' .. full_presets[e.n].name .. '"'); return end
        full_presets[e.n].name = name
        save_full_preset(e.n)
        say('Named it "' .. name .. '"')
    end

    -- One typed character (UTF-8), or false for Backspace.
    local function type_char(c)
        local e = ui.editing
        if not e then return end
        if c == false then
            e.text = e.fresh and '' or e.text:gsub('[%z\1-\127\194-\244][\128-\191]*$', '')
        else
            if e.fresh then e.text = '' end
            if #e.text + #c <= NAME_BYTES then e.text = e.text .. c end
        end
        e.fresh = false
        ui.version = ui.version + 1
    end

    -- A new preset holding the current changes; its name is typed next.
    local function new_full_preset()
        local n = nil
        for k = 1, FULL_PRESETS do if not full_presets[k] then n = k; break end end
        if not n then say('All ' .. FULL_PRESETS .. ' presets are in use: delete one first'); return end
        full_presets[n] = { name = 'Preset ' .. n, values = current_values() }
        save_full_preset(n)
        show(n)
        start_rename(n)
        say('Saved ' .. #full_presets[n].values .. ' changed value(s) as a new preset. Type its name, Enter keeps it.')
    end

    local function save_full_preset_now(n)
        if not full_presets[n] then return end
        full_presets[n].values = current_values()
        save_full_preset(n)
        say('Saved ' .. #full_presets[n].values .. ' changed value(s) into "' .. full_presets[n].name .. '"')
        ui.version = ui.version + 1
    end

    -- Every current change is undone, then the preset's values are applied.
    local function load_full_preset(n)
        local preset = full_presets[n]
        if not preset then return end
        if not settings.changes then say('Your changes are off: turn them on in Settings to load a preset'); return end
        reset_all()
        local refused = 0
        for _, o in ipairs(preset.values) do
            local weapon = by_hash[o.hash]
            local parts = weapon and MOD.parts_of(weapon, o.id)
            local ok, why = false, weapon and ('no stat ' .. o.id) or ('unknown weapon ' .. o.hash)
            for _, p in ipairs(parts or {}) do
                local d = default_of(p.field)
                ok, why = write_field(p.field, o.value)
                if p.field.storage == 'grenade' and why == 'grenade assets loading' then ok = true end   -- applied once loaded
                if ok then set_override(weapon, p, unless_default(o.value, d)) end
            end
            if not ok then refused = refused + 1; log('preset "' .. preset.name .. '": ' .. (weapon and weapon.name or o.hash) .. ' ' .. o.id .. ': ' .. tostring(why)) end
        end
        say('Loaded "' .. preset.name .. '"' .. (refused > 0 and (' (' .. refused .. ' value(s) not applied)') or ''))
        ui.version = ui.version + 1
    end

    local function delete_full_preset(n)
        local preset = full_presets[n]
        if not preset then return end
        full_presets[n] = nil
        save_full_preset(n)
        if ui.editing and ui.editing.n == n then ui.editing = nil end
        say('Deleted "' .. preset.name .. '"')
        ui.version = ui.version + 1
    end

    -- Overwriting and deleting take a second click (or key press) within 3 s.
    local function confirm(kind, n)
        local c = ui.confirm
        if c and c.kind == kind and c.n == n and api.now() < c.till then
            ui.confirm = nil
            if kind == 'save' then save_full_preset_now(n) else delete_full_preset(n) end
            return
        end
        if not full_presets[n] then return end
        ui.confirm = { kind = kind, n = n, till = api.now() + 3 }
        say((kind == 'save' and 'Again to overwrite "' or 'Again to delete "') .. full_presets[n].name .. '"')
        ui.version = ui.version + 1
    end
    presets.load_presets = load_presets
    presets.weapon_preset = weapon_preset
    presets.save_weapon_preset = save_weapon_preset
    presets.load_weapon_preset = load_weapon_preset
    presets.clear_weapon_preset = clear_weapon_preset
    presets.full_order, presets.chosen, presets.show = full_order, chosen, show
    presets.new_full_preset, presets.load_full_preset, presets.confirm = new_full_preset, load_full_preset, confirm
    presets.start_rename, presets.finish_rename, presets.type_char = start_rename, finish_rename, type_char
end

-- Draws the whole panel into a fresh screen gui. Coordinates are 1080p units from the panel's
-- top left; the gui itself counts pixels from the bottom left.
local function draw(width, height)
    local Gui, Vector3, Vector2, Color = sr.Gui, sr.Vector3, sr.Vector2, sr.Color
    local s = height / 1080 * (MOD.offline and 100 or settings.size) / 100   -- panel units -> 1080p units (offline: the window is the panel's)
    local ox, oy = settings.side == 'left' and 30 * s or width - (W + 30) * s, (height - H * s) / 2
    local gui = ui.gui
    local regions = {}
    local shared_overlay = nil   -- set while the cursor is on a cut-short 'shared with' list
    local tip_overlay = nil      -- set while the cursor is on a row with a tip (row.tip: its lines)
    local ink_font, ink_material = font.font, font.material

    local function color(r, g, b, a) return Color(a or 255, r, g, b) end
    local function vx(v)
        for _, get in ipairs({ function() return Vector2.x(v) end, function() return Vector3.x(v) end,
                               function() return v[1] end }) do
            local ok, x = pcall(get)
            if ok and type(x) == 'number' then return x end
        end
        return nil
    end
    local GOLD, WHITE, MUTED, DIM = color(255, 213, 0), color(238, 242, 246), color(153, 171, 184), color(95, 108, 120)
    local WARN, GOOD = color(255, 150, 60), color(120, 220, 140)

    local function rect(x, y, w, h, c, z)
        step('Gui.rect')
        Gui.rect(gui, Vector3(ox + x * s, height - oy - (y + h) * s, z or 951), Vector2(w * s, h * s), c)
    end
    -- a text's width on screen at a (scaled) size; measured once per text, size and font (the panel redraws often)
    local function measure_text(value, size)
        local key = value .. '|' .. size
        local measure = ui.measured[key]
        if not measure then
            step('Gui.text_extents')
            local ok, lo, hi = pcall(Gui.text_extents, gui, value, ink_font, size)
            if ok and lo and hi then
                local a, b = vx(lo), vx(hi)
                if a and b and b > a then measure = b - a end
            end
            if not measure then   -- per character: CJK is about twice as wide as Latin
                local units = 0
                for c in value:gmatch('[^\128-\191]') do units = units + (c < '\128' and 0.5 or 1) end
                measure = units * size
            end
            if ui.measures > 5000 then ui.measured, ui.measures = {}, 0 end
            ui.measured[key], ui.measures = measure, ui.measures + 1
        end
        return measure
    end
    local function width(value, size) return measure_text(settings.tr(value), size) end
    local function text(value, x, y, size, c, limit, align_right, z)
        if value == nil or value == '' or not ink_font then return end
        value = settings.tr(value)
        size = size * s
        local px = ox + x * s
        if limit or align_right then
            local measure = measure_text(value, size)
            if limit and measure > limit * s then size = size * limit * s / measure; measure = limit * s end
            if align_right then px = px - measure end
        end
        step('Gui.text')
        Gui.text(gui, value, ink_font, size, ink_material, Vector3(px, height - oy - y * s - size * 0.8, z or 953), c or WHITE)
    end
    local function outline(x, y, w, h, c, z)
        z = z or 952
        rect(x, y, w, 2, c, z); rect(x, y + h - 2, w, 2, c, z)
        rect(x, y, 2, h, c, z); rect(x + w - 2, y, 2, h, c, z)
    end
    local function region(key, x, y, w, h, enabled)
        regions[#regions + 1] = { key = key, x = ox + x * s, y = height - oy - (y + h) * s, w = w * s, h = h * s,
                                  enabled = enabled ~= false }
    end
    -- z: over an overlay (its buttons at z, z + 1, z + 2)
    local function button(key, label, x, y, w, h, enabled, active, ink, z)
        local hovered = ui.hover == key and enabled ~= false
        local fill = active and color(90, 74, 8) or hovered and color(52, 66, 80) or color(28, 34, 42)
        rect(x, y, w, h, fill, z or 951)
        outline(x, y, w, h, enabled == false and DIM or (active or hovered) and GOLD or color(70, 82, 94), z and z + 1)
        text(label, x + 8, y + (h - 16) / 2, 16, enabled == false and DIM or ink or WHITE, w - 12, false, z and z + 2)
        region(key, x, y, w, h, enabled)
    end

    -- frame
    rect(0, 0, W, H, color(8, 11, 15, math.floor(255 * settings.opacity / 100 + 0.5)), 950)
    outline(0, 0, W, H, GOLD)
    region('panel', 0, 0, W, H, false)
    text('SHODAN STAT EDITOR', 18, 12, 24, GOLD)
    if not MOD.offline then   -- (offline the panel is the window)
        text(hotkey_name .. ' to open/close', W - 56, 16, 15, MUTED, nil, true)
        button('close', 'X', W - 16 - 30, 10, 30, 30, true)
    end
    if rawget(_G, 'SHODAN_PACK_HUB') or rawget(_G, 'SHODAN_SCAN_HUB') then
        text('SHODAN weapon mods are running too: they put their own values back every 5 s', 290, 17, 14, WARN, 540)
    end

    if state.phase ~= 'ready' then
        local found = 0
        for _, kind in ipairs(KIND_ORDER) do if tables[kind] then found = found + 1 end end
        text('Reading the game\'s weapon tables... (' .. found .. ' of ' .. #KIND_ORDER .. ' found)', 18, 70, 18, WHITE)
        return regions
    end

    -- the tabs, each as wide as its (translated) name, the row shrunk to end before the reset button
    do
        local tabs, widths, total = settings.shown_tabs(), {}, 0
        for i, tab in ipairs(tabs) do
            widths[i] = math.max(#tab * 7 + 8, width(tab, 16) + 18)
            total = total + widths[i]
        end
        local room = W - 16 - 124 - 16 - 4 * (#tabs - 1)
        local fit, tab_x = math.min(1, room / total), 16
        for i, tab in ipairs(tabs) do
            local w = math.floor(widths[i] * fit + 0.5)
            button('tab:' .. tab, tab, tab_x, 52, w, 32, true, ui.tab == tab)
            tab_x = tab_x + w + 4
        end
    end
    button('reset_weapon', ui.weapon and (ui.weapon.passive and 'Reset passive' or ui.weapon.player and 'Reset helldiver' or ui.weapon.record and 'Reset record') or 'Reset weapon', W - 16 - 124, 52, 124, 32, ui.weapon ~= nil and modified(ui.weapon))

    -- a list's scroll bar (the weapon list, or the full presets): a thin track between the list and the
    -- line that parts the panel's halves, shown when the list is longer than LIST_ROWS
    ui.lbar, ui.split_gx = nil, ox + 343 * s
    local function list_bar(id, total)
        if total <= LIST_ROWS then return end
        local top, len, span = 96, LIST_ROWS * 26 - 1, total - LIST_ROWS
        local th = math.max(24, len * LIST_ROWS / total)
        local ty = top + (len - th) * math.min(1, (ui[id] - 1) / span)
        rect(336, top, 5, len, color(28, 34, 42), 951)
        local hot = (ui.drag and ui.drag.bar == 'lbar') or ui.hover == 'lbar:thumb'
        rect(336, ty, 5, th, hot and GOLD or color(110, 124, 138), 952)
        region('lbar:track', 335, top, 8, len)
        region('lbar:thumb', 335, ty, 8, th)
        ui.lbar = { id = id, top = height - oy - top * s, bottom = height - oy - (top + len) * s,
                    thumb_top = height - oy - ty * s, thumb = th * s, span = span, page = LIST_ROWS }
    end

    local presets_tab = ui.tab == 'Presets'
    if presets_tab then
        -- full presets: the list holds them by name, the right side the chosen one
        local order, chosen = presets.full_order(), presets.chosen()
        local last_top = math.max(1, #order - LIST_ROWS + 1)
        ui.fpage = math.max(1, math.min(ui.fpage, last_top))
        for k = 1, LIST_ROWS do
            local n = order[ui.fpage + k - 1]
            if not n then break end
            local y, key, preset = 96 + (k - 1) * 26, 'fslot:' .. n, presets.full[n]
            if n == chosen then rect(16, y, 318, 25, color(90, 74, 8), 951)
            elseif ui.hover == key then rect(16, y, 318, 25, color(40, 52, 64), 951) end
            text(preset.name, 24, y + 4, 16, n == chosen and GOLD or WHITE, 214)
            text(#preset.values .. ' value(s)', 326, y + 5, 14, MUTED, 86, true)
            region(key, 16, y, 318, 25)
        end
        if #order == 0 then text('No presets yet.', 24, 100, 16, MUTED) end
        local py = 96 + LIST_ROWS * 26 + 8
        button('fpage:prev', '<', 16, py, 40, 30, ui.fpage > 1)
        text((#order > LIST_ROWS and (ui.fpage .. '-' .. math.min(#order, ui.fpage + LIST_ROWS - 1) .. ' of ') or '') ..
             #order .. ' (max ' .. presets.full_count .. ')', 70, py + 7, 16, MUTED, 214)
        button('fpage:next', '>', 294, py, 40, 30, ui.fpage < last_top)
        list_bar('fpage', #order)
        button('fpreset:new', '+ New preset from current changes', 16, py + 40, 318, 30, #order < presets.full_count)
        rect(343, 96, 2, H - 96 - 70, color(70, 82, 94), 951)

        local x0, preset = 356, chosen and presets.full[chosen]
        if ui.settings then
            -- the Settings page, drawn below
        elseif not preset then
            text('Presets', x0, 94, 22, GOLD)
            text('A preset keeps every change you have made as one set, under a name you choose.', x0, 136, 16, WHITE, W - x0 - 20)
            text('"+ New preset" (or Insert) saves your current changes as one; you name it next.', x0, 162, 16, MUTED, W - x0 - 20)
        else
            local e = ui.editing
            if e and e.n == chosen then
                rect(x0 - 4, 88, 420, 34, color(20, 26, 34), 951)
                outline(x0 - 4, 88, 420, 34, GOLD)
                text(e.text .. '_', x0 + 4, 94, 20, e.fresh and MUTED or WHITE, 404)
                button('name:ok', 'OK', x0 + 426, 88, 70, 34, true)
                button('name:cancel', 'Cancel', x0 + 502, 88, 100, 34, true)
            else
                text(preset.name, x0, 94, 22, GOLD, W - x0 - 20)
            end
            local sure = ui.confirm and ui.confirm.n == chosen and ui.confirm.kind
            button('fpreset:load', 'Load', x0, 136, 100, 32, true)
            button('fpreset:save', sure == 'save' and 'Click again to overwrite' or 'Save current changes here',
                   x0 + 110, 136, 250, 32, true, sure == 'save')
            button('fpreset:rename', 'Rename', x0 + 370, 136, 110, 32, true)
            button('fpreset:delete', sure == 'delete' and 'Sure?' or 'Delete', x0 + 490, 136, 110, 32, true, sure == 'delete')
            text('Now changed: ' .. #overrides .. ' value(s). Loading a preset replaces every current change with it.',
                 x0, 182, 15, MUTED, W - x0 - 20)
            -- what it holds: weapon (or stratagem) and how many of its values
            local y, names, counts = 212, {}, {}
            for _, o in ipairs(preset.values) do
                if not counts[o.hash] then counts[o.hash] = 0; names[#names + 1] = o.hash end
                counts[o.hash] = counts[o.hash] + 1
            end
            if #preset.values == 0 then
                text('No changes: loading it puts every value back to the game\'s.', x0, y, 16, MUTED, W - x0 - 20)
            else
                text(#preset.values .. ' value(s) for ' .. #names .. ' weapon(s) / stratagem(s):', x0, y, 16, WHITE)
            end
            y = y + 28
            local room = math.floor((H - 110 - y) / 22)
            for k, hash in ipairs(names) do
                if k == room and #names > room then
                    text('+ ' .. (#names - room + 1) .. ' more', x0, y, 15, MUTED)
                    break
                end
                local weapon = by_hash[hash]
                text(weapon and weapon.name or ('unknown ' .. hash), x0, y, 15, weapon and WHITE or WARN, 480)
                text(counts[hash] .. ' value(s)', W - 24, y, 15, MUTED, 120, true)
                y = y + 22
            end
            text('Saved as StatEditor\\preset_' .. string.format('%02d', chosen) .. '.txt (copy it to share the set).',
                 x0, H - 100, 14, DIM, W - x0 - 20)
        end
    end

    -- weapon list
    local searching = ui.search.text ~= '' or ui.search.active
    local list = presets_tab and {} or weapons_in(ui.search.text ~= '' and '?search' or ui.tab)
    local last_top = math.max(1, #list - LIST_ROWS + 1)
    ui.page = math.max(1, math.min(ui.page, last_top))
    for k = 1, LIST_ROWS do
        local weapon = list[ui.page + k - 1]
        if not weapon then break end
        local y = 96 + (k - 1) * 26
        local key = 'weapon:' .. weapon.hash
        if searching then text(weapon.slot, 326, y + 5, 13, DIM, 80, true) end
        local selected = weapon == ui.weapon
        if selected then rect(16, y, 318, 25, color(90, 74, 8), 951)
        elseif ui.hover == key then rect(16, y, 318, 25, color(40, 52, 64), 951) end
        local changed = modified(weapon)
        -- a stratagem: its number as an extra stratagem after its name
        if (weapon.stratagem or weapon.sentry_defs) and not MOD.extra.list then MOD.extra.choices() end
        local id = weapon.extra_id and ' (' .. weapon.extra_id .. ')' or ''
        text((changed and '* ' or '') .. settings.tr(weapon.name) .. id, 24, y + 4, 16, changed and GOLD or WHITE, searching and 226 or 302)
        region(key, 16, y, 318, 25)
    end
    local py = 96 + LIST_ROWS * 26 + 8
    if not presets_tab then
        if ui.search.text ~= '' and #list == 0 then text('Nothing matches.', 24, 100, 16, MUTED) end
        button('page:prev', '<', 16, py, 40, 30, ui.page > 1)
        list_bar('page', #list)
        text((#list > LIST_ROWS and (ui.page .. '-' .. math.min(#list, ui.page + LIST_ROWS - 1) .. ' of ') or '') ..
             #list .. (ui.search.text ~= '' and ' found' or ' listed'),
             70, py + 7, 16, MUTED, 214)
        button('page:next', '>', 294, py, 40, 30, ui.page < last_top)
        -- search box: click it (or Ctrl+F) and type; the list shows what matches, from every tab
        local sy, active = py + 40, ui.search.active
        rect(16, sy, 274, 30, active and color(20, 26, 34) or color(28, 34, 42), 951)
        outline(16, sy, 274, 30, active and GOLD or (ui.hover == 'search' and GOLD or color(70, 82, 94)))
        if ui.search.text == '' and not active then
            text('Search weapons and stratagems', 24, sy + 7, 15, DIM, 258)
        else
            text(ui.search.text .. (active and '_' or ''), 24, sy + 6, 16, WHITE, 258)
        end
        region('search', 16, sy, 274, 30)
        button('search:clear', 'X', 296, sy, 38, 30, ui.search.text ~= '')
        rect(343, 96, 2, H - 96 - 70, color(70, 82, 94), 951)
    end

    -- stats of the selected weapon
    local weapon = ui.weapon
    local x0 = 356
    if ui.settings then
        text('Settings', x0, 94, 22, GOLD)
        local y = 132
        local function choice(label, key, options, current)
            text(label, x0, y + 6, 16, WHITE, 270)
            for k, o in ipairs(options) do
                button('set:' .. key .. ':' .. tostring(o[1]), o[2], 640 + (k - 1) * 64, y, 60, 28, true, o[1] == current)
            end
            y = y + 36
        end
        local ONOFF = { { 'on', 'On' }, { 'off', 'Off' } }
        local function onoff(v) return v and 'on' or 'off' end
        if MOD.offline then
            text('Language', x0, y + 6, 16, WHITE, 270)
            local options = { { id = 'en', name = 'English' } }
            for _, l in ipairs(MOD.langs or {}) do options[#options + 1] = l end
            for k, l in ipairs(options) do
                button('set:lang:' .. l.id, l.name, 640 + (k - 1) * 86, y, 82, 28, true, settings.lang == l.id)
            end
        else
            text('Open / close key', x0, y + 6, 16, WHITE, 270)
            button('set:bind', ui.binding and 'Press a key (Esc cancels)' or hotkey_name, 640, y, ui.binding and 316 or 124, 28, true, ui.binding)
        end
        y = y + 36
        -- offline (the panel is the window, edits go into the game's files) only the rows that apply there
        if not MOD.offline then choice('Block game input while open', 'block_input', ONOFF, onoff(settings.block_input)) end
        choice('Apply my changes', 'changes', ONOFF, onoff(settings.changes))
        text(settings.changes and ('On: your ' .. #overrides .. ' change(s) are applied.')
             or ('Off: the game\'s values everywhere; your ' .. #overrides .. ' change(s) are kept for when you turn them on.'),
             x0 + 16, y - 6, 14, settings.changes and MUTED or WARN, W - x0 - 40)
        y = y + 14
        local function percent(label, key)
            text(label, x0, y + 6, 16, WHITE, 270)
            local r = settings.RANGE[key]
            button('set:' .. key .. ':down', '<', 640, y, 36, 28, settings[key] > r[1])
            local typing = ui.value and ui.value.setting == key
            if typing or ui.hover == 'value:' .. key then
                rect(680, y, 80, 28, typing and color(20, 26, 34) or color(40, 52, 64), 951)
                outline(680, y, 80, 28, GOLD)
            end
            text(typing and (ui.value.text .. '_') or (settings[key] .. '%'), 754, y + 6, 17, WHITE, 70, true)
            region('value:' .. key, 680, y, 80, 28)
            button('set:' .. key .. ':up', '>', 764, y, 36, 28, settings[key] < r[2])
            y = y + 36
        end
        if not MOD.offline then
            percent('Panel size', 'size')
            choice('Panel side', 'side', { { 'left', 'Left' }, { 'right', 'Right' } }, settings.side)
            percent('Background opacity', 'opacity')
        end
        choice('Remember last tab and weapon', 'remember', ONOFF, onoff(settings.remember))
        if MOD.offline then   -- wider buttons than choice()'s: 'Automatic', 'Every commit' in every language
            text('Updates', x0, y + 6, 16, WHITE, 270)
            for k, o in ipairs({ { 'ask', 'Ask' }, { 'auto', 'Automatic' } }) do
                button('set:updates:' .. o[1], o[2], 640 + (k - 1) * 134, y, 130, 28, true, settings.updates == o[1])
            end
            y = y + 36
            text('Update channel', x0, y + 6, 16, WHITE, 270)
            for k, o in ipairs({ { 'releases', 'Releases' }, { 'commits', 'Every commit' } }) do
                button('set:update_channel:' .. o[1], o[2], 640 + (k - 1) * 134, y, 130, 28, true,
                       settings.update_channel == o[1])
            end
            text(settings.update_channel == 'commits' and 'Every change as soon as it is pushed, before testing: it may break.'
                 or 'Tested releases only.', x0 + 16, y + 34, 14, settings.update_channel == 'commits' and WARN or MUTED,
                 W - x0 - 40)
            y = y + 56
        end
        local arc = settings.arc
        if not MOD.offline then
        choice('Arc chain edits in multiplayer', 'arc_mp', ONOFF, onoff(settings.arc_mp))
        text('(untested) ' .. (arc.state:find('^unavailable') and ('Arc chains: player count ' .. arc.state .. '; your values stay.')
             or arc.paused and "Other players are in your game: arc chain length / split use the game's values."
             or settings.arc_mp and 'On: your arc chain length / split apply with other players too (arcs can stay on screen).'
             or "Off: with other players, arc chain length / split use the game's values (else arcs can stay on screen)."),
             x0 + 16, y - 6, 14, arc.paused and WARN or MUTED, W - x0 - 40)
        y = y + 14
        end
        local notes, warn = {}, false
        choice('Several vehicles of a kind', 'vehicles', ONOFF, onoff(MOD.vehicles.on))
        text('On: a loadout can take more than one exosuit, FRV or tank.', x0 + 16, y - 6, 14, MUTED, W - x0 - 40)
        y = y + 14
        if not MOD.offline then   -- (the game's item list exists only while it runs)
        choice('Unlock unused items', 'unlock_all', ONOFF, onoff(settings.unlock_any()))
        local names = {}
        for _, item in ipairs(settings.UNLOCKS) do
            names[#names + 1] = item.name
            local state = settings.unlock.state[item.id] or 'off'
            if state ~= 'on' and state ~= 'off' then
                notes[#notes + 1] = item.name .. ': ' .. state
                warn = warn or state:find('^unavailable') ~= nil
            end
        end
        text(table.concat(names, ', ') .. ': in the game files, not offered by it.', x0 + 16, y - 6, 14, MUTED, W - x0 - 40)
        text(#notes > 0 and table.concat(notes, '; ') .. '.' or 'On: in your armory / stratagem list.',
             x0 + 16, y + 12, 14, warn and WARN or MUTED, W - x0 - 40)
        y = y + 32
        end
        -- the tabs: each on / off, wrapped under the label (one stays on)
        text('Tabs shown', x0, y + 6, 16, WHITE, 270)
        local tx = 640
        for _, tab in ipairs(TABS) do
            local w = math.max(#tab * 7 + 8, width(tab, 15) + 18)
            if tx + w > W - 16 then tx, y = 640, y + 34 end
            button('set:tab:' .. tab, tab, tx, y, w, 28, true, not settings.hidden[tab])
            tx = tx + w + 4
        end
        y = y + 42
        local sure_reset = ui.confirm and ui.confirm.kind == 'reset_all'
        button('reset_all', sure_reset and 'Sure?' or 'Reset all values', x0, y, 188, 28, #overrides > 0, sure_reset)
        text('Resets all values from the current preset to default.', x0 + 16, y + 30, 14, MUTED, W - x0 - 40)
        y = y + 50
        y = y + 16
        rect(x0, y, W - x0 - 16, 1, color(70, 82, 94), 951)
        y = y + 14
        text(MOD.title .. ' v' .. MOD.version, x0, y, 18, GOLD)
        text('Made by SHODAN', x0, y + 30, 16, WHITE)
        if not MOD.offline then text('Bingus Shared Loader by CowboyBingus', x0, y + 54, 16, MUTED) end
        y = y + (MOD.offline and 68 or 92)
        text('GitHub', x0, y + 6, 16, WHITE)
        text(settings.GITHUB:gsub('^https://', ''), x0 + 90, y + 7, 15, MUTED, 340)
        button('link:github_open', 'Open', 800, y, 88, 28, true)
        button('link:github_copy', 'Copy', 896, y, 88, 28, true)
        y = y + 36
        local log_dir = (data_dir('Logs') or ''):gsub('/', '\\')
        -- offline the editor's own folder holds the presets, config and Logs: that folder
        text(MOD.offline and 'Logs and Presets' or 'Log file', x0, y + 6, 16, WHITE)
        button('link:log_copy', 'Copy', 800, y, 88, 28, true)
        button('link:log_open', 'Folder', 896, y, 88, 28, true)
        text(MOD.offline and (data_dir('StatEditor') or ''):gsub('/', '\\') or log_dir .. '\\' .. MOD.log,
             x0, y + 36, 14, MUTED, W - x0 - 16)
    elseif presets_tab then
        -- drawn above
    elseif not weapon then
        text('Choose a weapon on the left.', x0, 100, 18, MUTED)
    else
        text(weapon.name, x0, 94, 22, GOLD, W - x0 - 20)
        local y, section = 126, nil
        if weapon.note ~= '' then
            text(weapon.note, x0, 122, 14, WARN, W - x0 - 20)
            y = 144
        end
        -- rows get closer together when there are too many to fit at full spacing; past 22 units
        -- apart the list scrolls (Up/Down follow the chosen row; buttons below page through it)
        local sections, below = 0, 0
        for n, row in ipairs(weapon.rows) do
            if n == 1 or row.section ~= weapon.rows[n - 1].section then sections = sections + 1 end
            below = below + (row.after_h or 0)
        end
        -- this weapon's presets, under its stats
        local sy = H - 70 - 34
        text('PRESETS', x0, sy + 8, 15, MUTED)
        for n = 1, presets.weapon_count do
            local saved = presets.weapon_preset(weapon, n)
            button('wslot:' .. n, tostring(n), x0 + 76 + (n - 1) * 46, sy, 40, 30, true, n == ui.wslot, saved and GOLD)
        end
        local chosen = presets.weapon_preset(weapon, ui.wslot)
        button('wpreset:save', 'Save', x0 + 316, sy, 90, 30, true)
        button('wpreset:load', 'Load', x0 + 412, sy, 90, 30, chosen ~= nil)
        button('wpreset:clear', 'Clear', x0 + 508, sy, 90, 30, chosen ~= nil)
        local bottom = H - 70 - 40
        -- an armor passive (offline): the passives stacked on it, under its rows
        local stack_id = MOD.offline and weapon.passive and tables[weapon.passive] and tables[weapon.passive].index.id
        local stack_list = stack_id and (settings.stacks[stack_id] or {})
        if stack_list then bottom = bottom - (36 + 34 * (#stack_list + 2)) end
        local pitch = math.floor((bottom - y - sections * 24 - below) / math.max(1, #weapon.rows))
        local scrolling = pitch < 22
        if scrolling then
            pitch, bottom = 24, bottom - 36
            ui.scroll = math.max(1, math.min(ui.scroll, #weapon.rows))
        else
            pitch, ui.scroll = math.min(26, pitch), 1
        end
        ui.last_visible = #weapon.rows
        local top = y
        for n, row in ipairs(weapon.rows) do
            if n >= ui.scroll then
                if y + pitch + (row.section ~= section and 24 or 0) + (row.after_h or 0) > bottom then
                    ui.last_visible = n - 1
                    break
                end
                if row.section ~= section then
                    section = row.section
                    local note, others = row.note or '', shared_with(weapon, row)
                    if type(note) == 'function' then note, others = note(others), {} end
                    -- the note after the section's name (long ones: 'PARTIAL CHARGE EXPLOSION')
                    local nx = math.max(110, #section * 10 + 14)
                    local room, shown = W - x0 - 20 - nx, 0
                    if note == '' and #others > 0 then
                        -- as many names (up to 3) as fit at full size, then '+N' (one name at least)
                        for k = math.min(3, #others), 1, -1 do
                            shown = k
                            note = 'shared with ' .. table.concat(others, ', ', 1, k) ..
                                   (#others > k and (' +' .. (#others - k)) or '')
                            if k == 1 or not ink_font or width(note, 14 * s) <= room * s then break end
                        end
                    end
                    text(section:upper(), x0, y + 4, 15, MUTED)
                    if note ~= '' then text(note, x0 + nx, y + 4, 14, WARN, room) end
                    -- a list cut short: hovering it shows every name
                    if #others > shown then   -- (a note of its own lists none)
                        local key = 'shared_' .. n
                        region(key, x0 + nx, y, W - x0 - 20 - nx, 22)
                        if ui.hover == key then shared_overlay = { names = others, y = y + 24, x = x0 + nx } end
                    end
                    y = y + 24
                end
                local value, default = row_value(row), row_value(row, true)
                local changed = value ~= nil and default ~= nil and math.abs(value - default) > 1e-4
                local focus = n == ui.row
                local bh = pitch - 3
                if focus then rect(x0 - 6, y - 1, W - x0 - 10, pitch - 1, color(30, 38, 48), 951) end
                local label = row.label
                if row.label_of then label = row.label_of() end
                text(label, x0, y + bh / 2 - 8, 16, focus and GOLD or WHITE, 236)
                if row.tip then
                    text('(?)', x0 + math.min(width(label, 16), 236) + 6, y + bh / 2 - 7, 14, DIM)
                    if ui.hover == 'row:' .. n then tip_overlay = { lines = row.tip, x = x0, y = y + bh + 2 } end
                end
                text(changed and ('was ' .. fmt(default, row.storage)) or '', 690, y + bh / 2 - 7, 14, DIM, 90, true)
                local typing = ui.value and ui.value.n == n and ui.value.weapon == weapon
                if typing or (ui.hover == 'value:' .. n and value ~= nil) then
                    rect(696, y, 88, bh, typing and color(20, 26, 34) or color(40, 52, 64), 951)
                    outline(696, y, 88, bh, GOLD)
                end
                if typing then
                    text(ui.value.text .. '_', 780, y + bh / 2 - 8, 17, WHITE, 84, true)
                else
                    text(fmt(value, row.storage), 780, y + bh / 2 - 8, 17, changed and GOLD or WHITE, 84, true)
                end
                local ok = value ~= nil
                button('dec_big:' .. n, '--', 790, y, 40, bh, ok)
                button('dec:' .. n, '-', 834, y, 36, bh, ok)
                button('inc:' .. n, '+', 874, y, 36, bh, ok)
                button('inc_big:' .. n, '++', 914, y, 40, bh, ok)
                button('reset:' .. n, 'R', 958, y, 26, bh, changed)
                region('row:' .. n, x0 - 6, y - 1, 430, pitch - 1)
                region('value:' .. n, 696, y, 88, bh, ok)
                y = y + pitch
                for k, line in ipairs(row.after or {}) do text(line, x0, y + 2 + (k - 1) * 16, 14, MUTED, W - x0 - 20) end
                y = y + (row.after_h or 0)
            end
        end
        ui.sbar, ui.last_page = nil, nil
        if scrolling then
            -- scroll bar: a thin track at the panel's right edge, its thumb the part in view (drag it,
            -- or click the track to page)
            local len, total = bottom - top, #weapon.rows
            local shown = math.max(1, ui.last_visible - ui.scroll + 1)
            -- the furthest scroll: the first row of the last page, counted from the end (a page's section
            -- headers take room, so the page in view says nothing about how many rows the last one holds)
            local last_page, changes, under = total, 0, weapon.rows[total].after_h or 0
            for n = total - 1, 1, -1 do
                if weapon.rows[n + 1].section ~= weapon.rows[n].section then changes = changes + 1 end
                under = under + (weapon.rows[n].after_h or 0)
                if (total - n + 1) * pitch + 24 * (1 + changes) + under > len then break end
                last_page = n
            end
            local span = math.max(1, last_page - 1)
            ui.last_page = last_page
            local th = math.max(24, math.min(len, len * shown / total))
            local ty = top + (len - th) * math.min(1, (ui.scroll - 1) / span)
            rect(989, top, 5, len, color(28, 34, 42), 951)
            local hot = (ui.drag and ui.drag.bar == 'sbar') or ui.hover == 'sbar:thumb'
            rect(989, ty, 5, th, hot and GOLD or color(110, 124, 138), 952)
            region('sbar:track', 986, top, 12, len)
            region('sbar:thumb', 986, ty, 12, th)
            ui.sbar = { id = 'scroll', top = height - oy - top * s, bottom = height - oy - (top + len) * s,
                        thumb_top = height - oy - ty * s, thumb = th * s, span = span }
            text(string.format('rows %d-%d of %d', ui.scroll, ui.last_visible, #weapon.rows), x0, bottom + 12, 15, MUTED)
            button('scroll:up', 'Up', 790, bottom + 6, 80, 26, ui.scroll > 1)
            button('scroll:down', 'Down', 874, bottom + 6, 80, 26, ui.last_visible < #weapon.rows)
        end
        if stack_list then
            y = (scrolling and bottom + 36 or y) + 12
            text('ALSO INCLUDES', x0, y + 4, 15, MUTED)
            text('Every armor with this passive gets their effects too (set on their own pages).',
                 x0 + 150, y + 4, 14, MUTED, W - x0 - 170)
            y = y + 26
            -- its own effects: on (the rows above) or off (only the passives below apply)
            local own = not settings.own_off[stack_id]
            text('Own effects', x0, y + 6, 16, WHITE, 140)
            text(own and 'Its stats above apply.' or 'Off: its stats above are left out; only the passives below apply.',
                 x0 + 150, y + 7, 14, own and MUTED or WARN, 800 - x0 - 160)
            button('stack_own:on', 'On', 800, y, 88, 28, true, own)
            button('stack_own:off', 'Off', 896, y, 88, 28, true, not own)
            y = y + 34
            for _, id in ipairs(stack_list) do
                local other = by_hash[string.format('FFFFFFFE%08X', id)]
                text(other and other.name or ('Passive ' .. id), x0, y + 6, 16, WHITE, 420)
                button('stack_open:' .. id, 'Open', 800, y, 88, 28, other ~= nil)
                button('stack_del:' .. id, 'Remove', 896, y, 88, 28, true)
                y = y + 34
            end
            button('stack_pick', '+ Add passive', x0, y, 188, 28, true)
        end
    end

    -- footer, and the Settings button at the bottom right
    rect(16, H - 64, W - 32, 1, color(70, 82, 94), 951)
    button('presets', 'Presets', W - 16 - 104 - 8 - 104, H - 54, 104, 34, true, ui.tab == 'Presets' and not ui.settings)
    button('settings', ui.settings and 'Back' or 'Settings', W - 16 - 104, H - 54, 104, 34, true, ui.settings)
    if ui.binding then
        text('Press the key that should open and close the panel: F1-F12, Insert, Home, End, Pause or Scroll Lock. Esc cancels.',
             18, H - 56, 14, MUTED, W - 260)
    elseif ui.settings then
        text('Settings are saved at once, in config.txt with your changes.', 18, H - 56, 14, MUTED, W - 260)
    elseif ui.editing then
        text('Type the name: Enter keeps it, Esc cancels. The game sees these keys too, so name presets from a menu.',
             18, H - 56, 14, MUTED, W - 260)
    elseif ui.value and ui.value.setting then
        local r = settings.RANGE[ui.value.setting]
        text(string.format('Type the percent (%d-%d): Enter sets it, Esc cancels.', r[1], r[2]), 18, H - 56, 14, MUTED, W - 260)
    elseif ui.value then
        text('Type the value: Enter sets it, Esc cancels. Values out of range are set to the nearest allowed one.',
             18, H - 56, 14, MUTED, W - 260)
    elseif ui.search.active and not presets_tab then
        text('Type to search: Enter keeps the results, Esc clears the search. The game sees these keys too.',
             18, H - 56, 14, MUTED, W - 260)
    elseif presets_tab then
        text('Up/Down choose, Enter loads, Insert makes a new one, Shift+Insert saves into it, F2 renames, Del deletes.',
             18, H - 56, 14, MUTED, W - 260)
    else
        text('Up/Down choose a stat, Left/Right change it (Shift: bigger steps), click a value or press Enter to type it,',
             18, H - 56, 14, MUTED, W - 260)
    end
    if ui.message then
        text(ui.message.text, 18, H - 34, 14, GOOD, W - 260)
    elseif presets_tab then
        text('Overwriting and deleting ask twice. Changes apply at once and are saved; ' .. #overrides ..
             ' value(s) changed.', 18, H - 34, 14, MUTED, W - 260)
    else
        text('PgUp/PgDn change weapon, Del resets, Ctrl+1-5 loads a weapon preset, Ctrl+Shift+1-5 saves one; ' .. #overrides ..
             ' value(s) changed.', 18, H - 34, 14, MUTED, W - 260)
    end
    -- the passives to stack on the chosen one: over its page, until one is chosen (Cancel / Esc: none)
    if ui.stack_pick and ui.stack_pick == weapon and not ui.settings then
        local target = tables[weapon.passive] and tables[weapon.passive].index.id
        local taken = { [target or -1] = true }
        for _, id in ipairs(settings.stacks[target] or {}) do taken[id] = true end
        local choices = {}
        for _, w in ipairs(weapons) do
            local t = w.passive and tables[w.passive]
            if t and not taken[t.index.id] then choices[#choices + 1] = { id = t.index.id, name = w.name } end
        end
        table.sort(choices, function(a, b) return a.name:lower() < b.name:lower() end)
        local x, y, w, h = 350, 84, W - 360, H - 104 - 84 - 8   -- (above the presets row)
        rect(x, y, w, h, color(8, 11, 15), 958)
        outline(x, y, w, h, GOLD, 959)
        region('stack_modal', x, y, w, h, false)
        text('Add a passive to ' .. weapon.name, x + 16, y + 14, 20, GOLD, w - 32, false, 960)
        text('Its effects are added to every armor with this passive.', x + 16, y + 44, 14, MUTED, w - 32, false, 960)
        local cols, bw = 3, math.floor((w - 32 - 16) / 3)
        for k, c in ipairs(choices) do
            local col, row = (k - 1) % cols, math.floor((k - 1) / cols)
            button('stack_add:' .. c.id, c.name, x + 16 + col * (bw + 8), y + 74 + row * 34, bw, 30, true, false, nil, 961)
        end
        if #choices == 0 then text('Every passive is in already.', x + 16, y + 80, 16, MUTED, w - 32, false, 960) end
        button('stack_cancel', 'Cancel', x + w - 16 - 104, y + h - 16 - 30, 104, 30, true, false, nil, 961)
    end
    -- a hovered row's tip, under it (above it near the bottom)
    if tip_overlay then
        local w, h = 0, #tip_overlay.lines * 18 + 16
        for _, line in ipairs(tip_overlay.lines) do w = math.max(w, width(line, 15)) end
        w = math.min(w + 24, W - 32)
        local x = math.max(16, math.min(tip_overlay.x, W - 16 - w))
        local y = tip_overlay.y
        if y + h > H - 70 then y = math.max(56, tip_overlay.y - 30 - h) end
        rect(x, y, w, h, color(8, 11, 15), 958)
        rect(x, y, w, 2, GOLD, 959); rect(x, y + h - 2, w, 2, GOLD, 959)
        rect(x, y, 2, h, GOLD, 959); rect(x + w - 2, y, 2, h, GOLD, 959)
        for k, line in ipairs(tip_overlay.lines) do text(line, x + 12, y + 8 + (k - 1) * 18, 15, WHITE, w - 24, false, 960) end
    end
    -- every entry a hovered 'shared with' list names, in columns, over the rows below it (above, near the bottom)
    if shared_overlay then
        local names = {}
        for k, name in ipairs(shared_overlay.names) do names[k] = name end
        table.sort(names, function(a, b) return a:lower() < b:lower() end)
        local col_w, pitch = 230, 20
        local cols = math.min(4, math.max(1, math.ceil(#names / 12)))
        local rows = math.min(math.ceil(#names / cols), math.floor((H - 160) / pitch))
        local shown = math.min(#names, cols * rows)
        if shown < #names then shown = shown - 1 end
        local w, h = cols * col_w + 24, rows * pitch + 46
        local x = math.max(16, math.min(shared_overlay.x, W - 16 - w))
        local y = shared_overlay.y
        if y + h > H - 70 then y = math.max(56, shared_overlay.y - 24 - h - 4) end
        rect(x, y, w, h, color(8, 11, 15), 958)
        rect(x, y, w, 2, GOLD, 959); rect(x, y + h - 2, w, 2, GOLD, 959)
        rect(x, y, 2, h, GOLD, 959); rect(x + w - 2, y, 2, h, GOLD, 959)
        text('Also changes (' .. #names .. '):', x + 12, y + 10, 15, MUTED, w - 24, false, 960)
        for k = 1, shown do
            local c, r = math.floor((k - 1) / rows), (k - 1) % rows
            text(names[k], x + 12 + c * col_w, y + 36 + r * pitch, 15, WHITE, col_w - 12, false, 960)
        end
        if shown < #names then
            text('+' .. (#names - shown) .. ' more', x + 12 + (cols - 1) * col_w, y + 36 + (rows - 1) * pitch, 15, DIM,
                 col_w - 12, false, 960)
        end
    end
    return regions
end

local function hit(x, y, enabled_only)
    for k = #ui.regions, 1, -1 do
        local r = ui.regions[k]
        if x >= r.x and x < r.x + r.w and y >= r.y and y < r.y + r.h then
            if enabled_only and not r.enabled then return nil end
            return r.key
        end
    end
    return nil
end

local function click(key)
    if not key then return end
    local weapon = ui.weapon
    local kind, arg = key:match('^([%w_]+):?(.*)$')
    -- clicking anything else while naming keeps the name typed so far
    if ui.editing and kind ~= 'name' then presets.finish_rename(true) end
    if ui.search.active and kind ~= 'search' then ui.search.active = false end
    if ui.value and key ~= 'value:' .. ui.value.n then finish_value(true) end
    if kind ~= 'set' then ui.binding = nil end
    if kind == 'tab' then
        ui.tab, ui.page, ui.search, ui.settings = arg, 1, { text = '', active = false }, false
        if settings.remember and state.phase == 'ready' and settings.last_tab ~= arg then
            settings.last_tab = arg
            mark_config_dirty()
        end
    elseif kind == 'close' then ui.close_request = true   -- closed by tick, once this frame is done
    elseif kind == 'settings' then ui.settings = not ui.settings
    elseif kind == 'presets' then   -- Presets, or back to the tab before them
        if ui.tab == 'Presets' and not ui.settings then ui.tab = ui.before_presets or settings.shown_tabs()[1] or 'Primary'
        elseif ui.tab ~= 'Presets' then ui.before_presets, ui.tab = ui.tab, 'Presets' end
        ui.page, ui.search, ui.settings = 1, { text = '', active = false }, false
    elseif kind == 'value' and (arg == 'size' or arg == 'opacity') then
        if not ui.value then ui.value = { n = arg, setting = arg, text = tostring(settings[arg]), fresh = true } end
    elseif kind == 'set' then
        local name, value = arg:match('^([%w_]+):?(.*)$')
        if name == 'bind' then ui.binding = not ui.binding or nil
        elseif name == 'changes' then settings.set_changes(value == 'on')
        elseif name == 'block_input' or name == 'remember' then settings[name] = value == 'on'
        elseif name == 'updates' and (value == 'ask' or value == 'auto') then settings.updates = value
        elseif name == 'update_channel' and (value == 'releases' or value == 'commits') then settings.update_channel = value
        elseif name == 'arc_mp' then settings.arc_mp, settings.arc.next_check = value == 'on', 0
        elseif name == 'vehicles' then
            MOD.vehicles.on = value == 'on'; MOD.vehicles.apply()
        elseif name == 'unlock_all' then
            settings.unlock_all(value == 'on'); settings.unlock.next_check = 0
        elseif name:find('^unlock_') then
            settings.unlocks[name:sub(8)], settings.unlock.next_check = value == 'on', 0
        elseif (name == 'size' or name == 'opacity') and (value == 'up' or value == 'down') then
            local v = settings[name]
            settings.set_percent(name, value == 'up' and math.floor(v / 5) * 5 + 5 or math.ceil(v / 5) * 5 - 5)
        elseif name == 'size' or name == 'opacity' then settings.set_percent(name, tonumber(value) or settings[name])
        elseif name == 'side' then settings.side = value
        elseif name == 'tab' then
            local on = 0
            for _, tab in ipairs(TABS) do if not settings.hidden[tab] then on = on + 1 end end
            if settings.hidden[value] then settings.hidden[value] = nil
            elseif on > 1 then settings.hidden[value] = true end
            if settings.hidden[ui.tab] then ui.tab, ui.page = settings.shown_tabs()[1], 1 end
        elseif name == 'lang' and (value == 'en' or settings.LANGS[value]) then
            local chinese = settings.lang == 'zh-Hans' or value == 'zh-Hans'
            settings.lang = value
            if chinese then MOD.records.refresh() end
        end
        if name ~= 'bind' then mark_config_dirty(); ui.version = ui.version + 1 end
    elseif kind == 'link' then
        local log_file = (data_dir('Logs') or '') .. '/' .. MOD.log
        local done
        -- offline: the editor's own folder (presets, config, Logs)
        local home = MOD.offline and (data_dir('StatEditor') or ''):gsub('/', '\\')
        if arg == 'github_open' then done = settings.open(settings.GITHUB) and 'Opened the GitHub page in your browser.'
        elseif arg == 'github_copy' then done = settings.copy(settings.GITHUB) and 'GitHub link copied.'
        elseif arg == 'log_copy' and home then done = settings.copy(home) and 'Folder path copied.'
        elseif arg == 'log_open' and home then done = settings.open(home) and 'Opened the folder.'
        elseif arg == 'log_copy' then done = settings.copy((log_file:gsub('/', '\\'))) and 'Log file path copied.'
        elseif arg == 'log_open' then done = settings.open((data_dir('Logs') or ''):gsub('/', '\\')) and 'Opened the log folder.' end
        ui.message = { text = done or 'That did not work; see the log.', till = api.now() + 4 }
    elseif kind == 'search' then
        if arg == 'clear' then ui.search, ui.page = { text = '', active = false }, 1
        else ui.search.active = true end
    elseif kind == 'weapon' then select_weapon(by_hash[arg])
    elseif kind == 'page' then ui.page = math.max(1, ui.page + (arg == 'next' and LIST_ROWS or -LIST_ROWS))
    elseif kind == 'reset_all' then
        if not (ui.confirm and ui.confirm.kind == 'reset_all') then
            ui.confirm = { kind = 'reset_all', till = api.now() + 3 }
        else
            ui.confirm = nil
            reset_all()
        end
    elseif kind == 'reset_weapon' and weapon then reset_weapon(weapon)
    elseif kind == 'wslot' then ui.wslot = tonumber(arg) or 1
    elseif kind == 'wpreset' and weapon then
        if arg == 'save' then presets.save_weapon_preset(weapon, ui.wslot)
        elseif arg == 'load' then presets.load_weapon_preset(weapon, ui.wslot)
        elseif arg == 'clear' then presets.clear_weapon_preset(weapon, ui.wslot) end
    elseif kind == 'fslot' then ui.fslot = tonumber(arg)
    elseif kind == 'fpage' then ui.fpage = math.max(1, ui.fpage + (arg == 'next' and LIST_ROWS or -LIST_ROWS))
    elseif kind == 'name' then presets.finish_rename(arg == 'ok')
    elseif kind == 'fpreset' then
        local n = presets.chosen()
        if arg == 'new' then presets.new_full_preset()
        elseif n and arg == 'load' then presets.load_full_preset(n)
        elseif n and arg == 'save' then presets.confirm('save', n)
        elseif n and arg == 'delete' then presets.confirm('delete', n)
        elseif n and arg == 'rename' then presets.start_rename(n) end
    elseif kind == 'stack_pick' and weapon then ui.stack_pick = weapon
    elseif kind == 'stack_cancel' then ui.stack_pick = nil
    elseif kind == 'stack_own' and weapon and weapon.passive and tables[weapon.passive] then
        local id = tables[weapon.passive].index.id
        if (arg == 'off') ~= (settings.own_off[id] == true) then
            settings.own_off[id] = arg == 'off' or nil
            state.writes = state.writes + 1   -- (the host: changed since the last install)
            mark_config_dirty()
            log('passive own effects: ' .. weapon.name .. ' ' .. arg)
        end
    elseif (kind == 'stack_add' or kind == 'stack_del') and weapon and weapon.passive and tables[weapon.passive] then
        local target, id = tables[weapon.passive].index.id, tonumber(arg)
        local list, kept = settings.stacks[target] or {}, {}
        for _, other in ipairs(list) do if other ~= id then kept[#kept + 1] = other end end
        if kind == 'stack_add' and id ~= target then kept[#kept + 1] = id end
        settings.stacks[target] = #kept > 0 and kept or nil
        ui.stack_pick = nil
        state.writes = state.writes + 1   -- (the host: changed since the last install)
        mark_config_dirty()
        local other = by_hash[string.format('FFFFFFFE%08X', id)]
        log('passive stack: ' .. weapon.name .. (kind == 'stack_add' and ' + ' or ' - ') .. (other and other.name or id))
    elseif kind == 'stack_open' then
        local other = by_hash[string.format('FFFFFFFE%08X', tonumber(arg) or 0)]
        if other then select_weapon(other) end
    elseif kind == 'scroll' and weapon then
        local page = math.max(1, (ui.last_visible or ui.scroll) - ui.scroll)
        ui.scroll = math.max(1, math.min(#weapon.rows, ui.scroll + (arg == 'down' and page or -page)))
    elseif weapon and tonumber(arg) and weapon.rows[tonumber(arg)] then
        local row = weapon.rows[tonumber(arg)]
        ui.row = tonumber(arg)
        if kind == 'dec' then change(row, -1, false)
        elseif kind == 'dec_big' then change(row, -1, true)
        elseif kind == 'inc' then change(row, 1, false)
        elseif kind == 'inc_big' then change(row, 1, true)
        elseif kind == 'reset' then reset_row(weapon, row)
        elseif kind == 'value' and not ui.value and row_value(row) ~= nil then
            ui.value = { n = tonumber(arg), weapon = weapon, text = fmt(row_value(row), row.storage), fresh = true }
        end
    end
end

-- Keyboard: presses, and repeats while held (after 0.4 s, every 0.08 s).
local held = {}
local function pressed(name, now)
    local down = key_down(VK[name])
    local h = held[name]
    if not down then held[name] = nil; return false end
    if not h then held[name] = { next = now + 0.4 }; return true end
    if now >= h.next then h.next = now + 0.08; return true end
    return false
end

local function keyboard(now)
    local weapon = ui.weapon
    if ui.binding then
        if pressed('Escape', now) then ui.binding = nil; return end
        for _, name in ipairs({ 'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9', 'F10', 'F11', 'F12',
                                'Insert', 'Home', 'End', 'Pause', 'ScrollLock' }) do
            if pressed(name, now) then
                hotkey_name, ui.binding, ui.hotkey_hold = name, nil, true
                mark_config_dirty()
                ui.message = { text = 'The panel now opens and closes with ' .. name .. '.', till = now + 4 }
                log('settings: hotkey ' .. name)
                return
            end
        end
        return
    end
    if ui.editing then
        if pressed('Escape', now) then presets.finish_rename(false); return end
        if pressed('Enter', now) then presets.finish_rename(true); return end
        if pressed('Backspace', now) then presets.type_char(false) end
        for _, vk in ipairs(TEXT_KEYS) do
            if pressed('T' .. vk, now) then
                local c = key_char(vk)
                if c then presets.type_char(c) end
            end
        end
        return
    end
    if ui.value then
        local edit = ui.value
        if pressed('Escape', now) then finish_value(false); return end
        if pressed('Enter', now) then finish_value(true); return end
        if pressed('Backspace', now) then
            edit.text = edit.fresh and '' or edit.text:sub(1, -2)
            edit.fresh = false
        end
        for _, vk in ipairs(TEXT_KEYS) do
            if pressed('T' .. vk, now) then
                local c = key_char(vk)
                if c and c:find('^[%d%.,%-]$') then
                    if edit.fresh then edit.text, edit.fresh = '', false end
                    if #edit.text < 16 then edit.text = edit.text .. c end
                end
            end
        end
        return
    end
    if ui.search.active then
        local search = ui.search
        if pressed('Escape', now) then ui.search, ui.page = { text = '', active = false }, 1; return end
        if pressed('Enter', now) then search.active = false; return end
        if pressed('Backspace', now) then
            search.text, ui.page = search.text:gsub('[%z\1-\127\194-\244][\128-\191]*$', ''), 1
        end
        for _, vk in ipairs(TEXT_KEYS) do
            if pressed('T' .. vk, now) then
                local c = key_char(vk)
                if c and #search.text + #c <= 40 then search.text, ui.page = search.text .. c, 1 end
            end
        end
        return
    end
    if ui.tab ~= 'Presets' and key_down(VK.Ctrl) and pressed('T70', now) then     -- Ctrl+F
        ui.search.active = true
        return
    end
    if ui.settings then
        if pressed('Escape', now) then ui.settings = false end
        return
    end
    if ui.stack_pick then   -- the passive picker is open: Esc closes it
        if pressed('Escape', now) then ui.stack_pick = nil end
        return
    end
    if pressed('PageDown', now) or pressed('PageUp', now) then
        local all = {}
        for _, tab in ipairs(settings.shown_tabs()) do
            if (tab == 'Records') == (weapon ~= nil and weapon.record == true) then
                for _, w in ipairs(weapons_in(tab)) do all[#all + 1] = w end
            end
        end
        local at = 0
        for n, w in ipairs(all) do if w == weapon then at = n end end
        local forward = held.PageDown ~= nil
        at = at + (forward and 1 or -1)
        if at < 1 then at = #all elseif at > #all then at = 1 end
        select_weapon(all[at])
        return
    end
    if ui.tab == 'Presets' then
        local order, n = presets.full_order(), presets.chosen()
        local at = 0
        for k, m in ipairs(order) do if m == n then at = k end end
        if #order > 0 then
            if pressed('Down', now) then presets.show(order[at % #order + 1]) end
            if pressed('Up', now) then presets.show(order[(at - 2) % #order + 1]) end
        end
        n = presets.chosen()
        if pressed('Insert', now) then
            if key_down(VK.Shift) then if n then presets.confirm('save', n) end else presets.new_full_preset() end
        end
        if n and pressed('Enter', now) then presets.load_full_preset(n) end
        if n and pressed('F2', now) then presets.start_rename(n) end
        if n and pressed('Delete', now) then presets.confirm('delete', n) end
        return
    end
    if not weapon or #weapon.rows == 0 then return end
    if key_down(VK.Ctrl) then
        for n = 1, presets.weapon_count do
            if pressed('Key' .. n, now) then
                ui.wslot = n
                if key_down(VK.Shift) then presets.save_weapon_preset(weapon, n) else presets.load_weapon_preset(weapon, n) end
            end
        end
    end
    if pressed('Enter', now) and weapon.rows[ui.row] and row_value(weapon.rows[ui.row]) ~= nil then
        ui.value = { n = ui.row, weapon = weapon, text = fmt(row_value(weapon.rows[ui.row]), weapon.rows[ui.row].storage), fresh = true }
        return
    end
    local moved = false
    if pressed('Down', now) then ui.row = ui.row % #weapon.rows + 1; moved = true end
    if pressed('Up', now) then ui.row = (ui.row - 2) % #weapon.rows + 1; moved = true end
    -- keep the chosen row in view (the next draw settles the exact last visible row)
    if moved then
        if ui.row < ui.scroll then ui.scroll = ui.row
        elseif ui.last_visible and ui.row > ui.last_visible then
            ui.scroll = ui.scroll + ui.row - ui.last_visible
            -- the last row (and any note under it): the last page
            if ui.row == #weapon.rows and ui.last_page then ui.scroll = math.max(ui.scroll, ui.last_page) end
        end
    end
    local row = weapon.rows[ui.row]
    if not row then ui.row = 1; return end
    local big = key_down(VK.Shift)
    if pressed('Right', now) then change(row, 1, big) end
    if pressed('Left', now) then change(row, -1, big) end
    if pressed('Delete', now) then reset_row(weapon, row) end
end

-- the cursor and the game's input while the panel is open (see cursor, below)
local cursor = { taken = false }

-- The scroll bars: the stats' (ui.sbar, set while the rows scroll) and the list's (ui.lbar, set while
-- the weapon or preset list is longer than a page); track and thumb in gui pixels from the bottom,
-- `id` the ui field they move. Pressing the thumb grabs it and dragging moves the rows along;
-- pressing the track pages; the wheel (panel_frame) moves the bar of the half the cursor is over.
function ui.scroll_press(key, gy)
    local name = key:sub(1, 1) == 'l' and 'lbar' or 'sbar'
    local b = ui[name]
    if not b then return end
    if key:find(':thumb$') then ui.drag = { bar = name, from = gy, value = ui[b.id] }
    elseif name == 'sbar' then click(gy > b.thumb_top and 'scroll:up' or 'scroll:down')
    else ui[b.id] = math.max(1, math.min(b.span + 1, ui[b.id] + (gy > b.thumb_top and -b.page or b.page))) end
end

function ui.scroll_drag(gy)
    local d = ui.drag
    local b = d and ui[d.bar]
    local per = b and (b.top - b.bottom - b.thumb) / b.span
    if not per or per <= 0 then return end
    ui[b.id] = math.max(1, math.min(b.span + 1, d.value + math.floor((d.from - gy) / per + 0.5)))
end

function ui.wheel_scroll(notches)
    local left = ui.cursor_gx and ui.split_gx and ui.cursor_gx < ui.split_gx
    local b = left and ui.lbar or (not left and ui.weapon and ui.sbar)
    if b then ui[b.id] = math.max(1, math.min(b.span + 1, ui[b.id] - notches * 3)) end
end

local mouse_was_down, armed = nil, nil

-- Hover and clicks (press and release on the same control), in gui pixels from the bottom left.
local function mouse(window)
    if user.GetCursorPos(ffi.cast('void *', point)) == 0
       or user.ScreenToClient(window, ffi.cast('void *', point)) == 0
       or user.GetClientRect(window, ffi.cast('void *', rect)) == 0 then return end
    local cw, ch = rect[2] - rect[0], rect[3] - rect[1]
    local x, y = point[0], point[1]
    if cw <= 0 or ch <= 0 or x < 0 or y < 0 or x >= cw or y >= ch then return end
    local width, height = sr.Gui.resolution()
    local gy = (ch - y) * height / ch
    ui.cursor_gx = x * width / cw
    ui.hover = hit(ui.cursor_gx, gy, true)
    local down
    if cursor.raw.saved then
        down = key_down(0x01)   -- VK_LBUTTON: the engine gets no mouse input while the panel holds it
    else
        local value = sr.Mouse.button(sr.Mouse.button_id('left'))
        down = value == true or (type(value) == 'number' and value > 0)
    end
    if mouse_was_down ~= nil then
        if down and not mouse_was_down then
            armed = ui.hover
            if armed and armed:find('^[sl]bar:') then ui.scroll_press(armed, gy) end
        end
        if down and ui.drag then ui.scroll_drag(gy) end
        if not down then ui.drag = nil end
        if not down and mouse_was_down then
            if armed and armed == ui.hover then click(armed) end
            armed = nil
        end
    end
    mouse_was_down = down
end

-- ---------------------------------------------------------------- cursor
-- While the panel is open the cursor is shown and free to leave the window's centre, through
-- the engine's Window functions where it has them, else through Windows (ShowCursor and
-- ClipCursor). Everything is put back as it was when the panel closes. The game may hide the
-- cursor again on its own (screen changes), so it is shown again each frame while open.

local function window_fn(name)
    local f = sr.Window and rawget(sr.Window, name)
    return type(f) == 'function' and f or nil
end

local function engine_cursor_shown()
    local f = window_fn('show_cursor')
    if not f then return nil end
    local ok, shown = pcall(f)
    if ok and type(shown) == 'boolean' then return shown end
    return nil
end

local function take_cursor()
    if cursor.taken then return end
    cursor.taken = true
    local set_show, set_clip = window_fn('set_show_cursor'), window_fn('set_clip_cursor')
    cursor.was_shown = engine_cursor_shown()
    cursor.engine = set_show ~= nil
    if cursor.engine then
        pcall(set_show, true)
        if set_clip then pcall(set_clip, false) end
    end
    -- Windows: show (ShowCursor keeps a count; raise it to 0) and unclip, remembering both
    cursor.shows = 0
    while user.ShowCursor(1) < 0 and cursor.shows < 20 do cursor.shows = cursor.shows + 1 end
    cursor.shows = cursor.shows + 1
    cursor.clip = ffi.new('int32_t[4]')
    cursor.clipped = user.GetClipCursor(ffi.cast('void *', cursor.clip)) ~= 0
    user.ClipCursor(nil)
    if not cursor.logged then
        cursor.logged = true
        local names = {}
        for _, n in ipairs({ 'show_cursor', 'set_show_cursor', 'clip_cursor', 'set_clip_cursor', 'set_mouse_focus' }) do
            names[#names + 1] = n .. (window_fn(n) and '+' or '-')
        end
        log('cursor: engine Window ' .. table.concat(names, ' ') .. '; was shown: ' .. tostring(cursor.was_shown) ..
            '; now shown: ' .. tostring(engine_cursor_shown()))
        flush_log()
    end
end

local function keep_cursor()
    if not cursor.taken then return end
    if engine_cursor_shown() == false then
        local set_show, set_clip = window_fn('set_show_cursor'), window_fn('set_clip_cursor')
        if set_show then pcall(set_show, true) end
        if set_clip then pcall(set_clip, false) end
        cursor.retakes = (cursor.retakes or 0) + 1
        if cursor.retakes == 1 or cursor.retakes == 100 then log('cursor: the game hid it again (' .. cursor.retakes .. ' times)') end
    end
end

local function release_cursor()
    if not cursor.taken then return end
    cursor.taken = false
    if cursor.engine and cursor.was_shown == false then
        local set_show, set_clip = window_fn('set_show_cursor'), window_fn('set_clip_cursor')
        pcall(set_show, false)
        if set_clip then pcall(set_clip, true) end
    end
    for _ = 1, cursor.shows or 0 do user.ShowCursor(0) end
    if cursor.clipped and cursor.clip then user.ClipCursor(ffi.cast('const void *', cursor.clip)) end
end

-- Game input: while the panel is open the game gets no keyboard or mouse input, so typing and
-- the mouse move neither the character nor the camera and open none of the game's menus. The
-- engine reads both through Windows raw input: the panel takes the game's keyboard (page 1 usage 6)
-- and mouse (1/2) registrations away, keeping them, and registers them again exactly as they were
-- when it closes. The panel reads key and button states itself (GetAsyncKeyState), which raw input
-- does not touch. Taken once the hotkey is let go (so the game never misses a key's release), checked
-- twice a second while open (the game may register again), given back until Windows accepts it.
cursor.raw = { saved = nil, next_check = 0, retakes = 0 }

function cursor.registered()
    local count = ffi.new('uint32_t[1]')
    user.GetRegisteredRawInputDevices(nil, count, 16)
    if count[0] == 0 then return {} end
    local list = ffi.new('shodan_raw_device[?]', count[0])
    local got = user.GetRegisteredRawInputDevices(list, count, 16)
    local out = {}
    if got == 0xFFFFFFFF then return out end
    for k = 0, got - 1 do
        local d = list[k]
        out[#out + 1] = { page = d.page, usage = d.usage, flags = d.flags, target = d.target }
    end
    return out
end

function cursor.take_input(window, now)
    local raw = cursor.raw
    if raw.saved or raw.failed or now < raw.next_check then return end
    raw.next_check = now + 0.5
    local devices, game = cursor.registered(), {}
    for _, d in ipairs(devices) do
        if d.page == 1 and (d.usage == 2 or d.usage == 6) then game[#game + 1] = d end
    end
    if not raw.logged then
        raw.logged = true
        local text = {}
        for _, d in ipairs(devices) do
            text[#text + 1] = string.format('%d/%d flags 0x%X %s', d.page, d.usage, d.flags,
                                            d.target == nil and 'focus' or (d.target == window and 'game window' or 'other window'))
        end
        local thread = user.GetWindowThreadProcessId(window, nil)
        log('input: raw input registered: ' .. (#text > 0 and table.concat(text, ', ') or 'none') ..
            '; window thread ' .. tostring(thread) .. ', this thread ' .. tostring(ffi.load('kernel32').GetCurrentThreadId()))
    end
    if not raw.keys_on then raw.keys_on = true; cursor.block_keys(window, true) end
    if #game == 0 then
        if not raw.none then raw.none = true; log('input: the game has no raw keyboard / mouse registration now') end
        return
    end
    local list = ffi.new('shodan_raw_device[?]', #game)
    for k, d in ipairs(game) do
        list[k - 1].page, list[k - 1].usage, list[k - 1].flags, list[k - 1].target = d.page, d.usage, 0x1, nil   -- RIDEV_REMOVE
    end
    if user.RegisterRawInputDevices(list, #game, 16) ~= 0 then
        raw.saved, raw.window = game, window
        raw.taken = (raw.taken or 0) + 1
        if raw.taken <= 3 then log('input: taken from the game (' .. #game .. ' device(s))'); flush_log() end
    else
        raw.failed = true
        log('input: could not take it from the game (error ' .. tostring(ffi.errno()) .. '); the game keeps it')
        flush_log()
    end
end

function cursor.give_input(now)
    local raw = cursor.raw
    raw.failed = nil
    if raw.keys_on then raw.keys_on = false; pcall(cursor.block_keys, nil, false) end
    if not raw.saved then return true end
    if now and now < (raw.next_give or 0) then return false end
    local list = ffi.new('shodan_raw_device[?]', #raw.saved)
    for k, d in ipairs(raw.saved) do
        list[k - 1].page, list[k - 1].usage, list[k - 1].flags, list[k - 1].target = d.page, d.usage, d.flags, d.target
    end
    if user.RegisterRawInputDevices(list, #raw.saved, 16) ~= 0 then
        raw.saved, raw.next_check = nil, 0
        if raw.taken <= 3 then log('input: given back to the game'); flush_log() end
        return true
    end
    raw.next_give = (now or 0) + 0.25
    raw.give_errors = (raw.give_errors or 0) + 1
    if raw.give_errors <= 3 then log('input: could not give it back yet (error ' .. tostring(ffi.errno()) .. '); trying again') end
    return false
end

-- The keyboard and the mouse buttons reach the game as window messages, not raw input. A small native
-- filter goes in front of the game window's procedure (installed once, never removed: other mods may
-- chain after it): while its flag is set it drops key presses and typed characters (WM_KEYDOWN, WM_CHAR,
-- WM_DEADCHAR, WM_UNICHAR) and passes everything else, key releases included (no key can stick), to
-- the window's own procedure. It runs on the window's thread without Lua. While set it also keeps the
-- mouse wheel (WM_MOUSEWHEEL: its turns added up for the panel's scrolling) and drops mouse button presses
-- and double clicks (left, right, middle, X1, X2). A button's release reaches the game only when its press
-- did (a bit per button: a button held when the panel opens is let go in the game; a click on the panel
-- never ends up as a click in a menu after it closes). Each install gets its own block: +0 flag, +4 key
-- presses seen, +8 blocked, +12 wheel turns (120 a notch), +16 previous procedure, +24 CallWindowProcW,
-- +32 buttons the game has seen pressed, +36 button messages blocked, +48 per mouse message
-- (WM_LBUTTONDOWN + n): kind * 16 + button (kind 1 press, 2 release; button 7: X, from the message), code at +64.
cursor.keys = { blocks = {} }

function cursor.key_filter(window)
    local keys = cursor.keys
    local current = user.GetWindowLongPtrW(window, -4)   -- GWLP_WNDPROC
    for _, b in ipairs(keys.blocks) do
        if b.window == window and current == b.code then return b end
    end
    local kernel = ffi.load('kernel32')
    local call = kernel.GetProcAddress(kernel.GetModuleHandleA('user32.dll'), 'CallWindowProcW')
    local block = kernel.VirtualAlloc(nil, 4096, 0x3000, 0x40)   -- commit + reserve, execute / read / write
    if call == nil or block == nil or current == 0 then return nil end
    local base = ffi.cast('uint8_t *', block)
    local data = ffi.cast('uint64_t *', block)
    data[2], data[3] = ffi.cast('uint64_t', current), ffi.cast('uint64_t', ffi.cast('intptr_t', call))
    local a = tonumber(ffi.cast('uintptr_t', block))
    local code = { 0x49, 0xBA }                              -- mov r10, block
    for k = 0, 7 do code[#code + 1] = math.floor(a / 256 ^ k) % 256 end
    -- count WM_KEYDOWN; WM_xBUTTONDOWN / DBLCLK / UP: press -> blocked while set, else noted and passed;
    -- release -> passed if its press was, else blocked; then (while set) the wheel, then the keys; pass:
    -- CallWindowProcW(previous, window, msg, w, l). (Assembled from filter_asm.py.)
    for _, byte in ipairs({
        0x81, 0xFA, 0x00, 0x01, 0x00, 0x00, 0x75, 0x04, 0x41, 0xFF, 0x42, 0x04, 0x8D, 0x82, 0xFF, 0xFD,
        0xFF, 0xFF, 0x83, 0xF8, 0x0C, 0x77, 0x47, 0x45, 0x0F, 0xB6, 0x5C, 0x02, 0x30, 0x44, 0x89, 0xD8,
        0xC1, 0xE8, 0x04, 0x74, 0x39, 0x41, 0x83, 0xE3, 0x07, 0x41, 0x83, 0xFB, 0x07, 0x75, 0x0F, 0x4D,
        0x89, 0xC3, 0x49, 0xC1, 0xEB, 0x10, 0x41, 0x83, 0xE3, 0x03, 0x41, 0x83, 0xC3, 0x02, 0x83, 0xF8,
        0x02, 0x74, 0x0D, 0x41, 0x83, 0x3A, 0x00, 0x75, 0x0E, 0x45, 0x0F, 0xAB, 0x5A, 0x20, 0xEB, 0x52,
        0x45, 0x0F, 0xB3, 0x5A, 0x20, 0x72, 0x4B, 0x41, 0xFF, 0x42, 0x24, 0x31, 0xC0, 0xC3, 0x41, 0x83,
        0x3A, 0x00, 0x74, 0x3E, 0x81, 0xFA, 0x0A, 0x02, 0x00, 0x00, 0x75, 0x0D, 0x44, 0x89, 0xC0, 0xC1,
        0xF8, 0x10, 0x41, 0x01, 0x42, 0x0C, 0x31, 0xC0, 0xC3, 0x81, 0xFA, 0x00, 0x01, 0x00, 0x00, 0x74,
        0x1A, 0x81, 0xFA, 0x02, 0x01, 0x00, 0x00, 0x74, 0x12, 0x81, 0xFA, 0x03, 0x01, 0x00, 0x00, 0x74,
        0x0A, 0x81, 0xFA, 0x09, 0x01, 0x00, 0x00, 0x74, 0x02, 0xEB, 0x07, 0x41, 0xFF, 0x42, 0x08, 0x31,
        0xC0, 0xC3, 0x48, 0x83, 0xEC, 0x38, 0x4C, 0x89, 0x4C, 0x24, 0x20, 0x4D, 0x89, 0xC1, 0x41, 0x89,
        0xD0, 0x48, 0x89, 0xCA, 0x49, 0x8B, 0x4A, 0x10, 0x41, 0xFF, 0x52, 0x18, 0x48, 0x83, 0xC4, 0x38,
        0xC3,
    }) do code[#code + 1] = byte end
    for k, kind in ipairs({ 0x10, 0x20, 0x10, 0x11, 0x21, 0x11, 0x12, 0x22, 0x12, 0x00, 0x17, 0x27, 0x17 }) do
        base[47 + k] = kind
    end
    -- the buttons down now: the game has seen them pressed
    for bit, vk in ipairs({ 0x01, 0x02, 0x04, 0x05, 0x06 }) do
        if user.GetAsyncKeyState(vk) < 0 then ffi.cast('uint32_t *', block)[8] = ffi.cast('uint32_t *', block)[8] + 2 ^ (bit - 1) end
    end
    for k, byte in ipairs(code) do base[63 + k] = byte end
    kernel.FlushInstructionCache(kernel.GetCurrentProcess(), base + 64, #code)
    local entry = ffi.cast('intptr_t', base + 64)
    local previous = user.SetWindowLongPtrW(window, -4, entry)
    if previous == 0 then return nil end
    if previous ~= current then data[2] = ffi.cast('uint64_t', previous) end
    local b = { window = window, code = entry, flag = ffi.cast('uint32_t *', block) }
    keys.blocks[#keys.blocks + 1] = b
    log('input: key filter in front of the game window (' .. #keys.blocks .. ')')
    return b
end

function cursor.block_keys(window, on)
    local keys = cursor.keys
    if on then
        local ok, b = pcall(cursor.key_filter, window)
        if not ok or not b then
            if not keys.failed then keys.failed = true; log('input: no key filter: ' .. tostring(ok and 'not installed' or b)) end
            return
        end
    end
    local seen, blocked, clicks = 0, 0, 0
    for _, b in ipairs(keys.blocks) do
        b.flag[0] = on and 1 or 0
        seen, blocked, clicks = seen + b.flag[1], blocked + b.flag[2], clicks + b.flag[9]
    end
    if not on and #keys.blocks > 0 then
        keys.reports = (keys.reports or 0) + 1
        if keys.reports <= 3 then
            log('input: key presses the game window got: ' .. seen .. ', blocked while open: ' .. blocked ..
                '; mouse button messages blocked: ' .. clicks)
        end
    end
    if not keys.modules then
        keys.modules = true
        local kernel, found = ffi.load('kernel32'), {}
        for _, m in ipairs({ 'dinput8.dll', 'dinput.dll', 'GameInput.dll', 'xinput1_4.dll', 'xinput9_1_0.dll', 'hid.dll' }) do
            if kernel.GetModuleHandleA(m) ~= nil then found[#found + 1] = m end
        end
        log('input: input libraries loaded: ' .. (#found > 0 and table.concat(found, ', ') or 'none of dinput / GameInput / xinput / hid'))
    end
end

-- Wheel notches turned since the last call (up: positive), from the key filter's running total.
function cursor.wheel()
    local keys, total = cursor.keys, 0
    for _, b in ipairs(keys.blocks) do total = total + ffi.cast('int32_t *', b.flag)[3] end
    local turned = total - (keys.wheel_seen or total)
    keys.wheel_seen = total
    keys.wheel_rest = (keys.wheel_rest or 0) + turned
    local notches = keys.wheel_rest >= 0 and math.floor(keys.wheel_rest / 120) or -math.floor(-keys.wheel_rest / 120)
    keys.wheel_rest = keys.wheel_rest - notches * 120
    return notches
end

-- while open: the game may have registered again (focus changes); take it again
function cursor.hold_input(window, now)
    local raw = cursor.raw
    if not raw.saved then return cursor.take_input(window, now) end
    if now < raw.next_check then return end
    raw.next_check = now + 0.5
    for _, d in ipairs(cursor.registered()) do
        if d.page == 1 and (d.usage == 2 or d.usage == 6) then
            raw.retakes = raw.retakes + 1
            if raw.retakes <= 3 then log('input: the game registered again; taking it again') end
            raw.saved, raw.next_check = nil, 0
            return cursor.take_input(window, now)
        end
    end
end

-- The engine's worlds come and go with screens and cinematics (the intro runs with 8). The
-- panel draws only once the set of worlds has stayed the same for SETTLE_SECONDS, and is
-- taken down the moment it changes.
local SETTLE_SECONDS = 1.5

local function same_worlds(a, b)
    if not a or not b or #a ~= #b then return false end
    for k = 1, #a do if a[k] ~= b[k] then return false end end
    return true
end

local function panel_frame(now)
    local window = focused_window()
    pcall(keep_cursor)
    if not settings.block_input then
        if cursor.raw.saved or cursor.raw.keys_on then pcall(cursor.give_input) end
    elseif window and not key_down(VK[hotkey_name] or VK.F8) then
        local ok, why = pcall(cursor.hold_input, window, now)
        if not ok then log('input: ' .. tostring(why)); cursor.raw.failed = true end
    end
    -- the mouse wheel scrolls the list or the stats (the half the cursor is over), 3 rows a notch
    local ok, notches = pcall(cursor.wheel)
    if ok and notches ~= 0 and not ui.value then ui.wheel_scroll(notches) end
    local main = sr.Application.main_world()
    local worlds = sr.Application.worlds() or {}
    if not same_worlds(worlds, ui.worlds) or main ~= ui.main then
        if ui.worlds then
            log('panel: worlds changed (' .. #ui.worlds .. ' -> ' .. #worlds .. '); waiting for the screen to settle')
            flush_log()
        end
        clear_gui()
        ui.worlds, ui.main, ui.settled_at = worlds, main, now + SETTLE_SECONDS
        return
    end
    if now < ui.settled_at then return end
    local world = nil
    for _, w in ipairs(worlds) do if w ~= main then world = w break end end
    if not world then
        if ui.gui then log('panel: no overlay world; hidden') end
        clear_gui()
        return
    end
    if ui.world ~= world then
        clear_gui()
        ui.world = world
        local index = 0
        for k, w in ipairs(worlds) do if w == world then index = k end end
        local main_index = 0
        for k, w in ipairs(worlds) do if w == main then main_index = k end end
        log('panel: drawing on world ' .. index .. ' of ' .. #worlds .. ' (the game world is ' .. main_index .. ')')
        flush_log()
        trace_left, traced = math.max(trace_left, 2), {}
    end

    -- input: mouse and keyboard (while the game window has focus)
    ui.hover = nil
    if window and not ui.mouse_broken then
        local ok, why = pcall(mouse, window)
        if not ok then
            ui.mouse_broken = true
            log('mouse input off for this session: ' .. tostring(why))
        end
    end
    if not ui.hover and not ui.drag then mouse_was_down, armed = nil, nil end
    if window then keyboard(now) end

    -- redraw when anything shown changed
    local width, height = sr.Gui.resolution()
    if ui.message and api.now() >= ui.message.till then ui.message = nil end
    if ui.confirm and api.now() >= ui.confirm.till then ui.confirm = nil; ui.version = ui.version + 1 end
    local signature = table.concat({ width, height, state.phase, state.tables, ui.tab, ui.page, ui.row, ui.scroll,
                                     tostring(ui.hover), tostring(ui.drag ~= nil), ui.weapon and ui.weapon.hash or '-', ui.version,
                                     tostring(ui.settings), tostring(ui.binding), hotkey_name,
                                     #overrides, ui.wslot, tostring(ui.fslot), ui.fpage,
                                     ui.message and ui.message.text or '', ui.editing and ui.editing.text or '-',
                                     ui.search.text, tostring(ui.search.active),
                                     ui.value and (ui.value.n .. '=' .. ui.value.text) or '-' }, '|')
    if signature ~= ui.signature then
        -- a fresh gui each time: nothing drawn before can linger
        if ui.gui then
            step('World.destroy_gui')
            pcall(sr.World.destroy_gui, ui.world, ui.gui)
        end
        step('World.create_screen_gui')
        ui.gui = sr.World.create_screen_gui(ui.world, 'scale', 1, 1)
        if not ui.gui then
            log('panel: the overlay world refused a gui')
            clear_gui()
            return
        end
        local ok, chosen = pcall(choose_font, ui.gui)
        font = ok and chosen or { text = 'no text: ' .. tostring(chosen) }
        if font.text ~= ui.font_said then
            ui.font_said = font.text
            ui.measured, ui.measures = {}, 0
            log('font: ' .. font.text)
            flush_log()
        end
        ui.signature = signature
        ui.regions = draw(width, height)
        draws = draws + 1
        if trace_left > 0 then
            trace_left, traced = trace_left - 1, {}
            log('panel: draw ' .. draws .. ' done at ' .. width .. 'x' .. height .. ', ' .. #ui.regions .. ' regions')
            flush_log()
        end
    end
end

local function open_panel(open)
    ui.open = open
    if open then
        if state.phase == 'ready' and not tables_intact() then rescan() end
        if not ui.restored and state.phase == 'ready' then
            ui.restored = true
            local last = settings.remember and settings.last_weapon and by_hash[settings.last_weapon]
            if last and #last.rows > 0 and not settings.hidden[last.slot] then
                select_weapon(last)
            elseif settings.remember and settings.last_tab then
                for _, t in ipairs(settings.shown_tabs()) do if t == settings.last_tab then ui.tab = t end end
            end
            if settings.hidden[ui.tab] then ui.tab = settings.shown_tabs()[1] end
        end
        if not ui.weapon then
            local list = weapons_in(ui.tab)
            select_weapon(list[1])
        end
        ui.worlds = nil
        log('panel opened')
        flush_log()
        local ok, why = pcall(take_cursor)
        if not ok then log('cursor: could not free it: ' .. tostring(why)) end
        cursor.raw.next_check = 0   -- the game's input: taken as soon as the hotkey is up
    else
        pcall(release_cursor)
        pcall(cursor.give_input)
        clear_gui()
        ui.worlds = nil
        held, mouse_was_down, armed, ui.drag = {}, nil, nil, nil
        ui.editing, ui.confirm, ui.search.active, ui.value, ui.binding = nil, nil, false, nil, nil
    end
end

-- ---------------------------------------------------------------- per frame
local hotkey_was_down = false
local next_retry, next_flush = 0, 0

-- A swapped projectile's assets. A weapon's effects (its projectiles' trails among them) are in its loadout
-- package (LoadoutPackage +8: the package id, the hash of packages/generated/loadout/<item>), which the game
-- loads only while someone carries the weapon: a projectile swapped from a weapon nobody carries flies
-- without its trail (hits and explosions are loaded anyway). Each weapon a Projectile swap row fires from
-- gets its package loaded: one reference through game.dll's RefcountedPackageSystem request (the call the
-- game makes for a loadout), once per package per session and never released (fired projectiles use the
-- assets without holding one). The request function, its instance and the reference map's shape are
-- HD2Runtime's research (SkyeShade, docs/asset-loading.md); the function's code bytes are checked before
-- the first call, and a game build where they differ turns this off (logged): swaps still work, untrailed.
-- One local (the main chunk is at Lua's 200): settings, state (.off: why it is off; .call and .instance
-- once checked) and the functions below.
local packages = { held = {}, count = 0, next_check = 0, NO_ID = string.rep('\0', 8),
    request_rva = 19915600, instance_rva = 55037616,   -- game.dll: the request function, the global holding the instance
    proof =
        '4585c00f8475010000415641574883ec3848895c24504c8bfa48896c24584c8bf1488974246048897c24304c89642428' ..
        '4c8d25b9244d024c896c24204c8d2d89254d02418be866660f1f840000000000418b560833c0498b37458b46184c0faf' ..
        'c6448d4aff85d27459498b0e0f1f40008bd84903d84923d948c1e3044803d94839330f84f7000000ffc03bc272e24d8b' ..
        '5e104c8bd133c0660f1f8400000000008bd84903d84923d948c1e3044903da488b0b493bcb740d483bce7408ffc03bc2' ..
        '72de33db48893348c7430801000000488b15cade01024c8d05b38b0001488b7b08498bcc4c8bce488d4216493bc5480f' ..
        '42caba1600000048890da2de0102e8cdf41eff4c8b0596de0102488d0db71bfc00ffc04c8bcf4863d04903d04889157d' ..
        'de0102488d15f63ffc00e8819e430048837b08017514488b057b7e0202488bce488b5010ff92f00200004983c7084883' ..
        'ed010f85f8feffff4c8b6c24204c8b642428488b7c2430488b742460488b6c2458488b5c24504883c438415f415ec348',
    budget = 64, fill = 0.75,                  -- packages held at most; the reference map kept below 75 % full
}
function packages.unhex(hex) return (hex:gsub('%x%x', function(b) return string.char(tonumber(b, 16)) end)) end
function packages.u64(bytes, at)
    local lo, hi = 0, 0
    for k = 4, 1, -1 do lo = lo * 256 + bytes:byte(at + k); hi = hi * 256 + bytes:byte(at + 4 + k) end
    return lo + hi * 4294967296
end

-- The package system's reference map: its capacity and entries (16 bytes each, the package id first).
function packages.package_map()
    local header = api.read(packages.instance, 16)
    if not header or #header ~= 16 then return nil end
    local capacity = header:byte(9) + header:byte(10) * 256 + header:byte(11) * 65536 + header:byte(12) * 16777216
    if capacity < 16 or capacity > 65536 or capacity % 2 ~= 0 or packages.u64(header, 0) == 0 then return nil end
    return capacity, packages.u64(header, 0)
end

-- The checked request call, or nil (packages.off says why when it is off for the session).
function packages.package_loader()
    if packages.call or packages.off then return packages.call end
    local ok, why = pcall(function()
        pcall(ffi.cdef, 'void *GetModuleHandleA(const char *name);')
        local handle = ffi.load('kernel32').GetModuleHandleA('game.dll')
        local dll = handle ~= nil and tonumber(ffi.cast('uintptr_t', handle))
        if not dll then return 'game.dll not found' end
        local want = packages.unhex(packages.proof)
        if api.read(dll + packages.request_rva, #want) ~= want then return 'another game build (the request function differs)' end
        local slot = api.read(dll + packages.instance_rva, 8)
        local instance = slot and #slot == 8 and packages.u64(slot, 0)
        if not instance or instance < 65536 then return 'wait' end
        packages.instance = instance
        if not packages.package_map() then packages.instance = nil; return 'the package map differs' end
        packages.call = ffi.cast('void (*)(void *, const uint64_t *, uint32_t)', ffi.cast('void *', dll + packages.request_rva))
    end)
    if not ok then why = tostring(why) end
    if why and why ~= 'wait' then packages.off = why; log('packages: off: ' .. why) end
    return packages.call
end

-- Loads the loadout package of the entity `key` (a weapon a swap fires from) once; `label` for the log.
function packages.require_package(key, label)
    local t = tables[TYPES.package]
    local at = t and t.index[key]
    local id = at and api.read(t.copies[1] + HEADER_BYTES + at + 8, 8)
    if not id or #id ~= 8 or id == packages.NO_ID then return nil, 'grenade loadout package not found' end
    if packages.held[id] then return id end
    if packages.count >= packages.budget then return nil, 'package budget reached; restart the game' end
    local call = packages.package_loader()
    if not call then return nil, packages.off or 'grenade assets loading' end
    local capacity, first = packages.package_map()
    local entries = capacity and api.read(first, capacity * 16)
    if not entries or #entries ~= capacity * 16 then return nil, 'package map unreadable' end
    local used = 0
    for k = 0, capacity - 1 do
        if entries:sub(k * 16 + 1, k * 16 + 8) ~= packages.NO_ID then used = used + 1 end
    end
    if used >= capacity * packages.fill then
        log("packages: the game's package map is too full to load " .. label)
        return nil, 'package map too full'
    end
    local ids = ffi.new('uint64_t[1]')
    ffi.copy(ids, id, 8)
    call(ffi.cast('void *', packages.instance), ids, 1)
    packages.held[id], packages.count = label, packages.count + 1
    log('packages: loading the assets of ' .. label .. ' (' .. id:reverse():gsub('.', function(c) return string.format('%02X', c:byte()) end) .. ')')
    return id
end

-- HD2Runtime's package-residency layout, for the same pinned game build as the
-- request call above. Read engine state; holding a reference alone does not mean
-- an asynchronous load finished. No engine calls are made by this check.
packages.engine = {
    manager_rva = 27329032, has_loaded_rva = 3281712, find_package_rva = 6347392,
    has_loaded_proof = '4883ec28488b05cdee6e01488bd1488b8800040000488b8908020000e82fc72e004c8bc84885c0750733c04883c428c3458b411833c04585c074164d8b492090498b14c1837a1c0475dfffc0413bc072efb8010000004883c428c3cccccccccc',
    find_package_proof = '48895c2408488974241048897c24188bb9800000004533d285ff7440488bb1880000000f1f4000660f1f8400000000004a8b1cd633c0448b4b184585c974154c8b5b204d8b04c3493950107421ffc041',
}

function packages.resident(id)
    local engine = packages.engine
    local function bytes(at, n)
        local data = api.read(at, n)
        assert(data and #data == n, 'package residency unreadable')
        return data
    end
    local function pointer(at)
        local p = packages.u64(bytes(at, 8), 0)
        assert(p >= 65536, 'package manager not ready')
        return p
    end
    if not engine.base then
        local handle = ffi.load('kernel32').GetModuleHandleA(nil)
        local exe = handle ~= nil and tonumber(ffi.cast('uintptr_t', handle))
        assert(exe, 'game executable not found')
        for _, proof in ipairs({ { engine.has_loaded_rva, engine.has_loaded_proof },
                                  { engine.find_package_rva, engine.find_package_proof } }) do
            local want = packages.unhex(proof[2])
            assert(bytes(exe + proof[1], #want) == want, 'another game build (package residency differs)')
        end
        engine.base = exe
    end
    local manager = pointer(pointer(engine.base + engine.manager_rva) + 1024)
    local resources = pointer(manager + 520)
    local count = u32(bytes(resources + 128, 4), 0)
    assert(count <= 8192, 'package list bounds changed')
    if count == 0 then return false end
    local list = bytes(pointer(resources + 136), count * 8)
    for n = 0, count - 1 do
        local package = packages.u64(list, n * 8)
        if bytes(package + 16, 8) == id then
            local parts = u32(bytes(package + 24, 4), 0)
            if parts == 0 then return false end
            assert(parts <= 64, 'package part bounds changed')
            local array = bytes(pointer(package + 32), parts * 8)
            for k = 0, parts - 1 do
                if u32(bytes(packages.u64(array, k * 8) + 28, 4), 0) ~= 4 then return false end
            end
            return true
        end
    end
    return false
end

KINDS[TYPES.throwable].ensure_assets = function(value)
    local shot = KINDS[TYPES.throwable].by_id[value]
    if not shot then return false, 'unknown grenade selection' end
    local ok, ready, why = pcall(function()
        local id, reason = packages.require_package(shot.key, shot.label)
        if not id then return false, reason end
        if not packages.resident(id) then return false, 'grenade assets loading' end
        return true
    end)
    if not ok then return false, 'grenade assets unavailable: ' .. tostring(ready) end
    return ready, why
end

-- The throwable launch service (throwable_launch.lua by nnikolajev, written for Bingus Shared Loader;
-- build.py puts it here so the mod needs no second resource). It releases and arms the grenades a
-- launcher spawns: without it a swapped grenade sits still and never goes off.
MOD.throwable_launch = (function()
-- Optional Lua service: release an authored throwable spawned by a launcher.
-- Pack as mods/cowboybingus/throwable_launch and require it explicitly.
-- Uses code/research from HD2Runtime by SkyeShade:
-- https://github.com/SkyeShade/HD2Runtime (unit registry and entity descriptor layout).
-- No executable allocations, instruction patches, or firing-thread callbacks.
local M = { version = 1 }
local ffi = require('ffi')
local bit = require('bit')
local function unhex(s) return (s:gsub('..', function(h) return string.char(tonumber(h, 16)) end)) end
local function u32(s, o)
    if not s or o < 0 or o + 4 > #s then return nil end
    local a,b,c,d = s:byte(o+1,o+4)
    return a + b*256 + c*65536 + d*16777216
end
local function ptr(s, o)
    local lo,hi = u32(s,o),u32(s,o+4)
    if not hi or hi > 32767 then return nil end
    local n = lo + hi*4294967296
    return n >= 65536 and n or nil
end
local float = ffi.new('float[1]')
local function f32(s,o)
    if not s or o+4>#s then return nil end
    ffi.copy(float,s:sub(o+1,o+4),4)
    local n = tonumber(float[0])
    return n==n and math.abs(n)<=100000 and n or nil
end
local function hex64(s,o)
    local lo,hi=u32(s,o),u32(s,o+4)
    return hi and string.format('%08X%08X',hi,lo) or nil
end
local pins = {
    {0x615940,'4c8bdc55535657415541564157498daba8f5ffff4881ec200b0000410f2973b8'},
    {0x6c65f0,'48895c24105556574154415541564157488d6c24804881ec80010000440f29b4'},
    {0x8cdb40,'405355574883ec403b15d260bb02410fb6e88bda488bf90f8448010000448b49'},
    {0x8ce620,'405356574883ec203b15f255bb02418bf88bda488bf10f84aa010000448b4140'},
    {0x1787500,'40534883ec208bdae853ffffff84c00f84ac0000004c8b1dc4f7b9014533c03b'},
}

-- reader.read(address, size) returns bytes or nil. `native` is injectable for
-- offline tests; production uses direct calls to the existing game functions.
function M.new(reader, game, exe, native)
    assert(type(reader)=='table' and type(reader.read)=='function')
    local service = { released=0, refused=0, seen={}, frame=0 }
    local function read(at,n)
        if type(at)~='number' or at<65536 or n<1 or n>1048576 then return nil end
        local s=reader.read(at,n)
        return s and #s==n and s or nil
    end
    local function pointer(at) return ptr(read(at,8),0) end
    local function integer(at) return u32(read(at,4),0) end
    local function hash_index(at,id)
        local h=read(at,20)
        local slots,cap,empty,mult=ptr(h,0),u32(h,8),u32(h,12),u32(h,16)
        if not slots or not cap or cap<1 or cap>65536 or bit.band(cap,cap-1)~=0 then return nil end
        local rows=read(slots,cap*8)
        if not rows then return nil end
        -- Keep the multiplication exact for all u32 entity IDs.
        local low,high=mult%65536,math.floor(mult/65536)
        local start=(id*low+(id*high%65536)*65536)%4294967296
        for i=0,cap-1 do
            local atrow=(start+i)%cap*8
            local key=u32(rows,atrow)
            if key==id then
                local index=u32(rows,atrow+4)
                return index~=4294967295 and index or nil
            end
            if key==empty then return nil end
        end
    end
    local function descriptor(id)
        if not id or id==0 or id==4294967295 then return nil end
        local manager=pointer(game+0x346bf98)
        local index=manager and hash_index(manager+0xf1aeb0,id)
        if not index or index>=1048576 then return nil end
        local address=manager+0xf32f18+index*24
        local raw=read(address,24)
        if u32(raw,8)~=id then return nil end
        return raw,address
    end
    local function pose(unit)
        if not unit or unit==0 then return nil end
        local registry=pointer(exe+0x1a100f0)
        local index,generation=unit%4194304,math.floor(unit/4194304)%256
        local count=registry and integer(registry+152)
        local generations=registry and pointer(registry+160)
        local objects=registry and pointer(registry+136)
        if not count or not generations or not objects or index>=count then return nil end
        local current=read(generations+index,1)
        if not current or current:byte()~=generation then return nil end
        local object=pointer(objects+index*8)
        if not object or integer(object+8)~=unit then return nil end
        local vtable=pointer(object)
        if not vtable or pointer(vtable+0xe8)~=exe+0x2bd870 then return nil end
        local poses=pointer(object+0x88)
        local raw=poses and read(poses,64)
        if not raw then return nil end
        local position,direction={},{}
        for i=0,2 do
            position[i+1]=f32(raw,48+i*4)
            direction[i+1]=f32(raw,16+i*4)
            if not position[i+1] or not direction[i+1] then return nil end
        end
        local norm=direction[1]^2+direction[2]^2+direction[3]^2
        if math.abs(norm-1)>.02 then return nil end
        norm=math.sqrt(norm)
        for i=1,3 do direction[i]=direction[i]/norm end
        return position,direction
    end
    local function fire_data(source,source_raw)
        local manager=pointer(game+0x33266d8)
        local index=manager and hash_index(manager+0x50,source)
        if not index or index>=4096 then return nil end
        local override=hash_index(manager+0x90,source)
        local data
        if override and override<4096 then
            local rows=pointer(manager+0xd0)
            data=rows and rows+override*616
        else
            local root=pointer(game+0x346bf98)
            local table_at=root and pointer(root+0xf12e80)
            local buckets=table_at and read(table_at,542*16)
            if buckets then
                local key=source_raw:sub(1,8)
                for i=0,541 do
                    if buckets:sub(i*16+1,i*16+8)==key then
                        local row=u32(buckets,i*16+8)
                        if row<4096 then data=table_at+0x21e0+row*616 end
                        break
                    end
                end
            end
        end
        local raw=data and read(data,616)
        local records=pointer(manager+0x78)
        local runtime=records and read(records+index*0xa8,0xa8)
        return raw,runtime
    end
    if not native then
        local release=ffi.cast('void (*)(void *, uint32_t, const float *, const float *, uint32_t)',game+0x6c65f0)
        local start=ffi.cast('void (*)(void *, uint32_t, uint8_t)',game+0x8cdb40)
        local arm=ffi.cast('void (*)(void *, uint32_t, uint32_t)',game+0x8ce620)
        local query=ffi.cast('int (*)(uint32_t, uint32_t)',game+0x1787500)
        native={
            query=function(id,kind) return query(id,kind) end,
            release=function(manager,id,p,v,owner)
                release(ffi.cast('void *',manager),id,ffi.new('float[4]',p[1],p[2],p[3],0),
                    ffi.new('float[4]',v[1],v[2],v[3],0),owner)
            end,
            start=function(manager,id) start(ffi.cast('void *',manager),id,1) end,
            arm=function(manager,id,owner) arm(ffi.cast('void *',manager),id,owner) end,
        }
    end
    function service.prove()
        if service.proven then return true end
        for _,pin in ipairs(pins) do
            if read(game+pin[1],#pin[2]/2)~=unhex(pin[2]) then return false,'unsupported native throwable layout' end
        end
        if read(exe+0x2bd870,5)~=unhex('488d4160c3') then return false,'unsupported unit pose layout' end
        service.proven=true
        return true
    end
    function service.step(hosts,donors)
        if not service.proven then return false,'throwable service not proven' end
        service.frame=service.frame+1
        local manager=pointer(game+0x3326728)
        local h=manager and read(manager+0x38,20)
        local slots,cap,empty=ptr(h,0),u32(h,8),u32(h,12)
        if not slots or not cap or cap<1 or cap>65536 or bit.band(cap,cap-1)~=0 then return true end
        local identities,states=pointer(manager+0x50),pointer(manager+0x60)
        local rows=read(slots,cap*8)
        if not rows or not identities or not states then return true end
        local baseline=service.manager~=manager
        if baseline then service.manager=manager;service.seen={} end
        local present={}
        local players=pointer(game+0x3326468)
        local user=pointer(game+0x347cef0)
        local local_peer=user and read(user+0xb398,8)
        local solo=players and integer(players+132)==1
        local processed=0
        for i=0,cap-1 do
            local id,index=u32(rows,i*8),u32(rows,i*8+4)
            if id~=empty and id~=4294967295 and index<4096 then
                present[id]=true
                local age=service.seen[id]
                if baseline then service.seen[id]=true
                elseif age~=true and processed<32 then
                    service.seen[id]=(age or 0)+1
                    local identity_at=pointer(identities+index*8)
                    local identity=identity_at and read(identity_at,24)
                    local hash=hex64(identity,0)
                    if not donors[hash] or u32(identity,8)~=id then service.seen[id]=true
                    else
                        local state=read(states+index*64,64)
                        local source,owner=u32(state,40),u32(state,44)
                        local source_raw=descriptor(source)
                        local owner_raw=descriptor(owner)
                        local active=state and (state:byte(2)~=0 or state:byte(3)~=0)
                        if active then service.seen[id]=true
                        elseif solo and local_peer and state and state:sub(49,56)==local_peer
                            and source_raw and owner_raw and hosts[hex64(source_raw,0)]
                            and bit.band(u32(source_raw,20),1)==1 then
                            local data,runtime=fire_data(source,source_raw)
                            local selected=data and hex64(data,40)
                            local kind=data and u32(data,0)
                            if data and native.query(source,8)==1 then
                                local alternate=u32(data,0x240)
                                if alternate~=0 then kind=alternate end
                                if data:sub(0x248+1,0x248+8)~=string.rep('\0',8) then selected=hex64(data,0x248) end
                            end
                            local projectile=kind and kind<4096 and (kind==0 and game+0x37c7560 or pointer(game+0x37c7670+kind*8))
                            local speed=projectile and f32(read(projectile+32,4),0)
                            if data and native.query(source,7)==1 then
                                local alternate=f32(data,0x23c)
                                if alternate and alternate>0 then speed=alternate end
                            end
                            local multiplier=f32(runtime,0x50)
                            speed=speed and multiplier and speed*multiplier
                            local position,direction=pose(u32(identity,12))
                            local throwable=pointer(game+0x33264c0)
                            local member=throwable and hash_index(throwable+0x30,id)
                            if selected==hash and speed and speed>0 and speed<=100000 and position and member and member<4096 then
                                -- Re-read the identity and lifecycle before native calls; never
                                -- initialize a replaced object or an already thrown grenade.
                                local current=read(states+index*64,64)
                                if read(identity_at,24)==identity and current==state then
                                    local velocity={direction[1]*speed,direction[2]*speed,direction[3]*speed}
                                    service.seen[id]=true -- exactly once, including callback failure
                                    native.release(throwable,id,position,velocity,owner)
                                    native.start(manager,id)
                                    native.arm(manager,id,owner)
                                    service.released=service.released+1
                                    service.last={id=id,source=source,owner=owner,hash=hash,speed=speed}
                                    processed=processed+1
                                end
                            end
                        end
                        if service.seen[id]~=true and service.seen[id]>=8 then
                            service.seen[id]=true;service.refused=service.refused+1
                        end
                    end
                end
            end
        end
        for id in pairs(service.seen) do if not present[id] then service.seen[id]=nil end end
        return true
    end
    return service
end
return M
end)()

-- Started on the first grenade selection. A failure here is not kept: the next selection tries again.
-- Existing objects are baselined and never released retroactively.
KINDS[TYPES.throwable].ensure_launch = function()
    local spec = KINDS[TYPES.throwable]
    if spec.launch_off then return false, spec.launch_off end
    if spec.launch then return true end
    local ok, why = pcall(function()
        local helper = MOD.throwable_launch
        assert(type(helper) == 'table' and helper.version == 1, 'throwable launch service missing')
        local kernel = ffi.load('kernel32')
        local game = tonumber(ffi.cast('uintptr_t', kernel.GetModuleHandleA('game.dll')))
        local exe = tonumber(ffi.cast('uintptr_t', kernel.GetModuleHandleA(nil)))
        assert(game and game > 65536 and exe and exe > 65536, 'game modules unavailable')
        local launch = helper.new(api, game, exe)
        local proven, reason = launch.prove()
        assert(proven, reason)
        local donors = {}
        for _, hash in ipairs(spec.grenade_hashes) do donors[hash] = true end
        spec.launch_donors = donors
        launch.step(spec.grenade_hosts, donors)
        spec.launch = launch
        log('grenades: Lua launch service ready (solo missions)')
    end)
    if not ok then
        why = 'grenade launch unavailable: ' .. tostring(why)
        if why ~= spec.launch_why then spec.launch_why = why; log(why) end
        return false, why
    end
    return true
end

-- Whether a launcher holds a grenade now: the service only runs (every frame) while one does.
KINDS[TYPES.throwable].rearm = function()
    local spec = KINDS[TYPES.throwable]
    spec.armed = false
    for _, f in pairs(spec.fields or {}) do
        local v = read_field(f)
        if v and v ~= 0 then spec.armed = true end
    end
end

-- The service stopped: every launcher goes back to its own projectile (a grenade nobody releases
-- would sit still), the saved choices stay for the next start.
KINDS[TYPES.throwable].stop_launch = function(why)
    local spec = KINDS[TYPES.throwable]
    spec.launch_off = 'grenade launch stopped: ' .. tostring(why)
    log(spec.launch_off)
    for _, f in pairs(spec.fields or {}) do
        local v = read_field(f)
        if v ~= 0 then
            local ok, failed = write_field(f, 0)
            if not ok then log('grenades: could not restore a launcher: ' .. tostring(failed)) end
        end
    end
    spec.armed = false
    ui.message = { text = 'Grenade swap stopped (see the log); launchers fire their own projectiles again.',
                   till = api.now() + 6 }
end

KINDS[TYPES.throwable].update_launch = function()
    local spec = KINDS[TYPES.throwable]
    if not spec.launch or spec.launch_off or not spec.armed then return end
    local before = spec.launch.released
    local ok, why = pcall(spec.launch.step, spec.grenade_hosts, spec.launch_donors)
    if not ok then
        spec.stop_launch(why)
    elseif spec.launch.released ~= before then
        local shot = spec.launch.last or {}
        log('grenades: released ' .. tostring(shot.id) .. ' from ' .. tostring(shot.source) .. ' (' ..
            tostring(shot.hash) .. ', speed ' .. tostring(shot.speed) .. ', total ' .. tostring(spec.launch.released) .. ')')
    end
end

-- Every second: the weapons the Projectile swap rows fire from (another weapon's projectile) get their assets.
function packages.swap_assets()
    local by_id = KINDS[T_PROJECTILE].by_id or {}
    for _, weapon in ipairs(weapons) do
        for _, row in ipairs(weapon.swaps or {}) do
            local now = read_field(row.parts[1].field)
            local shot = now and now ~= default_of(row.parts[1].field) and by_id[now]
            if shot and shot.key and shot.key ~= weapon.key then packages.require_package(shot.key, shot.label) end
        end
    end
end

-- Items the game has but does not offer (settings.unlocks). Two lists decide what can be picked:
-- game.dll's stratagem list (blocks behind a pointer array the function at LIST_RVA loads with a LEA;
-- block +0x80 bit 0x02 = selectable) and the game's item registry (the root behind the MOV at
-- REGISTRY_MOV; rows of 184 bytes: +0 index, +4 record key, +8 key, +12 type (1 equipment, 10 stratagem),
-- +20 status 0/1 locked, 2/4 available; maps of 24 bytes: index, record key, key; a count and a ready
-- gate). A stratagem is unlocked by its selectable bit and its row's status; equipment by its row's
-- status, or, when the registry has no row for it, by a new row copied from a template item of the same
-- class (+0/+4/+8 its own, status 2; the class table behind the MOV at CLASS_MOV maps a model to its
-- key and class: entries of 32 bytes, +0 key, +8 model low, +12 model high, +16 class). The code bytes
-- are checked once (another build turns this off), every row's identity before each write. Off puts back
-- what was changed, while it still holds our value; a row added stays until the game restarts. Checked
-- every 2 s (the game can rebuild the registry between the menu and the ship).
settings.unlock = { next_check = 0, state = {}, changed = {},
    LIST_RVA = 0x136FC20, LIST_LEA = 0x136FC37, REGISTRY_MOV = 0x136FDF0, CLASS_MOV = 0x11E7C65,
    LIST_CODE = '\72\137\92\36\8\72\139\217\133\210\117', CLASS_BYTES = 0x1B20,
    COUNT = 0x1CE0, ROWS = 0x1CE4, MAPS = 0xB9CE4, GATE = 0xDDCF8, ROW = 184, MAP = 24, MOST = 4096 }
(function()   -- (a function of its own: the main chunk is at Lua's 200 locals)
    local U = settings.unlock
    local ZERO_ROW, ZERO_MAP = string.rep('\0', U.ROW), string.rep('\0', U.MAP)
    local function at32(at)
        local b = api.read(at, 4)
        return b and #b == 4 and u32(b, 0) or nil
    end
    local function ptr(at)
        local b = api.read(at, 8)
        return b and #b == 8 and u32(b, 0) + u32(b, 4) * 4294967296 or nil
    end
    local function put32(b, at, v) return b:sub(1, at) .. u32_bytes(v) .. b:sub(at + 5) end
    -- the address a 7-byte RIP-relative instruction at `at` refers to, and its bytes
    local function target(at)
        local b = api.read(at, 7)
        if not b or #b ~= 7 then return nil end
        local d = u32(b, 3)
        if d >= 0x80000000 then d = d - 0x100000000 end
        return at + 7 + d, b
    end

    -- game.dll's stratagem pointer array, the registry's slot and the class table's slot, once
    function U.anchors()
        if U.list then return true end
        local handle = ffi.load('kernel32').GetModuleHandleA('game.dll')
        if handle == nil then return nil, 'game.dll not found' end
        local base = tonumber(ffi.cast('uintptr_t', handle))
        if api.read(base + U.LIST_RVA, #U.LIST_CODE) ~= U.LIST_CODE then return nil, 'unavailable: another game build' end
        local list, lea = target(base + U.LIST_LEA)
        local m = lea and lea:byte(3)
        if not list or lea:byte(2) ~= 0x8D or (lea:byte(1) ~= 0x48 and lea:byte(1) ~= 0x4C) or m % 8 ~= 5 or m >= 64 then
            return nil, 'unavailable: another game build'
        end
        local slot, mov = target(base + U.REGISTRY_MOV)
        local classes, cmov = target(base + U.CLASS_MOV)
        if not slot or mov:sub(1, 3) ~= '\72\139\5' or not classes or cmov:sub(1, 3) ~= '\72\139\29' then
            return nil, 'unavailable: another game build'
        end
        U.list, U.slot, U.classes = list, slot, classes
        return true
    end

    -- The registry now: { root, count, maps }, or nil and why.
    local function registry()
        local ok, why = U.anchors()
        if not ok then return nil, why end
        local root = ptr(U.slot)
        if not root or root < 65536 or at32(root + U.GATE) ~= 12 then return nil, 'waiting for the game\'s item list' end
        local count = at32(root + U.COUNT)
        if not count or count < 1 or count > U.MOST then return nil, 'waiting for the game\'s item list' end
        local maps = api.read(root + U.MAPS, count * U.MAP)
        if not maps or #maps ~= count * U.MAP then return nil, 'waiting for the game\'s item list' end
        return { root = root, count = count, maps = maps }
    end

    -- The row (index, address, bytes) mapped by (record key, key), nil when there is none, false and why
    -- when it is not what it should be.
    local function row_of(s, record, key, size)
        local index
        for k = 0, s.count - 1 do
            if u32(s.maps, k * U.MAP + 4) == record and u32(s.maps, k * U.MAP + 8) == key then
                if index then return false, 'listed twice in the game\'s item list' end
                index = u32(s.maps, k * U.MAP)
            end
        end
        if not index then return nil end
        if index >= s.count then return false, 'its entry in the game\'s item list differs' end
        local at = s.root + U.ROWS + index * U.ROW
        local row = api.read(at, size or 24)
        if not row or #row ~= (size or 24) or u32(row, 0) ~= index or u32(row, 4) ~= record or u32(row, 8) ~= key then
            return false, 'its entry in the game\'s item list differs'
        end
        return index, at, row
    end

    -- An item model's key and class in the class table, or nil and why.
    local function class_of(model)
        local p = ptr(U.classes)
        local table_bytes = p and p >= 65536 and api.read(p, U.CLASS_BYTES)
        if not table_bytes or #table_bytes ~= U.CLASS_BYTES then return nil, 'waiting for the game\'s item classes' end
        local key, class
        for at = 0, U.CLASS_BYTES - 32, 32 do
            if u32(table_bytes, at) ~= 0 and u32(table_bytes, at + 8) == model[2] and u32(table_bytes, at + 12) == model[1] then
                if key then return nil, 'unavailable: listed twice in the game\'s item classes' end
                key, class = u32(table_bytes, at), u32(table_bytes, at + 16)
            end
        end
        if not key then return nil, 'unavailable: not in the game\'s item classes' end
        return key, class
    end

    -- Writes { address, old, new } in order, each only over its old bytes; undone if one fails.
    local function apply(writes)
        for k, w in ipairs(writes) do
            if api.read(w[1], #w[2]) ~= w[2] or not api.write(w[1], w[3]) or api.read(w[1], #w[3]) ~= w[3] then
                for j = k - 1, 1, -1 do api.write(writes[j][1], writes[j][2]) end
                return false
            end
        end
        return true
    end

    -- What turning `item` on writes now: a list of writes (empty = already available), or nil and why.
    -- appended: the writes add a row.
    function U.writes(item, s)
        if item.strat then
            local block = ptr(U.list + 8 * item.strat)
            local name = block and block >= 65536 and ptr(block + 0x10)
            if not name or name < 65536 or not api.read(name, 1) then return nil, 'waiting for the stratagem list' end
            local index, at, row = row_of(s, item.record, item.key)
            if not index then return nil, index == nil and 'unavailable: not in the game\'s item list' or at end
            if u32(row, 12) ~= 10 then return nil, 'unavailable: its entry in the game\'s item list differs' end
            local byte, state = api.read(block + 0x80, 1), u32(row, 20)
            if not byte or #byte ~= 1 then return nil, 'unavailable: its flags cannot be read' end
            if state ~= 0 and state ~= 1 and state ~= 2 and state ~= 4 then
                return nil, 'unavailable: unknown status ' .. state .. ' in the game\'s item list'
            end
            local writes, b = {}, byte:byte()
            if math.floor(b / 2) % 2 == 0 then writes[#writes + 1] = { block + 0x80, byte, string.char(b + 2) } end
            if state ~= 2 and state ~= 4 then writes[#writes + 1] = { at + 20, u32_bytes(state), u32_bytes(2) } end
            if not (U.changed[item.id] and U.changed[item.id].root == s.root) then
                local text = api.read(name, 64)
                log(string.format('unlock %s: stratagem block %s (%s), item list %s: row %d of %d (status %d, flag %d)',
                    item.id, hex(block), text and text:match('^([%w%p ]*)') or '?', hex(s.root), index, s.count, state, b))
            end
            return writes
        end
        local key, class = class_of(item.model)
        if not key then return nil, class end
        if item.key and key ~= item.key then return nil, 'unavailable: its item class differs' end
        local index, at, row = row_of(s, key, key)
        if index == false then return nil, 'unavailable: ' .. at end
        if index then
            local state = u32(row, 20)
            if u32(row, 12) ~= 1 then return nil, 'unavailable: its entry in the game\'s item list differs' end
            if state == 2 or state == 4 then return {} end
            if state ~= 0 and state ~= 1 then return nil, 'unavailable: unknown status ' .. state .. ' in the game\'s item list' end
            return { { at + 20, u32_bytes(state), u32_bytes(2) } }
        end
        local template, tclass = item.template_key, item.class
        if not template then
            template, tclass = class_of(item.template)
            if not template then return nil, tclass end
        end
        if tclass ~= class then return nil, 'unavailable: its template is another kind of item' end
        local tindex, _, trow = row_of(s, template, template, U.ROW)
        if not tindex then return nil, tindex == nil and 'waiting for the game\'s item list' or 'unavailable: its template differs' end
        local tstate = u32(trow, 20)
        if u32(trow, 12) ~= 1 or (tstate ~= 0 and tstate ~= 1 and tstate ~= 2 and tstate ~= 4) then
            return nil, 'unavailable: its template differs'
        end
        if s.count >= U.MOST then return nil, 'unavailable: the game\'s item list is full' end
        local tmap
        for k = 0, s.count - 1 do
            if u32(s.maps, k * U.MAP) == tindex and u32(s.maps, k * U.MAP + 4) == template and u32(s.maps, k * U.MAP + 8) == template then
                tmap = s.maps:sub(k * U.MAP + 1, (k + 1) * U.MAP)
            end
        end
        local row_at, map_at = s.root + U.ROWS + s.count * U.ROW, s.root + U.MAPS + s.count * U.MAP
        if not tmap or api.read(row_at, U.ROW) ~= ZERO_ROW or api.read(map_at, U.MAP) ~= ZERO_MAP then
            return nil, 'unavailable: the game\'s item list differs'
        end
        local new_row = put32(put32(put32(put32(trow, 0, s.count), 4, key), 8, key), 20, 2)
        local new_map = put32(put32(put32(tmap, 0, s.count), 4, key), 8, key)
        log(string.format('unlock %s: no row in the item list %s (%d rows): adding row %d (key %08X, class %d, from the row of %08X)',
            item.id, hex(s.root), s.count, s.count, key, class, template))
        return { { row_at, ZERO_ROW, new_row }, { map_at, ZERO_MAP, new_map },
                 { s.root + U.COUNT, u32_bytes(s.count), u32_bytes(s.count + 1) } }, nil, true
    end

    local function set(item, state)
        if state ~= U.state[item.id] then
            U.state[item.id] = state
            ui.version = ui.version + 1
            if state ~= 'on' and state ~= 'off' then log('unlock ' .. item.id .. ': ' .. state) end
        end
    end

    function U.check()
        local s, why
        for _, item in ipairs(settings.UNLOCKS) do
            local done = U.changed[item.id]
            if not settings.unlocks[item.id] then
                if done and not s then s, why = registry() end
                -- only while the registry is the one we changed (a rebuilt one holds the game's own values)
                if done and s and s.root == done.root then
                    for _, w in ipairs(done.flips) do
                        if api.read(w[1], #w[3]) == w[3] then api.write(w[1], w[2]) end
                    end
                    if #done.flips > 0 then log('unlock ' .. item.id .. ': locked again (' .. #done.flips .. ' value(s) put back)') end
                    done.flips = {}
                    if not done.added then U.changed[item.id] = nil end
                elseif done and s then
                    U.changed[item.id] = nil
                end
                set(item, U.changed[item.id] and 'off after the game restarts' or 'off')
            else
                if not s then s, why = registry() end
                if not s then
                    set(item, why)
                else
                    local writes, wrong, added = U.writes(item, s)
                    if not writes then
                        set(item, wrong)
                    elseif #writes > 0 and not apply(writes) then
                        set(item, 'unavailable: the game\'s memory could not be written')
                    else
                        if not done or done.root ~= s.root then done = { root = s.root, flips = {} }; U.changed[item.id] = done end
                        if added then
                            done.added = true
                            s = nil   -- the next item reads the grown list
                            log('unlock ' .. item.id .. ': added to the item list')
                        elseif #writes > 0 then
                            for _, w in ipairs(writes) do done.flips[#done.flips + 1] = w end
                            log('unlock ' .. item.id .. ': unlocked (' .. #writes .. ' value(s) set)')
                        end
                        set(item, 'on')
                    end
                end
            end
        end
    end
end)()

-- Arc chains with other players (issue #41): chain length / split (and the charge's arc multipliers)
-- are this PC's only; another player's game arcs with the game's values, and the arcs neither agrees on
-- stay on screen. Unless settings.arc_mp, while the game lists more than one player these fields hold
-- the game's values (checked every second), and get yours back once you are alone. Player count: the
-- player manager +0x84 (HD2Runtime 0.30.3 event natives, game build F5FEE03DCFDB), its slot taken from
-- the MOV at GLOBAL_MOV and the count's offset proven by its read 10 bytes on.
settings.arc = { next_check = 0, paused = false, state = 'solo',
    GLOBAL_MOV = 0x62C71A, COUNT_CODE = '\68\139\145\132\0\0\0', COUNT = 0x84, MOST = 4 }
function MOD.solo(p) p.field.solo = true; return p end
function MOD.same(p) return p end
(function()
    local A = settings.arc
    -- players in the game now, or nil and why (another game build: never known)
    function A.players()
        if A.slot == nil then
            A.slot = false
            local handle = ffi.load('kernel32').GetModuleHandleA('game.dll')
            if handle == nil then return nil, 'game.dll not found' end
            local at = tonumber(ffi.cast('uintptr_t', handle)) + A.GLOBAL_MOV
            local b = api.read(at, 10 + #A.COUNT_CODE)   -- the MOV (7 bytes), 3 more, then the count's read
            if b and #b == 10 + #A.COUNT_CODE and b:sub(1, 3) == '\72\139\13' and b:sub(11) == A.COUNT_CODE then
                local d = u32(b, 3)
                if d >= 0x80000000 then d = d - 0x100000000 end
                A.slot = at + 7 + d
            end
        end
        if not A.slot then return nil, 'unavailable: another game build' end
        local p = api.read(A.slot, 8)
        local manager = p and #p == 8 and u32(p, 0) + u32(p, 4) * 4294967296
        local c = manager and manager >= 65536 and api.read(manager + A.COUNT, 4)
        local count = c and #c == 4 and u32(c, 0)
        if not count or count > A.MOST then return 0 end   -- no session yet
        return count
    end
    -- every changed solo field: { field, your value }
    local function changed()
        local out = {}
        for _, o in ipairs(overrides) do
            local w = by_hash[o.hash]
            local p = w and w.by_id[o.id]
            if p and p.field.solo then out[#out + 1] = { p.field, o.value } end
        end
        return out
    end
    function A.check()
        local count, why = A.players()
        local others = count and count > 1
        A.state = why or (others and (count .. ' players') or 'solo')
        local hold = others and settings.changes and not settings.arc_mp
        if hold then
            local held = 0
            for _, c in ipairs(changed()) do
                local d = default_of(c[1])
                if d ~= nil and read_field(c[1]) ~= d and write_field(c[1], d) then held = held + 1 end
            end
            if not A.paused then log('arc chains: ' .. count .. ' players, the game\'s values (' .. held .. ' field(s))')
            elseif held > 0 then
                ui.message = { text = 'Arc chains use the game\'s values while other players are in your game (see Settings).',
                               till = api.now() + 5 }
            end
            A.paused = true
        elseif A.paused then
            A.paused = false
            local n = 0
            if settings.changes then
                for _, c in ipairs(changed()) do
                    if write_field(c[1], c[2]) then n = n + 1 end
                end
            end
            log('arc chains: ' .. (others and 'allowed with other players' or 'solo') .. ', your values back (' .. n .. ' field(s))')
        end
        return A.paused
    end
end)()

-- Speedloaders and stripper clips (issue #45): an empty P-4 Senator takes a speedloader of 6, an empty
-- R-2124 Constitution a clip of 5, whatever its capacity: the reload animation sets the number, no table
-- does. The 'Rounds per speedloader / clip' rows: once the game has put one in, the live rounds component
-- gets the rest from the spare rounds (or gives the difference back). Live rounds: game.dll's manager
-- (HD2 HUD Plus's layout for this build): +40 map live entity id -> row, +64 row -> owner (entity hash +0,
-- id +8), +88 rows of 20 bytes: +0 spare rounds, +4 magazine in use (0 / 1), +8 / +12 rounds loaded.
KINDS[T_ROUNDS].CLIPS = { ['8D3D52A3B2F19402'] = { count = 6, name = 'speedloader' },   -- P-4 Senator
                          ['7B75E5132FFD4CA6'] = { count = 5, name = 'clip' } }          -- R-2124 Constitution
KINDS[T_ROUNDS].live = { RVA = 0x3326CF0, seen = {}, told = 0, next_check = 0, targets = {}, any = false }
;(function()
    local L = KINDS[T_ROUNDS].live
    local function pointer(at)
        local b = api.read(at, 8)
        if not b or #b ~= 8 or u32(b, 4) > 32767 then return nil end
        local n = u32(b, 0) + u32(b, 4) * 4294967296
        return n >= 65536 and n or nil
    end
    -- game.dll, when it is the build the layout is known for
    local function game()
        if L.base ~= nil then return L.base end
        L.base = false
        local base = rawget(_G, 'TEST_GAME_BASE')
        if not base then
            local handle = ffi.load('kernel32').GetModuleHandleA('game.dll')
            base = handle ~= nil and tonumber(ffi.cast('uintptr_t', handle))
        end
        local dos = base and api.read(base, 64)
        local pe = dos and #dos == 64 and u32(dos, 60)
        local head = pe and api.read(base + pe, 16)
        if head and head:sub(1, 4) == 'PE\0\0' and u32(head, 8) == GAME_STAMP then L.base = base
        else log('clips: off (game.dll is another build)') end
        return L.base
    end
    -- every second: the weapons whose clip is changed, by entity bytes
    function L.refresh()
        L.targets, L.any = {}, false
        for hash in pairs(KINDS[T_ROUNDS].CLIPS) do
            local w = by_hash[hash]
            local p = w and w.by_id.rounds_per_clip
            local now = p and settings.changes and read_field(p.field)
            if now and now ~= p.field.default then
                L.targets[w.key] = { count = now, rounds = p.field.rounds, name = w.name }
                L.any = true
            end
        end
    end
    -- the magazine's capacity (rounds)
    function L.capacity(t, sel)
        local cap = read_field(field_at(T_ROUNDS, t.rounds + 72 + sel * 4, 'f32', 100000))
        return cap and cap >= 1 and math.floor(cap) or nil
    end
    -- the clip that went in makes `count` rounds loaded (capacity and spare rounds allowing); the new loaded / spare
    function L.top_up(t, row, sel, loaded, spare)
        local cap = L.capacity(t, sel)
        local want = math.min(t.count, loaded + spare)
        if cap then want = math.min(want, cap) end
        if want == loaded or want < 1 then return loaded, spare end
        local left = spare + loaded - want
        if api.write(row + 8 + sel * 4, u32_bytes(want)) and api.write(row, u32_bytes(left)) then return want, left end
        return loaded, spare
    end
    -- one live manager's map + owners: its rows by live entity id ({ index, key }), or nil and why
    function L.rows_of(manager, map_at, owners_at)
        local h = api.read(manager + map_at, 20)
        if not h or #h ~= 20 then return nil, 'no map header' end
        local slots, cap, empty = u32(h, 0) + u32(h, 4) * 4294967296, u32(h, 8), u32(h, 12)
        local p2 = 1
        while p2 < cap do p2 = p2 * 2 end
        if slots < 65536 or cap < 1 or cap > 65536 or p2 ~= cap then return nil, 'map header ' .. slots .. ' ' .. cap end
        local map, owners = api.read(slots, cap * 8), pointer(manager + owners_at)
        if not (map and #map == cap * 8 and owners) then return nil, 'map or owners unreadable' end
        local out = {}
        for i = 0, cap - 1 do
            local id, index = u32(map, i * 8), u32(map, i * 8 + 4)
            if id ~= empty and id ~= 4294967295 and index < 4096 then
                local owner = pointer(owners + index * 8)
                local identity = owner and api.read(owner, 12)
                if identity and #identity == 12 and u32(identity, 8) == id then
                    out[id] = { index = index, key = identity:sub(1, 8) }
                end
            end
        end
        return out
    end
    -- the rounds manager: game.dll + 0x3326CF0 in game (HUD Plus has + 0x3326EF0, empty in game), else found by its shape in
    -- game.dll's data (a page a frame): a map whose every live owner is a rounds-fed weapon
    function L.looks(at)
        local live = at and L.rows_of(at, 40, 64)
        if not (live and pointer(at + 88)) then return false end
        local any = false
        for _, e in pairs(live) do
            if not tables[T_ROUNDS].index[e.key] then return false end
            any = true
        end
        return any
    end
    L.SCAN_FROM, L.SCAN_TO = 0x3300000, 0x3360000
    function L.manager(base)
        local known = pointer(base + L.RVA)
        if known and L.looks(known) then return known end
        if L.found and L.looks(L.found) then return L.found end
        L.found = nil
        if not L.page or L.page >= L.SCAN_TO then
            if L.page and api.now() < (L.rest or 0) then return nil end
            L.rest = api.now() + 3   -- a pass takes 96 frames; then 3 s between passes
            L.page = L.SCAN_FROM
            if L.raw ~= tostring(known) then
                L.raw = tostring(known)
                local function raw(rva)
                    local b = api.read(base + rva, 8)
                    return b and #b == 8 and string.format('%08X%08X', u32(b, 4), u32(b, 0)) or 'nothing readable'
                end
                log(string.format('clips: game.dll+0x%X holds %s (magazine manager %s, heat %s); searching game.dll+0x%X-0x%X',
                    L.RVA, raw(L.RVA), raw(0x3326848), raw(0x3326F48), L.SCAN_FROM, L.SCAN_TO))
            end
        end
        local page = L.page
        L.page = page + 4096
        local blob = api.read(base + page, 4096)
        if not blob or #blob ~= 4096 then return nil end
        for k = 0, 511 do
            local lo, hi = u32(blob, k * 8), u32(blob, k * 8 + 4)
            if hi > 0 and hi <= 32767 and lo % 8 == 0 then
                local at = lo + hi * 4294967296
                if L.looks(at) then
                    L.found = at
                    log(string.format('clips: rounds manager found at game.dll+0x%X (expected +0x%X)', page + k * 8, L.RVA))
                    return at
                end
            end
        end
        return nil
    end
    -- every frame while a clip is changed: a weapon that was empty and, within 0.4 s, got at least the
    -- game's clip (all at once or a round per frame; single rounds take far longer) just took its clip
    L.WINDOW = 0.4
    function L.step()
        if not (L.any or L.watch) then return end
        local base = game()
        local manager = base and tables[T_ROUNDS] and L.manager(base)
        local live, why = nil, 'no rounds manager'
        if manager then live, why = L.rows_of(manager, 40, 64) end
        local rows = live and pointer(manager + 88)
        if not rows then
            if L.why ~= why then L.why = why; log('clips: waiting (' .. tostring(why or 'no rows') .. ')') end
            return
        end
        if L.why ~= false then
            L.why = false
            log(string.format('clips: rounds manager 0x%X, rows 0x%X', manager, rows))
        end
        local now = api.now()
        local present = {}
        for id, e in pairs(live) do
            local key = e.key
            local t = L.targets[key]
            local name = t and t.name or (L.watch and L.watch(key))
            if name then
                present[id] = true
                local row = rows + e.index * 20
                local s = api.read(row, 16)
                local spare = s and #s == 16 and u32(s, 0)
                local sel = spare and u32(s, 4)
                if spare and sel <= 1 and spare < 100000 then
                    local loaded = u32(s, 8 + sel * 4)
                    local last = L.seen[id]
                    local same = last and last.key == key and last.sel == sel
                    local clip = KINDS[T_ROUNDS].CLIPS[string.format('%08X%08X', u32(key, 4), u32(key, 0))]
                    if not same then
                        last = { key = key, sel = sel }
                        if clip and L.told < 200 then
                            L.told = L.told + 1
                            log(string.format('clips: %s live (id %d, row %d): spare %d, magazine %d, rounds %d / %d',
                                name, id, e.index, spare, sel, u32(s, 8), u32(s, 12)))
                        end
                    else
                        if loaded < last.loaded then last.done = nil end   -- fired: a new reload may follow
                        if loaded == 0 then last.empty = nil
                        elseif last.loaded == 0 then last.empty = now end
                        local was = loaded
                        if t and clip and last.empty and not last.done and now - last.empty <= L.WINDOW and loaded >= clip.count and loaded < 1000 then
                            last.done = true
                            loaded, spare = L.top_up(t, row, sel, loaded, spare)
                            if L.told < 200 then
                                L.told = L.told + 1
                                log('clips: ' .. t.name .. ' took ' .. was .. ', now ' .. loaded .. ' (spare ' .. spare .. ')')
                            end
                        end
                    end
                    last.loaded, last.spare = loaded, spare
                    L.seen[id] = last
                end
            end
        end
        for id in pairs(L.seen) do if not present[id] then L.seen[id] = nil end end
    end
end)()

local function tick()
    state.frame = state.frame + 1
    local now = api.now()
    if state.phase == 'building' then
        state.build_some()
    elseif state.phase == 'preparing' then
        prepare(now + FRAME_BUDGET)
    elseif state.phase == 'ready' then
        KINDS[TYPES.throwable].update_launch()
        if #pending > 0 and now >= next_retry then
            if apply_config(now + FRAME_BUDGET) then
                next_retry = now + 2
                if #pending == 0 then log('all saved values applied (' .. state.applied .. ')') end
            end
        end
        if config_dirty_at and now >= config_dirty_at then save_config() end
        if now >= settings.unlock.next_check then
            settings.unlock.next_check = now + 2
            local ok, why = pcall(settings.unlock.check)
            if not ok then log('unlock: ' .. tostring(why)) end
        end
        if now >= settings.arc.next_check then
            settings.arc.next_check = now + 1
            local ok, why = pcall(settings.arc.check)
            if not ok then log('arc chains: ' .. tostring(why)) end
        end
        do
            local live = KINDS[T_ROUNDS].live
            if now >= live.next_check then
                live.next_check = now + 1
                local ok, why = pcall(live.refresh)
                if not ok then log('clips: ' .. tostring(why)) end
            end
            if not live.failed then
                local ok, why = pcall(live.step)
                if not ok then live.failed = true; log('clips: off: ' .. tostring(why)) end
            end
        end
        if now >= packages.next_check and not packages.off then
            packages.next_check = now + 1
            local ok, why = pcall(packages.swap_assets)
            if not ok then packages.off = tostring(why); log('packages: off: ' .. packages.off) end
        end
    end

    -- hotkey: one key-state read per frame; the window check only while the key is down
    local vk = VK[hotkey_name] or VK.F8
    local down = key_down(vk)
    if MOD.offline then   -- the offline editor's window is the panel: open as soon as the tables are
        if not ui.open and state.phase == 'ready' then open_panel(true) end
    elseif ui.hotkey_hold then
        if not down then ui.hotkey_hold = nil end   -- a new hotkey: wait until it is let go
    elseif down and not hotkey_was_down and focused_window() then
        open_panel(not ui.open)
    end
    hotkey_was_down = down
    if not ui.open and cursor.raw.saved then pcall(cursor.give_input, now) end
    if ui.open then
        local ok, why = pcall(panel_frame, now)
        if ui.close_request then ui.close_request = nil; open_panel(false) end
        if ok then
            ui.errors = 0
        else
            state.ui_errors = state.ui_errors + 1
            ui.errors = ui.errors + 1
            log('panel error: ' .. tostring(why))
            pcall(clear_gui)
            if ui.errors >= 5 then
                open_panel(false)
                log('panel closed after 5 errors in a row')
            end
        end
    end
    if log_dirty and now >= next_flush then next_flush = now + 1; flush_log() end
end

-- ---------------------------------------------------------------- startup
local ok, failure = pcall(function()
    local loader = rawget(_G, 'CowboyBingusModLoader')
    assert(MOD.offline or type(loader) == 'table' and type(loader.api) == 'number' and loader.api >= 1,
           'Bingus Shared Loader v15 or newer (API 1) is required')
    assert(ffi_ok and ffi, 'LuaJIT FFI is unavailable')
    assert(ffi.abi('64bit'), 'Windows x64 is required')
    assert(type(update) == 'function', 'the game update hook is unavailable')
    api = build_api()
    local cell = ffi.new('float[1]')
    f32_bytes = function(value)
        cell[0] = value
        return ffi.string(cell, 4)
    end
    build_input()
    sr = rawget(_G, 'stingray')
    assert(type(sr) == 'table', 'the engine (stingray) is unavailable')
    load_config()
    presets.load_presets()
end)

if not ok then
    state.phase, state.status = 'gave_up', tostring(failure)
    print('[' .. MOD.global .. '] ' .. tostring(failure))
    if api then pcall(flush_log) end
    return
end

set_status('searching', 'waiting for the scan')
pcall(flush_log)

local BUS = rawget(_G, 'OCLAW_UPDATE_BUS')
if not BUS then
    BUS = { jobs = {}, base = update }
    if type(BUS.base) ~= 'function' then return end
    local dispatcher
    dispatcher = function(...)
        local ok, first, second = pcall(BUS.base, ...)
        for _, job in pairs(BUS.jobs) do pcall(job) end
        if ok then return first, second end
    end
    BUS.dispatcher = dispatcher
    _G.OCLAW_UPDATE_BUS = BUS
    update = dispatcher
end
BUS.jobs[MOD.global] = tick

local own = api.address_of(NEEDLE)
local skip_low = (own or LUA_HEAP_LIMIT) < LUA_HEAP_LIMIT
hub = rawget(_G, HUB_NAME)
if type(hub) ~= 'table' or hub.version ~= HUB_VERSION then
    hub = new_hub(api, skip_low)
    rawset(_G, HUB_NAME, hub)
    BUS.jobs[HUB_NAME] = hub.tick
end
hub.register({ name = MOD.title, searching = searching, wants = wants, handle = handle_table,
               after_pass = after_pass })
