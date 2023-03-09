modimport("dice/dicecore.lua")

local DEFAULT_DICE = "1D100"
local _G = GLOBAL

local displaycmd = GetModConfigData("DISPLAY_COMMAND")
local annstyle = GetModConfigData("ANNOUNCE_STYLE")

local function GetCharLang( name )
    return (annstyle == "CHARACTER" and name) and COC_DICE_LANG[string.upper(name)] or COC_DICE_LANG.DEFAULT
end



-------------
--    R    --
-------------

function GetRString( charName, arg1, arg2 )
    local charLang = GetCharLang(charName)

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
            return GetRString(charName, DEFAULT_DICE, arg1.."-"..arg2)  --/r 心理 学 <==> /r 心理-学
        end
        return _G.subfmt(charLang.NR, {
                R_NAME = name,
                EXP = string.format("%s=%d", exp, ParseDiceExp(exp)),
            })  --/r 1D100 心理学
    else
        local temp = arg1 or arg2
        if ParseDiceExp(temp) then
            return _G.subfmt(charLang.R, {
                EXP = string.format("%s=%d", temp, ParseDiceExp(temp)),
            })  --/r 1D100
        else
            return GetRString(charName, DEFAULT_DICE, temp)  --/r 心理学 <==> /r 1D100 心理学
        end
    end
end



--------------
--    RH    --
--------------

function GetRhString( charName, arg1, arg2 )
    local charLang = GetCharLang(charName)

    if not (arg1 or arg2) then
        return GetRhString(charName, DEFAULT_DICE)  --/rh <==> /rh 1D100
    elseif arg1 and arg2 then
        local exp,arg = nil,nil
        if ParseDiceExp(arg1) then
            exp = arg1
            name = arg2
        elseif ParseDiceExp(arg2) then
            exp = arg2
            name = arg1
        else
            return GetRhString(charName, DEFAULT_DICE, arg1.."-"..arg2)  --/rh 心理 学 <==> /rh 心理-学
        end
        return _G.subfmt(charLang.NRH, {
            R_NAME = name,
            EXP = exp,
        }), _G.subfmt(charLang.NRHR, {
            R_NAME = name,
            EXP = string.format("%s=%d", exp, ParseDiceExp(exp)),
        })  --/rh 1D100 心理学
    else
        local temp = arg1 or arg2
        if ParseDiceExp(temp) then
            return _G.subfmt(charLang.RH, {
                EXP = temp,
            }), _G.subfmt(charLang.RHR, {
                EXP = string.format("%s=%d", temp, ParseDiceExp(temp)),
            })  --/rh 1D100
        else
            return GetRhString(charName, DEFAULT_DICE, temp)  --/rh 心理学 <==> /rh 1D100 心理学
        end
    end
end



--------------------------
-- ADD MOD USER COMMAND --
--------------------------



_G.AddModUserCommand("r", "r", {
    prettyname = nil,
    desc = nil,
    permission = _G.COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = { "arg1", "arg2" },
    paramsoptional = { true, true },
    vote = false,
    localfn = function(params, caller)
        local rstring = GetRString(caller.prefab, params.arg1, params.arg2)
        if displaycmd then
            Say("(/r"..
                (params.arg1 and " " .. params.arg1 or "")..
                (params.arg2 and " " .. params.arg2 or "")..")"..
                MSG_PREFIX..rstring
            )
        else
            Say(MSG_PREFIX..rstring)
        end
    end,
})



_G.AddModUserCommand("rh", "rh", {
    prettyname = nil,
    desc = nil,
    permission = _G.COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = { "arg1", "arg2" },
    paramsoptional = { true, true },
    vote = false,
    localfn = function(params, caller)
        local rhstring,rhrstring = GetRhString(caller.prefab, params.arg1, params.arg2)

        if displaycmd then
            Say("(/rh"..
                (params.arg1 and " " .. params.arg1 or "")..
                (params.arg2 and " " .. params.arg2 or "")..")"..
                MSG_PREFIX..rhstring
            )
        else
            Say(GetRhString(MSG_PREFIX..rhstring))
        end
        
        LocalSay(MSG_PREFIX..rhrstring)
    end,
})
