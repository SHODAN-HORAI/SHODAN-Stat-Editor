-- HD2-Addon: mods/shodan/stat_editor
-- SHODAN Stat Editor v2.3.1 by SHODAN. Requires Bingus Shared Loader (API 1).
local MOD = { global = 'ShodanStatEditor', title = 'SHODAN Stat Editor', version = '2.3.1', author = 'SHODAN', log = 'SHODANStatEditor.log' }
-- ammunition types: the game's names, by the text id of the item (its English text)
MOD.ammo_names = {
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
    [0x3262E42D] = '5.5x50mm Explosive',
    [0x3A6AE678] = '8x60mm Penetrator',
    [0x3AF98635] = '15x100mm Emp-Rounds',
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
    [0x7496CC66] = '10g Tri-Ball',
    [0x76321A6C] = '8x60mm High Velocity',
    [0x7AB0ACAD] = '8x60mm Devastator',
    [0x7D628230] = '12x25mm Hollow Point',
    [0x7DDF07F3] = '10g Dual Sabot',
    [0x7DF3409F] = '9x70mm Penetrator',
    [0x82820B4B] = '9x20mm Thermite',
    [0x8800F269] = '15x100mm High Explosive',
    [0x8E597A62] = '15x100mm Thermite',
    [0x8E74AA13] = '12g Bugshot',
    [0x92D110A0] = '12x25mm Thermite',
    [0x9321CA5B] = '9x20mm Explosive',
    [0x94BE8BEA] = '10g Bugshot',
    [0xA2D4A5F4] = '10g Liberty Fire',
    [0xA4083CFB] = '8x60mm Liberty Fire',
    [0xA44CF329] = '9x70mm High Velocity',
    [0xA56C7CF7] = '13x40mm Full Metal Jacket',
    [0xB0D2442D] = '5.5x50mm High Velocity',
    [0xB71928D4] = '12g Magnum Triball',
    [0xB923E3F9] = '8x60mm Sniper Armour Piercing',
    [0xBBF12281] = '12x25mm Toxic',
    [0xBF670968] = '13x40mm Penetrator',
    [0xC3A21061] = '10g Scatter Shot',
    [0xC5C01BAE] = '8x60mm Airburst',
    [0xC5C1096B] = '12g Liberty Fire',
    [0xC6259AE0] = '8x60mm Super Uranium Core',
    [0xC711E6A8] = '8x60mm Full Metal Jacket',
    [0xCDDF65D0] = '13x40mm Hollow Point',
    [0xCF73C4BE] = '12x25mm High Velocity',
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
    { 'LAS-22 Shear', 'Primary', '7E3145A5BAA4B948', 'Not released yet: a laser in the game files, built on the Scythe.' },
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
        'int MoveFileExA(const char *from, const char *to, uint32_t flags);',
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

    function self.replace(from, to)
        return kernel.MoveFileExA(from, to, 9) ~= 0
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
    if not api.replace(temp, path) then
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
                thrower = 0xA29A84D8, minefield = 0x74FEF89A, mine_spawner = 0x0697FED6, bombard = 0xCDBC43D8, eagle = 0x556FF68B }
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
    [T_STATUS] = { name = 'status effect', stride = 152, tail = true, names = { [5] = 'Burning', [32] = 'Heavy burning', [42] = 'Gas', [43] = 'Gas' } },
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
    local bits = peek4(entry.copies[1] + HEADER_BYTES + f.offset)
    if not bits then return nil end
    local value = bits
    if f.storage == 'f32' then value = bits_to_f32(bits) end
    if value ~= value or value < (f.signed and -f.limit or 0) or value > f.limit then return nil end   -- implausible: layout moved
    return value
end

local function encode(f, value)
    if f.storage == 'f32' then return f32_bytes(value) end
    return u32_bytes(math.floor(value + 0.5))
end

local function default_of(f)
    if defaults[f.key] == nil then defaults[f.key] = read_field(f) end
    return defaults[f.key]
end

