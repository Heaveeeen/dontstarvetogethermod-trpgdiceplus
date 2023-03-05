local ModUserCommands = require("modusercommands")

AddModUserCommand("trpg_dice_plus", "r", {
    aliases = { "r" },
    prettyname = nil,
    desc = nil,
    permission = COMMAND_PERMISSION.USER,
    slash = true,
    usermenu = false,
    servermenu = false,
    params = { "dice" },
    paramsoptional = { true },
    vote = false,
    canstartfn = function(command, caller, targetid)
        return true
    end,
    localfn = function(params, caller)
        if params.dice ~= nil then
            local dice, sides = string.match(params.dice, "(%d+)[dD](%d+)")
            if dice ~= nil and sides ~= nil then
                TheNet:Announce(string.format("骰出了%s个D%s", dice, sides))
                return
            end

            sides = tonumber(params.dice)
            if sides ~= nil then
                TheNet:Announce(string.format("骰出了%s个D%s", 1, sides))
                return
            end
        end

        TheNet:Announce("语法错误！")
    end,
})