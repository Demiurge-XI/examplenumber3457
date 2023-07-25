------------------------------------
-- Mog Bonanza
-- http://www.playonline.com/ff11us/guide/nomadmogbon/index.html
-- https://www.bg-wiki.com/ffxi/Category:Mog_Bonanza
------------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/zone')
------------------------------------
xi = xi or {}
xi.events = xi.events or {}
xi.events.mogBonanza = xi.events.mogBonanza or {}
xi.events.mogBonanza.data = xi.events.mogBonanza.data or {}
xi.events.mogBonanza.entities = xi.events.mogBonanza.entities or {}

local localSettings =
{
    PEARL_COST = 200000,
    MAX_PEARLS = 1,

    -- 0x55: New Year's Nomad Mog Bonanza 2021
    -- 0x5A: 20th Vana'versary Nomad Mog Bonanza
    -- 0x5C: 21st Vana'versary Nomad Mog Bonanza
    -- 0x5E: <number>
    EVENT = 0x5E,

    COLLECTION_SERVER_MESSAGE =
        'Announcing the winning numbers for the 21st Vana\'versary Nomad Mog Bonanza!\n' ..
        '\n' ..
        'Rank 3 prize: "7" (last digit)-- 13,298 winners.\n' ..
        'Rank 2 prize: "71" (last two digits)-- 1,299 winners.\n' ..
        'Rank 1 prize: "800" (all three digits)-- 62 winners.\n' ..
        '*The number of winners for each prize is a combined total from all worlds.\n' ..
        '\n' ..
        'Collection period: On July 11, 2023 at 1:00 (PDT) / 8:00 (GMT) to July 31, at 7:59 (PDT) / 14:59 (GMT)\n' ..
        'Details on the prize can be confirmed by speaking to a Bonanza Moogle at one of the following locations:\n' ..
        'Port San d\'Oria (I-9) / Port Bastok (L-8) / Port Windurst (F-6) / Chocobo Circuit (H-8)\n',

    -- When WINNING_NUMBER is nil, false, or anything that isn't a type() == 'number', the whole system will be in
    -- the buying period. Once WINNING_NUMBER is set, everything will be in the collection period until the event ends.
    WINNING_NUMBER = nil,
}

local event = SeasonalEvent:new('MogBonanza')

-- Start Date (Buying Period)
-- Prize Collection Period
-- End Date
xi.events.mogBonanza.enabledCheck = function()
    return true
end

event:setEnableCheck(xi.events.mogBonanza.enabledCheck)

local csidLookup =
{
    [xi.zone.PORT_SAN_DORIA] =
    {
        baseCs = 824,
    },
    [xi.zone.PORT_BASTOK] =
    {
        baseCs = 467,
    },
    [xi.zone.PORT_WINDURST] =
    {
        baseCs = 912,
    },
    [xi.zone.CHOCOBO_CIRCUIT] =
    {
        baseCs = 503,
    },
}

