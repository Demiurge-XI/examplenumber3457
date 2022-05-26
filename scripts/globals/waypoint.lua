-----------------------------------
-- Waypoint Teleporters
-- https://www.bg-wiki.com/ffxi/Waypoint
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
xi = xi or {}
xi.waypoint = xi.waypoint or {}

local waypointStartIndex =
{
    [xi.zone.WESTERN_ADOULIN      ] = 0,
    [xi.zone.EASTERN_ADOULIN      ] = 20,
    [xi.zone.YAHSE_HUNTING_GROUNDS] = 30,
    [xi.zone.CEIZAK_BATTLEGROUNDS ] = 40,
    [xi.zone.FORET_DE_HENNETIEL   ] = 50,
    [xi.zone.MORIMAR_BASALT_FIELDS] = 60,
    [xi.zone.YORCIA_WEALD         ] = 70,
    [xi.zone.MARJAMI_RAVINE       ] = 80,
    [xi.zone.KAMIHR_DRIFTS        ] = 90,
    [xi.zone.LOWER_JEUNO          ] = 100,
}

-- Table Format: Index = { Offset, GroupID, EventID, { Teleport Position } }
-- Note: Group ID is unused at this time, but can be observed in the eventUpdate option.  This remains
-- in case it is needed for future implementations
local waypointInfo =
{
    -- Western Adoulin
    [1] = { 0, 1, 5000, {   4.896,     0,   -4.789,  33, xi.zone.WESTERN_ADOULIN } }, -- Platea Triumphus
    [2] = { 1, 1, 5001, {  -110.5,  3.85,  -13.482, 191, xi.zone.WESTERN_ADOULIN } }, -- Pioneer's Coalition
    [3] = { 2, 1, 5002, { -20.982, -0.15,  -79.891, 127, xi.zone.WESTERN_ADOULIN } }, -- Mummer's Coalition
    [4] = { 3, 1, 5003, {  91.451, -0.15,  -49.013,   0, xi.zone.WESTERN_ADOULIN } }, -- Inventor's Coalition
    [5] = { 4, 1, 5004, { -68.099,     4,  -73.672,  28, xi.zone.WESTERN_ADOULIN } }, -- Auction House
    [6] = { 5, 1, 5005, {   5.731,     0, -123.043, 127, xi.zone.WESTERN_ADOULIN } }, -- Rent-a-Room
    [7] = { 6, 1, 5006, { 174.783,  3.85,  -35.788,  63, xi.zone.WESTERN_ADOULIN } }, -- Big Bridge
    [8] = { 7, 1, 5007, {  14.586,     0,  162.608, 191, xi.zone.WESTERN_ADOULIN } }, -- Airship Docks
    [9] = { 8, 1, 5008, {  51.094,    32,  126.299, 191, xi.zone.WESTERN_ADOULIN } }, -- Adoulin Waterfront

    -- Eastern Adoulin
    [21] = { 15, 2, 5000, { -101.274,  -0.15, -10.726, 191, xi.zone.EASTERN_ADOULIN } }, -- Peacekeeper's Coalition
    [22] = { 16, 2, 5001, {  -77,944,  -0.15, -63.926,   0, xi.zone.EASTERN_ADOULIN } }, -- Scout's Coalition
    [23] = { 17, 2, 5002, {  -46.838, -0.075, -12.767,  63, xi.zone.EASTERN_ADOULIN } }, -- Statue of the Goddess
    [24] = { 18, 2, 5003, {  -57.773,  -0.15,  85.237, 127, xi.zone.EASTERN_ADOULIN } }, -- Yahse Wharf
    [25] = { 19, 2, 5004, {  -61.865,  -0.15, -120.81, 127, xi.zone.EASTERN_ADOULIN } }, -- Rent-a-Room
    [26] = { 20, 2, 5005, {  -42.065,  -0.15, -89.979, 191, xi.zone.EASTERN_ADOULIN } }, -- Auction House
    [27] = { 21, 2, 5006, {   11.681, -22.15,  29.976, 127, xi.zone.EASTERN_ADOULIN } }, -- Sverdhried Hillock
    [28] = { 22, 2, 5007, {   27.124, -40.15, -60.844, 127, xi.zone.EASTERN_ADOULIN } }, -- Coronal Esplanade
    [29] = { 23, 2, 5008, {   95.994, -40.15, -74.541,   0, xi.zone.EASTERN_ADOULIN } }, -- Castle Gates

    -- Yahse Hunting Grounds
    [31] = { 38, 4, 5000, {    321, 0, -199.8, 127, xi.zone.YAHSE_HUNTING_GROUNDS } }, -- Frontier Station
    [32] = { 39, 4, 5001, {   86.5, 0,    1.5,   0, xi.zone.YAHSE_HUNTING_GROUNDS } }, -- Bivouac #1
    [33] = { 40, 4, 5002, { -286.5, 0,   43.5, 127, xi.zone.YAHSE_HUNTING_GROUNDS } }, -- Bivouac #2
    [34] = { 41, 4, 5003, { -162.4, 0, -272.8, 191, xi.zone.YAHSE_HUNTING_GROUNDS } }, -- Bivouac #3

    -- Ceizak Battlegrounds
    [41] = { 32, 3, 5000, {    365, 0.448,      190, 128, xi.zone.CEIZAK_BATTLEGROUNDS } }, -- Frontier Station
    [42] = { 33, 3, 5001, { -6.879,     0, -117.511,  63, xi.zone.CEIZAK_BATTLEGROUNDS } }, -- Bivouac #1
    [43] = { 34, 3, 5002, {    -42,     0,      155, 191, xi.zone.CEIZAK_BATTLEGROUNDS } }, -- Bivouac #2
    [44] = { 35, 3, 5003, {   -442,     0,     -247, 191, xi.zone.CEIZAK_BATTLEGROUNDS } }, -- Bivouac #3

    -- Foret de Hennetiel
    [51] = { 64, 5, 5000, { 398.11,    -2, 279.11,   0, xi.zone.FORET_DE_HENNETIEL } }, -- Frontier Station
    [52] = { 65, 5, 5001, {   12.6,  -2.4,    342,   0, xi.zone.FORET_DE_HENNETIEL } }, -- Bivouac #1
    [53] = { 66, 5, 5002, {    505, -2.25, -303.5, 127, xi.zone.FORET_DE_HENNETIEL } }, -- Bivouac #2
    [54] = { 67, 5, 5003, {    103,  -2.2,  -92.3,  63, xi.zone.FORET_DE_HENNETIEL } }, -- Bivouac #3
    [55] = { 68, 5, 5004, { -251.8, -2.37, -39.25,  63, xi.zone.FORET_DE_HENNETIEL } }, -- Bivouac #4

    -- Morimar Basalt Fields
    [61] = { 70, 6, 5000, { 443.728,     -16, -325.428, 191, xi.zone.MORIMAR_BASALT_FIELDS } }, -- Frontier Station
    [62] = { 71, 6, 5001, {     368,     -16,     37.5, 127, xi.zone.MORIMAR_BASALT_FIELDS } }, -- Bivouac #1
    [63] = { 72, 6, 5002, {   112.8,  -0.483,    324.4,  63, xi.zone.MORIMAR_BASALT_FIELDS } }, -- Bivouac #2
    [64] = { 73, 6, 5003, {   175.5, -15.581,   -318.2, 127, xi.zone.MORIMAR_BASALT_FIELDS } }, -- Bivouac #3
    [65] = { 74, 6, 5004, {    -323,     -32,        2,  63, xi.zone.MORIMAR_BASALT_FIELDS } }, -- Bivouac #4
    [66] = { 75, 6, 5005, {   -78.2, -47.284,      303, 191, xi.zone.MORIMAR_BASALT_FIELDS } }, -- Bivouac #5

    -- Yorcia Weald
    [71] = { 96, 7, 5000, {    353.3,   0.2,    153.3, 223, xi.zone.YORCIA_WEALD } }, -- Frontier Station
    [72] = { 97, 7, 5001, {    -40.5, 0.367,  296.367,   0, xi.zone.YORCIA_WEALD } }, -- Bivouac #1
    [73] = { 98, 7, 5002, {  122.132, 0.146, -287.731, 127, xi.zone.YORCIA_WEALD } }, -- Bivouac #2
    [74] = { 99, 7, 5003, { -274.776, 0.357,  85.376,  127, xi.zone.YORCIA_WEALD } }, -- Bivouac #3

    -- Marjami Ravine
    [81] = { 102, 8, 5000, {      358,     -60,      165,  63, xi.zone.MARJAMI_RAVINE } }, -- Frontier Station
    [82] = { 103, 8, 5001, {      323,     -20,      -79,   0, xi.zone.MARJAMI_RAVINE } }, -- Bivouac #1
    [83] = { 104, 8, 5002, {    6.808,       0,   78.437, 191, xi.zone.MARJAMI_RAVINE } }, -- Bivouac #2
    [84] = { 105, 8, 5003, { -318.708,     -20, -127.275,  63, xi.zone.MARJAMI_RAVINE } }, -- Bivouac #3
    [85] = { 106, 8, 5004, { -326.022, -40.023,  201.096, 191, xi.zone.MARJAMI_RAVINE } }, -- Bivouac #4

    -- Kamihr Drifts
    [91] = { 134, 9, 5000, {  439.403,    63, -272.554,  63, xi.zone.KAMIHR_DRIFTS } }, -- Frontier Station
    [92] = { 135, 9, 5001, {  -42.574,    43,  -71.319,   0, xi.zone.KAMIHR_DRIFTS } }, -- Bivouac #1
    [93] = { 136, 9, 5002, {     8.24,    43, -283.017, 191, xi.zone.KAMIHR_DRIFTS } }, -- Bivouac #2
    [94] = { 137, 9, 5003, {     9.24,    23,  162.803,  63, xi.zone.KAMIHR_DRIFTS } }, -- Bivouac #3
    [95] = { 138, 9, 5004, { -228.942, 3.567,  364.512, 127, xi.zone.KAMIHR_DRIFTS } }, -- Bivouac #4

    -- Jeuno

    -- Enigmatic Devices

    -- Runes
}

