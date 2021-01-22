-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Quelveuiat
-- Standard Info NPC
-- !pos -3.177 -22.750 -25.970 26
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local SealionCrestKey = trade:hasItemQty(1658, 1)
    local CoralCrestKey = trade:hasItemQty(1659, 1)
    local Count = trade:getItemCount()

    if (player:getQuestStatus(tpz.quest.log_id.OTHER_AREAS, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT) == QUEST_COMPLETED and player:hasKeyItem(tpz.ki.TEMPLE_KNIGHT_KEY) == false) then
    -- Trade Sealion and Coral Crest keys to obtain Temple Knight key (keyitem).
        if (SealionCrestKey and CoralCrestKey and Count == 2) then
            player:addKeyItem(tpz.ki.TEMPLE_KNIGHT_KEY)
            player:tradeComplete()
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TEMPLE_KNIGHT_KEY)
        end
    end

end

entity.onTrigger = function(player, npc)

    if (player:getQuestStatus(tpz.quest.log_id.OTHER_AREAS, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT) == QUEST_AVAILABLE) then
        player:startEvent(119)
    elseif (player:getQuestStatus(tpz.quest.log_id.OTHER_AREAS, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT) == QUEST_ACCEPTED and player:getCharVar("SPLINTERSPINE_GRUKJUK") <= 1) then
        player:startEvent(120)
    elseif (player:getCharVar("SPLINTERSPINE_GRUKJUK") == 2 and player:getQuestStatus(tpz.quest.log_id.OTHER_AREAS, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT) == QUEST_ACCEPTED) then
        player:startEvent(121)
    else
        player:startEvent(122)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 119 and option == 3) then
        player:addQuest(tpz.quest.log_id.OTHER_AREAS, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT)
    elseif (csid == 121) then
        player:setCharVar("SPLINTERSPINE_GRUKJUK", 0)
        player:completeQuest(tpz.quest.log_id.OTHER_AREAS, tpz.quest.id.otherAreas.A_HARD_DAY_S_KNIGHT)
        player:addGil(GIL_RATE*2100)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*2100)
    end

end

return entity
