-----------------------------------
-- Area: Dynamis - Windurst
--  Mob: Loo Hepe the Eyepiercer
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special"),
    require("scripts/mixins/remove_doom")
}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
