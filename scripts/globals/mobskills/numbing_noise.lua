-----------------------------------
-- Numbing Noise
--
-- Description: Creates an unsettling sound. Additional effect: Stun
-- Type: Physical
-- Utsusemi/Blink absorb: Ignore
-- Range: 10' cone
-- Notes:
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
    local typeEffect = xi.effect.STUN

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 5))

    return typeEffect
end

return mobskill_object
