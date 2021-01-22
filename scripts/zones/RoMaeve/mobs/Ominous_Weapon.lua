-----------------------------------
-- Area: RoMaeve
--  Mob: Ominous Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 119, 2, tpz.regime.type.FIELDS)
end

return entity
