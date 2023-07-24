-----------------------------------
-- Area: Beadeaux
--  NPC: Haggleblix
-- Type: Dynamis NPC
-- !pos -255.847 0.595 106.485 147
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.dynamis.hourglassAndCurrencyExchangeNPCOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.dynamis.hourglassAndCurrencyExchangeNPCOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.dynamis.hourglassAndCurrencyExchangeNPCOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.dynamis.hourglassAndCurrencyExchangeNPCOnTrade(player, csid, option, npc)
end

return entity
