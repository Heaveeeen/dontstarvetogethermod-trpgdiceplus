modimport("dice/dice-NONE.lua")

local _G = GLOBAL

local roomrule = GetModConfigData("COC_SUB_RULE")
local displaycmd = GetModConfigData("DISPLAY_COMMAND")
local annstyle = GetModConfigData("ANNOUNCE_STYLE")

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
defaultStatus["斧"] = 15
defaultStatus["链锯"] = 10
defaultStatus["连枷"] = 10
defaultStatus["绞索"] = 15
defaultStatus["矛"] = 20
defaultStatus["剑"] = 20
defaultStatus["鞭"] = 5
defaultStatus["手枪"] = 20
defaultStatus["弓"] = 15
defaultStatus["重武器"] = 10
defaultStatus["火焰喷射器"] = 10
defaultStatus["机枪"] = 10
defaultStatus["步枪"] = 25
defaultStatus["冲锋枪"] = 15
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
defaultStatus["天文学"] = 1
defaultStatus["生物学"] = 1
defaultStatus["植物学"] = 1
defaultStatus["化学"] = 1
defaultStatus["密码学"] = 1
defaultStatus["工程学"] = 1
defaultStatus["司法科学"] = 1
defaultStatus["地质学"] = 1
defaultStatus["数学"] = 10
defaultStatus["气象学"] = 1
defaultStatus["药学"] = 1
defaultStatus["物理学"] = 1
defaultStatus["动物学"] = 1
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
    { "步枪", "霰弹枪", },
    { "图书馆使用", "图书馆", },
    { "锁匠", "开锁", "撬锁", },
    { "博物学", "自然学", },
    { "领航", "导航", },
    { "操作重型机械", "重型机械", "重型操作", "重型", },
    { "侦查", "侦察", },
    { "驯兽", "动物驯养", },
}

local function Dealias( name )
    for i,x in ipairs(statueAlias) do
        for j,y in ipairs(x) do
            if y == string.lower(name) then
                return string.lower(x[1])
            end
        end
    end
    return name
end

_G.setmetatable(status, {
    __index = function( t, k )
        return defaultStatus[Dealias(k)] or 0
    end,
})

local function GetStatue( name )
    return status[Dealias(name)]
end

local function SetStatue( name, value )
    status[Dealias(name)] = _G.tonumber(value)
end

local function ChangeStatue( name, value )
    local n = Dealias(name)
    if _G.tonumber(status[n]) then
        status[n] = status[n] + _G.tonumber(value)
    end
end

local function ClearStatue()
    status = {}
end

local function GetCharLang( name )
    return (annstyle == "CHARACTER" and name) and COC_DICE_LANG[string.upper(name)] or COC_DICE_LANG.DEFAULT
end



--------------
--    ST    --
--------------

function COC7_GetStString( charName, arg1, arg2 )
    local charLang = GetCharLang(charName)

    if arg2 then
        if string.lower(arg1) == "show" then
            return _G.subfmt(charLang.ST_SHOW, {
                ST_NAME = arg2,
                ST_VALUE = GetStatue(arg2),
            })  --/st show san
        else
            return nil
        end
    else
        if string.match(arg1, "%D+%d+") then
            local count = 0
            local tempTable = {}

            for name,value in string.gmatch(arg1, "(%D+)(%d+)") do
                count = count + 1
                local operator = string.match(string.sub(name, -1), "[%+%-]")
                if operator then
                    name = string.sub(name, 1, -2)
                end
                if name ~= "" and not string.match(string.sub(name, -1), "[%+%-]") then
                    tempTable[name] = { op = operator, v = _G.tonumber(value), }
                else
                    return _G.subfmt(charLang.ST_ERROR, {
                        ST_ERR_NUM = count,
                        ST_ERR_CODE = name..(operator or "")..value,
                    })  --用/st设置属性时格式出错
                end
            end

            for name,args in pairs(tempTable) do
                if args.op then
                    ChangeStatue(name, args.op == "+" and args.v or -1 * args.v)
                else
                    SetStatue(name, args.v)
                end
                if GetStatue(name) < 0 then 
                    SetStatue(name, 0)
                end
            end

            return _G.subfmt(charLang.ST, {
                ST_AMOUNT = _G.tostring(count),
            })  --/st 力量50体质50xxxxxxxx; /st san-5hp+2

        elseif (string.lower(arg1) == "clear") or (string.lower(arg1) == "init") then
            ClearStatue()
            return charLang.ST_CLEAR  --/st clear; /st init (clear和init不区分大小写)
        else
            return nil
        end
    end
end



---------------
--  RA / RC  --
---------------

