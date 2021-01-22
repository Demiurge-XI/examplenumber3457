-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Namtar
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 369)
    tpz.regime.checkRegime(player, mob, 805, 2, tpz.regime.type.GROUNDS)
end

return entity
