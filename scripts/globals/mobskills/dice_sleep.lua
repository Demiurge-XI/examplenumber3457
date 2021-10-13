-----------------------------------
-- Goblin Dice
--
-- Description: Sleep
-- Type: Physical (Blunt)
--
--
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SLEEP_I

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 30))
    return typeEffect
end

return mobskill_object
