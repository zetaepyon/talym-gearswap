-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    gs c step
        Uses the currently configured step on the target, with either <t> or <stnpc> depending on setting.

    gs c step t
        Uses the currently configured step on the target, but forces use of <t>.


    Configuration commands:

    gs c cycle mainstep
        Cycles through the available steps to use as the primary step when using one of the above commands.

    gs c cycle altstep
        Cycles through the available steps to use for alternating with the configured main step.

    gs c toggle usealtstep
        Toggles whether or not to use an alternate step.

    gs c toggle selectsteptarget
        Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.
]]--


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')

end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Climactic Flourish'] = buffactive['Climactic Flourish'] or false

    state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
    state.UseAltStep = M(false, 'Use Alt')
    state.SelectStepTarget = M(false, 'Sel. Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
    state.SkillchainPending = M(false, 'Skillchain Pending')

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()

    include('Talym-Include.lua')
    include('Talym-GearStats.lua')

    data.gear_stats['Samnuha Coat'].dual_wield = 3
    data.gear_stats['Toetapper Mantle'].dual_wield = 2

    classes.Hastes = S{'Haste','March','Embrava','Haste Samba','Mighty Guard'}

    -- State variables for haste & delay reduction calculation and display
    state.March1 = 'Honor March'
    state.March2 = 'Victory March'
    state.DelayReduction = 0
    state.TotalHaste = 0
    state.DualWield = 5

    state.OffenseMode:options('Normal', 'Acc', 'Acc2')
    state.HybridMode:options('Normal', 'DT', 'PDT', 'MDT', 'Turtle')
    state.WeaponskillMode:options('Normal', 'Acc')

    -- Additional local binds
    global_on_unload() --Unload default Mote keybinds

    add_to_chat(001,' ')
    add_to_chat(159,'DANCER KEYBINDS')
    bind('f9','gs c cycle OffenseMode','Cycle Offense Mode')
    bind('f10','gs c cycle HybridMode','Cycle Hybrid Mode')
    bind('f11','gs c cycle WeaponskillMode','Cycle Weaponskill Mode')
    bind('f12','gs c update user','Update User')
    bind('^=','gs c cycle mainstep','Cycle Main Step')
    bind('!=','gs c cycle altstep','Cycle Alternate Step')
    bind('^-','gs c toggle selectsteptarget','Select Step Target')
    bind('!-','gs c toggle usealtstep','Alternate Steps')

    bind('^f11','gs c randls','Select Random Lockstyle')
    bind('^f12','sb reset;input /ma "Shikaree Z"; wait 5; input /ma "Selh\'teus"; wait 5; input /ma "Qultada"; wait 5; input /ma "Ulmia"; wait 5; input /ma "Yoran-Oran (UC)"','Summon Dragon Trusts')

    init_job_states({"SelectStepTarget","UseAltStep"},{"TotalHaste","DelayReduction","MainStep","AltStep","OffenseMode","WeaponskillMode"})

    add_to_chat(001,' ')
    send_command('gs validate')

    random_lockstyle(8,17,18,31,37,38,39,60)

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^=')
    send_command('unbind !=')
    send_command('unbind ^-')
    send_command('unbind !-')
    clear_job_states()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['No Foot Rise'] = {
        body="Horos Casaque +1",                    --> +50 TP per 'No Foot Rise' merit
    }
    sets.precast.JA['Trance'] = {
        head="Horos Tiara +1",                      --> 'Trance' duration +20s
    }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = { --> CHR +105  VIT +110  Potency +52(50)%  Received +10%  Delay -1
        ammo="Yamarang",                            --> Potency +5%
        head="Anwig Salade",                        --> CHR +4  VIT +4  Delay -2
        neck="Unmoving Collar +1",                  --> CHR +9  VIT +9
        ear1="Roundel Earring",                     --> Potency +5%
        ear2="Etiolation Earring",
        body="Maxixi Casaque +2",                   --> CHR +28  VIT +29  Potency +17%  Received +7%  Delay -1
        hands=gear.hands.Herculean.Waltz,           --> CHR +19  VIT +30  Potency +10%
        ring1="Defending Ring",
        ring2="Asklepian Ring",                     --> Received +3%
        back="Toetapper Mantle",                    --> Potency +5%
        waist="Flume Belt",
        legs="Desultor Tassets",                    --> TP Cost -50
        feet="Maxixi Shoes +1",                     --> CHR +30  VIT +20  Potency +10%
    }

    --[[
    sets.precast.WaltzMax = { -- CHR +150  VIT +95  Potency +56(50)%  Received +11%  Delay -4
        ammo="Yamarang",                            --> Potency +5%
        head="Anwig Salade",                        --> CHR +4  Delay -2
        neck="Unmoving Collar +1",                  --> CHR +9  VIT +9
        ear1="Roundel Earring",                     --> Potency +5%
        ear2="Etiolation Earring",
        body="Maxixi Casaque +3",                   --> CHR +33  VIT +34  Potency +19%  Received +8%  Delay -1
        hands="Herculean Gloves",                   --> CHR +34  VIT +30  Potency +10%
        ring1="Valseur's Ring",                     --> Potency +3%
        ring2="Asklepian Ring",                     --> Received +3%
        back="Senuna's Cape",                       --> CHR +30
        waist="Flume Belt",
        legs="Desultor Tassets",                    --> TP Cost -50
        feet="Maxixi Shoes +3",                     --> CHR +40  VIT +22  Potency +14%
    }]]--

    sets.precast.Waltz['Healing Waltz'] = {
        head="Anwig Salade",                        --> Delay -2
        body="Maxixi Casaque +2",                   --> Delay -1
        legs="Desultor Tassets",                    --> TP Cost -50
    }

    sets.precast.Samba = {
        head="Maxixi Tiara",    --+1                --> "Samba" duration +40s --+45s
        back=gear.back.Senunas.TP,                  --> "Samba" duration +15s
    }

    sets.precast.Jig = { -- Duration +75(50)%
        legs="Horos Tights +1",                     --> Duration +45%
        feet="Maxixi Shoes +1",                     --> Duration +30%
    }

    sets.precast.Step = { -- Primary Accuracy 1289
        --main="Terpsichore",                       --> Step Acc +60
        ammo="Yamarang",                            --> Acc +15
        head="Mummu Bonnet +1",                     --> Acc +38  DEX +35
        neck="Sanctity Necklace",                   --> Acc +10
        ear1="Telos Earring",                       --> Acc +10
        ear2="Dignitary's Earring",                 --> Acc +10
        body=gear.body.Herculean.Acc,               --> Acc +53  DEX +34
        hands="Maxixi Bangles +3",                  --> Acc +48  DEX +45  Step Acc +40
        ring1="Petrov Ring",                        --> DEX +3
        ring2="Apate Ring",                         --> DEX +6
        back=gear.back.Senunas.TP,                  --> Acc +20  DEX +30
        waist="Grunfeld Rope",                      --> Acc +10  DEX +5
        legs="Mummu Kecks +1",                      --> Acc +39  DEX +7
        feet=gear.feet.Herculean.Acc,               --> Acc +50  DEX +24
    }
    sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step,{
        feet="Maculele Toeshoes +1",                --> Feather Step potency +4%
    })

    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {  -- MAcc +201
        ammo="Pemphredo Tathlum",                   --> MAcc +8
        head="Mummu Bonnet +1",                     --> MAcc +38
        neck="Sanctity Necklace",                   --> MAcc +10
        ear1="Psystorm Earring",                    --> MAcc +12
        ear2="Lifestorm Earring",                   -->
        body="Horos Casaque +1",                    --> Violent Flourish acc +37
        hands="Mummu Wrists +1",                    --> MAcc +37
        ring1="Stikini Ring",                       --> MAcc +8
        ring2="Stikini Ring",                       --> MAcc +8
        back="Izdubar Mantle",                      --> MAcc +5
        legs="Mummu Kecks +1",                      --> MAcc +39
        feet="Mummu Gamashes +1",                   --> MAcc +36
    }
    sets.precast.Flourish1['Desperate Flourish'] = sets.precast.Step

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {
        hands="Maculele Bangles +1",                --> Sq. Mod +12
        back="Toetapper Mantle",                    --> Reverse Flourish +30
    }

    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {
        body="Maculele Casaque", --+1               --> Enhances "Striking Flourish" effect
    }
    sets.precast.Flourish3['Climactic Flourish'] = {
        head="Maculele Tiara +1",                   --> Climactic Flourish: Crit rate +1, Crit damage +22%
    }

    -- Fast cast sets for spells

    sets.precast.FC = { -- FC +35%  QC +2%
        ammo="Impatiens",                           --> QC +2%
        head="Haruspex Hat",                        --> FC +8%
        neck="Voltsurge Torque",                    --> FC +4%
        ear1="Etiolation Earring",                  --> FC +1%
        ear2="Loquacious Earring",                  --> FC +2%
        body="Foppish Tunica",                      --> FC +5%
        hands="Leyline Gloves",                     --> FC +8%
        ring1="Rahab Ring",                         --> FC +2%
        ring2="Prolix Ring",                        --> FC +2%
        legs="Limbo Trousers",                      --> FC +3%
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { --neck="Magoraga Beads"
    })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        -- Terps/Sari: STR +183  DEX +222  AGI +152  INT +92  CHR +100  Acc 1161/1136  Atk 1129/1034  WSD +13%
        ammo="Jukukik Feather",                     --> STR +2   Atk +8
        head=gear.head.Herculean.WSD,               --> STR +22  DEX +35  AGI +25  INT +20  CHR +17  Acc +28  Atk +29  WSD +3%
        --head="Lilitu Headpiece",                    --> STR +31  DEX +35  AGI +22  INT +18  CHR +19           Atk +33  WSD +2%
        neck="Fotia Gorget",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",                  --> DA +7%
        body="Adhemar Jacket",                      --> STR +36  DEX +43  Acc +20  Atk +35  TA +3%  Haste +4%  DW +5%
        --hands=gear.hands.atk,                       --> STR +25  DEX +53  Acc +15  Atk +15  TA +2%  Haste +5%  STP +6
        hands="Maxixi Bangles +3",
        ring1="Apate Ring",                         --> STR +6   DEX +6   AGI +6
        ring2="Epona's Ring",                       --> DA +3%  TA +3%
        back=gear.back.Senunas.WSD,                 -->          DEX +20  Acc +20  Atk +20  WSD +10%
        waist="Fotia Belt",
        legs="Samnuha Tights",                      --> STR +48  DEX +16  AGI +30  INT +28  CHR +8   Acc +15
        feet=gear.feet.Herculean.WS,                --> STR +21  DEX +24  Acc +43  Atk +49  TA +2%  Haste +4%
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        -- Terps/Sari: STR +175  DEX +212  AGI +153  INT +93  CHR +101  Acc 1209/1184  Atk 1138/1042  WSD +13%
        ammo="Falcon Eye",                          --> DEX +3  Acc +13
        body=gear.body.Herculean.Acc,               --> STR +28  DEX +34  Acc +53  Atk +30  CRate +5%  Haste +4%  STP +3
        feet=gear.feet.Herculean.Acc,               --> STR +26  DEX +24  Acc +50  Atk +40  TA +2%  Haste +4%
    })

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    -- Exenterator Sets | AGI: 85%                    --> AGI +133
    --sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, { })
    --sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], { })

    -- Pyrrhic Kleos Sets | STR: 40%  DEX: 40%
    -- [Acc1110 Atk1097] STR +208  DEX +237
    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
        ammo="Floestone",                           --> STR +3  Atk +10
        head="Lustratio Cap",                       --> STR +41  DEX +39
        neck="Fotia Gorget",
        rear="Sherida Earring",                     --> STR +5  DEX +5  DA +5%
        lear="Moonshade Earring",                   --> TPBonus +250
        body="Adhemar Jacket",                      --> STR +36  DEX +43  Acc +25  Atk +40  TA +3%
        --hands=gear.hands.Adhemar.Atk,               --> STR +25  DEX +53  Acc +22  Atk +15  TA +3%
        hands="Maxixi Bangles +3",                  --> STR +21  DEX +45  Acc +48  Atk +35  WSD +10%
        lring="Apate Ring",                         --> STR +6  DEX +6
        rring="Rajas Ring",                         --> STR +5  DEX +5
        back=gear.back.Senunas.TP,                  --> DEX +30  Acc +20  Atk +20  DA +10%
        waist="Fotia Belt",
        legs="Samnuha Tights",                      --> STR +48  DEX +16  Acc +15  DA +3%  TA +3%
        feet="Lustratio Leggings",                  --> STR +39  DEX +40
    })

    -- [Acc1227 Atk1157] STR +172  DEX +198  Acc +220  Atk +184  CDmg +5%  WSD +20%  DA +2%  TA +4%
    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
        ammo="Falcon Eye",                          --> DEX +3  Acc +13
        head="Meghanada Visor +1",                  --> STR +24  DEX +30  Acc +42  Atk +38
        --neck="Fotia Gorget",
        --lear="Mache Earring",                       --> DEX +5  Acc +7  DA +1%
        --rear="Telos Earring",                       --> Acc +10  Atk +10  DA +1%
        body="Meghanada Cuirie +1",                 --> STR +31  DEX +42  Acc +44  Atk +40  CDmg +5%
        --hands="Meghanada Gloves +1",                --> STR +20  DEX +47  Acc +41  Atk +37  WSD +10%
        --lring="Apate Ring",                         --> STR +6  DEX +6
        --rring="Rajas Ring",                         --> STR +5  DEX +5
        --back=gear.back.wsd, -- Senuna's Mantle      --> STR +10  DEX +20  Acc +20  Atk +20  WSD +10%
        --waist="Fotia Belt",
        legs="Meghanada Chausses +1",               --> STR +37  Acc +43  Atk +39  TA +4%
        --feet="Lustratio Leggings",                  --> STR +39  DEX +40
    })

    -- Evisceration Sets | DEX: 50%
    -- [Acc1159 Atk1117] DEX +249
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        ammo="Charis Feather",                      --> DEX +5  CDMG +5%
        head="Adhemar Bonnet",                      --> DEX +31  CDMG +5%
        neck="Fotia Gorget",
        ear1="Sherida Earring",                     --> DEX +5  DA +5%
        ear2="Moonshade Earring",                   --> TPBonus +250
        body="Meghanada Cuirie +1",                 --> DEX +42  CDMG +5%
        hands=gear.hands.Herculean.CR,              --> DEX +53  CRate +3%
        ring1="Apate Ring",                         --> DEX +6
        ring2="Begrudging Ring",                    --> CRate +5%
        back=gear.back.Senunas.Crit,                --> DEX +30  CDMG +5%  CRate +10%
        waist="Fotia Belt",
        legs="Lustratio Subligar",                  --> DEX +37  CRate +2%
        feet="Lustratio Leggings",                  --> DEX +40
    })
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
        ammo="Honed Tathlum",
        --back="Toetapper Mantle",
    })

    -- Rudra's Storm Sets | DEX: 80%
    -- Herc:  STR +121  DEX +255  Acc +199?  Atk +216  CRate +2%  CDmg +10%  WSD +20%  TPBonus +250
    -- AF3:   STR +117  DEX +240  Acc +194  Atk +212  CRate +2%  CDmg +35%  WSD +17%  TPBonus +250
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
        ammo="Charis Feather",                      --> DEX +5  CDmg +5%
        --head=gear.head.wsd, -- Herculean Helm       --> STR +22  DEX +43  Acc +11  Atk +26  WSD +3%
        head="Maculele Tiara +1",                   --> STR +18  DEX +28  Acc +23  Atk +23  CDmg +25%
        neck="Caro Necklace",                       --> STR +6  DEX +6  Atk +10
        lear="Ishvara Earring",                     --> WSD +2%
        rear="Moonshade Earring",                   --> Atk +4  TPBonus +250
        body="Meghanada Cuirie +1",                 --> STR +31  DEX +42  Acc +44  Atk +40  CDmg +5%
        hands="Maxixi Bangles +3",                  --> STR +21  DEX +45  Acc +48  Atk +35  WSD +10%
        lring="Apate Ring",                         --> STR +6  DEX +6
        rring="Rajas Ring",                         --> STR +5  DEX +5
        back=gear.back.Senunas.WSD,                 --> STR +10  DEX +20  Acc +20  Atk +20  WSD +10%
        waist="Grunfeld Rope",                      --> STR +5  DEX +5  Acc +10  Atk +20  DA +2%
        legs="Lustratio Subligar",                  --> DEX +37  Acc +15  Atk +35  CRate +2%
        feet=gear.feet.Herculean.TA,                --> STR +16  DEX +39  Acc +21  Atk +23  TA +4%
    })

    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], { })

    -- Aeolian Edge Sets | DEX: 40%, INT: 40%
    sets.precast.WS['Aeolian Edge'] = {             --> MDMG +5  MAB +179  MAcc +107  INT +96  DEX +129  MCrit Rate +3%
        ammo="Pemphredo Tathlum",                   --> MAB +4  MAcc +8  INT +4
        head="Herculean Helm",                      --> MAB +30  MAcc +19  DEX +28  INT +20
        neck="Sanctity Necklace",                   --> MAB +10  MAcc +10
        ear1="Hecate's Earring",                    --> MAB +6   MCrit Rate +3%
        ear2="Friomisi Earring",                    --> MAB +10
        body="Samnuha Coat",                        --> MAB +33  MAcc +37  DEX +33  INT +20
        hands="Leyline Gloves",                     --> MAB +30  MAcc +33  DEX +35  INT +12
        ring1="Mephitas's Ring +1",                 --> MDMG +5
        ring2="Acumen Ring",                        --> MAB +4  INT +2
        back="Toro Cape",                           --> MAB +10  INT +8
        waist="Chaac Belt",                         --> TH +1
        legs="Limbo Trousers",                      --> MAB +17  INT +30
        feet="Adhemar Gamashes",                    --> MAB +25  DEX +33
    }

    -- Midcast Sets
    sets.midcast.FastRecast = { -- FC +31%
        ammo="Sapience Orb",                        --> FC +2%
        head="Herculean Helm",                      --> FC +7%
        neck="Voltsurge Torque",                    --> FC +4%
        ear1="Etiolation Earring",                  --> FC +1%
        ear2="Loquacious Earring",                  --> FC +2%
        body="Samnuha Coat",                        --> FC +4%
        hands="Leyline Gloves",                     --> FC +8%
        ring2="Prolix Ring",                        --> FC +2%
        legs="Limbo Trousers",                      --> FC +3%
    }

    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, { })


    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    -- DT -26%  PDT -16%  MDT -7%
    sets.idle = {
        ammo="Staunch Tathlum",                     --> DT -2%
        head="Dampening Tam",                       --> MDT -4%
        neck="Loricate Torque +1",                  --> DT -6%
        lear="Etiolation Earring",                  --> MDT -3%
        rear="Steelflash Earring",                  --> Regen +1
        body="Meghanada Cuirie +1",                 --> PDT -7%
        hands="Meghanada Gloves +1",                --> PDT -3%
        ring1="Defending Ring",                     --> DT -10%
        ring2="Shneddick Ring",                     --> Movement Speed +18%
        back="Solemnity Cape",                      --> DT -4%
        waist="Flume Belt",                         --> PDT -4%
        legs="Mummu Kecks +1",                      --> DT -4%
        --feet=gear.feet.Herculean.TA,                --> PDT -2%
        feet="Tandava Crackows",                    --> Movement Speed +12%
    }

    -- Defense sets

    sets.defense.Evasion = {}
    sets.defense.PDT = {}
    sets.defense.MDT = {}
    sets.Kiting = { ring2="Shneddick Ring", }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group

    -- DT -22%
    sets.DT = {
        ammo="Staunch Tathlum",                     --> DT -2%
        neck="Loricate Torque +1",                  --> DT -6%
        ring2="Defending Ring",                     --> DT -10%
        legs="Mummu Kecks +1",                      --> DT -4%
    }

    -- PDT -19%
    sets.PDT = set_combine(sets.DT, {
        head="Meghanada Visor +1",                  --> PDT -4%
        body="Meghanada Cuirie +1",                 --> PDT -7%
        hands="Meghanada Gloves +1",                --> PDT -3%
        legs="Meghanada Chausses +1",               --> PDT -5%
    })

    -- MDT -4%
    sets.MDT = set_combine(sets.DT, {
        head="Dampening Tam",                       --> MDT -4%
    })

    -- Turtle :: PDT -42%  MDT -30%
    sets.Turtle = set_combine(sets.PDT, sets.MDT, {
        ring1="Warden's Ring",                      --> PDT -3%
        back="Solemnity Cape",                      --> DT -4%
        feet=gear.feet.Herculean.TA,                --> PDT -2%
    })

    -- STR +143  DEX +273  Acc +154  Atk +102  QA +6%  TA +12%  DA +28%  Haste +26%  STP +28
    -- ACC 1196  ATK 1025/964  [Terps/Twash 119-3]
    sets.engaged = {
        ammo="Ginsen",                              --> Acc +5  Atk +10
        head="Dampening Tam",                       --> STR +18  DEX +33  Acc +33  QA +2%  Haste +7%
        neck="Asperity Necklace",                   --> Atk +8  DA +2%  STP +3
        ear1="Sherida Earring",                     --> STR +5  DEX +5  DA +5%  STP +5
        ear2="Telos Earring",                       --> Acc +10  Atk +10  DA +1%  STP +5
        body=gear.body.Herculean.TA,                --> STR +28  DEX +49  Acc +39  TA +3%  Haste +4%  STP +3
        hands=gear.hands.Adhemar.Atk,               --> STR +25  DEX +53  Acc +15  Atk +15  TA +2%  Haste +5%  STP +6
        ring1="Petrov Ring",                        --> STR +3  DEX +3  DA +1%  STP +5
        ring2="Epona's Ring",                       --> DA +3%  TA +3%
        back=gear.back.Senunas.TP,                  --> DEX +30  Acc +20  Atk +20  DA +10%
        waist="Windbuffet Belt +1",                 --> Acc +2  TA +2%  QA +2%
        legs="Samnuha Tights",                      --> STR +48  DEX +16  Acc +15  DA +3%  TA +3%  Haste +6%  STP +7
        feet=gear.feet.Herculean.TA,                --> STR +21  DEX +24  Acc +43  Atk +49  TA +2%  Haste +4%
    }

    -- ACC 1170  ATK 1070/1008
    sets.engaged.NoHaste = set_combine(sets.engaged, {
        body="Adhemar Jacket",
    })

    -- ACC 1222  ATK 1024/966
    sets.engaged.Acc = set_combine(sets.engaged, {
        neck="Clotharius Torque",                   --> Acc +8
        body=gear.body.Herculean.Acc,               --> STR +28  DEX +34  Acc +53  Atk +30  CRate +5%  Haste +4%  STP +3
        hands=gear.hands.Adhemar.Acc,               --> Acc +37
    })

    -- ACC 1288 ATK 1094/1037
    sets.engaged.Acc2 = set_combine(sets.engaged.Acc, {
        ammo="Falcon Eye",                          --> Acc +15
        neck="Combatant's Torque",                  --> Skill +15
        ear1="Dignitary's Earring",                 --> Acc +10
        waist="Kentarch Belt",                      --> Acc +13  DA +2%
        legs="Meghanada Chausses +1",               --> Acc +34  Atk +39  TA +4%
        feet=gear.feet.Herculean.Acc,
    })

    -- Combines for Hybrid defense modes
    local off_modes = {"Acc", "Acc2"}
    local def_modes = {"DT", "PDT", "MDT", "Turtle"}
    for i,off in pairs(off_modes) do
        for k,def in pairs(def_modes) do
            sets.engaged[def] = set_combine(sets.engaged, sets[def])
            sets.engaged[off][def] = set_combine(sets.engaged[off], sets[def])
        end
    end

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Climactic Flourish'] = { head="Maculele Tiara +1", }
    sets.buff['Sleep'] = { head="Frenzy Sallet", }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == "JobAbility" then
        auto_fallback(spell,classes.AbilityFallback)
    end
    auto_presto(spell)
