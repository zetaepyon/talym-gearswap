-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    include('Talym-Include.lua')
    include('Mote-SelfCommands')

    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Death')
    state.IdleMode:options('Normal', 'Refresh', 'Death')

    state.MagicBurst = M(false, 'Magic Burst')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    -- Additional local binds
    add_to_chat(001,' ')
    add_to_chat(159,'BLACK MAGE KEYBINDS')

    bind('^`','/ma "Stun" <t>','Stun')
    bind('f8','gs c toggle MagicBurst','Burst Mode')
    bind('f9','gs c cycle CastingMode','Cast Mode')
    bind('f10','gs c cycle IdleMode','Idle Mode')
	--send_command('bind f8 gs c burstmode')

    --send_command('bind f8 gs c toggle MagicBurst')
    --send_command('bind f9 gs c cycle CastingMode')
    --send_command('bind f10 gs c cycle IdleMode')

    init_job_states({"MagicBurst"},{"CastingMode","IdleMode"})

    send_command('wait 10; input /lockstyleset 36')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')

    send_command('unbind f8')
    send_command('unbind f9')
    send_command('unbind f10')
    clear_job_states()
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 14)
end

function job_state_change()
    update_job_states()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    ---- Precast Sets ----

    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
        back=gear.back.Taranus.FC,                  --> Mana Wall +10%
        feet="Goetia Sabots +2",                    --> Mana Wall +10%
        --feet="Wicce Sabots +1",                     --> Mana Wall +15%
    }
    sets.precast.JA['Manafont'] = {
        body="Sorcerer's Coat +2",                  --> Manafont +30s
    }

    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}

    -- Fast cast sets for spells

    sets.precast.FC = { -- FC +72~74%
        ammo="Sapience Orb",                        --> FC +2%
        head=gear.head.Merlinic.FC,                 --> FC +15%
        neck="Voltsurge Torque",                    --> FC +4%
        ear1="Etiolation Earring",                  --> FC +1%
        ear2="Loquacious Earring",                  --> FC +2%
        body=gear.body.Merlinic.FC,                 --> FC +12%
        hands=gear.hands.Merlinic.FC,               --> FC +6%
        ring1="Rahab Ring",                         --> FC +2%
        ring2="Kishar Ring",                        --> FC +4%
        back=gear.back.Taranus.FC,                  --> FC +10%
        waist="Channeler's Stone",                  --> FC +2%
        legs="Psycloth Lappas",                     --> FC +7%
        feet="Regal Pumps +1",                      --> FC +5~7%
        --[[
        ring2="Lebeche Ring",						--> QM +2%
        body="Zendik Robe"							--> FC +13%
        ]]--
    }

    --sets.precast.FC.Meteor = {}

    sets.precast.FC.Death = set_combine(sets.precast.FC, {
        -- MP +826   (2127 MAX)
        ammo="Strobilus",                           --> MP +45
        head="Amalric Coif",                        --> FC +10%  MP +121
        ring1="Mephitas's Ring +1",                 --> MP +110
        waist="Luminary Sash",                      --> MP +45
        legs="Amalric Slops",                       --> MP +160
        feet="Amalric Nails",                       --> FC +5%  MP +86
    })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {	-- MP +1041  TP Bonus +250
        --sub="Niobid Strap",                         --> MP +20
        ammo="Strobilus",                           --> MP +45
        head="Amalric Coif",                        --> MP +121
        neck="Sanctity Necklace",                   --> MP +35
        ear1="Etiolation Earring",                  --> MP +50
        ear2="Moonshade Earring",                   --> TP Bonus +250
        body="Amalric Doublet",                     --> MP +133
        hands="Amalric Gages",                      --> MP +86
        ring1="Mephitas's Ring +1",                 --> MP +110
        ring2="Sangoma Ring",                       --> MP +70
        back="Bane Cape",                           --> MP +90
        waist="Yamabuki-no-Obi",                    --> MP +35
        legs="Amalric Slops",                       --> MP +160
        feet="Amalric Nails",                       --> MP +86
    }

    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
        --[[head=gear.head.fc,                          --> FC +15%
        ear1="Etiolation Earring",                  --> FC +1%
        ear2="Loquacious Earring",                  --> FC +2%
        body="Shango Robe",                         --> FC +8%
        hands=gear.hands.fc,                        --> FC +6%
        ring1="Prolix Ring",                        --> FC +2%
        back="Swith Cape +1",                       --> FC +4%
        waist="Witful Belt",                        --> FC +3%  QC +3%
        legs="Lengo Pants",                         --> FC +5%
        feet="Amalric Nails",                       --> FC +5%]]
    }

    sets.midcast.Cure = { -- MAX MP: 1696
        neck="Incanter's Torque",                   --> Skill +10
        ear1="Roundel Earring",                     --> Potency +5%
        ring1="Ephedra Ring",                       --> Skill +7
        ring2="Sirona's Ring",                      --> Skill +10
        waist="Hachirin-no-Obi",
        legs="Gyve Trousers",                       --> Potency +10%
    }

    sets.midcast.Cure.Death = set_combine(sets.midcast.Cure, {
        -- MAX MP: 1970
        ear2="Etiolation Earring",
        body="Amalric Doublet",
        ring1="Mephitas's Ring +1",
        ring2="Sangoma Ring",
    })

    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.Curaga.Death = sets.midcast.Cure.Death

    sets.midcast['Enhancing Magic'] = { -- MAX MP: 2039
        neck="Incanter's Torque",                   --> Skill +10
        head="Befouled Crown",                      --> Skill +10
    }
    sets.midcast['Enhancing Magic'].Death = sets.midcast['Enhancing Magic']

    sets.midcast['Enfeebling Magic'] = {  -- MAcc +265  MND +169  Skill +15  Duration +10%  MAX MP: 1624
        ammo="Pemphredo Tathlum",                   --> MAcc +8
        head=gear.head.Merlinic.MAcc,               --> MAcc +44  MND +28
        neck="Incanter's Torque",                   --> Skill +10  FreeCast +1%
        ear1="Barkarole Earring",                   --> MAcc +8
        ear2="Dignitary's Earring",                 --> MAcc +10
        body=gear.body.Merlinic.MAcc,               --> MAcc +43  MND +35
        hands="Psycloth Manillas",                  --> MAcc +27  MND +40
        ring1="Stikini Ring",                       --> MAcc +8  MND +5  Skill +5
        ring2="Kishar Ring",                        --> MAcc +5  Duration +10%
        back=gear.back.Taranus.FC,                  --> MAcc +20
        waist="Luminary Sash",                      --> MAcc +10  MND +10
        legs=gear.legs.Merlinic.MAcc,               --> MAcc +57  MND +28
        feet=gear.feet.Merlinic.MAB,                --> MAcc +25  MND +23
    }

    sets.midcast['Enfeebling Magic'].Death = set_combine(sets.midcast['Enfeebling Magic'], {
        -- MAX MP: 1937
        head="Amalric Coif",
        hands="Amalric Gages",
        ring1="Mephitas's Ring +1",
        feet="Amalric Nails",
    })

    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']
    sets.midcast.ElementalEnfeeble.Death = sets.midcast['Enfeebling Magic'].Death

    sets.midcast['Dark Magic'] = {
        -- MAX MP: 1680
        ammo="Pemphredo Tathlum",                   --> MAcc +8
        head="Pixie Hairpin +1",                    --> Affinity +28
        neck="Erra Pendant",                        --> Skill +10  MAcc +17
        ear1="Barkarole Earring",                   --> MAcc +8
        ear2="Dignitary's Earring",                 --> MAcc +10
        body=gear.body.Merlinic.MAB,                --> MAcc +43
        hands="Jhakri Cuffs +1",                    --> MAcc +37
        ring1="Evanescence Ring",                   --> Skill +10
        ring2="Stikini Ring",                       --> Skill +5  MAcc +8
        back=gear.back.Taranus.FC,                  --> MAcc +20
        waist="Luminary Sash",                      --> MAcc +10
        legs=gear.legs.Merlinic.MAcc,               --> MAcc +57
        feet=gear.feet.Merlinic.MAB,                --> MAcc +25
    }

    sets.midcast['Dark Magic'].Death = set_combine(sets.midcast['Dark Magic'], {
        -- MAX MP: 1933
        ammo="Strobilus",
        ear2="Etiolation Earring",
        hands="Amalric Gages",
        feet="Amalric Nails",
    })

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        -- Affinity +33  Skill +48  Draspir +64
        -- MAX MP: 1691
        head="Pixie Hairpin +1",                    --> Affinity +28
        neck="Erra Pendant",                        --> Skill +10  Draspir +5
        body=gear.body.Merlinic.Draspir,            --> Draspir +10
        hands=gear.hands.Merlinic.Draspir,          --> Draspir +9
        ring1="Evanescence Ring",                   --> Skill +10  Draspir +10
        ring2="Archon Ring",                        --> Affinity +5
        back=gear.back.Taranus.FC,                  --> Skill +9
        waist="Fucho-no-Obi",                       --> Draspir +8
        legs="Spaekona's Tonban +2",                --> Skill +19  Draspir +10
        feet=gear.feet.Merlinic.Draspir,            --> Draspir +12
    })
    sets.midcast.Drain.Death = set_combine(sets.midcast.Drain, {
        -- MAX MP: 1970
        ammo="Strobilus",
        ear2="Etiolation Earring",
        body="Amalric Doublet",
        ring1="Mephitas's Ring +1",
        ring2="Evanescence Ring",
    })

    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Aspir.Death = sets.midcast.Drain.Death

    sets.midcast.Death = {
        --> Affinity +33  MAB +277  MAcc +123  MDMG +257  Skill +241  MBurst +40+5%  INT +208  MP +838 (2031 MAX) <--

        -- MAB +73  MAcc +5  MDMG +232  Skill +228  INT +32  MP +100
        --main="Lathi",                             --> MAB +68  MDMG +232  INT +32
        --sub="Niobid Grip",                        --> MAB +5  MAcc +5  MP +20

        -- Affinity +33  MAB +204  MAcc +118  MDMG +25  Skill +13  MBurst +40+5%  INT +176  MP +738
        ammo="Strobilus",                           --> MP +45
        head="Pixie Hairpin +1",                    --> Affinity +28  INT +27  MP +120
        neck="Mizu. Kubikazari",                    --> MAB +8  MBurst +10%  INT +4
        ear1="Etiolation Earring",                  --> MP +50
        ear2="Static Earring",                      --> MBurst +5%
        body=gear.body.Merlinic.Burst,              --> MAB +43  MAcc +43  MBurst +11%  INT +40  MP +67
        hands="Amalric Gages",                      --> MAB +38  MAcc +15  Skill +13  MBurst +0+5%  INT +34  MP +86
        ring1="Mephitas's Ring +1",                 --> MDMG +5  MP +110
        ring2="Archon Ring",                        --> Affinity +5
        back=gear.back.Taranus.FC,                  --> MP +80  MAcc +20  MDMG +20  MBurst +5%  FC +10%
        waist="Hachirin-no-Obi",                    -->
        legs="Amalric Slops",                       --> MAB +45  MAcc +15  INT +40  MP +160
        feet=gear.feet.Merlinic.Burst,              --> MAB +50  MAcc +25  MBurst +9%  INT +31  MP +20
    }

    sets.midcast.Stun = {
        -- MAcc +263  Skill +39  FC +37% -- MAX MP: 1779
        ammo="Pemphredo Tathlum",                   --> MAcc +8
        head="Amalric Coif",                        --> MAcc +41  FC +10%
        neck="Erra Pendant",                        --> MAcc +17  Skill +10
        ear1="Barkarole Earring",                   --> MAcc +8
        ear2="Dignitary's Earring",                 --> MAcc +10
        body=gear.body.Merlinic.MAcc,               --> MAcc +43  FC +8%
        hands="Jhakri Cuffs +1",                    --> MAcc +37
        ring1="Evanescence Ring",                   --> Skill +10
        ring2="Kishar Ring",                        --> MAcc +5  FC +4%
        back=gear.back.Taranus.FC,                  --> MAcc +20  FC +10%
        waist="Luminary Sash",                      --> MAcc +10
        legs="Spaekona's Tonban +2",                --> MAcc +39  Skill +19
        feet=gear.feet.Merlinic.Burst,              --> MAcc +25  FC +5%
        --ammo="Sapience Orb",                        --> FC +2%
        --head=gear.head.fc,                          --> MAcc +25  FC +15%
        --neck="Voltsurge Torque",                    --> MAcc +7  FC +4%
        --body="Shango Robe",                         --> MAcc +23  Skill +15  FC +8%
        --hands=gear.hands.fc,                        --> MAcc +11  FC +6%
        --waist="Witful Belt",                        --> FC +3%
        --waist="Channeler's Stone",                  --> FC +2%
        --legs="Lengo Pants",                         --> MAcc +15  FC +5%
    }

    sets.midcast.Stun.Death = set_combine(sets.midcast.Stun, {
        -- MAX MP: 2050
        ammo="Strobilus",                           --> MP +45
        ear2="Etiolation Earring",                  --> MP +50
        ring2="Mephitas's Ring +1",                 --> MP +110
        feet="Amalric Nails",                       --> MP +86
    })

    -- Elemental Magic sets
    sets.midcast['Elemental Magic'] = {
        --> MAB +341  MAcc +263  MDMG +237  Skill +241  MBurst +19+5%  INT +215 <--
        -- MAX MP: 1706 (Lathi)

        -- MAB +59  MAcc +31  MDMG +224  Skill +228  MBurst +5%  INT +19
        --main="Grioavolr",                         --> MAB +54  MAcc +26  MDMG +224  MAcc Skill +228  MBurst +5%  INT +19
        --sub="Niobid Grip",                        --> MAB +5  MAcc +5

        -- MAB +73  MAcc +5  MDMG +232  Skill +228  INT +32  MP +100
        --main="Lathi",                             --> MAB +68  MDMG +232  INT +32
        --sub="Niobid Grip",                        --> MAB +5  MAcc +5  MP +20

        -- MAB +280  MAcc +232  MDMG +13  Skill +13  MBurst +16+5%  INT +176  FC +19%
        ammo="Pemphredo Tathlum",                   --> MAB +4  MAcc +8  INT +4
        head=gear.head.Merlinic.MAB,                --> MAB +47  MAcc +44  INT +29  FC +8%
        neck="Sanctity Necklace",                   --> MAB +10  MAcc +10
        ear1="Friomisi Earring",                    --> MAB +10
        ear2="Barkarole Earring",                   --> MAB +8  MAcc +8  INT +3
        body=gear.body.Merlinic.MAB,                --> MAB +43  MAcc +43  MBurst +11%  INT +40  FC +6%
        hands="Amalric Gages",                      --> MAB +38  MAcc +15  Skill +13  MBurst +0+5%  INT +24
        ring1="Acumen Ring",                        --> MAB +4  INT +2
        ring2="Strendu Ring",                       --> MAB +4  MAcc +2
        back=gear.back.Taranus.MAB,                 --> MAB +10  MAcc +20  MDMG +20  MBurst +5%  MP +80
        waist="Hachirin-no-obi",
        legs=gear.legs.Merlinic.MAB,                --> MAB +52  MAcc +57  MDMG +13  INT +43
        feet=gear.feet.Merlinic.MAB,                --> MAB +50  MAcc +25  MBurst +9%  INT +31  FC +5%
    }

    sets.midcast['Elemental Magic'].Meteor = { }

    sets.midcast['Elemental Magic'].Death = set_combine(sets.midcast['Elemental Magic'], {
        -- MAX MP: 2047
        ammo="Strobilus",
        ear1="Etiolation Earring",
        body="Amalric Doublet",
        ring1="Mephitas's Ring +1",
        ring2="Sangoma Ring",
    })

    sets.midcast['Elemental Magic'].Burst = set_combine(sets.midcast['Elemental Magic'], {
        -- MBurst +40+10%
        -- MAX MP: 1671
        neck="Mizukage-no-Kubikazari",              --> MAB +8  MBurst +10%  INT +4
        ear1="Static Earring",                      --> MBurst +5%
        body=gear.body.Merlinic.Burst,              --> MAB +43  MAcc +43  MBurst +11%  INT +40
        hands="Amalric Gages",                      --> MAB +38  MAcc +15  Skill +13  MBurst +0+5%  INT +34
        ring1="Mujin Band",                         --> MBurst +0+5%
        ring2="Locus Ring",                         --> MBurst +5%
        back=gear.back.Taranus.MAB,                 --> MAB +10  MAcc +20  MDMG +20  MBurst +5%  MP +66
        feet=gear.feet.Merlinic.Burst,              --> MAB +50  MAcc +25  MBurst +9%  INT +31
    })


    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = { }

    -- Idle sets
    sets.idle = { -- DT -22%  MDT -3%  Refresh +4~5  Regen +1  Movement Speed +8%
        ammo="Staunch Tathlum",                     --> DT -2%  Resist +10
        head="Befouled Crown",                      --> Refresh +1
        neck="Loricate Torque +1",                  --> DT -6%
        ear1="Etiolation Earring",                  --> MDT -3%
        ear2="Infused Earring",                     --> Regen +1
        body="Jhakri Robe +1",                      --> Refresh +3
        hands="Amalric Gages",
        ring1="Defending Ring",                     --> DT -10%
        ring2="Shneddick Ring",                     --> Movement Speed +18%
        back="Solemnity Cape",                      --> DT -4%
        waist="Fucho-no-Obi",                       --> Lat. Refresh +1
        legs="Track Pants +1",                      --> Movement Speed +8%
        feet="Amalric Nails",
    }

    sets.idle.Refresh = set_combine(sets.idle, {
        legs="Lengo Pants",                         --> Refresh +1
    })

    sets.idle.Death = { -- MP +903  (2159 MAX)
        ammo="Strobilus",                           --> MP +45
        head="Befouled Crown",                      --> Refresh +1  MP +32
        neck="Sanctity Necklace",                   --> MP +35
        ear1="Etiolation Earring",                  --> MP +50
        ear2="Halasz Earring",                      --> MP +45
        body="Wicce Coat +1",                       --> Refresh +1  MP +112
        hands="Amalric Gages",                      --> MP +86
        ring1="Mephitas's Ring +1",                 --> MP +110
        ring2="Defending Ring",
        back=gear.back.Taranus.FC,                  --> MP +80
        waist="Luminary Sash",                      --> MP +45
        legs="Amalric Slops",                       --> MP +160
        feet="Amalric Nails",                       --> MP +86
    }

    -- Defense sets
    sets.defense.PDT = { }

    sets.defense.MDT = { }

    sets.Kiting = { ring2="Shneddick Ring" }

    sets.latent_refresh = { waist="Fucho-no-obi" }

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    --sets.buff['Mana Wall'] = {feet="Goetia Sabots +2"}
    --sets.magic_burst = {neck="Mizukage-no-Kubikazari"}

    -- Engaged sets
    -- Normal melee group
    sets.engaged = { }
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value and (state.CastingMode ~= 'Death') then
        equip(sets.midcast['Elemental Magic'].Burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
end
