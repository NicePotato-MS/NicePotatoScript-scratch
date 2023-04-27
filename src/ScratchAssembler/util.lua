local util = {}

-- blockUIDchars ripped straight from scratch-vm source code
local blockUIDchars = '!#%()*+,-./:;=?@[]^_`{|}~'..'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
local blockUIDlength = 20 -- Do not change this
function util.randomBlockUID()
    local id = ""
    for i=1, blockUIDlength do
        math.randomseed(os.time()+math.random(1000000,9999999))
        local randomNum = math.random(1, #blockUIDchars)
        local randomChar = blockUIDchars:sub(randomNum, randomNum)
        id = id..randomChar
    end
    return id
end

return util