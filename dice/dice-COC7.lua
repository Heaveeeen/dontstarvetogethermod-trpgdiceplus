modimport("dice/dicecore.lua")

local DEFAULT_DICE = "1D100"

local roomrule = GetModConfigData("COC_SUB_RULE")
local displaycmd = GetModConfigData("DISPLAY_COMMAND")

local status = {}

local defaultStatus = {}
defaultStatus["会计"] = 5
defaultStatus["人类学"] = 1
defaultStatus["估价"] = 5
defaultStatus["考古学"] = 1
defaultStatus["取悦"] = 15
defaultStatus["攀爬"] = 20
defaultStatus["计算机使用"] = 5
defaultStatus["乔装"] = 5
defaultStatus["汽车驾驶"] = 20
defaultStatus["电气维修"] = 10
defaultStatus["电子学"] = 1
defaultStatus["话术"] = 5
defaultStatus["斗殴"] = 25
defaultStatus["手枪"] = 20
defaultStatus["急救"] = 30
defaultStatus["历史"] = 5
defaultStatus["恐吓"] = 15
defaultStatus["跳跃"] = 20
defaultStatus["法律"] = 5
defaultStatus["图书馆使用"] = 20
defaultStatus["聆听"] = 20
defaultStatus["锁匠"] = 1
defaultStatus["机械维修"] = 10
defaultStatus["医学"] = 1
defaultStatus["博物学"] = 10
defaultStatus["领航"] = 10
defaultStatus["神秘学"] = 5
defaultStatus["操作重型机械"] = 1
defaultStatus["说服"] = 10
defaultStatus["驾驶"] = 1
defaultStatus["精神分析"] = 1
defaultStatus["心理学"] = 10
defaultStatus["骑术"] = 5
defaultStatus["妙手"] = 10
defaultStatus["侦查"] = 25
defaultStatus["潜行"] = 20
defaultStatus["生存"] = 10
defaultStatus["游泳"] = 20
defaultStatus["投掷"] = 20
defaultStatus["追踪"] = 10
defaultStatus["驯兽"] = 5
defaultStatus["潜水"] = 1
defaultStatus["爆破"] = 1
defaultStatus["读唇"] = 1
defaultStatus["催眠"] = 1
defaultStatus["炮术"] = 1

local statueAlias =
{   --别名表中的第一项视为标准名，建议不要随意更改第一项
    --此表也可以用于本地化
    { "str", "力量", },
    { "con", "体质", },
    { "siz", "体型", },
    { "dex", "敏捷", },
    { "app", "外貌", },
    { "int", "智力", "灵感" },
    { "pow", "意志", },
    { "edu", "教育", },
    { "san", "san值", "理智", "理智值", },
    { "幸运", "运气", },
    { "mp", "魔法", "魔法值", },
    { "hp", "体力", "体力值" },
    { "取悦", "魅惑", },
    { "计算机使用", "计算机", "电脑", },
    { "信用评级", "信誉", "信用", },
    { "克苏鲁神话", "克苏鲁", "cm", },
    { "汽车驾驶", "汽车", },
    { "图书馆使用", "图书馆", },
    { "锁匠", "开锁", "撬锁", },
    { "博物学", "自然学", },
    { "领航", "导航", },
    { "操作重型机械", "重型机械", "重型操作", "重型", },
    { "侦查", "侦察", },
}

GLOBAL.setmetatable(status, {
    __index = function( t, k )
        local dk = Dealias(k)
        if t[dk] then
            return t[dk]
        else
            return defaultStatus[dk] or 0
        end
    end,

    __newindex = function( t, k, v )
        t[Dealias(k)] = v
    end,
})

local function Dealias( name )
    for i,x in ipairs(statueAlias) do
        for j,y in ipairs(x) do
            if y == name then
                return x[1]
            end
        end
    end
    return name
end

local function GetCharLang( name )
    return name and COC_DICE_LANG[string.upper(name)] or COC_DICE_LANG.DEFAULT
end