function COC7_GetRaString( charName, arg1, arg2, arg3 )
    local charLang = GetCharLang(charName)
    local name,stvalue,bp = nil,0,0

    --此处的逻辑我整理了很久，有点复杂，详见：
    --https://github.com/Heaveeeen/dontstarvetogethermod-trpgdiceplus/issues/10
    local function getBP( str )
        if string.match(str, "[BbPp]%d+") == str then
            local bp_o,bp_n = string.match(str, "([BbPp])(%d+)")
            return string.upper(bp_o) == "B" and _G.tonumber(bp_n) or _G.tonumber(bp_n) * -1
        else
            return nil
        end
    end

    if arg1 == nil then  --没有参数
        stvalue = 0  --/ra
    elseif arg2 == nil then  -----* 1个参数 *
        if _G.tonumber(arg1) then
            stvalue = _G.tonumber(arg1)  --/ra 70
        else
            name = arg1
            stvalue = GetStatue(name)  --/ra 侦查
        end
    elseif arg3 == nil then  -----* 2个参数 *
        if getBP(arg2) then
            bp = getBP(arg2)
            if _G.tonumber(arg1) then
                stvalue = _G.tonumber(arg1)  --/ra 70 B2
            else
                name = arg1
                stvalue = GetStatue(name)  --/ra 侦查 P1
            end
        else
            local temp = _G.tonumber(arg1) or _G.tonumber(arg2)
            if temp then
                name = _G.tonumber(arg1) and arg2 or arg1
                stvalue = temp  --/ra 邪教徒斗殴 50; /ra 40 邪教徒射击
            else
                name = arg1.."-"..arg2
                stvalue = GetStatue(name)  -- /ra 邪教徒 斗殴 ( <==> /ra 邪教徒-斗殴 )
            end
        end
    else  ------------------------* 3个参数 *
        bp = getBP(arg3) or 0
        local temp = _G.tonumber(arg1) or _G.tonumber(arg2)
        if temp then
            name = _G.tonumber(arg1) and arg2 or arg1
            stvalue = temp  --/ra 邪教徒驾驶 60 b2; /ra 60 邪教徒驾驶 P1
        else
            name = arg1.."-"..arg2
            stvalue = GetStatue(name)  -- /ra 邪教徒 斗殴 B1 ( <==> /ra 邪教徒-斗殴 B1 )
        end
    end

    local bonus = bp > 0
    local exDiceAmt = _G.math.abs(bp)

    local dice = ParseDiceExp("1D10")
    local diceB = {}
    for i=1,exDiceAmt+1 do
        diceB[i] = ParseDiceExp("1D10-1")
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
        exDiceStr = _G.tostring(diceB[1])
        for i=2,exDiceAmt do
            exDiceStr = exDiceStr .. "," .. _G.tostring(diceB[i])
        end

        local m = diceB[exDiceAmt+1]
        if bonus then
            for i=1,exDiceAmt do
                m = d100(dice, m) < d100(dice, diceB[i]) and m or diceB[i]
            end
            res2 = d100(dice, m)
            exDiceStr = string.format(" [%s%s] =%d", COC_DICE_LANG._.BONUS_DICE, exDiceStr, res2)
        else
            for i=1,exDiceAmt do
                m = d100(dice, m) > d100(dice, diceB[i]) and m or diceB[i]
            end
            res2 = d100(dice, m)
            exDiceStr = string.format(" [%s%s] =%d", COC_DICE_LANG._.PENALTY_DICE, exDiceStr, res2)
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
        elseif roomrule == 0 then
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
        elseif r > _G.math.floor(s/2) then
            return 3  --常规成功
        elseif r > _G.math.floor(s/5) then
            return 4  --困难成功
        else
            return 5  --极难成功
        end
    end

    local rares = CriOrFum(roomrule, res2, stvalue) or OtherRes(res2, stvalue)

    return name and _G.subfmt(charLang.NRA, {
        RA_NAME = name,
        EXP = string.format("1D100=%d%s/%d", res1, exDiceStr, stvalue),
        RA_RES = charLang.RA_RES[rares],
    }) or _G.subfmt(charLang.RA, {
        EXP = string.format("1D100=%d%s/%d", res1, exDiceStr, stvalue),
        RA_RES = charLang.RA_RES[rares],
    })
end



---------------
-- SAN CHECK --
---------------