-- NOTE: Each Reward Rank can support up to 46 items along with a gil reward.  This is bit-packed
-- where param0 in the event update is the gil reward, and each following parameter contains two items
-- (upper and lower 16 bits).  There are 3 event update requests per rank.  Any 0-value parameter
-- will stop the event from processing further values.
local rewardList =
{
    -- Rank 1 Prizes
    [1] =
    {
        gilReward = 0,

        rewardItems =
        {
            [ 0] = xi.items.ICE_BRAND,
            [ 1] = xi.items.ONION_SWORD_III,
            [ 2] = xi.items.AIR_KNIFE,
            [ 3] = xi.items.ZANMATO_P2,
            [ 4] = xi.items.DRAGON_FANGS,
            [ 5] = xi.items.MALEFIC_AXE,
            [ 6] = xi.items.DRASTIC_AXE,
            [ 7] = xi.items.ARTEMISS_BOW_P2,
            [ 8] = xi.items.MIRACLE_CHEER,
            [ 9] = xi.items.FINAL_SICKLE,
            [10] = xi.items.PANDITS_STAFF,
            [11] = xi.items.CHOCOBO_KNIFE,
            [12] = xi.items.DIAMOND_ASPIS,
            [13] = xi.items.FLAMETONGUE,
            [14] = xi.items.MUTSU_NO_KAMI_YOSHIYUKI,
            [15] = xi.items.HEBOS_SPEAR,
            [16] = xi.items.PREMIUM_HEART,
            [17] = xi.items.SAVE_THE_QUEEN_III,
            [18] = xi.items.YAGYU_DARKBLADE,
            [19] = xi.items.BRAVE_BLADE_III,
            [20] = xi.items.WIZARDS_ROD,
            [21] = xi.items.EXETER,
            [22] = xi.items.COPY_OF_JUDGMENT_DAY,
            [23] = xi.items.EBISU_FISHING_ROD,
            [24] = xi.items.MOG_KUPON_AW_KUPO,
            [25] = xi.items.ABDHALJS_TOME,
        },
    },

    -- Rank 2 Prizes
    [2] =
    {
        gilReward = 0,

        rewardItems =
        {
            [ 0] = xi.items.MOG_KUPON_A_OMII,
            [ 1] = xi.items.MOG_KUPON_AW_UWIII,
            [ 2] = xi.items.MOG_KUPON_I_AF119,
            [ 3] = xi.items.MOG_KUPON_AW_VGR,
            [ 4] = xi.items.MOG_KUPON_I_RME,
            [ 5] = xi.items.MOG_KUPON_W_PULSE,
            [ 6] = xi.items.MOG_KUPON_AW_VGRII,
            [ 7] = xi.items.MOG_KUPON_W_JOB,
            [ 8] = xi.items.MOG_KUPON_A_DEII,
            [ 9] = xi.items.MOG_KUPON_W_DEIII,
            [10] = xi.items.WAILING_BELT,
            [11] = xi.items.SHAPERS_SHAWL,
            [12] = xi.items.TEN_THOUSAND_BYNE_BILL,
            [13] = xi.items.RANPERRE_GOLDPIECE,
            [14] = xi.items.RIMILALA_STRIPESHELL,
            [15] = xi.items.BAYLD_CRYSTAL,
            [16] = xi.items.DENSE_CLUSTER,
            [17] = xi.items.CATS_EYE,
            [18] = xi.items.MOG_KUPON_AW_GFIII,
            [19] = xi.items.LU_SHANGS_FISHING_ROD,
        },
    },

    -- Rank 3 Prizes
    [3] =
    {
        gilReward = 0,

        rewardItems =
        {
            [ 0] = xi.items.MOG_KUPON_AW_UW,
            [ 1] = xi.items.MOG_KUPON_AW_COS,
            [ 2] = xi.items.AUCUBA_CROWN,
            [ 3] = xi.items.CURMUDGEONS_HELMET,
            [ 4] = xi.items.GAZERS_HELMET,
            [ 5] = xi.items.RETCHING_HELMET,
            [ 6] = xi.items.KARAKUL_CAP,
            [ 7] = xi.items.HOTENGEKI,
            [ 8] = xi.items.GRUDGE,
            [ 9] = xi.items.PLUTON_COFFER,
            [10] = xi.items.BEITETSU_COFFER,
            [11] = xi.items.RIFT_BOULDER_COFFER,
            [12] = xi.items.MARBLE_MOG_PELL,
            [13] = xi.items.OCHRE_MOG_PELL,
            [14] = xi.items.MARS_ORB,
            [15] = xi.items.CHOCOBO_ROPE,
            [16] = xi.items.CHOCOBO_TORQUE,
            [17] = xi.items.MOG_KUPON_A_SAP,
            [18] = xi.items.MOG_KUPON_A_JAD,
            [19] = xi.items.MOG_KUPON_A_RUB,
            [20] = xi.items.DEMONIC_AXE,
            [21] = xi.items.BRAVE_BLADE_II,
            [22] = xi.items.ONION_SWORD_II,
            [23] = xi.items.MOG_KUPON_I_ORCHE,
            [24] = xi.items.SHEET_OF_PROMATHIAN_TUNES,
            [25] = xi.items.SHEET_OF_ADOULINIAN_TUNES,
        },
    },
}

