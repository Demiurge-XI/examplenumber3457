-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Gigas Stonemason
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 785, 1, xi.regime.type.GROUNDS)
end

return entity
