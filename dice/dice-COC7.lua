modimport("dice/dice-NONE.lua")
modimport("scripts/memory.lua")

local roomrule = GetModConfigData("COC_SUB_RULE")
local displaycmd = GetModConfigData("DISPLAY_COMMAND")
local annstyle = GetModConfigData("ANNOUNCE_STYLE")

local status = {}

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

local defaultStatus = {}

local function SetDefaultStatue( name, value )
    defaultStatus[Dealias(name)] = value
end

local function GetDefaultStatue( name )
    return defaultStatus[Dealias(name)] or 0
end

--默认属性
    SetDefaultStatue("会计", 5)
    SetDefaultStatue("人类学", 1)
    SetDefaultStatue("估价", 5)
    SetDefaultStatue("考古学", 1)
    SetDefaultStatue("取悦", 15)
    SetDefaultStatue("攀爬", 20)
    SetDefaultStatue("计算机使用", 5)
    SetDefaultStatue("乔装", 5)
    SetDefaultStatue("汽车驾驶", 20)
    SetDefaultStatue("电气维修", 10)
    SetDefaultStatue("电子学", 1)
    SetDefaultStatue("话术", 5)
    SetDefaultStatue("斗殴", 25)
    SetDefaultStatue("斧", 15)
    SetDefaultStatue("链锯", 10)
    SetDefaultStatue("连枷", 10)
    SetDefaultStatue("绞索", 15)
    SetDefaultStatue("矛", 20)
    SetDefaultStatue("剑", 20)
    SetDefaultStatue("鞭", 5)
    SetDefaultStatue("手枪", 20)
    SetDefaultStatue("弓", 15)
    SetDefaultStatue("重武器", 10)
    SetDefaultStatue("火焰喷射器", 10)
    SetDefaultStatue("机枪", 10)
    SetDefaultStatue("步枪", 25)
    SetDefaultStatue("冲锋枪", 15)
    SetDefaultStatue("急救", 30)
    SetDefaultStatue("历史", 5)
    SetDefaultStatue("恐吓", 15)
    SetDefaultStatue("跳跃", 20)
    SetDefaultStatue("法律", 5)
    SetDefaultStatue("图书馆使用", 20)
    SetDefaultStatue("聆听", 20)
    SetDefaultStatue("锁匠", 1)
    SetDefaultStatue("机械维修", 10)
    SetDefaultStatue("医学", 1)
    SetDefaultStatue("博物学", 10)
    SetDefaultStatue("领航", 10)
    SetDefaultStatue("神秘学", 5)
    SetDefaultStatue("操作重型机械", 1)
    SetDefaultStatue("说服", 10)
    SetDefaultStatue("驾驶", 1)
    SetDefaultStatue("精神分析", 1)
    SetDefaultStatue("心理学", 10)
    SetDefaultStatue("骑术", 5)
    SetDefaultStatue("天文学", 1)
    SetDefaultStatue("生物学", 1)
    SetDefaultStatue("植物学", 1)
    SetDefaultStatue("化学", 1)
    SetDefaultStatue("密码学", 1)
    SetDefaultStatue("工程学", 1)
    SetDefaultStatue("司法科学", 1)
    SetDefaultStatue("地质学", 1)
    SetDefaultStatue("数学", 10)
    SetDefaultStatue("气象学", 1)
    SetDefaultStatue("药学", 1)
    SetDefaultStatue("物理学", 1)
    SetDefaultStatue("动物学", 1)
    SetDefaultStatue("妙手", 10)
    SetDefaultStatue("侦查", 25)
    SetDefaultStatue("潜行", 20)
    SetDefaultStatue("生存", 10)
    SetDefaultStatue("游泳", 20)
    SetDefaultStatue("投掷", 20)
    SetDefaultStatue("追踪", 10)
    SetDefaultStatue("驯兽", 5)
    SetDefaultStatue("潜水", 1)
    SetDefaultStatue("爆破", 1)
    SetDefaultStatue("读唇", 1)
    SetDefaultStatue("催眠", 1)
    SetDefaultStatue("炮术", 1)