-- NOTE: The observed offset indices are 0, 1, and 4 for event updates.  All events seem to be heavily
-- reliant on base 2; however, there is no use of bit1 (2 value).  The below function implements the above
-- logic, but there may be something else that was deprecated in the past.
local function getRewardEventUpdate(option)
    local prizeRank    = bit.rshift(option, 8) + 1
    local updateOffset = math.min(bit.band(option, 0xF), 2)
    local maxItems     = updateOffset == 0 and 13 or 15
    local startIndex   = updateOffset * 14
    local updateTable  = { 0, 0, 0, 0, 0, 0, 0, 0 }

    if updateOffset == 0 then
        updateTable[0] = rewardList[prizeRank].gilReward
    end

    local updateParameter = 0
    for indexVal = startIndex, startIndex + maxItems do
        local updateIndex = math.floor((indexVal - startIndex) / 2) + 1
        if updateOffset == 0 then
            updateIndex = updateIndex + 1
        end

        if not rewardList[prizeRank].rewardItems[indexVal] then
            if updateParameter > 0 then
                updateTable[updateIndex] = updateParameter
            end

            break
        end

        if updateParameter > 0 then
            updateParameter = updateParameter + bit.lshift(rewardList[prizeRank].rewardItems[indexVal], 16)
            updateTable[updateIndex] = updateParameter
            updateParameter = 0
        else
            updateParameter = rewardList[prizeRank].rewardItems[indexVal]
        end
    end

    return updateTable
end

--[[
    Will return the rank of the prize given winningNumber and guessNumber.
    1: 3 matching numbers
    2: 2 matchiung numbers
    3: 1 matching number
    4: 0 matching numbers

    Tested:
    print('Prize', getPrizeRank(123, 123))
    print('Prize', getPrizeRank(123, 124))
    print('Prize', getPrizeRank(123, 234))
    print('Prize', getPrizeRank(123, 199))
    print('Prize', getPrizeRank(123, 919))
    print('Prize', getPrizeRank(123, 991))
    print('Prize', getPrizeRank(123, 999))
    print('Prize', getPrizeRank(nil, nil))
    print('Prize', getPrizeRank(1, 1))

    Prize 1
    Prize 2
    Prize 2
    Prize 3
    Prize 3
    Prize 3
    Prize 4
    Prize 4
    Prize 4
]]--
local getPrizeRank = function(player, winningNumber, guessNumber)
    local winningNumberStr = tostring(winningNumber)
    local guessNumberStr   = tostring(guessNumber)

    -- TODO: guessNumber has to be zero padded on the left once it's a string

    if
        type(winningNumber) ~= 'number' or
        type(guessNumber) ~= 'number' or
        #winningNumberStr ~= #guessNumberStr or
        #winningNumberStr ~= 3 or
        #guessNumberStr ~= 3
    then
        print(string.format('getPrizeRank: %s tried to get prize rank with invalid number: %d', player:getName(), tonumber(guessNumber)))
        return 4
    end

    -- This assumes the strings are the same length, and that the length arg is less than their length
    -- TODO: Refactor to be baseStr and guessStr, and do 2 passes:
    local getMatchOfLength = function(str1, str2, length)
        local strLength = #str1
        for strIdx1 = 1, strLength - length + 1 do
            for strIdx2 = 1, strLength - length + 1 do
                local part1 = string.sub(str1, strIdx1, strIdx1 + length - 1)
                local part2 = string.sub(str2, strIdx2, strIdx2 + length - 1)
                if
                    #part1 == length and
                    #part2 == length and
                    part1 == part2
                then
                    return true
                end
            end
        end
        return false
    end

    -- Rank 1
    if getMatchOfLength(winningNumberStr, guessNumberStr, 3) then
        return 1
    end

    -- Rank 2
    if getMatchOfLength(winningNumberStr, guessNumberStr, 2) then
        return 2
    end

    -- Rank 3
    if getMatchOfLength(winningNumberStr, guessNumberStr, 1) then
        return 3
    end

    -- Rank 4
    return 4
