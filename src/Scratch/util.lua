local util = {}

-- UIDchars ripped straight from scratch-vm source code
local UIDchars = '!#%()*+,-./:;=?@[]^_`{|}~'..'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
local UIDlength = 20 -- Do not change this
function util.randomUID()
    local id = ""
    for i=1, UIDlength do
        math.randomseed(os.time()+math.random(1000000,9999999))
        local randomNum = math.random(1, #UIDchars)
        local randomChar = UIDchars:sub(randomNum, randomNum)
        id = id..randomChar
    end
    return id
end

return util