local bytes = {}

local potato = require("./potato")

function bytes.bytesToNum_be(bytes)
    local num = 0
    for i = #bytes, 1, -1 do
        num = num + string.byte(bytes, i) * 256 ^ (#bytes - i)
    end
    return num
end
function bytes.bytesToNum_le(bytes)
    local num = 0
    for i = 1, #bytes do
      num = num + string.byte(bytes, i) * 256^(i-1)
    end
    return num
  end
  
  

return bytes