end


function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" then
        if state.Buff['Climactic Flourish'] then
            equip(sets.buff['Climactic Flourish'])
        end
    end
end


-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain,eventArgs,buff_details)

    if classes.Hastes:contains(buff) then

        if buff == 'Haste' and not gain then haste_type = 0 end

        local haste = calc_haste()
        local delay = calc_delay_reduction(haste[1])

        handle_equipping_gear(player.status)

    end

    -- Monitor for other buffs/debuffs and adjust gear set
    if S{'Poison','Sleep','Saber Dance','Climactic Flourish'}:contains(buff) then
        handle_equipping_gear(player.status)
    end

    update_job_states()

end

function buff_refresh(buff, buff_details)

    if classes.Hastes:contains(buff) then

        local haste = calc_haste()
        local delay = calc_delay_reduction(haste[1])

        handle_equipping_gear(player.status)

    end

    update_job_states()

end

function job_state_change()
    update_job_states()
end

function job_status_change(new_status, old_status)

    if new_status == 'Engaged' then
        --determine_haste_group()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    --determine_haste_group()
end


function customize_idle_set(idleSet)
    if player.hpp < 80 and not areas.Cities:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    if state.DefenseMode.value == 'None' then
        if state.TotalHaste < 68.75 then
            --meleeSet = set_combine(meleeSet, sets.engaged.NoHaste)
        end
        if state.Buff['Climactic Flourish'] then
            meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
        end
        if buffactive['Sleep'] and player.hp > 300 then
            meleeSet = set_combine(meleeSet, sets.buff['Sleep'])
        end
    end

    return meleeSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end

        eventArgs.SelectNPCTargets = state.SelectStepTarget.value
    end
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'

    -- Include combat form
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    msg = msg .. ': '

    -- Include Offense and Hybrid defense mode
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value

    -- Include Defense override mode
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    -- Include kiting state
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    -- Include selected steps and step targeting
    msg = msg .. ', ['..state.MainStep.current
    if state.UseAltStep.value == true then
        msg = msg .. '/'..state.AltStep.current
    end
    msg = msg .. ']'
    if state.SelectStepTarget.value == true then
        steps = steps..' (Targeted)'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'step' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doStep = ''
        if state.UseAltStep.value == true then
            doStep = state[state.CurrentStep.current..'Step'].current
            state.CurrentStep:cycle()
        else
            doStep = state.MainStep.current
        end

        send_command('@input /ja "'..doStep..'" <t>')

    elseif cmdParams[1] == 'randls' then

        random_lockstyle(8,17,18,31,37,38,39,60)

    elseif cmdParams[1] == 'calchaste' then

        local haste = calc_haste()
        windower.add_to_chat(006, string.format("Total Haste: %2d%% (M:%2d J:%2d E:%2d)", haste[1], haste[2], haste[3], haste[4]))

    end
end


-- Automatically use Presto for steps when it's available and we have less than 6 finishing moves
function auto_presto(spell)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]

        if player.main_job_level >= 77 and prestoCooldown < 1 and not buffactive['Finishing Move (6+)'] then
            cast_delay(1.1)
            send_command('@input /ja "Presto" <me>')
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'SAM' then
        set_macro_page(1, 3)
    else
        set_macro_page(1, 3)
    end
end
