local Lang = GetModConfigData("LANGUAGE")
modimport("lang/lang-" .. Lang .. ".lua")

local TRPGRule = GetModConfigData("TRPG_RULE")
modimport("dice/dice-" .. TRPGRule .. ".lua")



local RuleInfo = RULE_INFO[TRPGRule]._
if TRPGRule == "COC7" then
    RuleInfo = GLOBAL.subfmt(RuleInfo, {
        COC_SUB_RULE = RULE_INFO.COC7.COC_SUB_RULE[GetModConfigData("COC_SUB_RULE")+1]
    })
end

GLOBAL.AddModUserCommand("rule", "rule", {
    prettyname = nil,
    desc = nil,
    permission = GLOBAL.COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = {},
    paramsoptional = {},
    vote = false,
    localfn = function(params, caller)
        GLOBAL.TheNet:Announce("[TRPG Dice +]\238\132\130\n"..RuleInfo)
    end,
})