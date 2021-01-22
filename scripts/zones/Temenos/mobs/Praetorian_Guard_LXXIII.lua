-----------------------------------
-- Area: Temenos N T
--  Mob: Praetorian Guard LXXIII
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/limbus")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetMobByID(ID.mob.TEMENOS_N_MOB[5]):isDead() and GetMobByID(ID.mob.TEMENOS_N_MOB[5]+2):isDead() and
            GetMobByID(ID.mob.TEMENOS_N_MOB[5]+3):isDead()
        then
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[5]):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[5]+1):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[5]+2):setStatus(tpz.status.NORMAL)
        end
        if GetNPCByID(ID.npc.TEMENOS_N_GATE[5]):getAnimation() == tpz.animation.CLOSE_DOOR then
            tpz.limbus.handleDoors(mob:getBattlefield(), true, ID.npc.TEMENOS_N_GATE[5])
        end
    end
end

return entity