local runeKeyItems =
{
    xi.ki.SAN_DORIA_WARP_RUNE,
    xi.ki.BASTOK_WARP_RUNE,
    xi.ki.WINDURST_WARP_RUNE,
    xi.ki.SELBINA_WARP_RUNE,
    xi.ki.MHAURA_WARP_RUNE,
    xi.ki.KAZHAM_WARP_RUNE,
    xi.ki.RABAO_WARP_RUNE,
    xi.ki.NORG_WARP_RUNE,
    xi.ki.TAVNAZIA_WARP_RUNE,
    xi.ki.WHITEGATE_WARP_RUNE,
    xi.ki.NASHMAU_WARP_RUNE,
}

-- Number of Kinetic Units granted for each item trade.
-- TODO: Add support for HQ Crystals
local crystalTradeValues =
{
    [xi.items.EARTH_CRYSTAL    ] = 15,
    [xi.items.FIRE_CRYSTAL     ] = 15,
    [xi.items.WATER_CRYSTAL    ] = 15,
    [xi.items.WIND_CRYSTAL     ] = 15,
    [xi.items.ICE_CRYSTAL      ] = 30,
    [xi.items.LIGHTNING_CRYSTAL] = 30,
    [xi.items.DARK_CRYSTAL     ] = 80,
    [xi.items.LIGHT_CRYSTAL    ] = 80,
    [xi.items.EARTH_CLUSTER    ] = 200,
    [xi.items.FIRE_CLUSTER     ] = 200,
    [xi.items.WATER_CLUSTER    ] = 200,
    [xi.items.WIND_CLUSTER     ] = 200,
    [xi.items.ICE_CLUSTER      ] = 400,
    [xi.items.LIGHTNING_CLUSTER] = 400,
    [xi.items.DARK_CLUSTER     ] = 1000,
    [xi.items.LIGHT_CLUSTER    ] = 1000,
}