setmetatable(status, {
    __index = function( t, k )
        return GetDefaultStatue(k)
    end,
})

local function GetStatue( name )
    return status[Dealias(name)]
end

local function SetStatue( name, value )
    status[Dealias(name)] = toint(value)
    if GetStatue(name) < 0 then
        SetStatue(name, 0)
    end
end

local function ChangeStatue( name, value )
    SetStatue(name, GetStatue(name) + toint(value))
end

local function GetStatusString()
    local changedStatus = {}
    for i,v in pairs(status) do
        if GetStatue(i) ~= GetDefaultStatue(i) then
            changedStatus[Dealias(i)] = v
        end
    end

    local str = ""
    for i,v in pairs(changedStatus) do  --其实这个循环完全可以在上一个循环里一并搞定的，但我保险起见还是拆成了两次循环
        str = string.format("%s%s%d", str, i, v)
    end
    return str
end

local function ClearStatue()
    status = {}
end

local function GetCharLang( name )
    return (annstyle == "CHARACTER" and name) and COC7_DICE_LANG[string.upper(name)] or COC7_DICE_LANG.DEFAULT
end



--------------
--    ST    --
--------------

function COC7_GetStString( charName, arg1, arg2 )
    local charLang = GetCharLang(charName)

    if arg2 then
        if string.lower(arg1) == "show" then
            return subfmt(charLang.ST_SHOW, {
                ST_NAME = arg2,
                ST_VALUE = GetStatue(arg2),
            })  --/st show san
        elseif string.lower(arg1) == "save" then  --SAVE
            local characters = LoadDataFromFile("COC7")

            if characters[arg2] then
                return subfmt(COC7_DICE_LANG._.ST_SAVE_ERROR, {
                    ST_NAME = arg2,
                })
            else
                characters[arg2] = GetStatusString()
                SaveDataToFile("COC7", characters)
                return subfmt(COC7_DICE_LANG._.ST_SAVE, {
                    ST_NAME = arg2,
                })
            end
        elseif string.lower(arg1) == "load" then  --LOAD
            local characters = LoadDataFromFile("COC7")

            if characters[arg2] then
                return COC7_GetStString(charName, characters[arg2])
            else
                return subfmt(COC7_DICE_LANG._.ST_CANT_FIND, {
                    ST_NAME = arg2,
                })
            end
        elseif (string.lower(arg1) == "update") or (string.lower(arg1) == "overwrite") then  --UPDATE/OVERWRITE
            local characters = LoadDataFromFile("COC7")

            if characters[arg2] then
                characters[arg2] = GetStatusString()
                SaveDataToFile("COC7", characters)
                return subfmt(COC7_DICE_LANG._.ST_UPDATE, {
                    ST_NAME = arg2,
                })
            else
                return subfmt(COC7_DICE_LANG._.ST_CANT_FIND, {
                    ST_NAME = arg2,
                })
            end
        elseif string.lower(arg1) == "delete" then  --DELETE
            local characters = LoadDataFromFile("COC7")

            if characters[arg2] then
                characters[arg2] = nil
                SaveDataToFile("COC7", characters)
                return subfmt(COC7_DICE_LANG._.ST_DELETE, {
                    ST_NAME = arg2,
                })
            else
                return subfmt(COC7_DICE_LANG._.ST_CANT_FIND, {
                    ST_NAME = arg2,
                })
            end
        end
    else
        if string.lower(arg1) == "show" then
            return GetStatusString(), "show"
        elseif string.lower(arg1) == "list" then
            local characters = LoadDataFromFile("COC7")
            local str = ""

            for name,code in pairs(characters) do
                str = string.format("%s%s: %s;\n", str, name, code)
            end
            return str, "list"
        elseif string.match(arg1, "%D+%d+") then
            local count = 0
            local tempTable = {}

            for name,value in string.gmatch(arg1, "(%D+)(%d+)") do
                count = count + 1
                local operator = string.match(string.sub(name, -1), "[%+%-]")
                if operator then
                    name = string.sub(name, 1, -2)
                end
                if name ~= "" and not string.match(string.sub(name, -1), "[%+%-]") then
                    tempTable[name] = { op = operator, v = toint(value), }
                else
                    return subfmt(charLang.ST_ERROR, {
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

            return subfmt(charLang.ST, {
                ST_AMOUNT = count,
            })  --/st 力量50体质50xxxxxxxx; /st san-5hp+2

        elseif (string.lower(arg1) == "clear") or (string.lower(arg1) == "init") then
            ClearStatue()
            return charLang.ST_CLEAR  --/st clear; /st init (clear和init不区分大小写)
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
        if string.match(str, "[BbPp]%d*") == str then
            local bp_o,bp_n = string.match(str, "([BbPp])(%d*)")
            bp_n = toint(bp_n) or 1
            return string.upper(bp_o) == "B" and bp_n or bp_n * -1
        else
            return
        end
    end

    if arg1 == nil then  --没有参数
        stvalue = 0  --/ra
    elseif arg2 == nil then  -----* 1个参数 *
        if toint(arg1) then
            stvalue = toint(arg1)  --/ra 70
        else
            name = arg1
            stvalue = GetStatue(name)  --/ra 侦查
        end
    elseif arg3 == nil then  -----* 2个参数 *
        if getBP(arg2) then
            bp = getBP(arg2)
            if toint(arg1) then
                stvalue = toint(arg1)  --/ra 70 B2
            else
                name = arg1
                stvalue = GetStatue(name)  --/ra 侦查 P1
            end
        else
            local temp = toint(arg1) or toint(arg2)
            if temp then
                name = toint(arg1) and arg2 or arg1
                stvalue = temp  --/ra 邪教徒斗殴 50; /ra 40 邪教徒射击
            else
                name = arg1.."-"..arg2
                stvalue = GetStatue(name)  -- /ra 邪教徒 斗殴 ( <==> /ra 邪教徒-斗殴 )
            end
        end
    else  ------------------------* 3个参数 *
        bp = getBP(arg3) or 0
        local temp = toint(arg1) or toint(arg2)
        if temp then
            name = toint(arg1) and arg2 or arg1
            stvalue = temp  --/ra 邪教徒驾驶 60 b2; /ra 60 邪教徒驾驶 P1
        else
            name = arg1.."-"..arg2
            stvalue = GetStatue(name)  -- /ra 邪教徒 斗殴 B1 ( <==> /ra 邪教徒-斗殴 B1 )
        end
    end

    local bonus = bp > 0
    local exDiceAmt = math.abs(bp)

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
        exDiceStr = tostring(diceB[1])
        for i=2,exDiceAmt do
            exDiceStr = exDiceStr .. "," .. tostring(diceB[i])
        end

        local m = diceB[exDiceAmt+1]
        if bonus then
            for i=1,exDiceAmt do
                m = d100(dice, m) < d100(dice, diceB[i]) and m or diceB[i]
            end
            res2 = d100(dice, m)
            exDiceStr = string.format(" [%s%s] =%d", COC7_DICE_LANG._.BONUS_DICE, exDiceStr, res2)
        else
            for i=1,exDiceAmt do
                m = d100(dice, m) > d100(dice, diceB[i]) and m or diceB[i]
            end
            res2 = d100(dice, m)
            exDiceStr = string.format(" [%s%s] =%d", COC7_DICE_LANG._.PENALTY_DICE, exDiceStr, res2)
        end
    end

    local function CriOrFum(roomrule, r, s)
    --r: 百分骰出目; s: 技能(或属性)值
        if roomrule == 0 then
            if r == 1 then
                return 6  --大成功
            elseif s < 50 and r > 95 then
                return 1  --大失败（不满50）
            elseif s >= 50 and r == 100 then
                return 1  --大失败（满50）
            else
                return false
            end

        elseif roomrule == 2 then
            if r < 6 and r <= s then
                return 6  --大成功
            elseif (r > 95 and r > s) or r == 100 then
                return 1 --大失败
            else
                return false
            end

        elseif roomrule == 3 then
            if r < 6 then
                return 6  --大成功
            elseif r > 95 then
                return 1 --大失败
            else
                return false
            end
        end
    end

    local function OtherRes(r, s)
        if r > s then
            return 2  --失败
        elseif r > math.floor(s/2) then
            return 3  --常规成功
        elseif r > math.floor(s/5) then
            return 4  --困难成功
        else
            return 5  --极难成功
        end
    end

    local rares = CriOrFum(roomrule, res2, stvalue) or OtherRes(res2, stvalue)

    return name and subfmt(charLang.NRA, {
        RA_NAME = name,
        EXP = string.format("1D100=%d%s/%d", res1, exDiceStr, stvalue),
        RA_RES = charLang.RA_RES[rares],
    }) or subfmt(charLang.RA, {
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
            return subfmt(str, {
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

    local ins_name = COC7_DICE_LANG._[type].NAME[res1]
    local ins_des = subfmt(COC7_DICE_LANG._[type].DES[res1], {
        PRON_PER = charLang.PRON_PER,
        PRON_POS = charLang.PRON_POS,
    })

    return subfmt(charLang[type], {
        EXP = exp1,
        EXP_2 = exp2,
        INS_NAME = ins_name,
        INS_DES = ins_des,
    })
end



---------------
--  PH & MA  --
---------------

function COC7_GetPhMaString( type, arg )
    local lang = COC7_DICE_LANG._[type]

    if arg == "list" then  --/ph list
        local temp = ""
        for i,n in ipairs(lang.NAME) do
            temp = string.format("%s%d. %s; ", temp, i, n)
        end
        return temp, "list"

    else
        if toint(arg) then
            n = math.max(math.min(toint(arg),100),1)
            exp = tostring(n)
        else
            n = ParseDiceExp("1D100")
            exp = string.format("1D100=%d", n)
        end

        return subfmt(lang._, {
            EXP = exp,
            PH_MA_NAME = lang.NAME[n],
            PH_MA_DES = lang.DES[n],
        })
    end
end



---------------
--    COC    --
---------------

function COC7_GetCocString()
    local function GetRandomStatus()
        local t = {
            STR = ParseDiceExp("3D6*5"),
            CON = ParseDiceExp("3D6*5"),
            SIZ = ParseDiceExp("(2D6+6)*5"),
            DEX = ParseDiceExp("3D6*5"),
            APP = ParseDiceExp("3D6*5"),
            INT = ParseDiceExp("(2D6+6)*5"),
            POW = ParseDiceExp("3D6*5"),
            EDU = ParseDiceExp("(2D6+6)*5"),
            LUCK = ParseDiceExp("3D6*5"),
        }
        t.TOTAL = t.STR + t.CON + t.SIZ + t.DEX + t.APP + t.INT + t.POW + t.EDU
        t.TOTAL_LUCK = t.TOTAL + t.LUCK
        t.HP = math.floor((t.CON + t.SIZ) / 10)
        t.SAN = math.floor(t.POW)
        t.MP = math.floor(t.POW / 5)
        return t
    end

    return subfmt(COC7_DICE_LANG._.COC, GetRandomStatus())
end



--------------------------
-- ADD MOD USER COMMAND --
--------------------------



AddModUserCommand("st", "st", {
    prettyname = nil,
    desc = nil,
    permission = COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = { "arg1", "arg2" },
    paramsoptional = { false, true },
    vote = false,
    localfn = function(params, caller)
        local ststring, localsay = COC7_GetStString(caller.prefab, params.arg1, params.arg2)
        if not ststring then
            return
        end
        if localsay then
            LocalSay(MSG_PREFIX..ststring)
            return
        end
        if displaycmd then
            Say("(/st"..
                (params.arg1 and " " .. params.arg1 or "")..
                (params.arg2 and " " .. params.arg2 or "")..")"..
                MSG_PREFIX..ststring
            )
        else
            Say(MSG_PREFIX..ststring)
        end
    end,
})

local function ralocalfn( params, caller, cmdname )
    local rastring = COC7_GetRaString(caller.prefab, params.arg1, params.arg2, params.arg3)
    if displaycmd then
        Say("(/"..cmdname..
            (params.arg1 and " " .. params.arg1 or "")..
            (params.arg2 and " " .. params.arg2 or "")..
            (params.arg3 and " " .. params.arg3 or "")..")"..
            MSG_PREFIX..rastring
        )
    else
        Say(MSG_PREFIX..rastring)
    end
end

AddModUserCommand("ra", "ra", {
    prettyname = nil,
    desc = nil,
    permission = COMMAND_PERMISSION.USER,
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

AddModUserCommand("rc", "rc", {
    prettyname = nil,
    desc = nil,
    permission = COMMAND_PERMISSION.USER,
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

AddModUserCommand("sc", "sc", {
    prettyname = nil,
    desc = nil,
    permission = COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = { "value" },
    paramsoptional = { false },
    vote = false,
    localfn = function(params, caller)
        local scstring = COC7_GetScString(caller.prefab, params.value)
        if not scstring then
            return
        end
        if displaycmd then
            Say("(/sc"..
                (params.value and " " .. params.value or "")..")"..
                MSG_PREFIX..scstring
            )
        else
            Say(MSG_PREFIX..scstring)
        end
    end,
})

AddModUserCommand("ti", "ti", {
    prettyname = nil,
    desc = nil,
    permission = COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = {},
    paramsoptional = {},
    vote = false,
    localfn = function(params, caller)
        Say(
            (displaycmd and "(/ti)" or "")..
            MSG_PREFIX..COC7_GetInsString(caller.prefab, "TI")
        )
    end,
})

AddModUserCommand("li", "li", {
    prettyname = nil,
    desc = nil,
    permission = COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = {},
    paramsoptional = {},
    vote = false,
    localfn = function(params, caller)
        Say(
            (displaycmd and "(/li)" or "")..
            MSG_PREFIX..COC7_GetInsString(caller.prefab, "LI")
        )
    end,
})

AddModUserCommand("coc", "coc", {
    prettyname = nil,
    desc = nil,
    permission = COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = {},
    paramsoptional = {},
    vote = false,
    localfn = function(params, caller)
        Say(
            (displaycmd and "(/coc)" or "")..
            MSG_PREFIX..COC7_GetCocString(params.amount)
        )
    end,
})

AddModUserCommand("ph", "ph", {
    prettyname = nil,
    desc = nil,
    permission = COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = { "arg" },
    paramsoptional = { true },
    vote = false,
    localfn = function(params, caller)
        local phstring, localsay = COC7_GetPhMaString( "PH", params.arg )
        if localsay then
            LocalSay(MSG_PREFIX..phstring)
            return
        end
        if displaycmd then
            Say("(/ph"..
                (params.arg and " " .. params.arg or "")..")"..
                MSG_PREFIX..phstring
            )
        else
            Say(MSG_PREFIX..phstring)
        end
    end,
})

AddModUserCommand("ma", "ma", {
    prettyname = nil,
    desc = nil,
    permission = COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = { "arg" },
    paramsoptional = { true },
    vote = false,
    localfn = function(params, caller)
        local mastring, localsay = COC7_GetPhMaString( "MA", params.arg )
        if localsay then
            LocalSay(MSG_PREFIX..mastring)
            return
        end
        if displaycmd then
            Say("(/ma"..
                (params.arg and " " .. params.arg or "")..")"..
                MSG_PREFIX..mastring
            )
        else
            Say(MSG_PREFIX..mastring)
        end
    end,
})