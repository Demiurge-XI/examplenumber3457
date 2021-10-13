-----------------------------------
-- Amber Scutum
-- Family: Wamouracampa
-- Description: Increases defense.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local status = mob:getStatusEffect(xi.effect.DEFENSE_BOOST)
    local power = 100
    if status ~= nil then
        -- This is as accurate as we get until effects applied by mob moves can use subpower..
        power = status:getPower() * 2
    end

    skill:setMsg(MobBuffMove(mob, xi.effect.DEFENSE_BOOST, power, 0, 60))

    return xi.effect.DEFENSE_BOOST
end

return mobskill_object
