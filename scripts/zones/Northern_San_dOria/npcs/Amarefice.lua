-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Amarefice
-- Type: Woodworking Synthesis Image Support
-- !pos -181.506 10.15 259.905 231
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guildMember = xi.crafting.isGuildMember(player, 9)
    local SkillCap = xi.crafting.getCraftSkillCap(player, xi.skill.WOODWORKING)
    local SkillLevel = player:getSkillLevel(xi.skill.WOODWORKING)

    if (guildMember == 1) then
        if (player:hasStatusEffect(xi.effect.WOODWORKING_IMAGERY) == false) then
            player:startEvent(624, SkillCap, SkillLevel, 1, 207, player:getGil(), 0, 4095, 0)
        else
            player:startEvent(624, SkillCap, SkillLevel, 1, 207, player:getGil(), 7127, 4095, 0)
        end
    else
        player:startEvent(624, SkillCap, SkillLevel, 1, 201, player:getGil(), 0, 0, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 624 and option == 1) then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 1, 1)
        player:addStatusEffect(xi.effect.WOODWORKING_IMAGERY, 1, 0, 120)
    end
end

return entity
