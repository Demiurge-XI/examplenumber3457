-----------------------------------
-- ID: 5824
-- Item: Lucid Potion I
-- Item Effect: Restores 500 HP
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:getHP() == target:getMaxHP() then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end
    return 0
end

item_object.onItemUse = function(target)
    target:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, target:addHP(500*ITEM_POWER))
end

return item_object
