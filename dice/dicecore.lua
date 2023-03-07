GLOBAL.math.randomseed(GLOBAL.os.time())
local rand = GLOBAL.math.random

local function roll( amount, sides )
    local count = 0
    for i=1,amount do
        count = count + rand(sides)
    end
    return count
end

function ParseDiceExp( exp )  --"(3D6 + 10) x 3 + 1D10"
    if not exp then
        return nil
    end

    local exp2 = string.gsub(string.gsub(exp, "%s+", ""), "x", "*")  --"(3D6+10)*3+1D10"
    while string.match(exp2, "[dD]") do
		local a,d,s
		if string.match(exp2, "(%d+)([dD])(%d+)") then
			a,d,s = string.match(exp2, "(%d+)([dD])(%d+)")  -- 1D100 <==> 1D100
		elseif string.match(exp2, "([dD])(%d+)") then
			a,d,s = nil,string.match(exp2, "([dD])(%d+)")  -- D100 <==> 1D100
		elseif string.match(exp2, "(%d+)([dD])") then
			a,d = string.match(exp2, "(%d+)([dD])")  -- 2D <==> 2D100
		else
			a,d,s = nil,string.match(exp2, "[dD]"),nil  -- D <==> 1D100
		end
        exp2 = string.gsub(exp2, (a or "")..d..(s or ""), roll(GLOBAL.tonumber(a) or 1, GLOBAL.tonumber(s) or 100))
    end    --"(11+10)*3+4"

    local function operate( e, p, op )
        if not e then
            return nil
        end
        local _e = e
        while string.match(_e, op) do
		    local n1, o, n2 = string.match(_e, p)
            n1 = GLOBAL.tonumber(n1)
            n2 = GLOBAL.tonumber(n2)
            if not (n1 and n2) then
                return nil
            end
            local r = o == "+" and n1 + n2
                or o == "-" and n1 - n2
                or o == "*" and n1 * n2
                or o == "/" and n1 / n2
                or 0
            _e = string.gsub(_e, p, GLOBAL.tostring(r), 1)
        end
        return _e
    end

    local function getValue( e )
        if not e then
            return nil
        end

        local _e = e

        local temp = string.match(_e, "%b()")
        while temp do
			local value = getValue(string.sub(temp,2,-2))
			if not value then
				return nil
			end
            _e = string.gsub(_e, "%b()", value,1)
            temp = string.match(_e, "%b()")
        end  --"21*3+4"

        _e = operate(_e, "(%d+)([%*/])(%d+)", "[%*/]")  --"63+4"
        if not _e then
            return nil
        end
        _e = operate(_e, "(%d+)([%+%-])(%d+)", "[%+%-]")  --"67"

        return GLOBAL.tonumber(_e)  --67

    end

    return getValue(exp2) or nil

end