end

local giveBonanzaPearl = function(player, number)
    -- MAX: 16777215
    number = tonumber(number)
    if
        number == nil or
        number > 16777215 or
        number < 0
    then
        print(string.format('giveBonanzaPearl: %s tried to create a pear with invalid number: %d', player:getName(), number))
        return nil
    end

    player:addItem({ id = xi.items.BONANZA_PEARL,
        exdata = {
            [0] = bit.band(number, 0xFF),
            [1] = bit.band(bit.rshift(number,  8), 0xFF),
            [2] = bit.band(bit.rshift(number, 16), 0xFF),
            [3] = bit.band(localSettings.EVENT, 0xFF),
            [4] = 0, -- 0xCE, -- These might not be needed
            [5] = 0, -- 0x62, -- These might not be needed
            [6] = 0, -- 0x95, -- These might not be needed
            [7] = 0, -- 0x23, -- These might not be needed
        }
    })
end

local isInPurchasingPeriod = function()
    return xi.events.mogBonanza.enabledCheck() and type(localSettings.WINNING_NUMBER) ~= 'number'
end

local isInCollectionPeriod = function()
    return xi.events.mogBonanza.enabledCheck() and type(localSettings.WINNING_NUMBER) == 'number'
end

xi.events.mogBonanza.onBonanzaMoogleTrade = function(player, npc, trade)

    -- TODO: Empty?

    if not xi.events.mogBonanza.enabledCheck() then
        return
    end
end

xi.events.mogBonanza.onBonanzaMoogleTrigger = function(player, npc)

    if not xi.events.mogBonanza.enabledCheck() then
        return
    end

    local baseCs = csidLookup[player:getZoneID()].baseCs

    local disablePrimevalBrew = 1

    -- Args 5,6,7 might be garbage
    --player:startEvent(912, 1, disablePrimevalBrew, 0, 0, 67108863, 148230686, 4095, 3)

    -- 912: Buying phase
    -- 913: Priza phase

    -- 914: What is this?

    player:startEvent(baseCs, 397, 79, 1, 0, 65830911, 2632028, 4095, 131096)
end

xi.events.mogBonanza.onBonanzaMoogleEventUpdate = function(player, csid, option, npc)

    if not xi.events.mogBonanza.enabledCheck() then
        return
    end

    local baseCs = csidLookup[player:getZoneID()].baseCs

    -- option: 62722
    -- option: 771
    -- option: 44034

    if csid == baseCs + 1 then
        player:updateEvent(unpack(getRewardEventUpdate(option)))

    -- Purchase
    elseif csid == baseCs and option == 44290 then
        player:updateEvent(459877491, 137258278, 0, 0, 35929248, 54166282, 4095, 0)

    else
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    end
end

xi.events.mogBonanza.onBonanzaMoogleEventFinish = function(player, csid, option, npc)

    if not xi.events.mogBonanza.enabledCheck() then
        return
    end

    local baseCs = csidLookup[player:getZoneID()].baseCs

    -- Give Pearl
    if csid == baseCs and option == 3 then
        -- Already have a pearl
    elseif csid == baseCs and option == 771 then
        -- TODO
    end
end

event:setStartFunction(function()
    -- TODO: Show/Hide Bonanza Moogles
    -- TODO: Append onto xi.settings.main.SERVER_MESSAGE
end)

event:setEndFunction(function()
    -- TODO: Show/Hide Bonanza Moogles
end)

return event