-- Writes every copy of the table; read back, or rolled back.
local function write_field(f, value, plain)
    local entry = tables[f.kind]
    if not entry then return false, 'table not found' end
    if read_field(f) == nil then return false, 'current value implausible' end
    default_of(f)
    if f.most and value > f.most then value = f.most end
    local bytes, done = encode(f, value), {}
    for _, block in ipairs(entry.copies) do
        local at = block + HEADER_BYTES + f.offset
        local before = api.read(at, 4)
        if not before or not api.write(at, bytes) or api.read(at, 4) ~= bytes then
            for _, undo in ipairs(done) do api.write(undo[1], undo[2]) end
            return false, 'write failed at ' .. hex(at)
        end
        done[#done + 1] = { at, before }
    end
    -- its copies (the other attachments of its line, the weapon's own record) take the value; the
    -- game's value puts each back to its own
    if not plain and f.mirrors then
        local own = value == defaults[f.key]
        for _, m in pairs(f.mirrors) do
            local d = default_of(m)
            if d ~= nil then write_field(m, own and d or (m.neutral or value), true) end
        end
    end
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

local function add_row(weapon, section, id, label, storage, parts, min, max, small, big)
    local row = { section = section, id = id, label = label, storage = storage, parts = parts,
                  min = min, max = max, small = small, big = big }
    weapon.rows[#weapon.rows + 1] = row
    for _, part in ipairs(parts) do
        weapon.by_id[part.id] = part
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

-- A weapon's attachments set magazine and heat values of their own over the weapon's (its slot 5 item:
-- magazine, heatsink, canister) and modify its stats. For the weapon entity `key`: 'component:offset' ->
-- { lead = the default attachment's value (payload offset in the deltas; nil: it sets none), copies =
-- that value in every attachment of the line }, and mods = type -> the stat modifiers of the attachments
-- only its line uses (its slot 5 line).
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
    local out, t, mine = { mods = {} }, spec.find(fitted[5])
    local function add(mods)
        for type, value in pairs(mods) do
            out.mods[type] = out.mods[type] or {}
            out.mods[type][#out.mods[type] + 1] = value
        end
    end
    for _, r in ipairs(t and t.order or {}) do
        if t.lines[r] == t.lines[mine] then
            local words = spec.words(t, r)
            for word, data in pairs(words) do
                if not word:find('^236:') then
                    local link = out[word] or { copies = {} }
                    out[word] = link
                    link.copies[#link.copies + 1] = data
                    if r == mine then link.lead = data end
                end
            end
            add(spec.mods(words))
        end
    end
    cache[key] = out
    return out
end

-- The Attachments tab: every optic, underbarrel and muzzle with an ergonomics, sway, recoil or spread modifier,
-- as an entry of its own (they apply to every weapon fitted with it). A Custom muzzle brake is one weapon's
-- own (the Penetrator's, the Adjudicator's, ...): named after the weapon that comes with it (no designation).
-- Ammunition types (slot 6, and 7: a weapon's alternate load) take the game's names (MOD.ammo_names, by the
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
                name = MOD.ammo_names[peek4(top + r + 16) or 0]
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
-- and grenades, gas): how much each hit applies (`per`: 'hit', 'blast'), then the status's damage row
-- and duration (every source of that status shares them). Ids: `prefix` .. 'status<type>_' .. stat.
local function status_rows(entry, section, prefix, drow, per)
    for i = 0, 3 do
        local kind = read_field(field_at(T_DAMAGE, drow + 44 + i * 8, 'u32', 100000))
        if not kind or kind == 0 then break end
        local srow = tables[T_STATUS] and tables[T_STATUS].index[kind]
        local sid = srow and read_field(field_at(T_STATUS, srow + 44, 'u32', 100000))
        local qrow = sid and sid > 0 and tables[T_DAMAGE] and tables[T_DAMAGE].index[sid]
        if qrow then
            local name, key = KINDS[T_STATUS].names[kind] or ('Status ' .. kind), prefix .. 'status' .. kind
            add_row(entry, section, key .. '_strength', name .. ' applied per ' .. per, 'f32',
                    { part(key .. '_strength', T_DAMAGE, drow + 48 + i * 8, 'f32', 100000) }, 0, 1000, 0.1, 1)
            local first = damage_rows(entry, name, key .. '_', qrow, name, 6)   -- no forces: a status has none
            first.note = 'every ' .. name:lower() .. ' source shares these (other weapons, strikes, hazards, enemies)'
            add_row(entry, name, key .. '_duration', name .. ' duration (s)', 'f32',
                    { part(key .. '_duration', T_STATUS, srow + 40, 'f32', 100000) }, 0, 600, 0.5, 5)
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
    -- a magazine / heat value an attachment of the weapon's line also sets: the default attachment's
    -- copy leads (else the weapon's own), and every other copy follows an edit
    local ok, links = pcall(attachments, key)
    if not ok then log('attachments of ' .. weapon.name .. ': ' .. tostring(links)) end
    links = ok and weapon.key == key and links
    local function linked(kind, at, offset, storage, limit)
        local own = field_at(kind, at + offset, storage, limit)
        local link = links and links[(kind == T_MAGAZINE and 5 or kind == TYPES.reload and 113 or 266) .. ':' .. offset]
        if not link then return own end
        local lead = link.lead and field_at(TYPES.deltas, link.lead, storage, limit) or own
        lead.mirrors = lead.mirrors or {}
        for _, o in ipairs(link.copies) do
            local f = field_at(TYPES.deltas, o, storage, limit)
            if f ~= lead then lead.mirrors[f.key] = f end
        end
        if own ~= lead then lead.mirrors[own.key] = own end
        for _, f in pairs(lead.mirrors) do
            if f.users[#f.users] ~= weapon then f.users[#f.users + 1] = weapon end
        end
        return lead
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
    if weapon.key == key then
        local _, at = KINDS[TYPES.custom].projectile(key)
        local own = at and source('proj_ammo', TYPES.deltas, at)
        if (projectile == nil or projectile == 0) and own and own > 0 then projectile = own end
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
    if drow then
        weapon.damage_row = true
        damage_rows(weapon, 'Damage', '', drow)
    end
    if drow then status_rows(weapon, 'Damage', '', drow, 'hit') end
    if arow then
        add_row(weapon, 'Arc', 'arc_range', 'Range (m)', 'f32', { part('arc_range', TYPES.arc, arow + 8, 'f32', 100000) },
                0, 1000, 1, 5)
        add_row(weapon, 'Arc', 'arc_chain', 'Chain length', 'u32', { part('arc_chain', TYPES.arc, arow + 28, 'u32', 1000) },
                0, 20, 1, 1)
        add_row(weapon, 'Arc', 'arc_split', 'Chain split', 'u32', { part('arc_split', TYPES.arc, arow + 32, 'u32', 1000) },
                0, 20, 1, 1)
        local rate = read_field(field_at(TYPES.arc_weapon, arc + 4, 'f32', 100000))
        if rate and rate > 0 then
            add_row(weapon, 'Fire', 'arc_rpm', 'Fire rate (RPM)', 'f32', { part('arc_rpm', TYPES.arc_weapon, arc + 4, 'f32', 100000) },
                    1, 6000, 1, 10)
        end
    end
    local blasts = {}
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
            if xrow then
                local id = blast.damage and read_field(field_at(T_EXPLOSION, xrow + 4, 'u32', 100000))
                local qrow = id and id > 0 and tables[T_DAMAGE] and tables[T_DAMAGE].index[id]
                if qrow then
                    damage_rows(weapon, blast.section, blast.prefix .. '_', qrow, 'Explosion')
                end
                for _, r in ipairs({ { 'inner', 'Inner radius (m)', 16 }, { 'outer', 'Outer radius (m)', 20 },
                                     { 'shockwave', 'Shockwave radius (m)', 24 } }) do
                    local rid = blast.prefix .. '_' .. r[1]
                    add_row(weapon, blast.section, rid, r[2], 'f32', { part(rid, T_EXPLOSION, xrow + r[3], 'f32', 100000) }, 0, 200, 0.1, 1)
                end
            end
        end
        blasts = {}
    end
    if prow then projectile_rows(prow, '', 'Projectile', 'Explosion') end
    -- a melee strike's explosion (Breaching Hammer), with its damage row (explosion +4)
    local strike = melee and weapon.key == key and KINDS[T_MELEE].explosions[weapon.hash]
    if strike then blasts[#blasts + 1] = { id = strike, prefix = 'blast', section = 'Explosion', damage = true } end
    explosion_rows()
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
                            { part(id, TYPES.charge, charge + m[3] + (k - 1) * 4, 'f32', 100000) }, 0, 100, 0.05, 0.25)
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
    local magazine = record(T_MAGAZINE)
    if magazine then
        local function mag(id, label, offset, min, max, big)
            add_row(weapon, 'Ammo', id, label, 'u32', { { id = id, field = linked(T_MAGAZINE, magazine, offset, 'u32', 100000) } },
                    min, max, 1, big)
        end
        mag('capacity', 'Magazine size', 136, 1, 9999, 10)
        mag('mags_start', 'Starting magazines', 140, 0, 999, 5)
        mag('mags_supply', 'Magazines from supply', 144, 0, 999, 5)
        mag('mags_max', 'Max spare magazines', 148, 0, 999, 5)
    end
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
    -- reload time: the weapon's own (+56), or its magazine's (an attachment sets it over the weapon's 0).
    -- The game scales the reload animation to it; 0: the animation's own length (no scaling).
    local reload = (magazine or rounds or record(T_HEAT)) and record(TYPES.reload)
    local rf = reload and linked(TYPES.reload, reload, 56, 'f32', 1000)
    local rt = rf and default_of(rf)
    if rt and rt >= 0 and rt < 1000 then
        add_row(weapon, 'Ammo', 'reload_time', rt > 0 and 'Reload time (s)' or 'Reload time (s; 0: as animated)', 'f32',
                { { id = 'reload_time', field = rf } }, 0, 60, 0.1, 0.5)
    end
    -- heat weapons (lasers, Quasar): +84/+88/+92 heatsinks, +96 overheat threshold, +100 heat it
    -- recovers to after an overheat, +116/+120 heat per shot / second, +128 cooling per second,
    -- +140 cooling per second while overheated, +144 (byte) overheat needs a new heatsink
    local heat = record(T_HEAT)
    if heat then
        local function hf(offset) return linked(T_HEAT, heat, offset, 'f32', 1000000) end
        local reload = read_field(field_at(T_HEAT, heat + 144, 'u32', 4294967295))
        reload = reload and reload % 256 ~= 0
        if reload then
            local function sink(id, label, offset)
                add_row(weapon, 'Ammo', id, label, 'u32', { { id = id, field = linked(T_HEAT, heat, offset, 'u32', 100000) } }, 0, 999, 1, 5)
            end
            sink('heatsinks_start', 'Starting heatsinks', 84)
            sink('heatsinks_supply', 'Heatsinks from supply', 88)
            sink('heatsinks_max', 'Max spare heatsinks', 92)
        end
        local function h(id, label, offset, small, big)
            add_row(weapon, 'Heat', id, label, 'f32', { { id = id, field = hf(offset) } }, 0, 100000, small, big)
        end
        h('heat_capacity', 'Overheat threshold', 96, 1, 10)
        for _, g in ipairs({ { 'heat_shot', 'Heat per shot', 116 }, { 'heat_second', 'Heat per second firing', 120 } }) do
            local v = read_field(hf(g[3]))
            if v and v > 0 then h(g[1], g[2], g[3], 0.1, 1) end
        end
        -- cool-down times: the heat to shed over the cooling rate; setting a time sets the rate
        local capacity, recover = hf(96), hf(100)
        local function span(recovered)
            local c, r = read_field(capacity), recovered and read_field(recover) or 0
            return c and r and c - r
        end
        local function span_default(recovered)
            local c, r = default_of(capacity), recovered and default_of(recover) or 0
            return c and r and c - r
        end
        local function cool(id, label, offset, recovered)
            local s = span(recovered)
            if not s or s <= 0 then return end
            local row = add_row(weapon, 'Heat', id, label, 'f32', { { id = id, field = hf(offset) } }, 0.1, 3600, 0.5, 5)
            row.span = function() return span(recovered) end
            row.span_default = function() return span_default(recovered) end
        end
        cool('heat_cool', 'Cool-down time, full heat (s)', 128, false)
        if not reload then cool('heat_cool_overheated', 'Cool-down time after overheat (s)', 140, true) end
        -- wind-up (Sickles, Scythe, Quasar...): +148 the charge it needs to fire, +152 the charge gained
        -- per second holding the trigger, +156 lost per second once let go; times: that charge over the rate
        local needed = hf(148)
        local function wind(id, label, offset)
            local c = read_field(needed)
            if not c or c <= 0 then return end
            local row = add_row(weapon, 'Wind-up', id, label, 'f32', { { id = id, field = hf(offset) } }, 0.01, 3600, 0.05, 0.25)
            row.span = function() return read_field(needed) end
            row.span_default = function() return default_of(needed) end
        end
        wind('windup', 'Wind-up time (s)', 152)
        wind('winddown', 'Wind-down time, released (s)', 156)
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
    local data = record(T_WEAPON)
    if data then
        local function w(id, offset) return part(id, T_WEAPON, data + offset, 'f32', 100000) end
        -- the modifiers of the attachments only its line uses follow an edit (ergonomics to 0, the rest to 1)
        local function follow(p, types, neutral)
            for _, type in ipairs(types) do
                for _, offset in ipairs(links and links.mods[type] or {}) do
                    local m = field_at(TYPES.deltas, offset, 'f32', 1000)
                    m.signed, m.neutral = type == 0, neutral
                    p.field.mirrors = p.field.mirrors or {}
                    p.field.mirrors[m.key] = m
                    if m.users[#m.users] ~= weapon then m.users[#m.users + 1] = weapon end
                end
            end
            return p
        end
        add_row(weapon, 'Handling', 'recoil_h', 'Recoil (horizontal)', 'f32', { follow(w('recoil_dh', 0), { 2, 10 }, 1), w('recoil_ch', 28) }, 0, 2000, 1, 5)
        add_row(weapon, 'Handling', 'recoil_v', 'Recoil (vertical)', 'f32', { follow(w('recoil_dv', 4), { 4, 12 }, 1), w('recoil_cv', 32) }, 0, 2000, 1, 5)
        add_row(weapon, 'Handling', 'spread_h', 'Spread (horizontal)', 'f32', { follow(w('spread_h', 84), { 14 }, 1) }, 0, 5000, 1, 10)
        add_row(weapon, 'Handling', 'spread_v', 'Spread (vertical)', 'f32', { follow(w('spread_v', 88), { 16 }, 1) }, 0, 5000, 1, 10)
        add_row(weapon, 'Handling', 'sway', 'Sway multiplier', 'f32', { follow(w('sway', 104), { 1 }, 1) }, 0, 100, 0.1, 0.5)
        add_row(weapon, 'Handling', 'ergonomics', 'Ergonomics', 'f32', { follow(w('ergonomics', 356), { 0 }, 0) }, 0, 1000, 1, 5)
    end
    if weapon.key == key and weapon.slot == 'Support' then
        local pack = KINDS[TYPES.rack].pack(key)
        if pack then KINDS[TYPES.jumppack].backpack(weapon, pack, true) end
    end
    if weapon.key == key then KINDS[T_PROJECTILE].swap_row(weapon, sources, shots) end
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
--   jump / hover pack: recharge +0 (RechargeComponentData); launch force +0, takeoff duration +24, forward
--     share of the launch +32, landing thrust force +36 / duration +40, mid-air steering +60, hover
--     duration +156 (-1: does not hover; the Hover Pack's 6 s). A pack reads them when it is called in.
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
        r(section, 'bp_launch', 'Launch force', TYPES.jumppack, jump, 'f32', 1000, 1, 5)
        r(section, 'bp_takeoff', 'Takeoff duration (s)', TYPES.jumppack, jump + 24, 'f32', 10, 0.05, 0.25)
        r(section, 'bp_forward', 'Forward share of the launch (0-1)', TYPES.jumppack, jump + 32, 'f32', 1, 0.05, 0.1)
        r(section, 'bp_landing', 'Landing thrust force', TYPES.jumppack, jump + 36, 'f32', 1000, 1, 5)
        r(section, 'bp_landing_time', 'Landing thrust duration (s)', TYPES.jumppack, jump + 40, 'f32', 10, 0.05, 0.25)
        r(section, 'bp_steer', 'Mid-air steering speed', TYPES.jumppack, jump + 60, 'f32', 100, 0.5, 2)
        if hover then r(section, 'bp_hover', 'Hover duration (s)', TYPES.jumppack, jump + 156, 'f32', 120, 0.5, 2) end
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
            add_row(entry, 'Arc', 'arc_chain', 'Chain length', 'u32', { part('arc_chain', TYPES.arc, arc + 28, 'u32', 1000) }, 0, 20, 1, 1)
            add_row(entry, 'Arc', 'arc_split', 'Chain split', 'u32', { part('arc_split', TYPES.arc, arc + 32, 'u32', 1000) }, 0, 20, 1, 1)
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
    explosion(id, 'blast_', 'Explosion', true)
end

local function resolve(weapon)
    weapon.rows, weapon.by_id, weapon.aliases, weapon.backpack, weapon.mines = {}, {}, nil, nil, nil
    if weapon.slot == 'Throwables' then resolve_throwable(weapon); return end
    -- a support weapon you place (the C4 Pack): the backpack that shares its loadout package (its
    -- charges), the charge (health, throw distance) and its explosion
    if weapon.slot == 'Support' and KINDS[TYPES.package].placed(weapon.key) then
        local dt = tables[TYPES.deposit]
        for _, k in ipairs(KINDS[TYPES.package].kin(weapon.key)) do
            if dt and dt.index[k] then KINDS[TYPES.jumppack].backpack(weapon, k) end
        end
        unit_rows(weapon, weapon.key, 'Charge', 'charge_')
        resolve_throwable(weapon, true)
        return
    end
    if weapon.passive then KINDS[TYPES.passive].resolve(weapon); return end
    if weapon.stratagem then resolve_stratagem(weapon); return end
    if weapon.attachment then
        for _, m in ipairs(KINDS[TYPES.items].MODS) do
            local offset = weapon.attachment.mods[m[1]]
            if offset then
                local f = field_at(TYPES.deltas, offset, 'f32', 1000)
                f.signed = m[4] < 0
                local parts = { { id = m[2], field = f } }
                -- its 'Alt' twin (the next type: recoil, climb and spread have one) moves with it
                local alt = m[1] >= 2 and weapon.attachment.mods[m[1] + 1]
                if alt then parts[2] = { id = m[2] .. '_alt', field = field_at(TYPES.deltas, alt, 'f32', 1000) } end
                add_row(weapon, 'Attachment', m[2], m[3], 'f32', parts, m[4], m[5], m[6], m[7])
            end
        end
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

-- Projectile swap (the last row of a weapon that fires projectiles): one row writing every field the
-- weapon's projectile comes from (its rounds record, ammo type, fire mode, charge stages) with another
-- weapon's projectile. The stat rows above stay the weapon's own projectile's. Choices:
-- KINDS[T_PROJECTILE].choices, every listed weapon's own projectiles by name (built after resolving).
KINDS[T_PROJECTILE].swap_row = function(weapon, sources, shots)
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
    local row = add_row(weapon, 'Projectile swap', 'projectile', 'Projectile fired (id)', 'u32', parts, 1, 100000, 1, 10)
    row.choice = true
    -- under the row: what a swap changes and what it keeps (drawn below it, `after_h` units)
    row.after = { "Swapping makes the shot the chosen weapon's, your edits to it included: damage,",
                  'armor penetration, forces, velocity, drag, gravity, pellets and explosions. Kept: this',
                  "weapon's fire rate, ammo, handling and heat. To tune the shot, edit the chosen weapon." }
    row.after_h = #row.after * 16 + 6
    row.note = function(others)
        local spec, now, own = KINDS[T_PROJECTILE], read_field(parts[1].field), default_of(parts[1].field)
        local shot = spec.by_id and spec.by_id[now]
        local text = now == own and "its own. - / + : fire another weapon's"
                     or ('fires: ' .. (shot and shot.label or ('projectile ' .. tostring(now))) .. '. The rows above stay its own')
        if #others > 0 then text = text .. '; ammo type shared with ' .. table.concat(others, ', ', 1, math.min(2, #others)) end
        return text
    end
    weapon.own_shots = {}
    for _, shot in ipairs(shots or { { id = weapon.projectile } }) do
        weapon.own_shots[#weapon.own_shots + 1] = { id = shot.id,
            label = shots and (weapon.name .. ' (' .. shot.name:lower() .. ')') or weapon.name }
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

-- Resolves weapons from `next` on until the deadline; true once all are done.
local function resolve_some(progress, deadline)
    if progress.next == 1 then
        for _, f in pairs(fields) do f.users = {} end
        KINDS[TYPES.custom].cache = {}
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
    if row.choice then return get(row.parts[1].field) end
    if row.span then return as_time((default and row.span_default or row.span)(), get(row.parts[1].field)) end
    local sum = 0
    for _, p in ipairs(row.parts) do
        local v = get(p.field)
        if v == nil then return nil end
        sum = sum + v
    end
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
                   remember = true, last_tab = nil, last_weapon = nil,
                   GITHUB = 'https://github.com/SHODAN-HORAI/SHODAN-Stat-Editor',
                   RANGE = { size = { 50, 100 }, opacity = { 10, 100 } } }

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
                            'remember ' .. onoff(settings.remember) }) do
        lines[#lines + 1] = line
    end
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
        if line:find('%S') then
            local known = false
            local key = line:match('^%s*hotkey%s+(%S+)')
            if key then hotkey_name = key; known = true end
            local name, value = line:match('^%s*([%a_]+)%s+(%S+)%s*$')
            if name == 'changes' or name == 'block_input' or name == 'remember' then
                settings[name] = value ~= 'off'
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
            end
            local hash, id, amount = line:match('^%s*(%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x)%s+([%w_]+)%s+(%S+)')
            local parsed = hash and MOD.parse_number(amount)
            if parsed then
                overrides[#overrides + 1] = { hash = hash:upper(), id = id, value = parsed }
                count = count + 1
                known = true
            end
            if not known then log('config: line ' .. at .. ' not understood: ' .. line:sub(1, 60)) end
        end
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
    mark_config_dirty()
end

-- The value to keep as a change: nil when it is the game's own.
local function unless_default(value, default)
    if default ~= nil and math.abs(value - default) < 1e-4 then return nil end
    return value
end

local pending = {}      -- config values not applied yet (tables still being written)

-- Applies pending values until the deadline (the rest wait for the next call); true when the
-- whole list was gone through once. Values that could not be written yet are tried again
-- later (the table may still be filling), up to 30 times.
local apply_at = 1
local function apply_config(deadline)
    while apply_at <= #pending do
        local o = pending[apply_at]
        local weapon = by_hash[o.hash]
        local p = weapon and weapon.by_id[o.id]
        local keep = false
        if not weapon then
            log('config: unknown weapon ' .. o.hash); state.refused = state.refused + 1
        elseif not p then
            log('config: ' .. weapon.name .. ' has no stat ' .. o.id); state.refused = state.refused + 1
        else
            default_of(p.field)
            local ok, why = write_field(p.field, o.value)
            if ok then
                state.applied = state.applied + 1
            else
                o.tries = (o.tries or 0) + 1
                keep = o.tries < 30
                if not keep then
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

local function prepare(deadline)
    if not resolve_some(progress, deadline) then return end
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

local function modified(weapon)
    for _, o in ipairs(overrides) do if o.hash == weapon.hash then return true end end
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
    target = math.max(row.min, math.min(row.max, target))
    if target == current then return end
    for _, p in ipairs(row.parts) do
        local v = read_field(p.field)
        default_of(p.field)
        local new = target
        if row.span then new = row.span() / target
        elseif #row.parts > 1 then new = (current > 0) and v * target / current or target end
        local ok, why = write_field(p.field, new)
        local d = defaults[p.field.key]
        if ok then
            set_override(weapon, p, unless_default(new, d))
        else
            log('write refused: ' .. weapon.name .. ' ' .. p.id .. ': ' .. why)
        end
    end
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
        ui.message = { text = text, till = api.now() + 4 }
    end
end

local function reset_row(weapon, row)
    for _, p in ipairs(row.parts) do
        local d = default_of(p.field)
        if d ~= nil then write_field(p.field, d) end
        set_override(weapon, p, nil)
    end
    ui.version = ui.version + 1
end

local function reset_weapon(weapon)
    for _, row in ipairs(weapon.rows) do reset_row(weapon, row) end
end

local function reset_all()
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
        for _, o in ipairs(overrides) do pending[#pending + 1] = { hash = o.hash, id = o.id, value = o.value } end
        log('settings: changes on (' .. #pending .. ' value(s) applied again)')
    else
        pending = {}
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

    -- Every value of the weapon that differs from the game's, part by part.
    local function weapon_changes(weapon)
        local out = {}
        for _, row in ipairs(weapon.rows) do
            for _, p in ipairs(row.parts) do
                local v, d = read_field(p.field), default_of(p.field)
                if v and d and math.abs(v - d) > 1e-4 then out[#out + 1] = { id = p.id, value = v } end
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
            if want[id] == nil or id == v.id then want[id] = v.value end
        end
        local refused = 0
        for _, row in ipairs(weapon.rows) do
            for _, p in ipairs(row.parts) do
                local d = default_of(p.field)
                local target = want[p.id]
                if target == nil then target = d end
                want[p.id] = nil
                local current = read_field(p.field)
                if target ~= nil and current ~= nil and math.abs(current - target) > 1e-6 then
                    local ok, why = write_field(p.field, target)
                    if not ok then refused = refused + 1; log('preset refused: ' .. weapon.name .. ' ' .. p.id .. ': ' .. why) end
                end
                if target ~= nil then set_override(weapon, p, unless_default(target, d)) end
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
            local p = weapon and weapon.by_id[o.id]
            local ok, why = false, weapon and ('no stat ' .. o.id) or ('unknown weapon ' .. o.hash)
            if p then
                local d = default_of(p.field)
                ok, why = write_field(p.field, o.value)
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
    local function text(value, x, y, size, c, limit, align_right)
        if value == nil or value == '' or not ink_font then return end
        size = size * s
        local px = ox + x * s
        if limit or align_right then
            -- widths are measured once per text, size and font (the panel redraws often)
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
            if limit and measure > limit * s then size = size * limit * s / measure; measure = limit * s end
            if align_right then px = px - measure end
        end
        step('Gui.text')
        Gui.text(gui, value, ink_font, size, ink_material, Vector3(px, height - oy - y * s - size * 0.8, 953), c or WHITE)
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
                    if note == '' and #others > 0 then
                        note = 'shared with ' .. table.concat(others, ', ', 1, math.min(3, #others)) ..
                               (#others > 3 and (' +' .. (#others - 3)) or '')
                    end
                    text(section:upper(), x0, y + 4, 15, MUTED)
                    -- the note after the section's name (long ones: 'PARTIAL CHARGE EXPLOSION')
                    local nx = math.max(110, #section * 10 + 14)
                    if note ~= '' then text(note, x0 + nx, y + 4, 14, WARN, W - x0 - 20 - nx) end
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

local function tick()
    state.frame = state.frame + 1
    local now = api.now()
    if state.phase == 'building' then
        state.build_some()
    elseif state.phase == 'preparing' then
        prepare(now + FRAME_BUDGET)
    elseif state.phase == 'ready' then
        if #pending > 0 and now >= next_retry then
            if apply_config(now + FRAME_BUDGET) then
                next_retry = now + 2
                if #pending == 0 then log('all saved values applied (' .. state.applied .. ')') end
            end
        end
        if config_dirty_at and now >= config_dirty_at then save_config() end
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
