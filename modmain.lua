GLOBAL.setmetatable(env,{__index=function(t,k)return GLOBAL.rawget(GLOBAL,k)end})

local Lang = GetModConfigData("LANGUAGE")
modimport("lang/lang-" .. Lang .. ".lua")

local TRPGRule = GetModConfigData("TRPG_RULE")
modimport("dice/dice-" .. TRPGRule .. ".lua")

MSG_PREFIX = "\238\132\130"

function Say(str)
    TheNet:Say(str)
end

function LocalSay( str )
    ChatHistory:AddToHistory(ChatTypes.Message, nil, nil, MSG_PREFIX .. "[Trpg Dice +]", str, { 0.6, 0.6, 0.6, 1, }, nil, nil, true)
end

local LangMetatable =
{
    __index = function(t, k)
        return t.DEFAULT
    end,
}

setmetatable(COC7_DICE_LANG, LangMetatable)




local RuleInfo = RULE_INFO[TRPGRule]._
if TRPGRule == "COC7" then
    RuleInfo = subfmt(RuleInfo, {
        COC_SUB_RULE = RULE_INFO.COC7.COC_SUB_RULE[GetModConfigData("COC_SUB_RULE")+1]
    })
end

AddModUserCommand("rule", "rule", {
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
        Say("(/rule)\n"..RuleInfo)
    end,
})



setmetatable(DICE_HELP_LANG.COC7, { __index = DICE_HELP_LANG.NONE, })

AddModUserCommand("dicehelp", "dicehelp", {
    prettyname = nil,
    desc = nil,
    permission = COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = { "name" },
    paramsoptional = { true },
    vote = false,
    localfn = function(params, caller)
        local n = (params.name and params.name ~= "_") and string.upper(params.name) or nil
        LocalSay(DICE_HELP_LANG[TRPGRule][n] or (DICE_HELP_LANG._HELP .. DICE_HELP_LANG[TRPGRule]._))
    end,
})
