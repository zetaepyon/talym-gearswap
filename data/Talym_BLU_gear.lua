-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()

    include('Talym-Include.lua')

    if not haste_type then haste_type = 0 end
    --include('Talym-Haste.lua')

    --windower.register_event('incoming chunk', manage_haste_level)

    state.OffenseMode:options('Normal', 'Acc', 'Acc2', 'Refresh', 'Learning')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Learning')

	state.CPMode = M(false, 'CP Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.Haste2 = M(false, 'Haste II')

    -- Custom gear definitions
    --gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}

    gear.feet.refresh = {name="Herculean Boots", augments={'INT+3','"Mag.Atk.Bns."+22','"Refresh"+2'}}
    gear.feet.atk = {name="Herculean Boots", augments={'Accuracy+24 Attack+24','Weapon skill damage +2%','STR+5','Accuracy+9','Attack+15'}}
    gear.feet.tp = { name="Herculean Boots", augments={'Accuracy+11 Attack+11','"Triple Atk."+2','DEX+15','Attack+2',}}
    gear.feet.acc = { name="Herculean Boots", augments={'Accuracy+25 Attack+25','STR+10','Accuracy+15','Attack+5',}}
    gear.feet.ws = gear.feet.acc

    gear.body.tp = { name="Herculean Vest", augments={'"Dbl.Atk."+1','Crit.hit rate+3','Quadruple Attack +2',}}
    gear.body.acc = { name="Herculean Vest", augments={'Accuracy+23 Attack+23','Crit.hit rate+2','Accuracy+15','Attack+7',}}

    gear.hands.acc = { name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15'}}
    gear.hands.atk = { name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15'}}
    gear.hands.dt = { name="Herculean Gloves", augments={'Accuracy+27','Damage taken-4%','STR+10','Attack+13',}}

    gear.back.ws = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}
    gear.back.tp = gear.back.ws

    -- Additional local binds
    add_to_chat(001,' ')
    add_to_chat(159,'BLUE MAGE KEYBINDS')

    bind('^`','/ja "Chain Affinity" <me>','Chain Affinity')
    bind('@`','/ja "Burst Affinity"','Burst Affinity')
    bind('!`','/ja "Efflux" <me>','Efflux')
    bind('^f10','//gs c lockcp','Lock CP Mode')

    init_job_states({"CPMode","Haste2"},{"OffenseMode","WeaponskillMode","IdleMode"})

    update_combat_form()
    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind ^f10')
    clear_job_states()
end

function job_state_change()
    update_job_states()
end


-- Set up gear sets.
function init_gear_sets()

    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.buff['Burst Affinity'] = { } --feet="Mavi Basmak +2" }
    sets.buff['Chain Affinity'] = {
        --head="Mavi Kavuk +2",
        feet="Assimilator's Charuqs"
        }
    sets.buff.Convergence = { } --head="Luhlaza Keffiyeh" }
    sets.buff.Diffusion = { feet="Luhlaza Charuqs +1" }
    sets.buff.Enchainment = { } --body="Luhlaza Jubbah" }
    sets.buff.Efflux = { } --legs="Mavi Tayt +2" }


    -- Precast Sets

    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = { } --hands="Mirage Bazubands +2" }


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        --[[
        ammo="Sonia's Plectrum",
        head="Uk'uxkaj Cap",
        body="Vanir Cotehardie",
        hands="Buremte Gloves",
        ring1="Spiral Ring",
        back="Iximulew Cape",
        waist="Caudata Belt",
        legs="Hagondes Pants",
        feet="Iuitl Gaiters +1"
        ]]--
        }

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    --> Fast Cast +61% (2x Vamp: +71%), Quick Magic +3% <--
    sets.precast.FC = {
        ammo="Sapience Orb",                        --> FC +2%
        head="Carmine Mask",                        --> FC +12%
        neck="Voltsurge Torque",                    --> FC +4%
        ear1="Etiolation Earring",                  --> FC +1%
        ear2="Loquacious Earring",                  --> FC +2%
        body="Foppish Tunica",                      --> FC +5%
        hands="Leyline Gloves",                     --> FC +8%
        ring1="Prolix Ring",                        --> FC +2%
        ring2="Kishar Ring",                        --> FC +4%
        back="Swith Cape +1",                       --> FC +4%
        waist="Witful Belt",                        --> FC +3%  QM +3%
        legs="Psycloth Lappas",                     --> FC +7%
        feet="Carmine Greaves"                      --> FC +7%
		}

    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {
		body="Hashishin Mintan"
		})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Jukukik Feather",
        head="Adhemar Bonnet",
		neck="Fotia Gorget",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
        body="Adhemar Jacket",
		hands=gear.hands.atk,
		ring1="Hetairoi Ring",
		ring2="Epona's Ring",
        back=gear.back.ws,
		waist="Fotia Belt",
		legs="Samnuha Tights",
		feet="Adhemar Gamashes"
		}

    sets.precast.WS.acc = set_combine(sets.precast.WS, {
        hands=gear.hands.acc
        })

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    -- Chant du Cygne | WSMod: 80% DEX
    -- DEX: +226
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
		ear2="Brutal Earring",
        waist="Fotia Belt"
		})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {
        ammo="Falcon Eye",
        ear1="Telos Earring",
        ear2="Dignitary's Earring",
        hands=gear.hands.acc
        })

    -- Requiescat | WSMod: 73~85% MND
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		--ring1="Aquasoul Ring",
		feet="Luhlaza Charuqs +1"
		})

    -- Sanguine Blade | WSMod: 50% MND, 30% STR
    sets.midcast['Blue Magic'] = {}
    sets.precast.WS['Sanguine Blade'] = sets.midcast['Blue Magic']['Tenebral Crush']


    -- Midcast Sets
    sets.midcast.FastRecast = { -- FC +55% (2x Vamp: +69%)
        ammo="Sapience Orb",                        --> FC +2%
        head="Carmine Mask",                        --> FC +12%
        neck="Voltsurge Torque",                    --> FC +4%
        ear1="Etiolation Earring",                  --> FC +1%
        ear2="Loquacious Earring",                  --> FC +2%
        body="Foppish Tunica",                      --> FC +5%
        hands="Leyline Gloves",                     --> FC +8%
        ring1="Prolix Ring",                        --> FC +2%
        ring2="Rahab Ring",                         --> FC +2%
        back="Swith Cape +1",                       --> FC +4%
        waist="Witful Belt",                        --> FC +3%
        legs="Lengo Pants",                         --> FC +5%
        feet="Amalric Nails"                        --> FC +5%
		}

    -- Physical Spells --

    sets.midcast['Blue Magic'].Physical = {
		ammo="Ginsen",
        head="Lilitu Headpiece",
		neck="Sanctity Necklace",
		ear1="Telos Earring",
		ear2="Bladeborn Earring",
        body="Adhemar Jacket",
		hands="Adhemar Wristbands",
		ring1="Apate Ring",
		ring2="Petrov Ring",
        back="Cornflower Cape",
		waist="Anguinus Belt",
		legs="Samnuha Tights",
		feet="Adhemar Gamashes"
		}

    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {
		})

    -- Magical Spells --
    --> MAB +211 (236), MAcc +154 (460), MDMG +10 (251), MCrit rate +30, MCrit dmg +10 <--

    sets.midcast['Blue Magic'].Magical = {
		--main="Nehushtan",							--> MAB +13  MAcc +201  MDMG +130
		--sub="Eminent Wand",						--> MAB +14  MAcc +191  MDMG +111

		--main="Vampirism",							--> MAB +34  MAcc +201  MDMG +108  FC +7%  Occ. Acumen +8
		--main="Vampirism",							--> MAB +34  MAcc +201  MDMG +108  FC +7%  Occ. Acumen +5

        -- MAB +245  MAcc +182  INT +170
		ammo="Pemphredo Tathlum",					--> MAB +4   MAcc +8   INT +4
        head="Jhakri Coronal +1",                   --> MAB +38  MAcc +38  INT +33
		neck="Sanctity Necklace",					--> MAB +10  MAcc +10
		ear1="Friomisi Earring",					--> MAB +10
		ear2="Hecate's Earring",					--> MAB +6   MCrit rate +3%
        body="Jhakri Robe +1",                      --> MAB +30  MAcc +40  INT +47
        hands="Jhakri Cuffs +1",                    --> MAB +37  MAcc +37  INT +33
		ring1="Acumen Ring",						--> MAB +4  INT +2
        ring2="Strendu Ring",                       --> MAB +4   MAcc +2
        back="Cornflower Cape",						--> MAB +15  MAcc +15  Skill +12  INT +5
		waist="Yamabuki-no-Obi",					--> MAB +5   MAcc +2  INT +6
		legs="Amalric Slops",						--> MAB +45  MAcc +15  INT +40
		feet="Amalric Nails"						--> MAB +37  MAcc +15
		--[[
		--> MAB +193 (255), MAcc +68 (512), MDMG +10 (258), MCrit rate +30, MCrit dmg +10 <--
		--main="Nibiru Cudgel",						--> MAB +31  MAcc +222  MDMG +124
		--sub="Nibiru Cudgel",						--> MAB +31  MAcc +222  MDMG +124
        head="Helios Band",							--> MAB +23  MAcc +23  Occ. Acumen +8
		hands="Mavi Bazubands +2",
		hands="Leyline Gloves",						--> MAB +31  MAcc +33  Fast Cast +8%
		ring1="Icesoul Ring",
		waist="Caudata Belt",

        head="Helios Band",							--> MAB +25  MAcc +25  OA +8  MBurst +5%  INT +21
        head="Amalric Coif",                          --> MAB +15  MAcc +41  INT +24
        body="Samnuha Coat",						    --> MAB +33  MAcc +37  FC +4%  MBurst +8%  INT +20
		hands="Amalric Gages",						--> MAB +35  MAcc +15  Skill +13  MBurst +5%  INT +34
		]]--
		}

    sets.midcast['Blue Magic']['Tenebral Crush'] = set_combine(sets.midcast['Blue Magic'].Magical, {
        head="Pixie Hairpin +1",                    --> MAB +28  INT +27
        ring2="Archon Ring"                         --> MAB +5  MAcc +5
    })

    -- Breath Spells --

    sets.midcast['Blue Magic'].Breath = {
        ear1="Lifestorm Earring",
		ear2="Psystorm Earring",
		hands="Assimilator's Bazubands +1"
		--[[
        ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",
		neck="Ej Necklace",
        body="Vanir Cotehardie",
		ring1="K'ayres Ring",
		ring2="Beeline Ring",
        back="Refraction Cape",
		legs="Enif Cosciales",
		feet="Iuitl Gaiters +1"
        ]]--
		}

    -- Other Types --

    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,{
		waist="Chaac Belt"
		})

    sets.midcast['Blue Magic']['White Wind'] = { -- Potency +36%  Received +17%
        ammo="Sapience Orb",                        --> FC +2%
        head="Carmine Mask",                        --> FC +12%  Haste +8%  HP+38
        neck="Phalaina Locket",                     --> Potency +4%  Potency rec. +4%
        ear1="Etiolation Earring",                  --> FC +1%  HP +50
		ear2="Mendicant's Earring",                 --> Potency +5%
        --body="Vrikodara Jupon",                       --> Potency +13%  FC +5%  Haste +3%  HP +54
        hands="Telchine Gloves",                    --> Potency +10%  HP +52
        ring1="Defending Ring",
        ring2="Asklepian Ring",                     --> Received +3%
        back="Swith Cape +1",                       --> FC +4%
        back="Solemnity Cape",                      --> Potency +7%  DT -4%
        waist="Gishdubar Sash",                     --> Potency rec. +10%
        legs="Gyve Trousers",                       --> Potency +10%  FC +4%  Haste +5%  HP +22
        feet="Amalric Nails"                        --> FC +5%  Interrupt -15%
        }

    sets.midcast['Blue Magic']['Mighty Guard'] = {
        feet="Luhlaza Charuqs +1"
    }

    sets.midcast['Blue Magic'].Healing = {
		neck="Phalaina Locket",						--> Potency +4%  Potency rec. +4%
		ear1="Etiolation Earring",
		ear2="Mendicant's Earring",                 --> Potency +5%
		ring1="Asklepian Ring",						--> Potency rec. +3%
		ring2="Sirona's Ring",						--> Healing skill +10
        back="Solemnity Cape",					    --> Potency +7%
		waist="Gishdubar Sash",                     --> Potency rec. +10%
        legs="Gyve Trousers"                        --> Potency +10%
		}

    sets.midcast['Blue Magic'].SkillBasedBuff = {
		neck="Incanter's Torque",					--> Skill +10
        body="Assimilator's Jubbah",
        back="Cornflower Cape",
		feet="Luhlaza Charuqs +1"
        --[[
        ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",
        legs="Mavi Tayt +2",
        ]]--
		}

    sets.midcast['Blue Magic'].Buff = {}

    sets.midcast.Protect = { } --ring1="Sheltered Ring" }
    sets.midcast.Protectra = { } --ring1="Sheltered Ring" }
    sets.midcast.Shell = { } --ring1="Sheltered Ring" }
    sets.midcast.Shellra = { } --ring1="Sheltered Ring" }

	sets.midcast.Refresh = { waist="Gishdubar Sash" }
	sets.midcast['Battery Charge'] = sets.midcast.Refresh




    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {
		hands="Assimilator's Bazubands +1",
        body="Assimilator's Jubbah",
        back="Cornflower Cape"
		--[[
		head="Luhlaza Keffiyeh",
		feet="Luhlaza Charuqs"
        ammo="Mavi Tathlum",
		head="Mirage Keffiyeh",
		legs="Mavi Tayt +2"
		]]--
		}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Resting sets
    sets.resting = { }

    -- Idle sets
    sets.idle = { --> DT -26%  PDT -8%  MDT -3%
		ammo="Staunch Tathlum",                           --> DT -2%  Interrupt -10%  Resist +10
		head="Rawhide Mask",						      --> Refresh +1
		neck="Loricate Torque +1",					      --> DT -6%
		ear1="Etiolation Earring",                        --> MDT -3%
		ear2="Loquacious Earring",
        body="Jhakri Robe +1",                            --> Refresh +3
		hands=gear.hands.dt, -- Herculean Gloves          --> DT -4%  PDT -2%
		ring1="Defending Ring",                           --> DT -10%
		ring2="Shneddick Ring",					          --> Movement Speed +18%
		back="Solemnity Cape",                            --> DT -4%
		waist="Flume Belt",                               --> PDT -4%
		--legs="Lengo Pants",                               --> Refresh +1
        legs="Carmine Cuisses +1",                        --> Movement Speed +18%
		feet=gear.feet.refresh                            --> PDT -2%  Refresh +2
		}

    sets.idle.PDT = set_combine(sets.idle, {        --> PDT -27%  MDT -26%
        head="Dampening Tam",                       --> MDT -4%
        legs="Herculean Trousers"                   --> PDT -2%  MDT -4%
        })

    sets.idle.Town = set_combine(sets.idle, {
        ring1="Warp Ring"
        })

    sets.idle.Learning = set_combine(sets.idle, sets.Learning)


    -- Defense sets
    sets.defense.PDT = { }
    sets.defense.MDT = { }
    sets.Kiting = { } --legs="Crimson Cuisses" }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
		ammo="Ginsen",
        head="Adhemar Bonnet",
		neck="Asperity Necklace",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
        body="Adhemar Jacket",
		hands=gear.hands.atk,
		ring1="Petrov Ring",
		ring2="Epona's Ring",
        back=gear.back.tp,
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet="Herculean Boots"
		}

    sets.engaged.Acc = set_combine(sets.engaged, {
		ammo="Falcon Eye",
        ear1="Dignitary's Earring",
		ear2="Telos Earring",
        hands=gear.hands.acc,
		ring2="Epona's Ring"
        --[[
        head="Whirlpool Mask",
		neck="Ej Necklace",
        body="Luhlaza Jubbah",
		hands="Buremte Gloves",
		ring1="Rajas Ring",
        back="Letalis Mantle",
		waist="Hurch'lan Sash",
		legs="Manibozho Brais",
		feet="Qaaxo Leggings"
        ]]--
        })

    sets.engaged.Acc2 = set_combine(sets.engaged.Acc, {
        neck="Combatant's Torque",
        body=gear.body.acc,
        waist="Anguinus Belt",
        feet=gear.feet.acc
        })

    sets.engaged.Refresh = set_combine(sets.engaged, {
		ammo="Jukukik Feather",
        neck="Asperity Necklace",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
		hands="Assimilator's Bazubands +1",
		ring2="Epona's Ring",
		waist="Windbuffet Belt +1"
        --[[
        head="Whirlpool Mask",
        body="Luhlaza Jubbah",
		ring1="Rajas Ring",
        back="Atheling Mantle",
		legs="Manibozho Brais",
		feet="Qaaxo Leggings"
        ]]--
    })

    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)

    sets.self_healing = {
		--ring1="Kunaji Ring",
		ring2="Asklepian Ring"
		}

	sets.cpmode = {
		back="Mecistopins Mantle"
		}
end

function job_self_command(commandArgs, eventArgs)
	if commandArgs[1]:lower() == 'lockcp' then
		if state.CPMode == 'CP Lock' then
			enable('back')
			self_command('toggle CPMode')
		else
			equip(sets.cpmode)
			disable('back')
			self_command('toggle CPMode')
		end
	end
    if commandArgs[1]:lower() == 'sethaste' then
        state.Haste2:set(commandArgs[2])
        update_job_states()
    end
end

function job_buff_change(buff, gain)

    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end

    --if buff == 'Blink' then windower.add_to_chat(006, 'OH SHIT SON') end

    if buff == 'Haste' then
        if gain and haste_type == 2 then
            state.Haste2:set(true)
        else
            if not gain then haste_type = 0 end
            state.Haste2:set(false)
        end
    --    windower.add_to_chat(006, 'Haste Type: '..tostring(haste_type))
    end
    update_job_states()

end

function buff_refresh(buff, buff_details)

    if buff == 'Haste' then
        if haste_type == 2 then
            state.Haste2:set(true)
        else
            state.Haste2:set(false)
        end
    --    windower.add_to_chat(006, 'Haste Type: '..tostring(haste_type))
    end
    update_job_states()

end
