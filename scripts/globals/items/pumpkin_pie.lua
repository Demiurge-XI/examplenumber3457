-----------------------------------
-- ID: 4446
-- Item: pumpkin_pie
-- Food Effect: 30Min, All Races
-----------------------------------
-- Magic 40
-- Agility -1
-- Intelligence 3
-- Charisma -2
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4446)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MP, 40)
    target:addMod(tpz.mod.AGI, -1)
    target:addMod(tpz.mod.INT, 3)
    target:addMod(tpz.mod.CHR, -2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MP, 40)
    target:delMod(tpz.mod.AGI, -1)
    target:delMod(tpz.mod.INT, 3)
    target:delMod(tpz.mod.CHR, -2)
end

return item_object
