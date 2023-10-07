-----------------------------------
-- xi.effect.GESTATION
-- https://ffxiclopedia.fandom.com/wiki/Gestation
--
-- Effects
-- Gestation is a combination of the following:
-- - Completely undetectable, even to True Sight and True Hearing monsters
-- - Quickening
-- - Unable take any actions (attacks, spells, job abilities, etc.)
--
-- Duration
-- - Outside Belligerency: 18 hours
-- - During Belligerency: 1 minute
--
-- How to remove the effect
-- - Wait for the effect to wear off
-- - Remove manually
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
