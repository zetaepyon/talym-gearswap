-- Define gear variable framework
function define_gear()

    local slots = {
        "main","sub","ranged","ammo",
        "head","neck","ear",
        "body","hands","ring",
        "back","waist","legs","feet",
    }

    local gearsets = {
        "Herculean",
        "Merlinic",
        "Adhemar",
        "Lustratio",
        "Senunas",
        "Taranus",
        "Grioavolr",
        "Ogma"
    }

    for i,slot in pairs(slots) do
        gear[slot] = {}
        for k,set in pairs(gearsets) do
            gear[slot][set] = {}
        end
    end

end

define_gear()

gear.main.Grioavolr.FC = { name="Grioavolr", augments={'"Fast Cast"+7','MND+7','Mag. Acc.+13','"Mag.Atk.Bns."+9',}}
gear.main.Grioavolr.Burst = { name="Grioavolr", augments={'Magic burst mdg.+8%','MND+8','Mag. Acc.+19','"Mag.Atk.Bns."+23','Magic Damage +4',}}

gear.head.Herculean.WSD = { name="Herculean Helm", augments={'Accuracy+11 Attack+11','Weapon skill damage +3%','DEX+15',}}


gear.body.Herculean.QA = { name="Herculean Vest", augments={'"Dbl.Atk."+1','Crit.hit rate+3','Quadruple Attack +2',}}
gear.body.Herculean.TA = { name="Herculean Vest", augments={'Accuracy+24','"Triple Atk."+3','DEX+15',}}
gear.body.Herculean.WS = gear.body.Herculean.TA
gear.body.Herculean.Acc = gear.body.Herculean.TA

gear.body.Merlinic.MAB = { name="Merlinic Jubbah", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+11%','MND+2',}}
gear.body.Merlinic.FC = { name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+29','"Fast Cast"+6','DEX+8','Mag. Acc.+11',}}
gear.body.Merlinic.Draspir = { name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+16','"Drain" and "Aspir" potency +10','INT+8','Mag. Acc.+5',}}
gear.body.Merlinic.Burst = gear.body.Merlinic.MAB
gear.body.Merlinic.MAcc = gear.body.Merlinic.MAB

gear.hands.Adhemar.Acc = { name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}}
gear.hands.Adhemar.Atk = { name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}}
gear.hands.Herculean.DT = { name="Herculean Gloves", augments={'Accuracy+27','Damage taken-4%','STR+10','Attack+13',}}
gear.hands.Herculean.CR = { name="Herculean Gloves", augments={'Accuracy+24 Attack+24','Crit.hit rate+3','DEX+14',}}
gear.hands.Herculean.Waltz = { name="Herculean Gloves", augments={'Attack+18','"Waltz" potency +10%','STR+3',}}
gear.hands.Herculean.StrTA = { name="Herculean Gloves", augments={'Attack+26','"Triple Atk."+4','STR+9','Accuracy+15',}}

gear.legs.Herculean.MAB = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+17','INT+10','Accuracy+9 Attack+9','Mag. Acc.+13 "Mag.Atk.Bns."+13',}}

gear.feet.Herculean.MAB = { name="Herculean Boots", augments={'INT+3','"Mag.Atk.Bns."+22','"Refresh"+2',}}
gear.feet.Herculean.TA = { name="Herculean Boots", augments={'Accuracy+22 Attack+22','"Triple Atk."+3','DEX+3','Accuracy+12','Attack+1',}}
gear.feet.Herculean.Acc = { name="Herculean Boots", augments={'Accuracy+25 Attack+25','STR+10','Accuracy+15','Attack+5',}}
gear.feet.Herculean.StrTA = { name="Herculean Boots", augments={'Attack+25','"Triple Atk."+3','STR+6',}}
gear.feet.Herculean.Refresh = gear.feet.Herculean.MAB

gear.back.Ogma.DA = { name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
gear.back.Ogma.STP = { name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10',}}
gear.back.Senunas.TP = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}
gear.back.Senunas.WSD = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
gear.back.Senunas.Crit = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
gear.back.Taranus.FC = { name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10',}}
gear.back.Taranus.MAB = { name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Mag.Atk.Bns."+10',}}
