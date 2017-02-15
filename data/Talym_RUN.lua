function get_sets()
    mote_include_version = 2
    include('Mote-Include')
end

function job_setup()
end

function user_setup()

    include('Talym-Include')

    state.OffenseMode:options('Normal','Acc','Acc2')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.WeaponskillMode:options('Normal','Acc')
    state.CastingMode:options('Normal','SID')
    state.IdleMode:options('Normal','DT','Regen','Refresh')

    init_job_states({},{"OffenseMode","WeaponskillMode","CastingMode","IdleMode"})

end

function init_gear_sets()

    sets.enmity = { -- Enmity +62
        ammo="Sapience Orb",                        --> Enmity +2
        head="", -- Halitus Helm
        neck="Unmoving Collar +1",                  --> Enmity +10
        lear="", -- Cryptic Earring
        rear="Friomisi Earring",                    --> Enmity +2
        body="Emet Harness +1",                     --> Enmity +10
        hands="Nilas Gloves",                       --> Enmity +5
        lring="Begrudging Ring",                    --> Enmity +5
        rring="Petrov Ring",                        --> Enmity +4
        back="Evasionist's Cape",                   --> Enmity +7
        waist="", -- Warwolf Belt
        legs="Erilaz Leg Guards +1",                --> Enmity +11
        feet="Erilaz Greaves +1",                   --> Enmity +6
    }

    --------------------------------------------------
    -- Precast sets
    --------------------------------------------------

    -- Job Ability precasts
    sets.precast.JA['Vallation'] = set_combine(sets.enmity, {
        body="Runeist Coat +1",                     --> Duration +15s
        back="Ogma's Cape",                         --> Duration +15s
        legs="Futhark Trousers +1",                 --> Fast Cast +2%/merit
    })
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']

    sets.precast.JA['Pflug'] = set_combine(sets.enmity, {
        feet="Runeist Bottes", --+1,                --> Pflug +1
    })

    sets.precast.JA['Battuta'] = set_combine(sets.enmity, {
        head="Futhark Bandeau +1",                  --> Enhances Battuta
    })

    sets.precast.JA['Liement'] = set_combine(sets.enmity, {
        body="Futhark Coat +1",                     -->
    })

    sets.precast.JA['Gambit'] = set_combine(sets.enmity, {
        hands="Runeist Mitons +1",                  -->
    })

    sets.precast.JA['Rayke'] = set_combine(sets.enmity, {
        feet="Futhark Boots",--+1,                  -->
    })

    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.enmity, {
        body="Futhark Coat +1",                     -->
    })

    sets.precast.JA['Swordplay'] = set_combine(sets.enmity, {
        hands="Futhark Mitons",--+1,                -->
    })

    sets.precast.JA['Embolden'] = set_combine(sets.enmity, {
        back="Evasionist's Cape",                   --> Duration +11%
    })

    sets.precast.JA['Vivacious Pulse'] = set_combine(sets.enmity, {
        head="Erilaz Galea +1",                     --> Remove Status Ailments
        neck="Incanter's Torque",                   --> Skill +10
        lear="", -- Beatific Earring
        rear="", -- Divine Earring
        lring="Stikini Ring",                       --> Skill +5
        rring="Stikini Ring",                       --> Skill +5
        waist="", -- Bishop's Sash
        legs="Runeist Trousers +1",                 --> Skill +15
    })

    sets.precast.JA['Lunge'] = set_combine(sets.enmity, {
        ammo="Pemphredo Tathlum",                   --> INT +4  MAcc +8  MAB +4
        head="",
        neck="Sanctity Necklace",                   --> MAcc +10  MAB +10
        lear="Hecate's Earring",                    --> MAB +6  MCrit +3%
        rear="Friomisi Earring",                    --> MAB +10
        body="Samnuha Coat",                        --> INT +20  MAcc +37  MAB +33
        hands="Leyline Gloves",                     --> INT +12  MAcc +33  MAB +30
        lring="Defending Ring",
        rring="Acumen Ring",                        --> INT +2  MAB +4
        back="Toro Cape",                           --> INT +8  MAB +10
        waist="Yamabuki-no-Obi",                    --> INT +6  MAcc +2  MAB +5
        legs=gear.legs.Herculean.MAB,               --> INT +39  MAcc +13  MAB +30
        feet=gear.feet.Herculean.MAB,               --> INT +3  MAcc +10  MAB +32
    })
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

    sets.precast.JA['One for All'] = set_combine(sets.enmity, {
        ammo="Falcon Eye",                          --> HP +10
        head="Runeist Bandeau +1", -- Halitus Helm  --> HP +66
        neck="Sanctity Necklace", -- Dualism Collar --> HP +35
        lear="Thureous Earring", -- Cryptic Ear.    --> HP +30
        rear="Etiolation Earring",                  --> HP +50
        body="Runeist Coat +1",                     --> HP +139
        hands="Runeist Mitons +1", -- Nilas Gloves? --> HP +50
        lring="", -- Meridian Ring
        rring="", -- Vexer Ring +1
        back="Xucau Mantle", -- Reiki Cloak         --> HP +100
        waist="Oneiros Belt",                       --> HP +55
        legs="Futhark Trousers +1", -- Erilaz       --> HP +87
        feet="Carmine Greaves", -- +1               --> HP +75
    })
    sets.precast.JA['Odyllic Subterfuge'] = sets.enmity

    -- Fast Cast precasts
    sets.precast.FC = { -- FC +50%
        ammo="Sapience Orb",                        --> FC +2%
        head="Carmine Mask",                        --> FC +12%
        neck="Voltsurge Torque",                    --> FC +4%
        lear="Etiolation Earring",                  --> FC +1%
        rear="Loquacious Earring",                  --> FC +2%
        body="Foppish Tunica",                      --> FC +5%
        hands="Leyline Gloves",                     --> FC +8%
        lring="Kishar Ring",                        --> FC +4%
        rring="Prolix Ring",                        --> FC +2%
        back="",
        waist="",
        legs="Limbo Trousers",                      --> FC +3%
        feet="Carmine Greaves",                     --> FC +7%
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",                        --> Cast time -8%
        legs="Futhark Trousers +1",                 --> Cast time -13%
    })

    sets.precast.FC['Cure'] = set_combine(sets.precast.FC, {
        lear="Mendicant's Earring",                 --> Cast time -5%
        legs="Doyen Pants",                         --> Cast time -15%
    })

    -- Weaponskill precasts

    -- Resolution: 73~85% STR, fTP Transfer
    -- STR +203~207  DEX +158  Acc +110  Atk +194  DA +21%  TA +23%  TPBonus +250
    sets.precast.WS['Resolution'] = {
        ammo="Seething Bomblet +1",                 --> STR +1~5  Acc +13  Atk +13
        head="Adhemar Bonnet",                      --> STR +29  DEX +31  Atk +41  TA +3%
        neck="Fotia Gorget",
        lear="Sherida Earring",                     --> STR +5  DEX +5  DA +5%
        rear="Moonshade Earring",                   --> Atk +4  TPBonus +250
        body="Adhemar Jacket",                      --> STR +36  DEX +43  Acc +25  Atk +40  TA +3%
        hands=gear.hands.Herculean.StrTA,           --> STR +25  DEX +39  Acc +27  Atk +26  TA +6%
        lring="Epona's Ring",                       --> DA +3%  TA +3%
        rring="Shukuyu Ring",                       --> STR +7  Atk +15
        rring="Niqmaddu Ring",                      --> STR +10  DEX +10  QA +3%
        back=gear.back.Ogma.DA,                     --> STR +30  Acc +20  Atk +20  DA +10%
        waist="Fotia Belt",
        legs="Samnuha Tights",                      --> STR +48  DEX +16  Acc +15  DA +3%  TA +3%
        feet=gear.feet.Herculean.StrTA,             --> STR +22  DEX +24  Acc +10  Atk +35  TA +5%
    }

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {
        --head="Dampening Tam",
        lear="Cessance Earring",
        hands=gear.hands.Herculean.DT,
        rring="Rufescent Ring",
        feet=gear.feet.Herculean.Acc,               --> STR +26  DEX +24  Acc +50  Atk +40  TA +2%
    })

    sets.precast.WS['Dimidiation'] = { -- DEX +234
        ammo="Seething Bomblet +1",                 --> STR +1~5  Acc +13  Atk +13
        --head="Adhemar Bonnet",                      --> STR +29  DEX +31  Atk +41  CDMG +5%
        head=gear.head.Herculean.WSD,               --> STR +22  DEX +43  Acc +11  Atk +26  WSD +3%
        neck="Caro Necklace",                       --> STR +6  DEX +6  Atk +10
        lear="Ishvara Earring",                     --> WSD +2%
        rear="Moonshade Earring",                   --> Atk +4  TPBonus +250
        body="Meghanada Cuirie +1",                 --> STR +31  DEX +42  Acc +44  Atk +40  CDMG +5%
        hands="Meghanada Gloves +1",                --> STR +20  DEX +47  Acc +41  Atk +37  WSD +5%
        lring="Niqmaddu Ring",                      --> STR +10  DEX +10
        rring="Apate Ring",                         --> STR +6  DEX +6
        back="Bleating Mantle",                     --> Atk +20
        waist="Grunfeld Rope",                      --> STR +5  DEX +5  Acc +10  Atk +20
        legs="Lustratio Subligar",                  --> DEX +37  Acc +15  Atk +35  CRate +2%
        feet="Lustratio Leggings",                  --> STR +39  DEX +40
    }

    sets.precast.WS['Savage Blade'] = {}
    sets.precast.WS['Requiescat'] = {}

    --------------------------------------------------
    -- Midcast sets
    --------------------------------------------------

    sets.SID = { -- SID 81%
        ammo="Staunch Tathlum",                     --> SID 10%
        neck="", -- Willpower Torque 5%
        lear="Halasz Earring",                      --> SID 5%
        body="Taeon Tabard",                        --> SID 7%
        hands="Rawhide Gloves",                     --> SID 15%
        lring="Evanescence Ring",                   --> SID 5%
        waist="Rumination Sash",                    --> SID 10%
        legs="Carmine Cuisses +1",                  --> SID 20%
        feet="Taeon Boots",                         --> SID 9%
    }

    -- Base Fast Recast set
    sets.midcast.FastRecast = { -- reuse sets.precast.FC?
        ammo="Sapience Orb",                        --> FC +2%
        head="Carmine Mask",                        --> FC +12%
        neck="Voltsurge Torque",                    --> FC +4%
        lear="Etiolation Earring",                  --> FC +1%
        rear="Loquacious Earring",                  --> FC +2%
        body="Samnuha Coat",                        --> FC +4%
        hands="Leyline Gloves",                     --> FC +8%
        lring="Rahab Ring",                         --> FC +2%
        rring="Prolix Ring",                        --> FC +2%
        back="",
        waist="",
        legs="Limbo Trousers",                      --> FC +3%
        feet="Carmine Greaves",                     --> FC +7%
    }

    -- Enhancing Magic sets
    sets.midcast['Enhancing Magic'] = {
        head="Erilaz Galea +1",                     --> Duration +15
        neck="Incanter's Torque",                   --> Skill +10
        lear="", -- Andoaa Earring
        rear="", -- Augmenting Earring
        body="Manasa Chasuble",                     --> Skill +12
        hands="Runeist Mitons +1",                  --> Skill +15
        lring="Stikini Ring",                       --> Skill +5
        rring="Stikini Ring",                       --> Skill +5
        back="", -- Merciful Cape
        waist="", -- Olympus Sash
        legs="Futhark Trousers +1",                 --> Duration +20
        feet="", -- Carmine +1
    }

    -- Phalanx +15
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
        head="Futhark Bandeau +1",                  --> Phalanx +5
        body="Taeon Tabard",                        --> Phalanx +3
        hands="Taeon Gloves",                       --> Phalanx +2
        legs="Taeon Tights",                        --> Phalanx +3
        feet="Taeon Boots",                         --> Phalanx +2
    })

    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {
        head="Runeist Bandeau +1",                  --> Duration +21
    })

    sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {
        head="Erilaz Galea +1",                     --> Refresh +2
        waist="Gishdubar Sash",                     --> Duration +20
    })

    sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'], {
        waist="Siegel Sash",                        --> Stoneskin +20
    })

    sets.midcast['Temper'] = set_combine(sets.midcast['Enhancing Magic'], {
        legs="", -- Carmine Cuisses +1
    })

    -- Add Spell Interrupt Down variants
    sets.midcast['Enhancing Magic'].SID = set_combine(sets.SID, sets.midcast['Enhancing Magic'])
    sets.midcast['Phalanx'].SID = set_combine(sets.SID, sets.midcast['Phalanx'])
    sets.midcast['Regen'].SID = set_combine(sets.SID, sets.midcast['Regen'])
    sets.midcast['Refresh'].SID = set_combine(sets.SID, sets.midcast['Refresh'])
    sets.midcast['Stoneskin'].SID = set_combine(sets.SID, sets.midcast['Stoneskin'])
    sets.midcast['Temper'].SID = set_combine(sets.SID, sets.midcast['Temper'])

    -- Cure sets
    sets.midcast['Cure'] = { -- Potency +21%  Received +27%
        ammo="Hydrocera",                           --> MND +3
        head="", -- Halitus Helm
        neck="Phalaina Locket",                     --> MND +3  Potency +4%  Received +4%
        lear="Mendicant's Earring",                 --> Potency +5%
        rear="Roundel Earring",                     --> Potency +5%
        body="", -- Vrikodara Jupon
        hands="Buremte Gloves", -- Nilas Gloves     --> Received +13%
        lring="Ephedra Ring",                       --> Skill +7
        rring="Sirona's Ring",                      --> MND +3  Skill +10
        back="Solemnity Cape",                      --> Potency +7%
        waist="Gishdubar Sash",                     --> Received +10%
        legs="", -- Carmine Cuisses +1
        feet="", -- Erilaz Greaves +1
    }

    -- Add Spell Interrupt Down variants
    sets.midcast['Cure'].SID = set_combine(sets.SID, sets.midcast['Cure'])

    sets.midcast['Flash'] = sets.enmity

    --------------------------------------------------
    -- Idle sets
    --------------------------------------------------

    sets.idle = {
        ammo="Homiliary",                           --> Refresh +1
        head="Rawhide Mask",                        --> Refresh +1
        neck="Sanctity Necklace",                   --> Regen +2
        lear="Etiolation Earring",                  --> MDT -1%
        rear="", -- Genmei, Infused
        body="Mekosuchinae Harness",                --> Refresh +1
        hands="Meghanada Gloves +1", -- Herculean   --> PDT -3%
        lring="Defending Ring",                     --> DT -10%
        rring="Shneddick Ring",                     --> Movement Speed +18%
        back="Solemnity Cape",                      --> DT -4%
        waist="Gishdubar Sash",
        legs="Carmine Cuisses +1",                  --> Movement Speed +18%
        feet=gear.feet.Herculean.Refresh,           --> PDT -2%  Refresh +2
    }

    --------------------------------------------------
    -- Engaged sets
    --------------------------------------------------

    sets.engaged = {
        -- STR +186  DEX +184  Acc +143  Atk +150  DA +20%  TA +24%  QA +5%
        -- STP +33  Haste +27%  CRate +3%  CDMG +5%
        ammo="Ginsen",                              --> Acc +5  Atk +10  STP +3
        head="Adhemar Bonnet",                      --> STR +29  DEX +31  Atk +41  TA +3%  Haste +8%  CDMG +5%
        neck="Anu Torque",                          --> Atk +20  STP +7
        lear="Telos Earring",                       --> Acc +10  Atk +10  DA +1%  STP +5
        rear="Cessance Earring",                    --> Acc +6  DA +3%  STP +3
        body=gear.body.Herculean.TA,                --> STR +28  DEX +49  Acc +39  TA +3%  STP +3  CRate +3%  Haste +4%
        hands=gear.hands.Herculean.StrTA,           --> STR +25  DEX +39  Acc +27  Atk +26  TA +6%  Haste +5%
        lring="Epona's Ring",                       --> DA +3%  TA +3%
        rring="Niqmaddu Ring",                      --> STR +10  DEX +10  QA +3%  STP +5
        back=gear.back.Ogma.DA,                     --> STR +30  Acc +20  Atk +20  DA +10%
        waist="Windbuffet Belt +1",                 --> Acc +2  TA +2%  QA +2%
        legs="Samnuha Tights",                      --> STR +48  DEX +16  Acc +15  DA +3%  TA +3%  STP +7  Haste +6%
        feet=gear.feet.Herculean.TA,                --> STR +16  DEX +39  Acc +21  Atk +23  TA +4%  Haste +4%

        --body=gear.body.Herculean.QA,                --> STR +28  DEX +34  Acc +15  DA +1%  QA +1%  STP +3  CRate +6%  Haste +4%
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        ammo="Yamarang",                            --> Acc +15  STP +3
        head="Dampening Tam",                       --> STR +18  DEX +34  Acc +33  QA +2%  Haste +7%
        neck="Clotharius Torque",                   --> Acc +8  TA +1%
        body="Adhemar Jacket",                      --> STR +36  DEX +43  Acc +25  Atk +40  TA +3%  Haste +4%
        hands=gear.hands.Adhemar.Acc,               --> STR +15  DEX +53  Acc +37  TA +3%  Haste +5%  STP +6
        waist="Kentarch Belt",--+1,                 --> Acc +13  DA +2%  STP +5
    })

    sets.engaged.Acc2 = set_combine(sets.engaged.Acc, {
        neck="Combatant's Torque",                  --> Skill +15
        ear2="Dignitary's Earring",                 --> Acc +10  STP +3
        body=gear.body.Herculean.Acc,               --> STR +28  DEX +34  Acc +53  Atk +30  Haste +4%  STP +3  CRate +5%
        feet=gear.feet.Herculean.Acc,               --> STR +26  DEX +24  Acc +50  Atk +40  TA +2%  Haste +4%
    })

    --------------------------------------------------
    -- Defense lock sets
    --------------------------------------------------

    sets.defense.PDT = {    -- DT -29%  PDT -25%
        --main="Takoba",                            --> DT -3%
        ammo="Staunch Tathlum",                     --> DT -2%  Resist All +10  SID 10%
        head="Futhark Bandeau +1",                  --> PDT -4%
        neck="Loricate Torque +1",                  --> DT -6%
        lear="",
        rear="",
        body="Erilaz Surcoat +1",                   -->
        hands=gear.hands.Herculean.DT,              --> DT -4%  PDT -2%
        lring="Defending Ring",                     --> DT -10%
        rring="Warden's Ring",                      --> PDT -3%
        back="Solemnity Cape",                      --> DT -4%
        waist="Flume Belt",                         --> PDT -4%
        legs="Erilaz Leg Guards +1",                --> PDT -7%
        feet="Erilaz Greaves +1",                   --> PDT -5%
    }

    sets.defense.MDT = { -- DT -36%  MDT -12%
        --main="Takoba",                            --> DT -3%
        --sub="Irenic Strap",                       --> MDT -4%
        ammo="Staunch Tathlum",                     --> DT -2%  Resist All +10  SID 10%
        head="Dampening Tam",                       --> MDT -4%
        neck="Loricate Torque +1",                  --> DT -6%
        lear="Etiolation Earring",                  --> MDT -3%
        rear="Odnowa Earring",                      --> MDT -1%
        body="Futhark Coat +1",                     --> DT -7%
        hands=gear.hands.Herculean.DT,              --> DT -4%  PDT -2%
        lring="Defending Ring",                     --> DT -10%
        rring="Shadow Ring",                        --> Annul Magic +13%
        back="Solemnity Cape",                      --> DT -4%
        waist="Flume Belt",                         --> PDT -4%  DT>MP +2%
        legs="Erilaz Leg Guards +1",
        feet="Erilaz Greaves +1",
    }

end

function user_unload()
    clear_job_states()
end

function job_state_change()
    update_job_states()
end
