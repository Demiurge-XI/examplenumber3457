-----------------------------------
-- Area: Norg
--  NPC: Deigoff
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathNodes =
{
    { x = -15.048376, y = -1.476800, z = 30.425398 },
    { x = -15.526757, y = -1.225124, z = 29.480957 },
    { x = -14.723476, y = -1.423349, z = 30.104301 },
    { x = -13.893593, y = -1.648318, z = 30.828171 },
    { x = -12.975020, y = -1.871566, z = 31.517338 },
    { x = -12.044265, y = -2.053941, z = 31.966581 },
    { x = -11.003557, y = -2.393157, z = 32.302952 },
    { x = -9.985520, y = -2.708733, z = 32.557224 },
    { x = -8.916955, y = -3.017504, z = 32.716526 },
    { x = -7.803241, y = -3.231221, z = 32.842529 },
    { x = -6.703550, y = -3.548066, z = 32.933296 },
    { x = -2.621637, y = -4.728867, z = 33.234219 },
    { x = -3.692678, y = -4.392691, z = 33.156784 },
    { x = -4.784571, y = -4.086610, z = 33.078362 },
    { x = -7.672429, y = -3.273804, z = 32.870365 },
    { x = -8.728366, y = -3.020066, z = 32.775761 },
    { x = -9.767247, y = -2.778361, z = 32.601532 },
    { x = -10.786559, y = -2.469297, z = 32.379894 },
    { x = -11.791664, y = -2.154150, z = 32.110737 },
    { x = -12.739241, y = -1.916063, z = 31.632357 },
    { x = -13.613935, y = -1.713264, z = 31.018566 },
    { x = -14.453866, y = -1.501245, z = 30.353886 },
    { x = -15.187916, y = -1.273126, z = 29.586229 },
    { x = -15.810313, y = -1.031864, z = 28.727566 },
    { x = -16.338600, y = -0.821452, z = 27.804821 },
    { x = -16.721289, y = -0.631609, z = 26.800562 },
    { x = -17.015059, y = -0.430842, z = 25.772522 },
    { x = -17.276829, y = -0.226373, z = 24.724413 },
    { x = -17.057823, y = -0.418425, z = 25.708294 },
    { x = -16.776665, y = -0.621304, z = 26.739079 },
    { x = -16.362362, y = -0.804862, z = 27.727364 },
    { x = -15.858993, y = -1.014936, z = 28.676291 },
    { x = -15.207123, y = -1.261934, z = 29.550617 },
    { x = -14.408654, y = -1.502193, z = 30.350636 },
    { x = -13.596487, y = -1.725003, z = 31.070555 },
    { x = -12.709093, y = -1.926028, z = 31.662998 },
    { x = -11.711613, y = -2.167211, z = 32.087074 },
    { x = -10.711581, y = -2.485834, z = 32.386322 },
    { x = -9.675041, y = -2.801156, z = 32.616379 },
    { x = -8.606792, y = -3.039549, z = 32.759628 },
    { x = -7.521237, y = -3.312841, z = 32.868916 },
    { x = -6.463308, y = -3.617169, z = 32.952408 },
    { x = -2.352002, y = -4.875265, z = 33.252991 },
    { x = -3.373222, y = -4.489793, z = 33.181557 },
    { x = -8.309618, y = -3.099132, z = 32.823685 },
    { x = -9.346218, y = -2.897947, z = 32.683289 },
    { x = -10.356988, y = -2.596533, z = 32.481487 },
    { x = -11.362209, y = -2.289157, z = 32.248039 },
    { x = -12.344488, y = -1.993539, z = 31.858101 },
    { x = -13.248831, y = -1.799422, z = 31.288286 },
    { x = -14.096587, y = -1.592161, z = 30.646973 },
    { x = -14.883204, y = -1.374069, z = 29.931999 },
    { x = -15.547549, y = -1.137073, z = 29.104630 },
    { x = -16.128418, y = -0.943367, z = 28.213142 },
    { x = -16.578665, y = -0.713513, z = 27.230043 },
    { x = -16.879889, y = -0.529637, z = 26.273342 },
    { x = -17.146322, y = -0.330673, z = 25.258379 },
    { x = -17.403625, y = -0.115268, z = 24.211039 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(86)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
