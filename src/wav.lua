local wav = {}

local bytes = require("./bytes")

function wav.getSampleRateOfData(data)
    return bytes.bytesToNum_le(data:sub(25,28))
end

return wav