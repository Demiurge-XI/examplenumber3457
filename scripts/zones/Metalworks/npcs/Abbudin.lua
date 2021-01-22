-----------------------------------
-- Area: Metalworks
--  NPC: Abbudin
-- Type: Standard Info NPC
-- !pos -56.338 2.777 -31.446 237
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(558)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
