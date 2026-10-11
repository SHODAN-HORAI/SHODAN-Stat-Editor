-- HD2-Addon: mods/shodan/stat_editor
-- SHODAN Stat Editor v2.4.0 by SHODAN. Requires Bingus Shared Loader (API 1).
local MOD = { global = 'ShodanStatEditor', title = 'SHODAN Stat Editor', version = '2.4.0', author = 'SHODAN', log = 'SHODANStatEditor.log' }
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
    { 'P-69 Veto', 'Secondary', 'C780BCD79547DA0F', '' },
    { 'P-72 Crisper', 'Secondary', '3F92BA65EF65CCA9', '' },
    { 'P-92 Warrant', 'Secondary', 'CF8934FF6567A42D', '' },
    { 'P/40-K Bolt Pistol', 'Secondary', 'DBB6C961C59FADC1', '' },
    { 'PLAS-15 Loyalist', 'Secondary', 'AA69A60D74A3EC54', '' },
    { 'SG-22 Bushwhacker', 'Secondary', '2B28E17FFED05F7C', '' },
    { '40-K Meltagun', 'Support', '6CFCC7F8801A0266', '' },
    { 'AC-8 Autocannon', 'Support', 'A8CFFB316F0B5C5F', '' },
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
    { 1979913877, 'Eagle 110mm Rocket Pods', 'eagle', { '397792815583DA29' }, { { 'P', 82, 'Projectile' }, { 'D', 248, 'Direct hit' }, { 'X', 229, 'Blast radius' }, { 'D', 403, 'Blast' } } },
    { 4119049995, 'Eagle 500kg Bomb', 'eagle', { 'E44B691DC039A505' }, { { 'P', 239, 'Projectile' }, { 'D', 251, 'Direct hit' }, { 'X', 193, 'Blast radius' }, { 'D', 421, 'Blast' }, { 'X', 277, 'Burst radius' }, { 'D', 453, 'Burst' } } },
    { 1238358532, 'Eagle Airstrike', 'eagle', { '2EA01CB1676ACA29' }, { { 'P', 170, 'Projectile' }, { 'D', 234, 'Direct hit' }, { 'X', 194, 'Blast radius' }, { 'D', 422, 'Blast' } } },
    { 3656370131, 'Eagle Cluster Bomb', 'eagle', { '9D4F7CB4EB34515D' }, { { 'P', 286, 'Projectile' }, { 'D', 234, 'Direct hit' }, { 'X', 417, 'Burst radius' }, { 'D', 388, 'Burst' }, { 'P', 131, 'Shrapnel projectile' }, { 'D', 32, 'Shrapnel direct hit' }, { 'X', 162, 'Shrapnel blast radius' } } },
    { 4196275240, 'Eagle Gas Airstrike', 'eagle', { 'DBB286AD7ED9DF96' }, { { 'P', 188, 'Projectile' }, { 'D', 234, 'Direct hit' }, { 'X', 331, 'Blast radius' }, { 'D', 391, 'Blast' } } },
    { 2040137691, 'Eagle Napalm Airstrike', 'eagle', { '27BB558C893383CC' }, { { 'P', 141, 'Projectile' }, { 'D', 234, 'Direct hit' }, { 'X', 359, 'Blast radius' }, { 'D', 390, 'Blast' } } },
    { 1685231450, 'Eagle Smoke Strike', 'eagle', { '1B3BCADABC7EF8D6' }, { { 'P', 130, 'Projectile' }, { 'D', 234, 'Direct hit' }, { 'X', 75, 'Blast radius' } } },
    { 2808191861, 'Eagle Strafing Run', 'eagle', { '23A60681DD4383EC' }, { { 'P', 16, 'Projectile' }, { 'D', 218, 'Direct hit' }, { 'X', 50, 'Blast radius' }, { 'D', 367, 'Blast' } } },
    { 3923676543, 'FAF-14 Spear', 'support', { 'C57F85252B7D853B', '73F8498BFFDCF415' }, {  } },
    { 1432571981, 'FLAM-40 Flamethrower', 'support', { 'E90F771A36FB441E', '73F8498BFFDCF415' }, {  } },
    { 3343676429, 'GL-21 Grenade Launcher', 'support', { '20225DEE487C9F5F', '73F8498BFFDCF415' }, {  } },
    { 512147393, 'GL-28 Belt-Fed Grenade Launcher', 'support', { 'B7791DA91F13488C', '73F8498BFFDCF415' }, {  } },
    { 153819019, 'GL-52 De-Escalator', 'support', { '2F67BF9C4F560C02', '73F8498BFFDCF415' }, {  } },
    { 1298599997, 'GR-8 Recoilless Rifle', 'support', { 'DDEE9646723E09D3', '73F8498BFFDCF415' }, {  } },
    { 2822568285, 'LAS-98 Laser Cannon', 'support', { 'FDE262593307CA2F', '73F8498BFFDCF415' }, {  } },
    { 2625074523, 'LAS-99 Quasar Cannon', 'support', { '67AC082FF6D142F3', '73F8498BFFDCF415' }, {  } },
    { 3455841218, 'M-1000 Maxigun', 'support', { '73B63D637973C7A4', '73F8498BFFDCF415' }, {  } },
    { 14345846, 'M-105 Stalwart', 'support', { '31C4DD88C1450282', '73F8498BFFDCF415' }, {  } },
    { 533318241, 'MG-206 Heavy Machine Gun', 'support', { '0FD8B759412815DD', '73F8498BFFDCF415' }, {  } },
    { 458198946, 'MG-43 Machine Gun', 'support', { '94C5114EBA59AA21', '73F8498BFFDCF415' }, {  } },
    { 3288352984, 'MGX-42 Bullet Storm', 'support', { 'C87555EED1E9F092', '73F8498BFFDCF415' }, {  } },
    { 2232989803, 'MLS-4X Commando', 'support', { 'A0E691598F32932F', '73F8498BFFDCF415' }, {  } },
    { 1337271929, 'MS-11 Solo Silo', 'support', { 'DE18775FA447A9BF', 'FBE75EC44E7C9A50' }, {  } },
    { 1063322614, 'Orbital 120mm HE Barrage', 'orbital', { '2D3BD00B1ED411B1' }, { { 'P', 194, 'Round 1 projectile' }, { 'D', 262, 'Direct hit' }, { 'X', 213, 'Round 1 blast radius' }, { 'D', 445, 'Blast' }, { 'P', 137, 'Rounds 2, 3 projectile' }, { 'X', 176, 'Rounds 2, 3 blast radius' } } },
    { 3108516875, 'Orbital 380mm HE Barrage', 'orbital', { 'EF66B417EDC3B1D6' }, { { 'P', 80, 'Round 1 projectile' }, { 'D', 263, 'Direct hit' }, { 'X', 301, 'Round 1 blast radius' }, { 'D', 444, 'Blast' }, { 'P', 266, 'Rounds 2, 3 projectile' }, { 'X', 94, 'Rounds 2, 3 blast radius' } } },
    { 1560416221, 'Orbital Airburst Strike', 'orbital', { '75B131DC1DDC02D5' }, { { 'P', 158, 'Projectile' }, { 'D', 261, 'Direct hit' }, { 'X', 379, 'Blast radius' }, { 'D', 388, 'Blast' }, { 'P', 11, 'Shrapnel projectile' }, { 'D', 190, 'Shrapnel direct hit' }, { 'X', 106, 'Shrapnel blast radius' } } },
    { 1280711447, 'Orbital EMS Strike', 'orbital', { '55F3747B8C27AEF6' }, { { 'P', 74, 'Projectile' }, { 'D', 261, 'Direct hit' }, { 'X', 188, 'Blast radius' }, { 'D', 451, 'Blast' } } },
    { 3193297673, 'Orbital Gas Strike', 'orbital', { '05F3C83A91075766' }, { { 'P', 197, 'Projectile' }, { 'D', 261, 'Direct hit' }, { 'X', 82, 'Blast radius' }, { 'D', 447, 'Blast' } } },
    { 2084654169, 'Orbital Gatling Barrage', 'orbital', { '2F257B91037AC421' }, { { 'P', 77, 'Round 1 projectile' }, { 'D', 218, 'Direct hit' }, { 'X', 266, 'Round 1 blast radius' }, { 'D', 367, 'Round 1 blast' }, { 'P', 42, 'Rounds 2, 3, 4 projectile' } } },
    { 970450596, 'Orbital Laser', 'orbital', { 'EC3575E7A93793BB' }, { { 'D', 513, 'Laser damage' } } },
    { 2902516083, 'Orbital Napalm Barrage', 'orbital', { 'A16AB4FF66AE6970' }, { { 'P', 234, 'Round 1 projectile' }, { 'D', 265, 'Direct hit' }, { 'X', 63, 'Round 1 blast radius' }, { 'D', 266, 'Blast' }, { 'P', 238, 'Rounds 2, 3 projectile' }, { 'X', 74, 'Rounds 2, 3 blast radius' } } },
    { 3523620028, 'Orbital Precision Strike', 'orbital', { 'C897C0D84448AB2C' }, { { 'P', 100, 'Projectile' }, { 'D', 264, 'Direct hit' }, { 'X', 343, 'Blast radius' }, { 'D', 446, 'Blast' } } },
    { 2744472229, 'Orbital Railcannon Strike', 'orbital', { 'AC129AA2DB5EABC9' }, { { 'P', 277, 'Projectile' }, { 'D', 267, 'Direct hit' }, { 'X', 52, 'Burst radius' }, { 'D', 443, 'Burst' } } },
    { 3713568312, 'Orbital Smoke Strike', 'orbital', { 'DA76A06325E692C9' }, { { 'P', 247, 'Projectile' }, { 'D', 261, 'Direct hit' }, { 'X', 75, 'Blast radius' } } },
    { 3279813377, 'Orbital Walking Barrage', 'orbital', { 'CB7F154719F331EC' }, { { 'P', 80, 'Round 1 projectile' }, { 'D', 263, 'Direct hit' }, { 'X', 301, 'Round 1 blast radius' }, { 'D', 444, 'Blast' }, { 'P', 266, 'Rounds 2, 3 projectile' }, { 'X', 94, 'Rounds 2, 3 blast radius' } } },
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
    for _, part in ipairs({ 'CowboyBingus', 'Helldivers2', leaf }) do
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
                seeking = 0xBF3A6789, windup = 0x84CE7EEE }
