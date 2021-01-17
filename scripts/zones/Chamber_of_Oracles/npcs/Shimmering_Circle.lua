-----------------------------------
-- Area: Chamber of Oracles
-- NPC:  Shimmering Circle
-- !pos -220 0 12 168
-----------------------------------
require("scripts/globals/bcnm")
-----------------------------------

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)
    EventTriggerBCNM(player, npc)
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    EventFinishBCNM(player, csid, option)
end
