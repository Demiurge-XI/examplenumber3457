-----------------------------------
-- ID: 5290
-- Item: Slice of Diatryma Meat
-- Effect: 5 Minutes, food effect, Galka Only
-----------------------------------
-- Strength +3
-- Intelligence -5
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getRace() ~= xi.race.GALKA then
        result = xi.msg.basic.CANNOT_EAT
    end

    if target:getMod(xi.mod.EAT_RAW_MEAT) == 1 then
        result = 0
    end

    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5290)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 3)
    target:addMod(xi.mod.INT, -5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 3)
    target:delMod(xi.mod.INT, -5)
end

return itemObject
