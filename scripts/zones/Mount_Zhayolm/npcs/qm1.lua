-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Spawn Brass Borer(ZNM T1))
-- !pos 399 -27 120 61
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.items.CLUMP_OF_SHADELEAVES) and
        npcUtil.popFromQM(player, npc, ID.mob.BRASS_BORER)
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SHED_LEAVES)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