local KINDS = {
    [T_WEAPON] = { name = 'weapon', stride = 1232, keyed = true },
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
    [T_ORBITAL] = { name = 'orbital beam', stride = 552, keyed = true },
    [T_HEAT] = { name = 'weapon heat', stride = 592, keyed = true },
    [T_SPRAY] = { name = 'spray weapon', stride = 224, keyed = true },
    -- explosions: melee weapons whose strike explodes, by entity -> explosion id (the Breaching
    -- Hammer's; no settings table links it, the game sets it off from the strike itself)
    [T_MELEE] = { name = 'melee weapon', stride = 192, keyed = true, explosions = { ['5F3EC9BDA2BD8553'] = 19 } },
    -- names: the status effects that deal damage, by type (the game's debug names Fire, Gas)
    [T_STATUS] = { name = 'status effect', stride = 152, tail = true, names = { [5] = 'Burning', [32] = 'Heavy burning', [42] = 'Gas', [43] = 'Gas' },
                   -- stuns deal no damage (no damage row of their own); the Illuminate one (41) no weapon applies
                   stuns = { [37] = 'Stun (small)', [38] = 'Stun (medium)', [39] = 'Stun (large)', [40] = 'Stun (massive)' } },
    [TYPES.arc_weapon] = { name = 'arc weapon', stride = 80, keyed = true },
    [TYPES.arc] = { name = 'arc', stride = 104 },
    [TYPES.health] = { name = 'health', stride = 22096, keyed = true,
        -- stratagem id -> sentry gun, for sentries whose stratagem drops a body the panel does not list
        -- (Laser Cannon Sentry, Tesla Tower, Defense Wall Grenade Launcher = the Grenadier Battlement)
        sentry_ids = { [0x393E6019] = '56070F36CFFFA8A8', [0x8F349F3B] = '74599E56F72F9D7E',
                       [0x93D3C05C] = '1D5943301A29C940' } },
    [TYPES.sensor] = { name = 'sensor', stride = 44, keyed = true },
    [TYPES.detector] = { name = 'detector', stride = 24, keyed = true },
    [TYPES.turret] = { name = 'turret', stride = 76, keyed = true },
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
-- bomb count; not offered), +40 fire duration (guns, rockets), +44 time between bombs, +108 run length (m)
KINDS[TYPES.eagle] = { name = 'eagle', stride = 152, keyed = true }
-- Seeking missiles (SeekingMissileComponentData; the MS-11 Solo Silo's missile): +12 guidance on after (s),
-- +28 guidance lost past this angle (deg), +56 / +60 movement / warhead on after (s; the silo's -1: by
-- its script, not offered), +64 max lifetime (s),
-- +68 launch, +72 minimum, +76 cruise speed, +80 acceleration, +88 / +92 turn speed at cruise / slowest.
-- Records of 272 bytes (FileDiver's layout ends at 252; 264 also fits the table, read off by 8 bytes).
KINDS[TYPES.seeking] = { name = 'seeking missile', stride = 272, keyed = true }
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
    [40] = 'Blunt-Force Mitigation', [41] = 'True Grit' }
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
    [0xA189ADB6] = '+ Stamina when hit', [0x14ECCE15] = 'Enemy detection range' }
-- the weapon stat modifiers some passives also carry, by stat
KINDS[TYPES.passive].STATS = {
    [11] = 'Flinch', [12] = 'Ammo capacity', [13] = 'Primary reload speed', [14] = 'Support reload speed',
    [15] = 'Secondary reload speed', [16] = 'Secondary draw speed', [17] = 'Secondary recoil' }

-- kind -> { payload = size, index = key -> payload offset, entries = n, copies = { block address },
-- type = table type }; each stratagem group is under its own key (listed in stratagem_groups)
local tables, parsed_blocks, stratagem_groups = {}, {}, {}

-- Keyed table: bucket array (u64 entity hash, u32 record index, u32 0) holding exactly twice as
-- many buckets as entities, then fixed-stride records. Record bytes can look like buckets, so
-- every candidate bucket count is checked and exactly one must fit.
local function parse_keyed(blob, stride, spec)
    local MAX_UNINDEXED_RECORDS, ZERO8 = 2, string.rep('\0', 8)
    local slack = spec and spec.slack or 0   -- padding after the records
    local total, count, live, top, offset = #blob, 0, 0, -1, 0
    local fits = {}
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
        if count == 2 * live and array > 0 and array % stride == 0 then
            local records = array / stride
            if records > top and records <= live + MAX_UNINDEXED_RECORDS then fits[#fits + 1] = count end
        end
    end
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
    local entry = tables[f.kind]
    if not entry then return nil end
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
    local entry = tables[f.kind]
    if not entry then return false, 'table not found' end
    if read_field(f) == nil then return false, 'current value implausible' end
    if type(value) == 'number' and not MOD.parse_number(value) then return false, 'not a finite number' end
    default_of(f)
    if f.most and value > f.most then value = f.most end
    local bytes, done = encode(f, value), {}
    if not bytes then return false, 'unknown grenade selection' end
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

KINDS[TYPES.items].words = function(t, r)
    local deltas, at, out = tables[TYPES.deltas], KINDS[TYPES.deltas].layout, {}
    local slot = deltas and at and deltas.index[api.read(t.copies[1] + HEADER_BYTES + r + 32, 8) or '']
    if not slot then return out end
    local d = deltas.copies[1] + HEADER_BYTES
    local count, first = peek4(d + at[1] + slot * 8), peek4(d + at[1] + slot * 8 + 4)
    for c = first or 0, (first or 0) + (count or 0) - 1 do
        local comp = peek4(d + at[2] + c * 12)
        if comp == 5 or comp == 266 or comp == 236 or comp == 113 then
            local fd, nd = peek4(d + at[2] + c * 12 + 4), peek4(d + at[2] + c * 12 + 8)
            for x = fd, fd + nd - 1 do
                local offset, size, data = peek4(d + at[3] + x * 12), peek4(d + at[3] + x * 12 + 4), peek4(d + at[3] + x * 12 + 8)
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
    for s = 0, 8 do
        local t, r = spec.find(peek4(base + s * 8 + 4))
        local slot = t and deltas.index[api.read(t.copies[1] + HEADER_BYTES + r + 32, 8) or '']
        if slot then
            local count, first = peek4(d + at[1] + slot * 8) or 0, peek4(d + at[1] + slot * 8 + 4) or 0
            local value, value_at = nil, nil
            for c = first, first + count - 1 do
                if not value and peek4(d + at[2] + c * 12) == 321 then
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

-- A passive's rows: each modifier (named, or by its id), then its weapon stat modifiers.
KINDS[TYPES.passive].resolve = function(entry)
    local spec, t = KINDS[TYPES.passive], tables[entry.passive]
    if not t then return end
    --        type: min, max, small step, big step
    local RANGE = { [0] = { 0, 10, 1, 1 }, [1] = { 0, 1000, 0.5, 5 }, [2] = { 0, 10, 0.05, 0.25 }, [3] = { 0, 600, 0.5, 2 } }
    for k, m in ipairs(t.index.mods) do
        local r = RANGE[m.type]
        if m.id ~= 0 and r then
            local id = string.format('mod_%08X', m.id)
            if entry.by_id[id] then id = id .. '_' .. k end
            add_row(entry, 'Passive', id, spec.MODS[m.id] or string.format('Modifier %08X', m.id), 'f32',
                    { part(id, entry.passive, m.offset, 'f32', 100000) }, r[1], r[2], r[3], r[4])
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
local function status_rows(entry, section, prefix, drow, per)
    for i = 0, 3 do
        local kind = read_field(field_at(T_DAMAGE, drow + 44 + i * 8, 'u32', 100000))
        if not kind or kind == 0 then break end
        local srow = tables[T_STATUS] and tables[T_STATUS].index[kind]
        local sid = srow and read_field(field_at(T_STATUS, srow + 44, 'u32', 100000))
        local qrow = sid and sid > 0 and tables[T_DAMAGE] and tables[T_DAMAGE].index[sid]
        local stun = srow and not qrow and KINDS[T_STATUS].stuns[kind]
        if qrow or stun then
            local name, key = stun or KINDS[T_STATUS].names[kind] or ('Status ' .. kind), prefix .. 'status' .. kind
            add_row(entry, section, key .. '_strength', name .. ' applied per ' .. per, 'f32',
                    { part(key .. '_strength', T_DAMAGE, drow + 48 + i * 8, 'f32', 100000) }, 0, 1000, 0.1, 1)
            local first = qrow and damage_rows(entry, name, key .. '_', qrow, name, 6)   -- no forces: a status has none
            local duration = add_row(entry, name, key .. '_duration', name .. ' duration (s)', 'f32',
                                     { part(key .. '_duration', T_STATUS, srow + 40, 'f32', 100000) }, 0, 600, 0.5, 5)
            local by = qrow and '(other weapons, strikes, hazards, enemies)' or '(other weapons, grenades, strikes)'
            ;(first or duration).note = 'every ' .. name:lower() .. ' source shares ' .. (qrow and 'these ' or 'this ') .. by
        end
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
        proj('velocity', 'Velocity (m/s)', 32, 100000, 10, 100)
        proj('drag', 'Drag factor', 40, 100, 0.05, 0.5)
        proj('gravity', 'Gravity factor', 44, 100, 0.05, 0.5)
        proj('pen_slowdown', 'Penetration slowdown', 64, 100, 0.05, 0.25)
        local impact = read_field(field_at(T_PROJECTILE, p + 144, 'u32', 100000))
        local expiry = read_field(field_at(T_PROJECTILE, p + 156, 'u32', 100000))
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
        local rates = {}
        for n, offset in ipairs({ 4, 8, 12 }) do
            local f = field_at(T_FIRE, fire + offset, 'f32', 100000)
            local v = read_field(f)
            if v and v > 0 then rates[#rates + 1] = { n = n, offset = offset } end
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
            sentry.sentry_defs[#sentry.sentry_defs + 1] = def
            log('stratagem ' .. id_hex(id) .. ': cooldown on ' .. sentry.name)
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
    table.sort(list, function(a, b)
        local fa, fb = FAMILY_ORDER[a.stratagem.family] or 5, FAMILY_ORDER[b.stratagem.family] or 5
        if fa ~= fb then return fa < fb end
        if a.stratagem.family ~= b.stratagem.family then return a.stratagem.family < b.stratagem.family end
        return a.name:lower() < b.name:lower()
    end)
    -- the weapons each vehicle carries (its mounts), listed after it; one entry per weapon entity
    local MOUNTS = { [0x7BDEC47B] = 'Left arm', [0x47775624] = 'Right arm', [0x23CC0657] = 'Gun', [0xCB79FA57] = 'Main gun',
                     [0x409652FC] = 'Driver gun', [0x3ECFB64B] = 'Rack' }
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
                w = { name = entry.name .. ': ' .. (MOUNTS[label or 0] or ('Weapon ' .. (m + 1))), slot = 'Mechas', hash = hash,
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
    unit(TYPES.health, 'health', 'Health', 0, 'u32', 100000, 5, 25)
    unit(TYPES.sensor, 'sight', 'Spotting range (m)', 0, 'f32', 1000, 1, 5)
    unit(TYPES.detector, 'search_min', 'Target search interval, min (s)', 0, 'f32', 60, 0.05, 0.25)
    unit(TYPES.detector, 'search_max', 'Target search interval, max (s)', 4, 'f32', 60, 0.05, 0.25)
    unit(TYPES.turret, 'turn_h', 'Turn speed, horizontal (deg/s)', 12, 'f32', 3600, 1, 10)
    unit(TYPES.turret, 'turn_v', 'Turn speed, vertical (deg/s)', 8, 'f32', 3600, 1, 10)
end

-- A vehicle's rows (by its entity, `key`): its health component: health +0 (i32), armor +280 (the
-- default zone's), then each damageable zone (38 of 552 bytes from +520; +96 name, 0: unused; +216 armor,
-- +232 health, -1: none). Zones are named from MOD.vehicle_parts (by the name's hash), else numbered.
KINDS[TYPES.vehicle].rows = function(entry, key)
    local t = tables[TYPES.health]
    local at = t and t.index[key]
    if not at then return end
    local top = t.copies[1] + HEADER_BYTES
    add_row(entry, 'Vehicle', 'health', 'Health', 'u32', { part('health', TYPES.health, at, 'u32', 10000000) }, 0, 1000000, 50, 500)
    add_row(entry, 'Vehicle', 'armor', 'Armor', 'u32', { part('armor', TYPES.health, at + 280, 'u32', 100) }, 0, 10, 1, 1)
    local n = 0
    for z = 0, 37 do
        local base = at + 520 + z * 552
        local name = peek4(top + base + 96)
        if name and name ~= 0 then
            n = n + 1
            local label = MOD.vehicle_parts[name] or ('Part ' .. n)
            local id = 'zone' .. z
            local health = read_field(field_at(TYPES.health, base + 232, 'u32', 10000000))
            if health then
                add_row(entry, 'Body parts', id .. '_health', label .. ' health', 'u32',
                        { part(id .. '_health', TYPES.health, base + 232, 'u32', 10000000) }, 0, 1000000, 10, 100)
            end
            add_row(entry, 'Body parts', id .. '_armor', label .. ' armor', 'u32',
                    { part(id .. '_armor', TYPES.health, base + 216, 'u32', 100) }, 0, 10, 1, 1)
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
--     offered) and mid-air steering +60; the Hover Pack (skips the launch) its hover speed +176, fuel
--     rates +200 / +204, climb speed (+196 with +180), climb acceleration +168 and climb time limit +156
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
            r(section, 'bp_steer', 'Mid-air steering force', TYPES.jumppack, jump + 60, 'f32', 200, 0.5, 2)
        end
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
    return true
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
            local function e(id, label, offset, min, max, small, big)
                add_row(entry, 'Eagle', id, label, 'f32', { part(id, TYPES.eagle, eagle + offset, 'f32', 100000) }, min, max, small, big)
            end
            local payload = read_field(field_at(TYPES.eagle, eagle + 16, 'u32', 100))
            if payload == 5 then e('eagle_bomb_gap', 'Time between bombs (s)', 44, 0, 10, 0.05, 0.25)
            else e('eagle_fire_time', 'Fire duration (s)', 40, 0, 30, 0.1, 0.5) end
            if (read_field(field_at(TYPES.eagle, eagle + 108, 'f32', 100000)) or 0) > 0 then
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
    if s.vehicle then KINDS[TYPES.vehicle].rows(entry, s.vehicle); return end
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
    if has and (mode == 0 or mode == 3) and fuse and fuse > 0 then
        add_row(entry, 'Throwable', 'fuse', 'Fuse time (s)', 'f32', { part('fuse', TYPES.explosive, ex + 12, 'f32', 100000) }, 0, 60, 0.1, 1)
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
    for _, r in ipairs(seek and {
        { 'launch_speed', 'Launch speed (m/s)', 68, 2000, 5, 25 },
        { 'cruise_speed', 'Cruise speed (m/s)', 76, 2000, 5, 25 },
        { 'min_speed', 'Minimum speed (m/s)', 72, 2000, 5, 25 },
        { 'acceleration', 'Acceleration (m/s2)', 80, 10000, 10, 50 },
        { 'turn_cruise', 'Turn speed at cruise', 88, 100, 0.1, 1 },
        { 'turn_slow', 'Turn speed at slowest', 92, 100, 0.1, 1 },
        { 'lost_angle', 'Loses its target past (deg)', 28, 180, 1, 10 },
        { 'lifetime', 'Max flight time (s)', 64, 600, 1, 5 },
        { 'guidance_after', 'Guidance on after (s)', 12, 60, 0.1, 0.5 },
    } or {}) do
        local id = 'missile_' .. r[1]
        add_row(weapon, 'Missile flight', id, r[2], 'f32', { part(id, TYPES.seeking, seek + r[3], 'f32', 1000000) }, 0, r[4], r[5], r[6])
    end
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

-- ProjectileWeaponComponent +40 is a full 64-bit entity reference. Keep both
-- halves together through read/write/reset/presets; a Lua number cannot hold the hash.
-- Use the grenade entity and native release/activation lifecycle. Special grenade
-- behaviors still require gameplay validation; reference writes alone are insufficient.
KINDS[TYPES.throwable].grenade_row = function(weapon, fire)
    local spec = KINDS[TYPES.throwable]
    if not fire or not spec.grenade_hosts[weapon.hash] then return end
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
        progress.next = progress.next + 1
        if api.now() >= deadline then break end
    end
    if progress.next <= #weapons then return false end
    KINDS[T_PROJECTILE].list_choices()
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
            if not seen[other] then seen[other] = true; names[#names + 1] = other.name end
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
-- opacity: background, %; remember: reopen on the last tab / weapon.
local settings = { changes = true, block_input = true, size = 80, side = 'right', opacity = 90,
                   remember = true, arc_mp = true, last_tab = nil, last_weapon = nil,
                   GITHUB = 'https://github.com/SHODAN-HORAI/SHODAN-Stat-Editor',
                   RANGE = { size = { 50, 100 }, opacity = { 10, 100 } } }

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
    lines[#lines + 1] = 'unlock_unused ' .. onoff(settings.unlock_any())
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
        if name == 'changes' or name == 'block_input' or name == 'remember' then
            settings[name] = value ~= 'off'
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
        elseif name == 'last_tab' then
            settings.last_tab = value
            known = true
        elseif name == 'last_weapon' and value:find('^%x+$') and #value == 16 then
            settings.last_weapon = value:upper()
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
        if w.stratagem and not w.stratagem.def and #STRATAGEMS > 0 and w.stratagem.family ~= 'support' then
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
    local parse = spec.parse or (spec.keyed and parse_keyed or parse_rows)
    local started = api.now()
    local index, info = parse(blob, spec.stride, spec, address)
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
local TABS = { 'Primary', 'Secondary', 'Support', 'Throwables', 'Stratagems', 'Mechas', 'Attachments', 'Armors', 'Presets' }
local LIST_ROWS = 27
local W, H = 1000, 980       -- panel size in its own units

-- The weapons (or stratagems) of a tab; tab '?search': those of every tab whose name holds every
-- word of the search (any case).
local function weapons_in(tab)
    local list, words = {}, nil
    if tab == '?search' then
        words = {}
        for word in ui.search.text:lower():gmatch('%S+') do words[#words + 1] = word end
    end
    for _, weapon in ipairs(weapons) do
        if #weapon.rows > 0 then
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
    return false
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

-- Picks the font for a new gui and binds it: the game UI font when all its parts are loaded,
-- else the engine debug font when loaded, else none (the panel is drawn without text).
local function choose_font(gui)
    local ids, why = read_font_ids()
    if ids then
        local f, m, t = loaded('font', ids.font), loaded('material', ids.material), loaded('texture', ids.atlas)
        if f and m and t then
            step('Gui.material')
            local ink = sr.Gui.material(gui, sr.IdString64.from_hex(ids.material))
            if ink then
                step('Material.set_texture')
                sr.Material.set_texture(ink, sr.IdString64.from_hex('88bac99b00000000'), sr.IdString64.from_hex(ids.atlas))
                return { font = sr.IdString64.from_hex(ids.font), material = sr.IdString64.from_hex(ids.material),
                         text = 'game UI font ' .. ids.font }
            end
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
    ui.row, ui.scroll, ui.settings, ui.binding = 1, 1, false, nil
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
    local s = height / 1080 * settings.size / 100   -- panel units -> 1080p units
    local ox, oy = settings.side == 'left' and 30 * s or width - (W + 30) * s, (height - H * s) / 2
    local gui = ui.gui
    local regions = {}
    local shared_overlay = nil   -- set while the cursor is on a cut-short 'shared with' list
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
    local function width(value, size)
        local key = value .. '|' .. size
        local measure = ui.measured[key]
        if not measure then
            step('Gui.text_extents')
            local ok, lo, hi = pcall(Gui.text_extents, gui, value, ink_font, size)
            if ok and lo and hi then
                local a, b = vx(lo), vx(hi)
                if a and b and b > a then measure = b - a end
            end
            measure = measure or #value * size * 0.5
            if ui.measures > 5000 then ui.measured, ui.measures = {}, 0 end
            ui.measured[key], ui.measures = measure, ui.measures + 1
        end
        return measure
    end
    local function text(value, x, y, size, c, limit, align_right, z)
        if value == nil or value == '' or not ink_font then return end
        size = size * s
        local px = ox + x * s
        if limit or align_right then
            local measure = width(value, size)
            if limit and measure > limit * s then size = size * limit * s / measure; measure = limit * s end
            if align_right then px = px - measure end
        end
        step('Gui.text')
        Gui.text(gui, value, ink_font, size, ink_material, Vector3(px, height - oy - y * s - size * 0.8, z or 953), c or WHITE)
    end
    local function outline(x, y, w, h, c)
        rect(x, y, w, 2, c, 952); rect(x, y + h - 2, w, 2, c, 952)
        rect(x, y, 2, h, c, 952); rect(x + w - 2, y, 2, h, c, 952)
    end
    local function region(key, x, y, w, h, enabled)
        regions[#regions + 1] = { key = key, x = ox + x * s, y = height - oy - (y + h) * s, w = w * s, h = h * s,
                                  enabled = enabled ~= false }
    end
    local function button(key, label, x, y, w, h, enabled, active, ink)
        local hovered = ui.hover == key and enabled ~= false
        local fill = active and color(90, 74, 8) or hovered and color(52, 66, 80) or color(28, 34, 42)
        rect(x, y, w, h, fill, 951)
        outline(x, y, w, h, enabled == false and DIM or (active or hovered) and GOLD or color(70, 82, 94))
        text(label, x + 8, y + (h - 16) / 2, 16, enabled == false and DIM or ink or WHITE, w - 12)
        region(key, x, y, w, h, enabled)
    end

    -- frame
    rect(0, 0, W, H, color(8, 11, 15, math.floor(255 * settings.opacity / 100 + 0.5)), 950)
    outline(0, 0, W, H, GOLD)
    region('panel', 0, 0, W, H, false)
    text('SHODAN STAT EDITOR', 18, 12, 24, GOLD)
    text(hotkey_name .. ' to open/close', W - 56, 16, 15, MUTED, nil, true)
    button('close', 'X', W - 16 - 30, 10, 30, 30, true)
    if rawget(_G, 'SHODAN_PACK_HUB') or rawget(_G, 'SHODAN_SCAN_HUB') then
        text('SHODAN weapon mods are running too: they put their own values back every 5 s', 290, 17, 14, WARN, 540)
    end

    if state.phase ~= 'ready' then
        local found = 0
        for _, kind in ipairs(KIND_ORDER) do if tables[kind] then found = found + 1 end end
        text('Reading the game\'s weapon tables... (' .. found .. ' of ' .. #KIND_ORDER .. ' found)', 18, 70, 18, WHITE)
        return regions
    end

    local tab_x = 16
    for _, tab in ipairs(TABS) do
        local w = #tab * 8 + 20     -- each tab as wide as its name
        button('tab:' .. tab, tab, tab_x, 52, w, 32, true, ui.tab == tab)
        tab_x = tab_x + w + 5
    end
    button('reset_weapon', ui.weapon and ui.weapon.passive and 'Reset passive' or 'Reset weapon', W - 16 - 124, 52, 124, 32, ui.weapon ~= nil and modified(ui.weapon))

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
        text((changed and '* ' or '') .. weapon.name, 24, y + 4, 16, changed and GOLD or WHITE, searching and 226 or 302)
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
        text('Open / close key', x0, y + 6, 16, WHITE, 270)
        button('set:bind', ui.binding and 'Press a key (Esc cancels)' or hotkey_name, 640, y, ui.binding and 316 or 124, 28, true, ui.binding)
        y = y + 36
        choice('Block game input while open', 'block_input', ONOFF, onoff(settings.block_input))
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
        percent('Panel size', 'size')
        choice('Panel side', 'side', { { 'left', 'Left' }, { 'right', 'Right' } }, settings.side)
        percent('Background opacity', 'opacity')
        choice('Remember last tab and weapon', 'remember', ONOFF, onoff(settings.remember))
        choice('Arc chain edits in multiplayer', 'arc_mp', ONOFF, onoff(settings.arc_mp))
        local arc = settings.arc
        text('(untested) ' .. (arc.state:find('^unavailable') and ('Arc chains: player count ' .. arc.state .. '; your values stay.')
             or arc.paused and "Other players are in your game: arc chain length / split use the game's values."
             or settings.arc_mp and 'On: your arc chain length / split apply with other players too (arcs can stay on screen).'
             or "Off: with other players, arc chain length / split use the game's values (else arcs can stay on screen)."),
             x0 + 16, y - 6, 14, arc.paused and WARN or MUTED, W - x0 - 40)
        y = y + 14
        local notes, warn = {}, false
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
        local sure_reset = ui.confirm and ui.confirm.kind == 'reset_all'
        button('reset_all', sure_reset and 'Sure?' or 'Reset all values', x0, y, 188, 28, #overrides > 0, sure_reset)
        text('Resets all values from the current preset to default.', x0 + 16, y + 30, 14, MUTED, W - x0 - 40)
        y = y + 50
        y = y + 16
        rect(x0, y, W - x0 - 16, 1, color(70, 82, 94), 951)
        y = y + 14
        text(MOD.title .. ' v' .. MOD.version, x0, y, 18, GOLD)
        text('Made by SHODAN', x0, y + 30, 16, WHITE)
        text('Bingus Shared Loader by CowboyBingus', x0, y + 54, 16, MUTED)
        y = y + 92
        text('GitHub', x0, y + 6, 16, WHITE)
        text(settings.GITHUB:gsub('^https://', ''), x0 + 90, y + 7, 15, MUTED, 380)
        button('link:github_open', 'Open', 800, y, 88, 28, true)
        button('link:github_copy', 'Copy', 896, y, 88, 28, true)
        y = y + 36
        local log_dir = (data_dir('Logs') or ''):gsub('/', '\\')
        text('Log file', x0, y + 6, 16, WHITE)
        button('link:log_copy', 'Copy', 800, y, 88, 28, true)
        button('link:log_open', 'Folder', 896, y, 88, 28, true)
        text(log_dir .. '\\' .. MOD.log, x0, y + 36, 14, MUTED, W - x0 - 16)
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
                text(row.label, x0, y + bh / 2 - 8, 16, focus and GOLD or WHITE, 236)
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
    end

    -- footer, and the Settings button at the bottom right
    rect(16, H - 64, W - 32, 1, color(70, 82, 94), 951)
    button('settings', ui.settings and 'Back' or 'Settings', W - 16 - 104, H - 54, 104, 34, true, ui.settings)
    if ui.binding then
        text('Press the key that should open and close the panel: F1-F12, Insert, Home, End, Pause or Scroll Lock. Esc cancels.',
             18, H - 56, 14, MUTED, W - 150)
    elseif ui.settings then
        text('Settings are saved at once, in config.txt with your changes.', 18, H - 56, 14, MUTED, W - 150)
    elseif ui.editing then
        text('Type the name: Enter keeps it, Esc cancels. The game sees these keys too, so name presets from a menu.',
             18, H - 56, 14, MUTED, W - 150)
    elseif ui.value and ui.value.setting then
        local r = settings.RANGE[ui.value.setting]
        text(string.format('Type the percent (%d-%d): Enter sets it, Esc cancels.', r[1], r[2]), 18, H - 56, 14, MUTED, W - 150)
    elseif ui.value then
        text('Type the value: Enter sets it, Esc cancels. Values out of range are set to the nearest allowed one.',
             18, H - 56, 14, MUTED, W - 150)
    elseif ui.search.active and not presets_tab then
        text('Type to search: Enter keeps the results, Esc clears the search. The game sees these keys too.',
             18, H - 56, 14, MUTED, W - 150)
    elseif presets_tab then
        text('Up/Down choose, Enter loads, Insert makes a new one, Shift+Insert saves into it, F2 renames, Del deletes.',
             18, H - 56, 14, MUTED, W - 150)
    else
        text('Up/Down choose a stat, Left/Right change it (Shift: bigger steps), click a value or press Enter to type it,',
             18, H - 56, 14, MUTED, W - 150)
    end
    if ui.message then
        text(ui.message.text, 18, H - 34, 14, GOOD, W - 150)
    elseif presets_tab then
        text('Overwriting and deleting ask twice. Changes apply at once and are saved; ' .. #overrides ..
             ' value(s) changed.', 18, H - 34, 14, MUTED, W - 150)
    else
        text('PgUp/PgDn change weapon, Del resets, Ctrl+1-5 loads a weapon preset, Ctrl+Shift+1-5 saves one; ' .. #overrides ..
             ' value(s) changed.', 18, H - 34, 14, MUTED, W - 150)
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
    elseif kind == 'value' and (arg == 'size' or arg == 'opacity') then
        if not ui.value then ui.value = { n = arg, setting = arg, text = tostring(settings[arg]), fresh = true } end
    elseif kind == 'set' then
        local name, value = arg:match('^([%w_]+):?(.*)$')
        if name == 'bind' then ui.binding = not ui.binding or nil
        elseif name == 'changes' then settings.set_changes(value == 'on')
        elseif name == 'block_input' or name == 'remember' then settings[name] = value == 'on'
        elseif name == 'arc_mp' then settings.arc_mp, settings.arc.next_check = value == 'on', 0
        elseif name == 'unlock_all' then
            settings.unlock_all(value == 'on'); settings.unlock.next_check = 0
        elseif name:find('^unlock_') then
            settings.unlocks[name:sub(8)], settings.unlock.next_check = value == 'on', 0
        elseif (name == 'size' or name == 'opacity') and (value == 'up' or value == 'down') then
            local v = settings[name]
            settings.set_percent(name, value == 'up' and math.floor(v / 5) * 5 + 5 or math.ceil(v / 5) * 5 - 5)
        elseif name == 'size' or name == 'opacity' then settings.set_percent(name, tonumber(value) or settings[name])
        elseif name == 'side' then settings.side = value end
        if name ~= 'bind' then mark_config_dirty(); ui.version = ui.version + 1 end
    elseif kind == 'link' then
        local log_file = (data_dir('Logs') or '') .. '/' .. MOD.log
        local done
        if arg == 'github_open' then done = settings.open(settings.GITHUB) and 'Opened the GitHub page in your browser.'
        elseif arg == 'github_copy' then done = settings.copy(settings.GITHUB) and 'GitHub link copied.'
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
    if pressed('PageDown', now) or pressed('PageUp', now) then
        local all = {}
        for _, tab in ipairs(TABS) do for _, w in ipairs(weapons_in(tab)) do all[#all + 1] = w end end
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
            if last and #last.rows > 0 then
                select_weapon(last)
            elseif settings.remember and settings.last_tab then
                for _, t in ipairs(TABS) do if t == settings.last_tab then ui.tab = t end end
            end
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
        if now >= packages.next_check and not packages.off then
            packages.next_check = now + 1
            local ok, why = pcall(packages.swap_assets)
            if not ok then packages.off = tostring(why); log('packages: off: ' .. packages.off) end
        end
    end

    -- hotkey: one key-state read per frame; the window check only while the key is down
    local vk = VK[hotkey_name] or VK.F8
    local down = key_down(vk)
    if ui.hotkey_hold then
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
    assert(type(loader) == 'table' and type(loader.api) == 'number' and loader.api >= 1,
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