local function GetRString( charName, arg1, arg2 )
    local charlang = GetCharLang(charName)

    if not (arg1 or arg2) then
        return GetRString(charName, DEFAULT_DICE)  --/r <==> /r 1D100
    elseif arg1 and arg2 then
        local exp,arg = nil,nil
        if ParseDiceExp(arg1) then
            exp = arg1
            name = arg2
        elseif ParseDiceExp(arg2) then
            exp = arg2
            name = arg1
        else
            return GetRString(charName, DEFAULT_DICE, arg1 .. "-" .. arg2)  --/r 心理 学 <==> /r 心理-学
        end
        return GLOBAL.subfmt(charlang.NR, {
                R_NAME = name,
                EXP = string.format("%s=%d", exp, ParseDiceExp(exp)),
            })  --/r 1D100 心理学
    else
        local temp = arg1 or arg2
        if ParseDiceExp(temp) then
            return GLOBAL.subfmt(charlang.R, {
                EXP = string.format("%s=%d", temp, ParseDiceExp(temp)),
            })  --/r 1D100
        else
            return GetRString(charName, DEFAULT_DICE, temp)  --/r 心理学 <==> /r 1D100 心理学
        end
    end
end

local function GetRaString( charName, arg1, arg2, arg3 )
    local charlang = GetCharLang(charName)
    local stvalue = value or (name and status[name] or 0)
    local bonus = bp > 0
    local exDiceAmt = GLOBAL.math.abs(bp)

    local dice = roll(1, 10)
    local diceB = {}
    for i=1,exDiceAmt+1 do
        diceB[i] = roll(1, 10)
    end

    local function d100(a, b)
        if a == 0 and b == 0 then
            return 100
        else
            return a + b * 10
        end
    end

    local res1 = d100(dice, diceB[exDiceAmt+1])
    local res2 = res1

    local exDiceStr = ""
    if exDiceAmt > 0 then
        local exDiceStr = GLOBAL.tostring(diceB[1])
        for i=2,exDiceAmt do
            exDiceStr = exDiceStr .. ", " .. GLOBAL.tostring()
        end

        local m = diceB[exDiceAmt+1]
        if bonus then
            for i=1,exDiceAmt do
                m = d100(dice, m) < d100(dice, diceB[i]) and m or diceB[i]
            end
            res2 = d100(dice, m)
            exDiceStr = string.format("[%s%s]=%d", COC_DICE_LANG._.BONUS_DICE, exDiceStr, res2)
        else
            for i=1,exDiceAmt do
                m = d100(dice, m) > d100(dice, diceB[i]) and m or diceB[i]
            end
            res2 = d100(dice, m)
            exDiceStr = string.format("[%s%s]=%d", COC_DICE_LANG._.PENALTY_DICE, exDiceStr, res2)
        end
    end

    local function CriOrFum(roomrule, r, s)
        if roomrule == 3 then
            if r < 6 then
                return 6  --大成功
            elseif r > 95 then
                return 1 --大失败
            else
                return false
            end
        else --if roomrule == 0 then
            if r == 1 then
                return 6  --大成功
            elseif s < 50 and r > 95 then
                return 1  --大失败（不满50）
            elseif s >= 50 and r == 100 then
                return 1  --大失败（满50）
            else
                return false
            end
        end
    end

    local function OtherRes(r, s)
        if r > s then
            return 2  --失败
        elseif r > GLOBAL.math.floor(s/2) then
            return 3  --常规成功
        elseif r > GLOBAL.math.floor(s/5) then
            return 4  --困难成功
        else
            return 5  --极难成功
        end
    end

    local rares = CriOrFum(roomrule, res2, stvalue) or OtherRes(res2, stvalue)

    return name and GLOBAL.subfmt(charlang.NRA, {
        RA_NAME = name,
        EXP = string.format("%s=%d%s/%d", DEFAULT_DICE, res1, exDiceStr, stvalue),
        RA_RES = charlang.RA_RES[rares],
    }) or GLOBAL.subfmt(charlang.RA, {
        EXP = string.format("%s=%d%s/%d", DEFAULT_DICE, res1, exDiceStr, stvalue),
        RA_RES = charlang.RA_RES[rares],
    })
end



GLOBAL.AddModUserCommand("r", "r", {
    prettyname = nil,
    desc = nil,
    permission = GLOBAL.COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = { "arg1", "arg2" },
    paramsoptional = { true, true },
    vote = false,
    localfn = function(params, caller)
        if displaycmd then
            GLOBAL.TheNet:Say("(/r"..
                (params.arg1 and " " .. params.arg1 or "") ..
                (params.arg2 and " " .. params.arg2 or "") .. ")\238\132\130" ..
                GetRString(caller.prefab, params.arg1, params.arg2)
            )
        else
            GLOBAL.TheNet:Say(GetRString(caller.prefab, params.arg1, params.arg2))
        end
    end,
})