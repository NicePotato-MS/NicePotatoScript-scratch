local path = debug.getinfo(1, "S").source:sub(2)
local dir = path:match("(.*[/\\])") -- Extract the directory part of the path

package.path = package.path .. ";" .. dir .. "?.lua"

local wav = {}

local bytes = require("./bytes")

function wav.getSampleRateOfData(data)
    return bytes.bytesToNum_le(data:sub(25,28))
end

return wav