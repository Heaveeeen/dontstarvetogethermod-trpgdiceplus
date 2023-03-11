local json = require "json"
local path = "./trpgdiceplus-%s-data.json"

function LoadDataFromFile( name )
    local p = string.format(path, name)
    local f = io.open(p, "r")
    if not f then
        local f = io.open(p, "w")
        f:write("{}")
        f:close()
        return {}
    end
    local str = f:read("*a")
    f:close()
    return (str and str ~= "") and json.decode(str) or nil
end

function SaveDataToFile( name, table )
    local p = string.format(path, name)
    local f = io.open(p, "w")
    f:write(json.encode(table))
    f:close()
end
