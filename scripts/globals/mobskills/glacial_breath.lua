-----------------------------------
--  Glacial Breath
--
--  Description: Deals Ice damage to enemies within a fan-shaped area.
--  Type: Breath
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes: Used only by Jormungand and Isgebind
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/mobskills")
require("scripts/globals/utils")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) then
        return 1
    elseif not target:isInfront(mob, 128) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = MobBreathMove(mob, target, 0.2, 1.25, xi.magic.ele.ICE, 1400)
    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.9)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ICE)
    return dmg
end

return mobskill_object
