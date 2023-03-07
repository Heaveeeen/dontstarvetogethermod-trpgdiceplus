local Lang = GetModConfigData("LANGUAGE")
modimport("lang/lang-" .. Lang .. ".lua")

local TRPGRule = GetModConfigData("TRPG_RULE")
modimport("dice/dice-" .. TRPGRule .. ".lua")