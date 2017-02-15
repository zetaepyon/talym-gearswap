-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()

    include('Talym-Include')

    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'Movement')

    classes.AutoFallback = T{
        ["Protectra V"] = "Shellra V",
        ["Light Arts"] = "Afflatus Solace",
        ["Cure VI"] = "Cure V",
        ["Cure V"] = "Cure IV",
        ["Cure IV"] = "Cure III",
        ["Cure III"] = "Cure II",
        ["Curaga V"] = "Curaga IV",
        ["Curaga IV"] = "Curaga III",
        ["Curaga III"] = "Curaga II",
        ["Curaga II"] = "Curaga",
        ["Haste"] = "Regen"
    }

    send_command('wait 10; input /lockstyleset 1')--29')
	set_macro_page(1, 4)

end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Fast cast sets for spells
	--[[sets.precast.FC = { -- FC +80~82% (Cap)
        main=gear.main.Grioavolr.FC,                --> FC +10%
        sub="Clerisy Strap +1",                     --> FC +3%
        ammo="Sapience Orb",                        --> FC +2%
        head="Haruspex Hat",                        --> FC +8%
        neck="Voltsurge Torque",                    --> FC +4%
        ear1="Etiolation Earring",                  --> FC +1%
        ear2="Loquacious Earring",                  --> FC +2%
        body="Inyanga Jubbah +1",                   --> FC +13%
        hands="Fanatic Gloves",                     --> FC +7%
        ring1="Rahab Ring",                         --> FC +2%
        ring2="Kishar Ring",                        --> FC +4%
        back="Alaunus's Cape",                      --> FC +10%
        waist="Channeler's Stone",                  --> FC +2%
        legs="Psycloth Lappas",                     --> FC +7%
        feet="Regal Pumps +1",                      --> FC +5~7%
    }]]--
    sets.precast.FC = { -- FC +78~80% (Cap 80)  QM +7%
        main=gear.main.Grioavolr.FC,                --> FC +11%
        sub="Clerisy Strap +1",                     --> FC +3%
        ammo="Impatiens",                           --> QM +2%
        head="Haruspex Hat",                        --> FC +8%
        neck="Voltsurge Torque",                    --> FC +4%
        ear1="Etiolation Earring",                  --> FC +1%
        ear2="Loquacious Earring",                  --> FC +2%
        body="Inyanga Jubbah +1",                   --> FC +13%
        hands="Fanatic Gloves",                     --> FC +7%
        ring1="Lebeche Ring",                       --> QM +2%
        ring2="Kishar Ring",                        --> FC +4%
        back="Alaunus's Cape",                      --> FC +10%
        waist="Witful Belt",                        --> FC +3%  QM +3%
        legs="Psycloth Lappas",                     --> FC +7%
        feet="Regal Pumps +1",                      --> FC +5~7%
    }

    sets.precast.FC.Ideal = { -- FC +81~83%  QM +11% (Cap 80%, 10%)
        main=gear.main.Grioavolr.FC,                --> FC +12%
        sub="Clerisy Strap +1",                     --> FC +3%
        ammo="Sapience Orb",                        --> FC +2%
        head="Natirah Hat",                         --> FC +10%
        neck="Orunmila's Torque",                   --> FC +5%
        ear1="Enchanter Earring +1",                --> FC +2%
        ear2="Loquacious Earring",                  --> FC +2%
        body="Inyanga Jubbah +1",                   --> FC +13%
        hands="Fanatic Gloves",                     --> FC +7%
        ring1="Weatherspoon Ring +1",               --> FC +6% QM +4%
        ring2="Kishar Ring",                        --> FC +4%
        back="Perimede Cape",                       --> QM +4%
        waist="Witful Belt",                        --> FC +3%  QM +3%
        legs="Psycloth Lappas",                     --> FC +7%
        feet="Regal Pumps +1",                      --> FC +5~7%
    }
    --[[
        head="Natirah Hat",                         --> FC +10% (2)
        neck="Orunmila's Torque",                   --> FC +5% (1)
        ear1="Enchanter Earring +1",                --> FC +1% (1)
        ring1="Weatherspoon Ring +1",               --> FC +6% QM +4% (6 2)
    ]]--

    -- Quick Magic sets
    sets.precast.FC.QM = set_combine(sets.precast.FC, { -- QM +11% (10%)
        back="Perimede Cape",                       --> QM +4%
    })

    --[[
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",                        --> Cast time -8%
	})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
        legs="Doyen Pants",                         --> Cast time -10%
	})

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
        -- Job Points                               --> Cast time -6%
        legs="Ebers Pantaloons +1",                 --> Cast time -13%
	})

	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
        -- Cast Time -82%
        -- Job Points                               --> Cast time -6%
        head="Piety Cap",                           --> Cast time -12%
        --feet="Hygieia Clogs",                       --> Cast time -17%
    })

	sets.precast.FC.Curaga = sets.precast.FC.Cure
    ]]--

    sets.precast.FC.Raise     = sets.precast.FC.QM
    sets.precast.FC.Esuna     = sets.precast.FC.QM
    sets.precast.FC.Sacrifice = sets.precast.FC.QM

	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = {
		body="Piety Briault +1"						--> Benediction enmity -50
	}


	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = ""
	sets.precast.WS = {
		--head="Nahtirah Hat",
		neck="Fotia Gorget",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
		--body="Vanir Cotehardie",
		--hands="Yaoyotl Gloves",
		--ring1="Rajas Ring",
		--ring2="K'ayres Ring",
		--back="Refraction Cape",
		waist="Fotia Belt",
		--legs="Gendewitha Spats",
		--feet="Gendewitha Galoshes"
	}

	sets.precast.WS['Flash Nova'] = {
		--head="Nahtirah Hat",
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Hecate's Earring",
		--body="Vanir Cotehardie",
		--hands="Yaoyotl Gloves",
		ring1="Rajas Ring",
		ring2="Strendu Ring",
		back="Toro Cape",
		waist="Fotia Belt",
		--legs="Gendewitha Spats",
		--feet="Gendewitha Galoshes"
	}


	-- Midcast Sets

	sets.midcast.FastRecast = { -- FC +81~83%% (Recast Reduction 40%)
        main=gear.main.Grioavolr.FC,                --> FC +10%
        sub="Clerisy Strap +1",                     --> FC +3%
        ammo="Sapience Orb",                        --> FC +2%
        head="Haruspex Hat",                        --> FC +8%
        neck="Voltsurge Torque",                    --> FC +4%
        ear1="Etiolation Earring",                  --> FC +1%
        ear2="Loquacious Earring",                  --> FC +2%
        body="Inyanga Jubbah +1",                   --> FC +13%
        hands="Fanatic Gloves",                     --> FC +7%
        ring1="Rahab Ring",                         --> FC +2%
        ring2="Kishar Ring",                        --> FC +4%
        back="Alaunus's Cape",                      --> FC +10%
        waist="Witful Belt",                        --> FC +3%
        legs="Psycloth Lappas",                     --> FC +7%
        feet="Regal Pumps +1",                      --> FC +5~7%
	}


    sets.midcast['Full Cure'] = sets.midcast.FastRecast

	-- Cure sets
    -- Power (Cap 700) = floor(MND/2) + floor(VIT/4) + Skill
    --                   (104+173)/2  + (95+81)/4)   + 532 = 714
    -- Potency +51~52+4% (54%)  Enmity -53  Cureskin +24%
    sets.midcast.Cure = {
        main="Queller Rod",                         --> MND +6  Skill +15  Potency +10+2%  Enmity -10
        sub="Sors Shield",                          --> Potency +3%  Enmity -5
        ammo="Staunch Tathlum",
        head="Kaykaus Mitra",                       --> MND +19  VIT +19  Skill +15  Potency +10%  Enmity -5
        neck="Incanter's Torque",                   --> Skill +10
        ear1="Glorious Earring",                    --> Potency 0+2%  Enmity -5
        ear2="Nourishing Earring",                  --> MND +3  Potency +5~6%
        body="Ebers Bliaud +1",                     --> MND +33  VIT +20  Skill +24  Cureskin +14%
        hands="Kaykaus Cuffs",                      --> MND +35  VIT +25  Potency +10%  Enmity -10
        ring1="Stikini Ring",                       --> MND +5  Skill +5
        ring2="Lebeche Ring",                       --> Potency +3%  Enmity -5
        back="Alaunus's Cape",                      --> MND +20  Cureskin +10%
        waist="Channeler's Stone",                  --> Enmity -3
        legs="Ebers Pantaloons +1",                 --> MND +33  MP Return 6%
        feet="Kaykaus Boots",                       --> MND +19  VIT +10  Potency +10%  Enmity -10
    }

    -- (104+176)/2 + (95+86)/4 + 517 = 702
    -- Potency +48~49+2% (50%)  Enmity -39  Cureskin +24%  Iridescence
    sets.midcast.CureAurora = set_combine(sets.midcast.Cure, {
        main="Chatoyant Staff",                     --> MND +5  VIT +5  Potency +10%  Iridescence
        sub="Achaq Grip",                           --> MND +4  Enmity -4
        waist="Hachirin-no-Obi",   	                --> FreeCast +1%  Force weather proc
    })

    -- Base  = (floor(Power/2)/Rate) + Const
    -- Power = 3xMND + VIT + 3xfloor(Skill/5)
    -- (104+197) + (95+86) + 3xfloor(488/5) = 1375
    -- Potency 53~54+7% (57%)  Enmity -44
    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        ammo="Hydrocera",                           --> MND +3
        head="Theophany Cap +1",                    --> MND +27  VIT +19  Potency +10%  Enmity -4
        neck="Mizukage-no-Kubikazari",              --> MND +4
        body="Kaykaus Bliaut",                      --> MND +33  VIT +20  Potency 5+3%
        ring1="Stikini Ring",                       --> MND +5  Skill +5
        ring2="Stikini Ring",                       --> MND +5  Skill +5
        waist="Rumination Sash",                    --> MND +4
    })

    -- 3x(104+196) + (95+91) + 3xfloor(473/5) = 1368
    -- Potency 50~51+5% (55%)  Enmity -33
    sets.midcast.CuragaAurora = set_combine(sets.midcast.Curaga, {
        main="Chatoyant Staff",                     --> MND +5  VIT +5  Potency +10%  Iridescence
        sub="Achaq Grip",                           --> MND +4  Enmity -4
        waist="Hachirin-no-Obi",   	                --> FreeCast +1%  Force weather proc
    })

    -- 500 skill = 26% removal
    sets.midcast.Cursna = { -- Skill 526  Cursna +100  Received +10
        main="Queller Rod",                         --> Skill +15
        sub="Genbu's Shield",
        head="Ebers Cap +1",                        --> 22% AoE chance on status removal
        neck="Malison Medallion",                   --> Cursna +15
        hands="Fanatic Gloves",                     --> Skill +10  Cursna +15
        body="Ebers Bliaud +1",                     --> Skill +24
        ring1="Ephedra Ring",                       --> Skill +7  Cursna +10
        ring2="Ephedra Ring",                       --> Skill +7  Cursna +10
        back="Alaunus's Cape",                      --> Cursna +25
        waist="Gishdubar Sash",                     --> Cursna Rec. +10
        legs="Theophany Pantaloons +2",             --> Cursna +17
        feet="Gendewitha Galoshes +1",              --> Cursna +10
    }

	sets.midcast.StatusRemoval = {
		head="Ebers Cap +1",						--> 22% AoE chance on status removal
		legs="Ebers Pantaloons +1"					--> "Divine Benison" +2
	}

    sets.midcast.EnhancingDuration = {  -- Duration +63
        main="Gada",                                --> Duration +5
        sub="Ammurapi Shield",                      --> Duration +10
        head="Telchine Cap",                        --> Duration +10
        body="Telchine Chasuble",                   --> Duration +10
        hands="Telchine Gloves",                    --> Duration +10
        legs="Telchine Braconi",                    --> Duration +10
        feet="Telchine Pigaches",                   --> Duration +8
    }

    sets.midcast.Haste = sets.midcast.EnhancingDuration

    -- Auspice: Subtle Blow 10+15
    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {
        feet="Ebers Duckbills +1",                  --> Auspice +15
    })

    -- Skill +88  Duration +50
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.EnhancingDuration, {
        --main="Gada",                                --> Skill +18  Duration +5
        --sub="Ammurapi Shield",                      --> Duration +10
        neck="Incanter's Torque",					--> Skill +10
        body="Telchine Chasuble",                   --> Skill +12  Duration +10
        ring1="Stikini Ring",                       --> Skill +5
        ring2="Stikini Ring",                       --> Skill +5
        back="Mending Cape",                        --> Skill +10
        waist="Cascade Belt",                       --> Skill +3
        --feet="Ebers Duckbills +1",                  --> Skill +25
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        waist="Siegel Sash",                        --> Stoneskin +20
    })

    -- BarElement
    -- Solace MDB +12  Skill +47  Resist +30  Occ. null dmg +8%
    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
        head="Ebers Cap +1",                        --> Occ. null dmg +2%
        body="Ebers Bliaud +1",                     --> Solace MDB +14  Occ. null dmg +2%
        hands="Ebers Mitts +1",                     --> Occ. null dmg +2%
        legs="Piety Pantaloons +1",                 --> Skill +22  Resistance +30
        feet="Ebers Duckbills +1",                  --> Skill +25  Occ. null dmg +2%
        --[[ Future upgrades/additions
        main="Beneficus",							--> +5 MDB to elemental barspells
        ]]--
    })

    -- Regen --> Potency +58%  Regen duration +40s  Enh. duration +8
    sets.midcast.Regen = {
        main="Bolelabunga",                         --> Potency +10%
        sub="Ammurapi Shield",
        head="Inyanga Tiara +1",                    --> Potency +12%
        body="Piety Briault +1",                    --> Potency +36%
        hands="Ebers Mitts +1",                     --> Duration +22s
        legs="Theophany Pantaloons +2",             --> Duration +21s
        feet="Telchine Pigaches",                   --> Enh. duration +8
    }

    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {
        feet="Piety Duckbills +1",                  --> DEF +5
        --[[ Future upgrades/additions
        ring1="Sheltered Ring"						--> DEF +2*tier
        ]]--
    })

	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {
		legs="Piety Pantaloons +1",					--> MDB +5/256
        feet="Telchine Pigaches",                   --> Duration +8
		--[[ Future upgrades/additions
		ring1="Sheltered Ring",						--> MDB +tier/256
		]]--
    })

    sets.midcast.MAcc = {  -- MND +266  MAcc +562  Skill +28  (856)
        main="Oranyan",                             --> MND +22  MAcc +228+45
        sub="Clerisy Strap +1",                     --> MAcc +15
        ammo="Hydrocera",                           --> MND +3  MAcc +6
        head="Inyanga Tiara +1",                    --> MND +30  MAcc +38
        neck="Erra Pendant",                        --> MAcc +17
        ear1="Psystorm Earring",                    --> MAcc +12
        ear2="Lifestorm Earring",                   --> MND +4
        body="Chironic Doublet",                    --> MND +49  MAcc +46
        hands="Inyanga Dastanas +1",                --> MND +44  MAcc +37  Skill +18
        ring1="Stikini Ring",                       --> MND +5  MAcc +8  Skill +5
        ring2="Stikini Ring",                       --> MND +5  MAcc +8  Skill +5
        back="Alaunus's Cape",                      --> MND +20  MAcc +20
        waist="Luminary Sash",                      --> MND +10  MAcc +10
        legs="Chironic Hose",                       --> MND +39  MAcc +48
        feet="Inyanga Crackows +1",                 --> MND +30  MAcc +36
    }

    sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAcc, {
        hands="Fanatic Gloves",						--> Skill +20  MAcc +20
        legs="Theophany Pantaloons +2"				--> Skill +17
    })

    sets.midcast['Dark Magic'] = set_combine(sets.midcast.MAcc, {  -- MAcc +455  Skill +53
        body="Shango Robe",                         --> Skill +15  MAcc +23
        ring1="Evanescence Ring"					--> Skill +10
    })

    --sets.midcast.Stun = set_combine(sets.midcast.DarkMagic, {main=gear.RecastStaff})

    -- MND +269  MAcc +534  Skill +63   (866)
    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MAcc, {
        head="Befouled Crown",                      --> MND +33  MAcc +20  Skill +16
        legs="Chironic Hose",                       --> MND +39  MAcc +48  Skill +13
    })

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = { }

    -- Main Idle --> DT -20%  PDT -10%  MDT -5%  Refresh +7  Regen +1
	sets.idle = {
        main="Bolelabunga",							--> Refresh +1  Regen +1
        sub="Ammurapi Shield",--"Genbu's Shield",						--> PDT -10%
        ammo="Homiliary",							--> Refresh +1
        head="Befouled Crown",						--> Refresh +1
        neck="Loricate Torque +1",					--> DT -6%
        ear1="Etiolation Earring",                  --> Block +2%
        ear2="Thureous Earring",                    --> MDT -3%
        body="Ebers Bliaud +1",						--> Refresh +2
        hands="Chironic Gloves",    			    --> Refresh +1
        ring1="Defending Ring",						--> DT -10%
        ring2="Shneddick Ring",					    --> Movement Speed +18%
        back="Solemnity Cape",						--> DT -4%
        waist="Fucho-no-Obi",
        legs="Lengo Pants",							--> Refresh +1
        feet="Inyanga Crackows +1",   				--> MDT -2%
    }

    sets.idle.Movement = set_combine(sets.idle, {
        feet="Paean Boots",                         --> Movement Speed +8%
    })

	-- Defense sets

	sets.defense.PDT = { }
	sets.defense.MDT = { }

	sets.Kiting = {
        ring2="Shneddick Ring"
    }

	-- Engaged sets
	-- Basic set for if no TP weapon is defined.
	sets.engaged = { }

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {
        hands="Ebers Mitts +1",
        back="Mending Cape",
    }
end

function job_precast(spell, action, spellMap, eventArgs)

    auto_fallback(spell,classes.AutoFallback)

end

function party_buff_change(member, buff, gain, buffRes)

    --print_set(member)
    --print_set(buff)
    --print_set(gain)
    --print_set(buffRes)

    --[[local gainloss = 'lost'
    if gain then gainloss = 'gained' end

    send_command('input /p ' .. member['name'] ..' '.. gainloss ..' '.. buffRes['en'])

    if not gain and buffRes['en'] == 'Haste' then
        send_command('input /ma Haste ' .. member['name'])
    end]]

end

function indi_change(indi, gain)

    --print_set(indi)

end