local function getWaypointIndex(npcObj)
    local waypointNpcId = npcObj:getID()
    local zoneObject    = npcObj:getZone()
    local waypointList  = zoneObject:queryEntitiesByName('Waypoint') -- TODO: Fallback to Enigmatic devices if not found

    for indexVal, npcData in ipairs(waypointList) do
        if npcData:getID() == waypointNpcId then
            return waypointStartIndex[zoneObject:getID()] + indexVal
        end
    end

    return nil
end

local function getRuneMask(player)
    local resultMask = utils.MAX_UINT32

    for bitIndex, keyItem in ipairs(runeKeyItems) do
        if player:hasKeyItem(keyItem) then
            resultMask = utils.mask.setBit(resultMask, bitIndex, false)
        end
    end

    -- TODO: This seems to remain 0
    resultMask = utils.mask.setBit(resultMask, 0, false)

    return resultMask
end

-- The below functions are used by all Waypoint NPCs
xi.waypoint.onTrade = function(player, npc, trade)

end

xi.waypoint.onTrigger = function(player, npc)
    local waypointIndex     = getWaypointIndex(npc)

    if player:hasTeleport(xi.teleport.type.WAYPOINT, waypointInfo[waypointIndex][1]) then
        local unlockedWaypoints = player:getTeleportTable(xi.teleport.type.WAYPOINT)
        local discountParams    = 4 -- TODO: (nibble: Bit 2 here is discount, Bit 3 is accept/decline for simple/normal transport)

        -- Waypoint Event ID
        local eventId = waypointInfo[waypointIndex][3]

        -- First event parameters packs the player's kinetic units, two bits that determine teleportation cost,
        -- and the Index value of the waypoint (See: waypointInfo table)
        local p0 = bit.lshift(player:getCurrency('kinetic_unit'), 16) + bit.lshift(discountParams, 12) + waypointIndex

        -- Second event parameter packs an initial bit which could be related to having the charter permit,
        -- along with the unlocked geomagnetrons in Eastern and Western Adoulin
        local p1 = unlockedWaypoints[1]

        -- Third event parameter is an inverted bitfield for all but bit 0, the remainder of the field is set
        -- by the key items for warp runes.
        local p2 = getRuneMask(player)

        -- Unlock all non-city Waypoints
        local p3 = unlockedWaypoints[2]
        local p4 = unlockedWaypoints[3]
        local p5 = unlockedWaypoints[4]
        local p6 = unlockedWaypoints[5]

        player:startEvent(eventId, p0, p1, p2, p3, p4, p5, p6)
    else
        local zoneId = player:getZoneID()
        local ID = zones[zoneId]

        player:addTeleport(xi.teleport.type.WAYPOINT, waypointInfo[waypointIndex][1])
        player:messageSpecial(ID.text.GEOMAGNETRON_ATTUNED, waypointIndex - waypointStartIndex[zoneId], xi.ki.GEOMAGNETRON)
    end
end

-- Note: There is additional data packed into the event update option that is unused at this time (below):
-- currentWaypointIndex = bit.band(option, 0x7F)
-- destinationGroup     = bit.band(bit.rshift(option, 7), 0xF)
-- destinationOffset    = bit.band(bit.rshift(option, 11), 0xF)

xi.waypoint.onEventUpdate = function(player, csid, option, npc)
    local ID = zones[player:getZoneID()]
    local travelCost = bit.rshift(option, 21)

    if player:getCurrency('kinetic_unit') >= travelCost then
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 1)
        player:delCurrency('kinetic_unit', travelCost)
        player:messageSpecial(ID.text.EXPENDED_KINETIC_UNITS, travelCost)
    else
        player:messageSpecial(ID.text.INSUFFICIENT_UNITS)
    end
end

xi.waypoint.onEventFinish = function(player, csid, option, npc)
    if option > 0 and option <= 303 then
        player:setPos(unpack(waypointInfo[option][4]))
    end
end
