-----------------------------------
-- Area: Oldton Movalpolos
--   NM: Bugbear Muscleman
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 246)
end

return entity
