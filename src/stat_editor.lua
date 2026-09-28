-- HD2-Addon: mods/shodan/stat_editor
-- SHODAN Stat Editor v1.4.2 by SHODAN. Requires Bingus Shared Loader (API 1).
local MOD = { global = 'ShodanStatEditor', title = 'SHODAN Stat Editor', version = '1.4.2', author = 'SHODAN', log = 'SHODANStatEditor.log' }
if rawget(_G, MOD.global) then return end

-- Weapons: name, loadout slot, entity hash (from HD2Runtime's capability catalogs), variant note,
-- projectile set by the default attachments (when they set one).
local WEAPONS = {
    { 'AR-11 Arbitrator', 'Primary', 'A8A91EB54892B6B2', 'The rifle you carry. The underbarrel shotgun is listed separately.' },
    { 'AR-11 Arbitrator (underbarrel shotgun)', 'Primary', 'B9C209B4F99B5335', 'The Arbitrator\'s underbarrel shotgun, not the rifle itself.' },
    { 'AR-2 Coyote', 'Primary', '84354339522C932D', '' },
    { 'AR-23 Liberator', 'Primary', '968211C0033DCE64', '', 276 },
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
    { 'JAR-5 Dominator', 'Primary', '80F1A156D9FA1E36', '', 177 },
    { 'LAS-12 Sai', 'Primary', 'C85F576D5E086147', '' },
    { 'LAS-13 Trident', 'Primary', '3C86E871923F3970', '' },
    { 'LAS-16 Sickle', 'Primary', '8645F167B3C813A2', '' },
    { 'LAS-17 Double-Edge Sickle', 'Primary', '295BEB26DC4F8FF1', '' },
    { 'LAS-5 Scythe', 'Primary', '27EE1ED8F6FB6356', 'The Scythe you carry.' },
    { 'LAS-5 Scythe (unidentified twin)', 'Primary', '7E3145A5BAA4B948', 'A separate weapon built on the Scythe, with its own name and a targeting part. Not the Scythe.' },
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
    { 'R-63 Diligence', 'Primary', '03E67A19B07C6523', '', 305 },
    { 'R-63CS Diligence Counter Sniper', 'Primary', '4C786785C79D44E7', '' },
    { 'R-72 Censor', 'Primary', 'F0338468DCDB6A6C', '' },
    { 'R/40-K Hot-Shot Marksman Rifle', 'Primary', '1ABBFF60D26BA391', '' },
    { 'SG-20 Halt', 'Primary', '4E310B1FE4C52B52', '' },
    { 'SG-225 Breaker', 'Primary', '46183B50961D1328', '', 179 },
    { 'SG-225IE Breaker Incendiary', 'Primary', 'C12A34F375BD5A87', '' },
    { 'SG-225SP Breaker Spray&Pray', 'Primary', '5EBAEA70C0D060B9', '' },
    { 'SG-451 Cookout', 'Primary', 'D323DE60855898AC', '' },
    { 'SG-8 Punisher', 'Primary', '41EAC4A03987FAA0', '' },
    { 'SG-8P Punisher Plasma', 'Primary', '05D8D8C073B9D502', '' },
    { 'SG-8S Slugger', 'Primary', '4F749E2EE26F532D', '' },
    { 'SG-97 Sweeper', 'Primary', 'DCD1C835407EF7BA', '' },
    { 'SMG-203 Gallant', 'Primary', '186EA95DE7306B1A', '' },
    { 'SMG-32 Reprimand', 'Primary', '94BD931B5FB4EE95', '' },
    { 'SMG-37 Defender', 'Primary', '4E4A613EB9BF5C24', 'The one you carry.', 3 },
    { 'SMG-37 Defender (non-player copy)', 'Primary', 'CA4BBEF63C869C18', 'A copy that is not a loadout item (held by others). Not yours.', 3 },
    { 'SMG-72 Pummeler', 'Primary', '0807AEA5217E4767', '' },
    { 'SMG/FLAM-34 Stoker', 'Primary', '8A307BD1811A5FE9', '' },
    { 'StA-11 SMG', 'Primary', '4BA41B6F9F405CC2', '' },
    { 'StA-52 Assault Rifle', 'Primary', 'CDF28BE026BB7D84', '' },
    { 'VG-70 Variable', 'Primary', 'F992CE97577C8A7F', '' },
    { 'CQC-19 Stun Lance', 'Secondary', 'E3B6AEDD07FCB464', '' },
    { 'CQC-2 Saber', 'Secondary', 'FCD8A6E67EAC635A', '' },
    { 'CQC-30 Stun Baton', 'Secondary', '52CDBFBACA3CB397', '' },
    { 'CQC-42 Machete', 'Secondary', '792D5D2A340FD6E6', 'The one you carry. The CQC-20 Breaching Hammer is listed under Support.' },
    { 'CQC-5 Combat Hatchet', 'Secondary', '75816077C139C850', '' },
    { 'CQC-73 Entrenchment Tool', 'Secondary', '7E1F76163C667E4B', 'The one you carry.' },
    { 'CQC-73 Entrenchment Tool (pickup)', 'Secondary', 'E85E623F93F96FB3', 'The copy lying in the world that can be picked up.' },
    { 'GP-20 Ultimatum', 'Secondary', '9EB160830321BFD6', '' },
    { 'GP-31 Grenade Pistol', 'Secondary', '52E4334E6A128CAF', 'The pistol you carry. The One-Two\'s launcher is listed under the One-Two.' },
    { 'LAS-58 Talon', 'Secondary', '416D053372C4E433', '' },
    { 'LAS-7 Dagger', 'Secondary', '7B06196E90154C88', 'The one you carry.' },
    { 'LAS-7 Dagger (stripped copy)', 'Secondary', '2B3C367B280F4094', 'A cut-down copy that is not a loadout item. Not yours.' },
    { 'M6C/SOCOM Pistol', 'Secondary', '4D58C77087B774C5', '' },
    { 'P-11 Stim Pistol', 'Secondary', 'D6B1FB05B9109353', '' },
    { 'P-113 Verdict', 'Secondary', '1A437158E1B8D2A1', '' },
    { 'P-19 Redeemer', 'Secondary', '3575AABC5F1F9326', '', 291 },
    { 'P-2 Peacemaker', 'Secondary', '05E4E5C2DB6E44A2', '', 337 },
    { 'P-33 Missile Pistol', 'Secondary', '14D5D4506056C7A4', '' },
    { 'P-34 Breacher', 'Secondary', 'E91F569C2AD8AF01', '' },
    { 'P-35 Re-Educator', 'Secondary', '0B882808C6F498E8', '' },
    { 'P-4 Senator', 'Secondary', '8D3D52A3B2F19402', '', 309 },
    { 'P-69 Veto', 'Secondary', 'C780BCD79547DA0F', '' },
    { 'P-72 Crisper', 'Secondary', '3F92BA65EF65CCA9', 'The one you carry.' },
    { 'P-72 Crisper (non-player copy)', 'Secondary', '992B6F65A5BAB53D', 'A copy that is not a loadout item (held by others). Not yours.' },
    { 'P-92 Warrant', 'Secondary', 'CF8934FF6567A42D', '' },
    { 'P/40-K Bolt Pistol', 'Secondary', 'DBB6C961C59FADC1', '' },
    { 'PLAS-15 Loyalist', 'Secondary', 'AA69A60D74A3EC54', '' },
    { 'SG-22 Bushwhacker', 'Secondary', '2B28E17FFED05F7C', '' },
    { '40-K Meltagun', 'Support', '6CFCC7F8801A0266', '' },
    { 'AC-8 Autocannon', 'Support', 'A8CFFB316F0B5C5F', '' },
    { 'APW-1 Anti-Materiel Rifle', 'Support', '89C5493E08CA4207', '' },
    { 'ARC-3 Arc Thrower', 'Support', '96DE9CD50F7306E6', '' },
    { 'B/FLAM-80 Cremator', 'Support', '78A8185F63A70795', 'The flamethrower you carry. Its fuel backpack is listed separately.' },
    { 'B/FLAM-80 Cremator (fuel backpack)', 'Support', '0736BEE2D6328726', 'The fuel backpack worn with the Cremator, not the gun.' },
    { 'B/MD C4 Pack', 'Support', '9B75217D8312DD67', '' },
    { 'CQC-1 One True Flag', 'Support', 'B0F1B354BA1D38D8', '' },
    { 'CQC-20 Breaching Hammer', 'Support', '5F3EC9BDA2BD8553', 'The support hammer delivered by hellpod. The game data files it next to the Machete.' },
    { 'CQC-9 Defoliation Tool', 'Support', 'BF4CFD2AEABFB5A4', '' },
    { 'EAT-17 Expendable Anti-Tank', 'Support', '80932FA0ED6901D3', 'The one you carry.' },
    { 'EAT-17 Expendable Anti-Tank (stripped copy)', 'Support', '5C54E81A4AAA31FC', 'A cut-down copy that is not a loadout item. Not yours.' },
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
    { 'MG-206 Heavy Machine Gun (mounted A)', 'Support', '085C1EDB038EC24E', 'A mounted copy run by AI (emplacement-style). Not the one you carry.' },
    { 'MG-206 Heavy Machine Gun (mounted B)', 'Support', 'CD00BDC1149C2928', 'A mounted copy run by AI (emplacement-style). Not the one you carry.' },
    { 'MG-43 Machine Gun', 'Support', '11C27D3BABB38956', 'The one you carry.' },
    { 'MG-43 Machine Gun (non-player copy)', 'Support', '587878FB76F4B9B1', 'A copy that is not a loadout item (held by others). Not yours.' },
    { 'MGX-42 Bullet Storm', 'Support', 'B16C9D490AA59B77', '' },
    { 'MLS-4X Commando', 'Support', '5990123D142B16CB', '' },
    { 'MS-11 Solo Silo', 'Support', 'DE18775FA447A9BF', '' },
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

local function near(a, b)
    return a ~= nil and math.abs(a - b) < 1e-4
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
                turret = 0x1EBA7593 }
local KINDS = {
    [T_WEAPON] = { name = 'weapon', stride = 1232, keyed = true },
    [T_MAGAZINE] = { name = 'magazine', stride = 160, keyed = true },
    [T_ROUNDS] = { name = 'rounds', stride = 136, keyed = true },
    [T_FIRE] = { name = 'fire mode', stride = 616, keyed = true },
    [T_PROJECTILE] = { name = 'projectile', stride = 272 },
    [T_DAMAGE] = { name = 'damage', stride = 76 },
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
    -- drones: the Guard Dog stratagems (by stratagem id) -> name, drone entity, its gun entity.
    -- Nothing in the settings links a Guard Dog backpack to its drone, so they are listed here.
    [TYPES.health] = { name = 'health', stride = 22096, keyed = true, drones = {
        [485866824] = { 'AX/AR-23 "Guard Dog"', 'A0FF2F9A0CA6992A', 'A32621E3BDE13379' },
        [951988742] = { 'AX/LAS-5 "Guard Dog" Rover', '5BEEC97F4C7F4AE9', '2C66C201B2543D2C' },
        [5185868] = { 'AX/TX-13 "Guard Dog" Dog Breath', 'B9BAF571FC8F9959', 'B729A2BA153BCAED' },
        [1125307795] = { 'AX/FLAM-75 "Guard Dog" Hot Dog', '979E9BC6D48D1FC6', '65CD4325BA23F3C6' },
        [1692135420] = { 'AX/ARC-3 "Guard Dog" K-9', '4B071633584E4594', 'A0532C3616528CBF' } },
        -- units: sentries / emplacements whose body is not their gun (gun -> body)
        units = { ['1D5943301A29C940'] = '0C8257D1C0255593' },
        -- stratagem id -> sentry gun, for sentries whose stratagem drops a body the panel does not list
        -- (Laser Cannon Sentry, Tesla Tower, Defense Wall Grenade Launcher = the Grenadier Battlement)
        sentry_ids = { [0x393E6019] = '56070F36CFFFA8A8', [0x8F349F3B] = '74599E56F72F9D7E',
                       [0x93D3C05C] = '1D5943301A29C940' } },
    [TYPES.sensor] = { name = 'sensor', stride = 44, keyed = true },
    [TYPES.detector] = { name = 'detector', stride = 24, keyed = true },
    [TYPES.turret] = { name = 'turret', stride = 76, keyed = true },
    -- one table per stratagem group (orbitals, eagles, backpacks, ...), rows keyed by the id at +4
    [T_STRATAGEM] = { name = 'stratagem', stride = 400, tail = true, id_at = 4, groups = true },
}
-- the tables the panel waits for (stratagem groups are taken as they come)
local KIND_ORDER = { T_WEAPON, T_MAGAZINE, T_ROUNDS, T_FIRE, T_PROJECTILE, T_DAMAGE, T_BEAM_WEAPON, T_BEAM,
                     T_EXPLOSION, T_ORBITAL, T_HEAT, T_SPRAY, T_STATUS, T_MELEE, TYPES.arc_weapon, TYPES.arc,
                     TYPES.health, TYPES.sensor, TYPES.detector, TYPES.turret }

-- kind -> { payload = size, index = key -> payload offset, entries = n, copies = { block address },
-- type = table type }; each stratagem group is under its own key (listed in stratagem_groups)
local tables, parsed_blocks, stratagem_groups = {}, {}, {}

-- Keyed table: bucket array (u64 entity hash, u32 record index, u32 0) holding exactly twice as
-- many buckets as entities, then fixed-stride records. Record bytes can look like buckets, so
-- every candidate bucket count is checked and exactly one must fit.
local function parse_keyed(blob, stride)
    local MAX_UNINDEXED_RECORDS, ZERO8 = 2, string.rep('\0', 8)
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
        local array = total - count * 16
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
    if value ~= value or value < 0 or value > f.limit then return nil end   -- implausible: layout moved
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
local function write_field(f, value)
    local entry = tables[f.kind]
    if not entry then return false, 'table not found' end
    if read_field(f) == nil then return false, 'current value implausible' end
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
    local weapon = { name = w[1], slot = w[2], hash = w[3], note = w[4] or '', override = w[5], key = hash_key(w[3]),
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

-- Adds the rows of the gun whose entity hash is `key` (8 bytes) to `weapon` (a weapon, or a
-- stratagem whose payload is a gun: sentries, emplacements).
local function resolve_gun(weapon, key)
    local function record(kind)
        local entry = tables[kind]
        return entry and entry.index[key]
    end
    local projectile = nil
    local rounds, fire = record(T_ROUNDS), record(T_FIRE)
    if rounds then projectile = read_field(field_at(T_ROUNDS, rounds + 64, 'u32', 100000)) end
    -- the default attachments (ammo type) can set the fire mode's projectile (Peacemaker, Redeemer)
    if (projectile == nil or projectile == 0) and weapon.key == key and weapon.override then
        projectile = weapon.override
    end
    if fire and (projectile == nil or projectile == 0) then
        projectile = read_field(field_at(T_FIRE, fire, 'u32', 100000))
    end
    local prow = projectile and projectile > 0 and tables[T_PROJECTILE] and tables[T_PROJECTILE].index[projectile]
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
        local function dmg(id, label, offset, max, small, big)
            add_row(weapon, 'Damage', id, label, 'u32', { part(id, T_DAMAGE, drow + offset, 'u32', 1000000) }, 0, max, small, big)
        end
        dmg('damage', 'Damage', 4, 100000, 1, 10)
        dmg('durable', 'Durable damage', 8, 100000, 1, 10)
        dmg('ap_direct', 'Armor pen. (direct)', 12, 10, 1, 1)
        dmg('ap_slight', 'Armor pen. (slight angle)', 16, 10, 1, 1)
        dmg('ap_large', 'Armor pen. (large angle)', 20, 10, 1, 1)
        dmg('ap_extreme', 'Armor pen. (extreme angle)', 24, 10, 1, 1)
        dmg('demolition', 'Demolition force', 28, 10000, 1, 10)
        dmg('stagger', 'Stagger force', 32, 10000, 1, 10)
        dmg('push', 'Push force', 36, 10000, 1, 10)
    end
    -- status effects the hit applies that deal damage (fire from flamers and incendiary rounds, gas):
    -- how much each hit applies (this damage row's), then the status's damage row and duration
    -- (every source of that status shares them)
    if drow then
        for i = 0, 3 do
            local kind = read_field(field_at(T_DAMAGE, drow + 44 + i * 8, 'u32', 100000))
            if not kind or kind == 0 then break end
            local srow = tables[T_STATUS] and tables[T_STATUS].index[kind]
            local sid = srow and read_field(field_at(T_STATUS, srow + 44, 'u32', 100000))
            local qrow = sid and sid > 0 and tables[T_DAMAGE] and tables[T_DAMAGE].index[sid]
            if qrow then
                local name, key = KINDS[T_STATUS].names[kind] or ('Status ' .. kind), 'status' .. kind
                add_row(weapon, 'Damage', key .. '_strength', name .. ' applied per hit', 'f32',
                        { part(key .. '_strength', T_DAMAGE, drow + 48 + i * 8, 'f32', 100000) }, 0, 1000, 0.1, 1)
                local section = name
                local function sd(id, label, offset, max, small, big)
                    return add_row(weapon, section, key .. '_' .. id, label, 'u32',
                                   { part(key .. '_' .. id, T_DAMAGE, qrow + offset, 'u32', 1000000) }, 0, max, small, big)
                end
                local first = sd('damage', name .. ' damage', 4, 100000, 1, 10)
                first.note = 'every ' .. name:lower() .. ' source shares these (other weapons, strikes, hazards, enemies)'
                sd('durable', name .. ' durable damage', 8, 100000, 1, 10)
                sd('ap_direct', 'Armor pen. (direct)', 12, 10, 1, 1)
                sd('ap_slight', 'Armor pen. (slight angle)', 16, 10, 1, 1)
                sd('ap_large', 'Armor pen. (large angle)', 20, 10, 1, 1)
                sd('ap_extreme', 'Armor pen. (extreme angle)', 24, 10, 1, 1)
                add_row(weapon, section, key .. '_duration', name .. ' duration (s)', 'f32',
                        { part(key .. '_duration', T_STATUS, srow + 40, 'f32', 100000) }, 0, 600, 0.5, 5)
            end
        end
    end
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
    if prow then
        local function proj(id, label, offset, max, small, big)
            add_row(weapon, 'Projectile', id, label, 'f32', { part(id, T_PROJECTILE, prow + offset, 'f32', 100000) }, 0, max, small, big)
        end
        add_row(weapon, 'Projectile', 'pellets', 'Projectiles per shot', 'u32',
                { part('pellets', T_PROJECTILE, prow + 28, 'u32', 1000) }, 1, 100, 1, 5)
        proj('velocity', 'Velocity (m/s)', 32, 20000, 10, 100)
        proj('drag', 'Drag factor', 40, 100, 0.05, 0.5)
        proj('pen_slowdown', 'Penetration slowdown', 64, 100, 0.05, 0.25)
        -- explosions: the projectile's on impact (+144) and on expiry (+156, when another one)
        -- -> explosion row (+16 inner, +20 outer, +24 shockwave radius)
        local impact = read_field(field_at(T_PROJECTILE, prow + 144, 'u32', 100000))
        local expiry = read_field(field_at(T_PROJECTILE, prow + 156, 'u32', 100000))
        if impact and impact > 0 then blasts[#blasts + 1] = { id = impact, prefix = 'blast', section = 'Explosion' } end
        if expiry and expiry > 0 and expiry ~= impact then
            blasts[#blasts + 1] = { id = expiry, prefix = 'expiry', section = #blasts > 0 and 'Explosion (expiry)' or 'Explosion' }
        end
    end
    -- a melee strike's explosion (Breaching Hammer), with its damage row (explosion +4)
    local strike = melee and weapon.key == key and KINDS[T_MELEE].explosions[weapon.hash]
    if strike then blasts[#blasts + 1] = { id = strike, prefix = 'blast', section = 'Explosion', damage = true } end
    for _, blast in ipairs(blasts) do
        local xrow = tables[T_EXPLOSION] and tables[T_EXPLOSION].index[blast.id]
        if xrow then
            local id = blast.damage and read_field(field_at(T_EXPLOSION, xrow + 4, 'u32', 100000))
            local qrow = id and id > 0 and tables[T_DAMAGE] and tables[T_DAMAGE].index[id]
            if qrow then
                for _, r in ipairs({ { 'damage', 'Explosion damage', 4, 100000, 1, 10 },
                                     { 'durable', 'Explosion durable damage', 8, 100000, 1, 10 },
                                     { 'ap_direct', 'Armor pen. (direct)', 12, 10, 1, 1 },
                                     { 'ap_slight', 'Armor pen. (slight angle)', 16, 10, 1, 1 },
                                     { 'ap_large', 'Armor pen. (large angle)', 20, 10, 1, 1 },
                                     { 'ap_extreme', 'Armor pen. (extreme angle)', 24, 10, 1, 1 },
                                     { 'demolition', 'Demolition force', 28, 10000, 1, 10 },
                                     { 'stagger', 'Stagger force', 32, 10000, 1, 10 },
                                     { 'push', 'Push force', 36, 10000, 1, 10 } }) do
                    local rid = blast.prefix .. '_' .. r[1]
                    add_row(weapon, blast.section, rid, r[2], 'u32', { part(rid, T_DAMAGE, qrow + r[3], 'u32', 1000000) },
                            0, r[4], r[5], r[6])
                end
            end
            for _, r in ipairs({ { 'inner', 'Inner radius (m)', 16 }, { 'outer', 'Outer radius (m)', 20 },
                                 { 'shockwave', 'Shockwave radius (m)', 24 } }) do
                local rid = blast.prefix .. '_' .. r[1]
                add_row(weapon, blast.section, rid, r[2], 'f32', { part(rid, T_EXPLOSION, xrow + r[3], 'f32', 100000) }, 0, 200, 0.1, 1)
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
            add_row(weapon, 'Ammo', id, label, 'u32', { part(id, T_MAGAZINE, magazine + offset, 'u32', 100000) }, min, max, 1, big)
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
    end
    -- heat weapons (lasers, Quasar): +84/+88/+92 heatsinks, +96 overheat threshold, +100 heat it
    -- recovers to after an overheat, +116/+120 heat per shot / second, +128 cooling per second,
    -- +140 cooling per second while overheated, +144 (byte) overheat needs a new heatsink
    local heat = record(T_HEAT)
    if heat then
        local function hf(offset) return field_at(T_HEAT, heat + offset, 'f32', 1000000) end
        local reload = read_field(field_at(T_HEAT, heat + 144, 'u32', 4294967295))
        reload = reload and reload % 256 ~= 0
        if reload then
            local function sink(id, label, offset)
                add_row(weapon, 'Ammo', id, label, 'u32', { part(id, T_HEAT, heat + offset, 'u32', 100000) }, 0, 999, 1, 5)
            end
            sink('heatsinks_start', 'Starting heatsinks', 84)
            sink('heatsinks_supply', 'Heatsinks from supply', 88)
            sink('heatsinks_max', 'Max spare heatsinks', 92)
        end
        local function h(id, label, offset, small, big)
            add_row(weapon, 'Heat', id, label, 'f32', { part(id, T_HEAT, heat + offset, 'f32', 1000000) }, 0, 100000, small, big)
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
            local row = add_row(weapon, 'Heat', id, label, 'f32', { part(id, T_HEAT, heat + offset, 'f32', 1000000) }, 0.1, 3600, 0.5, 5)
            row.span = function() return span(recovered) end
            row.span_default = function() return span_default(recovered) end
        end
        cool('heat_cool', 'Cool-down time, full heat (s)', 128, false)
        if not reload then cool('heat_cool_overheated', 'Cool-down time after overheat (s)', 140, true) end
    end
    local data = record(T_WEAPON)
    if data then
        local function w(id, offset) return part(id, T_WEAPON, data + offset, 'f32', 100000) end
        add_row(weapon, 'Handling', 'recoil_h', 'Recoil (horizontal)', 'f32', { w('recoil_dh', 0), w('recoil_ch', 28) }, 0, 500, 1, 5)
        add_row(weapon, 'Handling', 'recoil_v', 'Recoil (vertical)', 'f32', { w('recoil_dv', 4), w('recoil_cv', 32) }, 0, 500, 1, 5)
        add_row(weapon, 'Handling', 'spread_h', 'Spread (horizontal)', 'f32', { w('spread_h', 84) }, 0, 1000, 1, 10)
        add_row(weapon, 'Handling', 'spread_v', 'Spread (vertical)', 'f32', { w('spread_v', 88) }, 0, 1000, 1, 10)
        add_row(weapon, 'Handling', 'sway', 'Sway multiplier', 'f32', { w('sway', 104) }, 0, 100, 0.1, 0.5)
        add_row(weapon, 'Handling', 'ergonomics', 'Ergonomics', 'f32', { w('ergonomics', 356) }, 0, 1000, 1, 5)
    end
    for _, row in ipairs(weapon.rows) do
        if row.section == 'Ammo' and not row.note then
            row.note = 'applies to weapons spawned after the change (deploy, respawn, call-in)'
        end
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

local function read_text(address)
    local bytes = address and address > 65536 and api.read(address, 96)
    local text = bytes and bytes:match('^([^%z]*)%z')
    if not text or #text < 3 or text:find('[^\32-\126]') then return nil end
    return text
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
        if weapons[k].stratagem then by_hash[weapons[k].hash] = nil; table.remove(weapons, k) end
    end
    local guns, sentries = {}, {}
    for _, w in ipairs(weapons) do
        guns[w.key] = true
        if w.slot == 'Stratagems' then
            w.sentry_defs = {}
            local body = KINDS[TYPES.health].units[w.hash]
            sentries[w.key] = w
            if body then sentries[hash_key(body)] = w end
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
        local drone = KINDS[TYPES.health].drones[id]
        if drone then name = drone[1] end
        local entry = { name = name, slot = 'Stratagems', hash = id_hex(id), note = FAMILY_NOTE[family] or '',
                        rows = {}, by_id = {},
                        stratagem = { id = id, family = family, def = def, payloads = keys, nodes = nodes, guns = guns,
                                      drone = drone } }
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
            named = named + 1
            local entry = add(id, name, family, {}, {}, def)
            if entry then
                entry.note = family:sub(1, 1):upper() .. family:sub(2) .. ' stratagem (' .. text .. ').'
                if entry.stratagem.drone then
                    entry.note = 'Guard Dog backpack: the drone and the gun it carries. ' .. entry.note
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
    for _, entry in ipairs(list) do
        weapons[#weapons + 1] = entry
        by_hash[entry.hash] = entry
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
                add_row(entry, section, id, 'Velocity (m/s)', 'f32', { part(id, T_PROJECTILE, row + 32, 'f32', 100000) }, 0, 20000, 10, 100)
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
                for _, f in ipairs({ { 'damage', 'Damage', 4, 100000, 10, 100 }, { 'durable', 'Durable damage', 8, 100000, 10, 100 },
                                     { 'ap_direct', 'Armor pen. (direct)', 12, 10, 1, 1 }, { 'ap_slight', 'Armor pen. (slight angle)', 16, 10, 1, 1 },
                                     { 'ap_large', 'Armor pen. (large angle)', 20, 10, 1, 1 }, { 'ap_extreme', 'Armor pen. (extreme angle)', 24, 10, 1, 1 },
                                     { 'demolition', 'Demolition force', 28, 10000, 1, 10 }, { 'stagger', 'Stagger force', 32, 10000, 1, 10 },
                                     { 'push', 'Push force', 36, 10000, 1, 10 } }) do
                    local id = 'd' .. record .. '_' .. f[1]
                    add_row(entry, section, id, f[2], 'u32', { part(id, T_DAMAGE, row + f[3], 'u32', 1000000) }, 0, f[4], f[5], f[6])
                end
            end
        end
    end
    -- a Guard Dog: its drone (health +0, spotting range +0, target search interval +0 / +4), then
    -- the gun it carries
    if s.drone then
        unit_rows(entry, hash_key(s.drone[2]), 'Drone', 'drone_')
        resolve_gun(entry, hash_key(s.drone[3]))
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

local function resolve(weapon)
    weapon.rows, weapon.by_id = {}, {}
    if weapon.stratagem then resolve_stratagem(weapon); return end
    -- sentries and emplacements (listed as weapons on the Stratagems tab): their body, then their gun
    if weapon.slot == 'Stratagems' then
        local parts = {}
        for k, def in ipairs(weapon.sentry_defs or {}) do
            parts[k] = part(k == 1 and 'cooldown' or 'cooldown' .. k, def.kind, def.off + 104, 'f32', 100000)
        end
        if parts[1] then add_row(weapon, 'Stratagem', 'cooldown', 'Cooldown (s)', 'f32', parts, 0, 10000, 1, 10) end
        local body = KINDS[TYPES.health].units[weapon.hash]
        unit_rows(weapon, body and hash_key(body) or weapon.key, weapon.name:find('^E/') and 'Emplacement' or 'Sentry', 'unit_')
    end
    resolve_gun(weapon, weapon.key)
end

-- Resolves weapons from `next` on until the deadline; true once all are done.
local function resolve_some(progress, deadline)
    if progress.next == 1 then
        for _, f in pairs(fields) do f.users = {} end
    end
    while progress.next <= #weapons do
        resolve(weapons[progress.next])
        progress.next = progress.next + 1
        if api.now() >= deadline then break end
    end
    if progress.next <= #weapons then return false end
    local usable, strats = 0, 0
    for _, weapon in ipairs(weapons) do
        if #weapon.rows > 0 then
            if weapon.stratagem then strats = strats + 1 else usable = usable + 1 end
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

local function row_value(row)
    if row.span then return as_time(row.span(), read_field(row.parts[1].field)) end
    local sum = 0
    for _, p in ipairs(row.parts) do
        local v = read_field(p.field)
        if v == nil then return nil end
        sum = sum + v
    end
    return sum / #row.parts
end

local function row_default(row)
    if row.span then return as_time(row.span_default(), default_of(row.parts[1].field)) end
    local sum = 0
    for _, p in ipairs(row.parts) do
        local v = default_of(p.field)
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

local function config_path()
    local dir = data_dir('StatEditor')
    return dir and dir .. '/config.txt'
end

local function number_text(v)
    if math.abs(v - math.floor(v + 0.5)) < 1e-6 then return tostring(math.floor(v + 0.5)) end
    return (string.format('%.4f', v):gsub('0+$', ''):gsub('%.$', ''))
end

local function save_config()
    config_dirty_at = nil
    local path = config_path()
    if not path then return end
    local lines = {
        '# SHODAN Stat Editor settings. Changed through the in-game panel; applied at every start.',
        '# Lines: <weapon hash> <stat> <value>. Delete a line (or this file) to go back to the game\'s value.',
        'hotkey ' .. hotkey_name,
    }
    for _, o in ipairs(overrides) do
        local weapon = by_hash[o.hash]
        lines[#lines + 1] = o.hash .. ' ' .. o.id .. ' ' .. number_text(o.value) ..
                            (weapon and ('   # ' .. weapon.name) or '')
    end
    local ok, handle = pcall(io.open, path, 'wb')
    if ok and handle then
        pcall(function() handle:write(table.concat(lines, '\r\n') .. '\r\n'); handle:close() end)
    else
        log('could not write ' .. path)
    end
end

local function load_config()
    local path = config_path()
    local handle = path and io.open(path, 'rb')
    if not handle then save_config(); return end
    local text = handle:read('*a') or ''
    handle:close()
    local count = 0
    for line in text:gmatch('[^\r\n]+') do
        line = line:gsub('#.*$', '')
        local key = line:match('^%s*hotkey%s+(%S+)')
        if key then hotkey_name = key end
        local hash, id, value = line:match('^%s*(%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x)%s+([%w_]+)%s+([%d%.%-]+)')
        if hash and tonumber(value) then
            overrides[#overrides + 1] = { hash = hash:upper(), id = id, value = tonumber(value) }
            count = count + 1
        end
    end
    log('config: ' .. count .. ' value(s), hotkey ' .. hotkey_name .. ' (' .. path .. ')')
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

local function become_ready(final)
    local ok, why = pcall(build_stratagems)
    if not ok then log('stratagems: not listed: ' .. tostring(why)) end
    progress = { next = 1 }
    pending, apply_at = {}, 1
    for _, o in ipairs(overrides) do pending[#pending + 1] = { hash = o.hash, id = o.id, value = o.value } end
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
            log('stratagem ' .. w.name .. ' (' .. w.hash .. '): ' .. #w.rows .. ' rows, ' .. #w.stratagem.payloads .. ' payload(s)')
        end
    end
    set_status('ready', state.weapons .. ' weapons and ' .. (state.stratagems or 0) .. ' stratagems editable; ' ..
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
    local parse = spec.keyed and parse_keyed or parse_rows
    local started = api.now()
    local index, info = parse(blob, spec.stride, spec)
    local took = (api.now() - started) * 1000
    if not index then
        log(spec.name .. ' table at ' .. hex(address) .. ' not usable yet: ' .. info)
        return
    end
    local table_type = kind
    if spec.groups then
        -- each group is its own table; copies of one group have its size and first row
        kind = 'stratagems ' .. payload .. ' ' .. (u32(blob, 16 + (spec.id_at or 0)) or 0)
        if not tables[kind] then stratagem_groups[#stratagem_groups + 1] = kind end
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
local ui = { open = false, tab = 'Primary', page = 1, row = 1, scroll = 1, weapon = nil, hover = nil,
             gui = nil, world = nil, signature = nil, regions = {}, version = 0, errors = 0,
             wslot = 1, fslot = nil, fpage = 1, message = nil,   -- chosen weapon preset / full preset, status line
             editing = nil, confirm = nil,    -- a preset name being typed; an overwrite / delete to confirm
             search = { text = '', active = false },    -- the list's search (active: being typed)
             value = nil }   -- a value being typed: { n = row, weapon, text, fresh (the first key replaces it) }
local TABS = { 'Primary', 'Secondary', 'Support', 'Stratagems', 'Presets' }
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
    return { font = font_id, material = material_id, atlas = atlas_id }
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
    ui.row, ui.scroll = 1, 1
    if weapon then
        ui.tab = weapon.slot
        local list = weapons_in(ui.search.text ~= '' and '?search' or ui.tab)
        for n, w in ipairs(list) do
            if w == weapon then ui.page = math.floor((n - 1) / LIST_ROWS) + 1 end
        end
    end
end

local function change(row, delta_sign, big, exact)
    local weapon = ui.weapon
    local current = row_value(row)
    if not weapon or current == nil then return end
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
    if row.section == 'Ammo' then
        ui.message = { text = 'Saved. Ammo changes apply to the next ' .. weapon.name ..
                              ' spawned (deploy, respawn, call-in), not the one already held.', till = api.now() + 4 }
    end
    ui.version = ui.version + 1
end

-- Ends typing a value: keep = true sets it (out of the stat's range: the nearest end, and says so).
local function finish_value(keep)
    local edit = ui.value
    ui.value = nil
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
        local ok, handle = pcall(io.open, path, 'wb')
        if ok and handle then
            pcall(function() handle:write(table.concat(lines, '\r\n') .. '\r\n'); handle:close() end)
            return true
        end
        log('could not write ' .. tostring(path))
        return false
    end

    -- The file's lines without comments, or nil when there is no file.
    local function read_lines(path)
        local handle = path and io.open(path, 'rb')
        if not handle then return nil end
        local text = handle:read('*a') or ''
        handle:close()
        local out = {}
        for line in text:gmatch('[^\r\n]+') do out[#out + 1] = (line:gsub('#.*$', '')) end
        return out
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
        for _, line in ipairs(read_lines(preset_file('weapon_presets.txt')) or {}) do
            local hash, n, rest = line:match('^%s*(' .. HEX16 .. ')%s+(%d+)%s+(.-)%s*$')
            n = tonumber(n)
            if hash and n and n >= 1 and n <= WEAPON_PRESETS then
                hash = hash:upper()
                weapon_presets[hash] = weapon_presets[hash] or {}
                local values = weapon_presets[hash][n]
                if not values then values = {}; weapon_presets[hash][n] = values; count = count + 1 end
                local id, value = rest:match('^([%w_]+)%s+([%d%.%-]+)$')
                if id and tonumber(value) then values[#values + 1] = { id = id, value = tonumber(value) } end
            end
        end
        local full = 0
        for n = 1, FULL_PRESETS do
            local lines = read_lines(full_preset_file(n))
            local preset = lines and { name = 'Preset ' .. n, values = {} }
            for _, line in ipairs(lines or {}) do
                if line:match('^%s*cleared') then preset = nil; break end
                local name = line:match('^%s*name%s+(.-)%s*$')
                if name and name ~= '' then preset.name = name:sub(1, NAME_BYTES) end
                local hash, id, value = line:match('^%s*(' .. HEX16 .. ')%s+([%w_]+)%s+([%d%.%-]+)')
                if hash and tonumber(value) then
                    preset.values[#preset.values + 1] = { hash = hash:upper(), id = id, value = tonumber(value) }
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
        local values = weapon_preset(weapon, n)
        if not values then say(weapon.name .. ' preset ' .. n .. ' is empty'); return end
        local want = {}
        for _, v in ipairs(values) do want[v.id] = v.value end
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
            if m == n then ui.fpage = math.floor((k - 1) / LIST_ROWS) + 1 end
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
    local s = height / 1080 * 0.8   -- panel units -> 1080p units
    local ox, oy = width - (W + 30) * s, (height - H * s) / 2
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
            step('Gui.text_extents')
            local ok, lo, hi = pcall(Gui.text_extents, gui, value, ink_font, size)
            local measure = nil
            if ok and lo and hi then
                local a, b = vx(lo), vx(hi)
                if a and b and b > a then measure = b - a end
            end
            measure = measure or #value * size * 0.5
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
    rect(0, 0, W, H, color(8, 11, 15, 232), 950)
    outline(0, 0, W, H, GOLD)
    region('panel', 0, 0, W, H, false)
    text('SHODAN STAT EDITOR', 18, 12, 24, GOLD)
    text(hotkey_name .. ' to close', W - 18, 16, 15, MUTED, nil, true)
    if rawget(_G, 'SHODAN_PACK_HUB') or rawget(_G, 'SHODAN_SCAN_HUB') then
        text('SHODAN weapon mods are running too: they put their own values back every 5 s', 290, 17, 14, WARN, 540)
    end

    if state.phase ~= 'ready' then
        local found = 0
        for _, kind in ipairs(KIND_ORDER) do if tables[kind] then found = found + 1 end end
        text('Reading the game\'s weapon tables... (' .. found .. ' of ' .. #KIND_ORDER .. ' found)', 18, 70, 18, WHITE)
        return regions
    end

    for n, tab in ipairs(TABS) do
        button('tab:' .. tab, tab, 16 + (n - 1) * 118, 52, 112, 32, true, ui.tab == tab)
    end
    button('reset_weapon', 'Reset weapon', W - 16 - 150 - 8 - 130, 52, 150, 32, ui.weapon ~= nil and modified(ui.weapon))
    button('reset_all', 'Reset all', W - 16 - 130, 52, 130, 32, #overrides > 0)

    local presets_tab = ui.tab == 'Presets'
    if presets_tab then
        -- full presets: the list holds them by name, the right side the chosen one
        local order, chosen = presets.full_order(), presets.chosen()
        local pages = math.max(1, math.ceil(#order / LIST_ROWS))
        ui.fpage = math.max(1, math.min(ui.fpage, pages))
        for k = 1, LIST_ROWS do
            local n = order[(ui.fpage - 1) * LIST_ROWS + k]
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
        text('page ' .. ui.fpage .. ' of ' .. pages .. '   ' .. #order .. ' of ' .. presets.full_count, 70, py + 7, 16, MUTED, 214)
        button('fpage:next', '>', 294, py, 40, 30, ui.fpage < pages)
        button('fpreset:new', '+ New preset from current changes', 16, py + 40, 318, 30, #order < presets.full_count)
        rect(343, 96, 2, H - 96 - 70, color(70, 82, 94), 951)

        local x0, preset = 356, chosen and presets.full[chosen]
        if not preset then
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
    local pages = math.max(1, math.ceil(#list / LIST_ROWS))
    if ui.page > pages then ui.page = pages end
    for k = 1, LIST_ROWS do
        local weapon = list[(ui.page - 1) * LIST_ROWS + k]
        if not weapon then break end
        local y = 96 + (k - 1) * 26
        local key = 'weapon:' .. weapon.hash
        if searching then text(weapon.slot, 326, y + 5, 13, DIM, 80, true) end
        local selected = weapon == ui.weapon
        if selected then rect(16, y, 318, 25, color(90, 74, 8), 951)
        elseif ui.hover == key then rect(16, y, 318, 25, color(40, 52, 64), 951) end
        text((modified(weapon) and '* ' or '') .. weapon.name, 24, y + 4, 16, modified(weapon) and GOLD or WHITE,
             searching and 226 or 302)
        region(key, 16, y, 318, 25)
    end
    local py = 96 + LIST_ROWS * 26 + 8
    if not presets_tab then
        if ui.search.text ~= '' and #list == 0 then text('Nothing matches.', 24, 100, 16, MUTED) end
        button('page:prev', '<', 16, py, 40, 30, ui.page > 1)
        text('page ' .. ui.page .. ' of ' .. pages .. (ui.search.text ~= '' and ('   ' .. #list .. ' found') or ''),
             70, py + 7, 16, MUTED, 214)
        button('page:next', '>', 294, py, 40, 30, ui.page < pages)
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
    if presets_tab then
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
        local sections = 0
        for n, row in ipairs(weapon.rows) do
            if n == 1 or row.section ~= weapon.rows[n - 1].section then sections = sections + 1 end
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
        local pitch = math.floor((bottom - y - sections * 24) / math.max(1, #weapon.rows))
        local scrolling = pitch < 22
        if scrolling then
            pitch, bottom = 24, bottom - 36
            ui.scroll = math.max(1, math.min(ui.scroll, #weapon.rows))
        else
            pitch, ui.scroll = math.min(26, pitch), 1
        end
        ui.last_visible = #weapon.rows
        for n, row in ipairs(weapon.rows) do
            if n >= ui.scroll then
                if y + pitch + (row.section ~= section and 24 or 0) > bottom then
                    ui.last_visible = n - 1
                    break
                end
                if row.section ~= section then
                    section = row.section
                    local note, others = row.note or '', shared_with(weapon, row)
                    if note == '' and #others > 0 then
                        note = 'shared with ' .. table.concat(others, ', ', 1, math.min(3, #others)) ..
                               (#others > 3 and (' +' .. (#others - 3)) or '')
                    end
                    text(section:upper(), x0, y + 4, 15, MUTED)
                    if note ~= '' then text(note, x0 + 110, y + 4, 14, WARN, W - x0 - 130) end
                    y = y + 24
                end
                local value, default = row_value(row), row_default(row)
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
            end
        end
        if scrolling then
            text(string.format('rows %d-%d of %d', ui.scroll, ui.last_visible, #weapon.rows), x0, bottom + 12, 15, MUTED)
            button('scroll:up', 'Up', 790, bottom + 6, 80, 26, ui.scroll > 1)
            button('scroll:down', 'Down', 874, bottom + 6, 80, 26, ui.last_visible < #weapon.rows)
        end
    end

    -- footer
    rect(16, H - 64, W - 32, 1, color(70, 82, 94), 951)
    if ui.editing then
        text('Type the name: Enter keeps it, Esc cancels. The game sees these keys too, so name presets from a menu.',
             18, H - 56, 14, MUTED, W - 36)
    elseif ui.value then
        text('Type the value: Enter sets it, Esc cancels. Values out of range are set to the nearest allowed one.',
             18, H - 56, 14, MUTED, W - 36)
    elseif ui.search.active and not presets_tab then
        text('Type to search: Enter keeps the results, Esc clears the search. The game sees these keys too.',
             18, H - 56, 14, MUTED, W - 36)
    elseif presets_tab then
        text('Up/Down choose, Enter loads, Insert makes a new one, Shift+Insert saves into it, F2 renames, Del deletes.',
             18, H - 56, 14, MUTED, W - 36)
    else
        text('Up/Down choose a stat, Left/Right change it (Shift: bigger steps), click a value or press Enter to type it,',
             18, H - 56, 14, MUTED, W - 36)
    end
    if ui.message then
        text(ui.message.text, 18, H - 34, 14, GOOD, W - 36)
    elseif presets_tab then
        text('Overwriting and deleting ask twice. Changes apply at once and are saved; ' .. #overrides ..
             ' value(s) changed.', 18, H - 34, 14, MUTED, W - 36)
    else
        text('PgUp/PgDn change weapon, Del resets, Ctrl+1-5 loads a weapon preset, Ctrl+Shift+1-5 saves one; ' .. #overrides ..
             ' value(s) changed.', 18, H - 34, 14, MUTED, W - 36)
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
    if kind == 'tab' then ui.tab, ui.page, ui.search = arg, 1, { text = '', active = false }
    elseif kind == 'search' then
        if arg == 'clear' then ui.search, ui.page = { text = '', active = false }, 1
        else ui.search.active = true end
    elseif kind == 'weapon' then select_weapon(by_hash[arg])
    elseif kind == 'page' then ui.page = ui.page + (arg == 'next' and 1 or -1)
    elseif kind == 'reset_all' then reset_all()
    elseif kind == 'reset_weapon' and weapon then reset_weapon(weapon)
    elseif kind == 'wslot' then ui.wslot = tonumber(arg) or 1
    elseif kind == 'wpreset' and weapon then
        if arg == 'save' then presets.save_weapon_preset(weapon, ui.wslot)
        elseif arg == 'load' then presets.load_weapon_preset(weapon, ui.wslot)
        elseif arg == 'clear' then presets.clear_weapon_preset(weapon, ui.wslot) end
    elseif kind == 'fslot' then ui.fslot = tonumber(arg)
    elseif kind == 'fpage' then ui.fpage = ui.fpage + (arg == 'next' and 1 or -1)
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
        elseif ui.last_visible and ui.row > ui.last_visible then ui.scroll = ui.scroll + ui.row - ui.last_visible end
    end
    local row = weapon.rows[ui.row]
    if not row then ui.row = 1; return end
    local big = key_down(VK.Shift)
    if pressed('Right', now) then change(row, 1, big) end
    if pressed('Left', now) then change(row, -1, big) end
    if pressed('Delete', now) then reset_row(weapon, row) end
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
    ui.hover = hit(x * width / cw, (ch - y) * height / ch, true)
    local value = sr.Mouse.button(sr.Mouse.button_id('left'))
    local down = value == true or (type(value) == 'number' and value > 0)
    if mouse_was_down ~= nil then
        if down and not mouse_was_down then armed = ui.hover end
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
local cursor = { taken = false }

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
    if not ui.hover then mouse_was_down, armed = nil, nil end
    if window then keyboard(now) end

    -- redraw when anything shown changed
    local width, height = sr.Gui.resolution()
    if ui.message and api.now() >= ui.message.till then ui.message = nil end
    if ui.confirm and api.now() >= ui.confirm.till then ui.confirm = nil; ui.version = ui.version + 1 end
    local signature = table.concat({ width, height, state.phase, state.tables, ui.tab, ui.page, ui.row, ui.scroll,
                                     tostring(ui.hover), ui.weapon and ui.weapon.hash or '-', ui.version,
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
        if not ui.weapon then
            local list = weapons_in(ui.tab)
            select_weapon(list[1])
        end
        ui.worlds = nil
        log('panel opened')
        flush_log()
        local ok, why = pcall(take_cursor)
        if not ok then log('cursor: could not free it: ' .. tostring(why)) end
    else
        pcall(release_cursor)
        clear_gui()
        ui.worlds = nil
        held, mouse_was_down, armed = {}, nil, nil
        ui.editing, ui.confirm, ui.search.active, ui.value = nil, nil, false, nil
    end
end

-- ---------------------------------------------------------------- per frame
local hotkey_was_down = false
local next_retry, next_flush = 0, 0

local function tick()
    state.frame = state.frame + 1
    local now = api.now()
    if state.phase == 'preparing' then
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
    if down and not hotkey_was_down and focused_window() then open_panel(not ui.open) end
    hotkey_was_down = down

    if ui.open then
        local ok, why = pcall(panel_frame, now)
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
