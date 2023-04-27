local potato = {}

function potato.printTable(tbl, max, inDepth)
    max = max or 16 -- maximum the function will go before overflowing
    local depth = inDepth or 1 -- default depth is 1
    local indent = string.rep("  ", depth - 1) -- indentation for current depth

    for k, v in pairs(tbl) do
        if depth >= max then
            print(indent.."...(overflow)")
            return
        end
        if type(v) == "table" and depth > 0 then
            if next(v) == nil then
                print(indent..k.." = {}")
            else
                print(indent..k.." = {")
                potato.printTable(v, max, depth + 1)
                print(indent.."}")
            end
        elseif type(v) == "string" then
            print(indent..k..' = "'..v..'"')
        else
            print(indent..k.." = "..tostring(v))
        end
    end
end


return potato