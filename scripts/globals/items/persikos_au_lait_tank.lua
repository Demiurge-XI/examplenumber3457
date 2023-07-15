-----------------------------------
-- ID: 16227
-- Persikos Tank
-- When used, you will obtain one Persikos au lait
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addItem(xi.items.FLASK_OF_PERSIKOS_AU_LAIT, 1)
end

return itemObject