function COC7_GetScString( charName, scValue )
    local charLang = GetCharLang(charName)

    if scValue == string.match(scValue, "[^/]+/[^/]+") then
        local ss,sf = string.match(scValue, "([^/]+)/([^/]+)")
        if ParseDiceExp(ss) and ParseDiceExp(sf) then
            local res1 = ParseDiceExp("1D100")
            local exp1 = string.format("1D100=%d/%d", res1, GetStatue("san"))

            local res2,str,sanExp = 0,"",""
            if res1 > GetStatue("san") then
                sanExp = sf
                str = charLang.SC..charLang.SC_FAIL
            else
                sanExp = ss
                str = charLang.SC..charLang.SC_SUCCESS
            end
            res2 = ParseDiceExp(sanExp)
            local exp2 = string.format("%s=%d", sanExp, res2)

            ChangeStatue("san", -1 * res2)
            return _G.subfmt(str, {
                SC_VALUE = scValue,
                EXP = exp1,
                EXP_2 = exp2,
            })
        end
    end
end



---------------
--  TI & LI  --
---------------

function COC7_GetInsString( charName, type )
    local charLang = GetCharLang(charName)

    local res1 = ParseDiceExp("1D10")
    local res2 = ParseDiceExp("1D10")

    local exp1 = string.format("1D10=%d", res1)  --症状
    local exp2 = string.format("1D10=%d", res2)  --持续时间

    local ins_name = COC_DICE_LANG._[type].NAME[res1]
    local ins_des = _G.subfmt(COC_DICE_LANG._[type].DES[res1], {
        CHAR_NAME = charLang.INS_CHAR_NAME
    })

    return _G.subfmt(charLang[type], {
        EXP = exp1,
        EXP_2 = exp2,
        INS_NAME = ins_name,
        INS_DES = ins_des,
    })
end



--------------------------
-- ADD MOD USER COMMAND --
--------------------------



_G.AddModUserCommand("st", "st", {
    prettyname = nil,
    desc = nil,
    permission = _G.COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = { "arg1", "arg2" },
    paramsoptional = { false, true },
    vote = false,
    localfn = function(params, caller)
        local ststring = COC7_GetStString(caller.prefab, params.arg1, params.arg2)
        if not ststring then
            return nil
        end
        if displaycmd then
            _G.TheNet:Say("(/st"..
                (params.arg1 and " " .. params.arg1 or "")..
                (params.arg2 and " " .. params.arg2 or "")..")"..
                MSG_PREFIX..ststring
            )
        else
            _G.TheNet:Say(MSG_PREFIX..ststring)
        end
    end,
})

local function ralocalfn( params, caller, cmdname )
    local rastring = COC7_GetRaString(caller.prefab, params.arg1, params.arg2, params.arg3)
    if displaycmd then
        _G.TheNet:Say("(/"..cmdname..
            (params.arg1 and " " .. params.arg1 or "")..
            (params.arg2 and " " .. params.arg2 or "")..
            (params.arg3 and " " .. params.arg3 or "")..")"..
            MSG_PREFIX..rastring
        )
    else
        _G.TheNet:Say(MSG_PREFIX..rastring)
    end
end

_G.AddModUserCommand("ra", "ra", {
    prettyname = nil,
    desc = nil,
    permission = _G.COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = { "arg1", "arg2", "arg3" },
    paramsoptional = { true, true, true },
    vote = false,
    localfn = function( params, caller )
        ralocalfn( params, caller, "ra" )
    end,
})

_G.AddModUserCommand("rc", "rc", {
    prettyname = nil,
    desc = nil,
    permission = _G.COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = { "arg1", "arg2", "arg3" },
    paramsoptional = { true, true, true },
    vote = false,
    localfn = function( params, caller )
        ralocalfn( params, caller, "rc" )
    end,
})

_G.AddModUserCommand("sc", "sc", {
    prettyname = nil,
    desc = nil,
    permission = _G.COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = { "value" },
    paramsoptional = { false },
    vote = false,
    localfn = function(params, caller)
        local scstring = COC7_GetScString(caller.prefab, params.value)
        if not scstring then
            return nil
        end
        if displaycmd then
            _G.TheNet:Say("(/sc"..
                (params.value and " " .. params.value or "")..")"..
                MSG_PREFIX..scstring
            )
        else
            _G.TheNet:Say(MSG_PREFIX..scstring)
        end
    end,
})

_G.AddModUserCommand("ti", "ti", {
    prettyname = nil,
    desc = nil,
    permission = _G.COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = {},
    paramsoptional = {},
    vote = false,
    localfn = function(params, caller)
        _G.TheNet:Say(
            (displaycmd and "(/ti)" or "")..
            MSG_PREFIX..COC7_GetInsString(caller.prefab, "TI")
        )
    end,
})

_G.AddModUserCommand("li", "li", {
    prettyname = nil,
    desc = nil,
    permission = _G.COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = {},
    paramsoptional = {},
    vote = false,
    localfn = function(params, caller)
        _G.TheNet:Say(
            (displaycmd and "(/li)" or "")..
            MSG_PREFIX..COC7_GetInsString(caller.prefab, "LI")
        )
    end,
})
