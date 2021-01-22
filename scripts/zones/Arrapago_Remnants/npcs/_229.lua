
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
-----------------------------------
local entity = {}

entity.onTrigger = function(entity, npc)
    if (npc:getInstance():getStage() == 3) then
        entity:startEvent(300)
    else
        entity:messageSpecial(ID.text.DOOR_IS_SEALED)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(entity, eventid, result, door)
    if (eventid == 300 and result == 1) then
        local instance = door:getInstance()
        instance:setStage(4)
        instance:setProgress(2)
        door:setAnimation(8)
        SpawnMob(ID.mob[3].treasure_hunter1, instance)
        SpawnMob(ID.mob[3].qiqirn_mine_1, instance)
        for i, v in pairs(ID.npc[3][1]) do
            local npc = GetNPCByID(v, instance)
            npc:untargetable(true)
        end
    end
end

return entity
