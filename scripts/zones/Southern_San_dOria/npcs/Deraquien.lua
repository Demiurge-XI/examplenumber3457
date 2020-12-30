-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Deraquien
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -98 -2 31 230
-------------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatSandy, 4)) then
        player:startEvent(811)
    else
        player:startEvent(18)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 811) then
        player:setCharVar("WildcatSandy", utils.mask.setBit(player:getCharVar("WildcatSandy"), 4, true))
    end

end

---------other CS
--    player:startEvent(654) -- nothing to report
--    player:startEvent(33)-- theif of royl sceptre
--    player:startEvent(47)-- as again about the theif
--    player:startEvent(34) -- reminder of theif in la thein
--    player:startEvent(80)  -- thief caught but phillone was there
--    player:startEvent(20)  -- go get reward for thief
--    player:startEvent(87) -- vijrtall shows up and derq tells you go talk tho phillone
--    player:startEvent(30) --reminder go talk to phillone
--    player:startEvent(38) -- go help  retrieve royal sceptre
--    player:startEvent(27) -- the lady wanst involved in the theft :(
