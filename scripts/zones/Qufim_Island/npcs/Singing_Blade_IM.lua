-----------------------------------
-- Area: Qufim Island
--  NPC: Singing Blade, I.M.
-- Type: Border Conquest Guards
-- !pos 179.093 -21.575 -15.282 126
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------
local entity = {}

local guardNation = xi.nation.BASTOK
local guardType   = xi.conq.guard.BORDER
local guardRegion = xi.region.QUFIMISLAND
local guardEvent  = 32760

entity.onTrade = function(player, npc, trade)
    xi.conq.overseerOnTrade(player, npc, trade, guardNation, guardType)
end

entity.onTrigger = function(player, npc)
    xi.conq.overseerOnTrigger(player, npc, guardNation, guardType, guardEvent, guardRegion)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.conq.overseerOnEventUpdate(player, csid, option, guardNation)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.conq.overseerOnEventFinish(player, csid, option, guardNation, guardType, guardRegion)
end

return entity
