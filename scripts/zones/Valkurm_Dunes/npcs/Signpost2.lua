-----------------------------------
-- Area: Valkurm Dunes
--  NPC: Signpost
-- !pos 490 -13 146 103
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SIGNPOST2)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
