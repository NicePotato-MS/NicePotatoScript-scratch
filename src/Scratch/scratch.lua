--[[

Created by NicePotato
Scratch library for Lua 5.1 (May be compatible with other versions)

Recommended for Lua 5.1:
- luarocks install bit32

Without bit32, md5 calculations will be extremely slow!
If you are using LuaJIT, you do not need to worry about this step.
]]--

--[[

Dev Notes

Global variables saved in stage
Local variables saved in sprite

Monitors are saved for every variable

]]--

local path = debug.getinfo(1, "S").source:sub(2)
local dir = path:match("(.*[/\\])")
package.path = package.path .. ";" .. dir .. "?.lua"

require("./deepcopy")

math.randomseed(os.time())

local md5

if package.config:sub(1,1) == "\\" then
    -- Windows
    print("Fatal: Not compatible with Windows! (yet)")
    os.exit(-1)
 else
    -- Linux (Probably)
    local lua_version = string.sub(_VERSION, 5) -- Detect Lua version
    local lua_dir = "/usr/local/lib/lua/"..lua_version

    -- Check if Lua directory exists before updating package.path and package.cpath
    local dir_exists = io.open(lua_dir)
    if dir_exists then
        dir_exists:close()
        package.path = lua_dir.."/?.lua;"..package.path
        package.cpath = lua_dir.."/?.so;"..package.cpath
        package.cpath = lua_dir.."/?.dll;"..package.cpath

        -- Check for quick MD5 library
        local ok, cmd5 = pcall(require, 'md5')
        if not ok then
            print("Scratch: Quick MD5 library is not found, resorting to slow MD5 library.")
            print("Scratch: If you have luarocks installed, try 'sudo luarocks install md5")

            -- Check for bit library
            local ok, bit = pcall(require, 'bit')
            if not ok then
                local ok, bit32 = pcall(require, 'bit32')
                if not ok then
                    print("Scratch: No bit library installed! Calculating slow MD5 hash will be VERY slow!")
                    print("Scratch: If you have luarocks installed, try 'sudo luarocks install bit32'")
                end
            end
            md5 = require("luamd5")
        else
            md5 = require("md5")
        end
    else
        print("Scratch: Lua libraries not found in /usr/local/lub/lua/5.X")
        print("Scratch: Beware of errors!")
    end
 end

local scratch = {}

scratch._VERSION = 0.1
scratch._LABEL = "early0.1"

scratch.default = {}

-- Below is an example agent I pulled from my project edited on a windows machine.
-- You shouldn't need to change this, nor is it recommended.
scratch.default.agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"


local pfs = require("./pfs")
local wav = require("./wav")
local util = require("./util")
local potato = require("./potato")

local blank_costume_data = pfs.readFile("./InternalAssets/Costumes/blank-costume.svg")
if blank_costume_data == nil then
    print("Fatal: Missing blank-costume.svg")
    os.exit(-1)
end
local blank_costume_hex = md5.sumhexa(blank_costume_data)
local blank_sound_data = pfs.readFile("./InternalAssets/Sounds/blank-sound.wav")
if blank_sound_data == nil then
    print("Fatal: Missing blank-sound.wav")
    os.exit(-1)
end
local blank_sound_hex = md5.sumhexa(blank_sound_data)

scratch.default.costume = {
    name = "NO_COSTUME",
    bitmapResolution = 1,
    dataFormat = "svg",
    assetId = blank_costume_hex,
    md5ext = blank_costume_hex..".svg",
    rotationCenterX = 0,
    rotationCenterY = 0,
    LIB_DATA = blank_costume_data
}

scratch.default.sound = {
    name = "NO_SOUND",
    assetId = blank_sound_hex,
    dataFormat = "wav",
    --format = nil
    rate = wav.getSampleRateOfData(blank_sound_data), -- Maybe not required, but it takes next to no processing time to compute
    sampleCount = 0, -- Scratch will fill this in for us
    md5ext = blank_costume_hex..".wav",
    LIB_DATA = blank_sound_data -- will be removed when project is saved
}

scratch.default.sprite = {
    isStage = false,
    name = "DUMMY",
    variables = {},
    lists = {},
    broadcasts = {},
    blocks = {},
    comments = {},
    currentCostume = 0,
    costumes = {table.deepcopy(scratch.default.costume)},
    sounds = {},
    volume = 100,
    layerOrder = 1,
    visible = true,
    x = 0,
    y = 0,
    size = 100,
    direction = 90,
    draggable = false,
    rotationStyle = "all around"
}

scratch.default.stage = table.deepcopy(scratch.default.sprite)
scratch.default.stage.isStage = true
scratch.default.stage.name = "Stage"
scratch.default.stage.layerOrder = 0
scratch.default.stage.tempo = 60
scratch.default.stage.videoTransparency = 50
scratch.default.stage.videoState = "off" -- Silly scratch sometimes sets this to on by default!
--scratch.default.stage.textToSpeechLanguage = nil
-- Remove normal sprite values
scratch.default.stage.visible = nil
scratch.default.stage.x = nil
scratch.default.stage.y = nil
scratch.default.stage.size = nil
scratch.default.stage.direction = nil
scratch.default.stage.draggable = nil
scratch.default.stage.rotationStyle = nil


scratch.default.project = {
    targets = {
        table.deepcopy(scratch.default.stage)
    },
    monitors = {},
    extensions = {},
    meta = {
        semver = "3.0.0",
        vm = "1.5.29",
        agent = scratch.default.agent
    }
}

scratch.extensionList = {
    "pen",
    "music",
    "videoSensing",
    "text2speech",
    "translate",
    "makeymakey",
    "microbit",
    "ev3", -- Lego Mindstorms EV3
    "boost", -- Lego BOOST
    "wedo2", -- Lego Education WeDo 2.0
    "gdxfor" -- Go direct force and acceleration
}

scratch.metatables = {}

--[[Project]]--
scratch.project = {}
scratch.metatables.project = {}
scratch.metatables.project.__index = function(_, key)
    return scratch.project[key]
end

function scratch.project.new()
    local proj = table.deepcopy(scratch.default.project)
    setmetatable(proj, scratch.metatables.project)
    return proj
end

function scratch.project:addExtension(extension)
    if type(extension) ~= "string" then
        print("Scratch: Tried to add an extension to a project without supplying a string!")
        return false
    end
    for k, v in pairs(self.extensions) do
        if v == extension then
            print("Scratch: Tried to add an extension to project that was already added!")
            return false
        end
    end
    table.insert(self.extensions, extension)
    return true
end

function scratch.project:removeExtension(extension)
    if type(extension) ~= "string" then
        print("Scratch: Tried to remove an extension from a project without supplying a string!")
        return false
    end
    local removed = false
    for k, v in pairs(self.extensions) do
        if v == extension then
            removed = true
            self.extensions[k] = nil
        end
    end
    if removed then
        return true
    else
        print("Scratch: Tried to remove an extension from a project that doesn't have it!")
        return false
    end
end

function scratch.project:addSprite(sprite)
    if getmetatable(sprite) ~= scratch.metatables.sprite then
        print("Scratch: Tried to add a non-sprite object to a project as a sprite!")
        return false
    end
    
end

--[[Sprite]]--
scratch.sprite = {}
scratch.metatables.sprite = {}
scratch.metatables.sprite.__index = function(_, key)
    return scratch.sprite[key]
end

-- Use layerOrder = "auto" to have it automatically assigned
function scratch.sprite.new(name, requiredCostume, layerOrder, visible, x, y, size, direction, rotationStyle, draggable, volume)
    --[[
    layerOrder = 1,
    ]]--
    name = name or "SPRITE_"..util.randomUID()
    x = x or 0
    y = y or 0
    size = size or 100
    direction = direction or 90
    rotationStyle = rotationStyle or "all around"
    volume = volume or 100
    draggable = draggable or false
    layerOrder = layerOrder or "auto"
    local spr = table.deepcopy(scratch.default.sprite)
    requiredCostume = requiredCostume or false
    if requiredCostume ~= false then
        spr.costumes = {
            requiredCostume
        }
    end
    spr.x = x
    spr.y = y
    spr.name = name
    spr.size = size
    spr.direction = direction
    spr.volume = volume
    spr.draggable = draggable
    spr.rotationStyle = rotationStyle
    spr.layerOrder = layerOrder
    spr.currentCostume = 0
    setmetatable(spr, scratch.metatables.sprite)
    return spr
end

--[[Costume]]--
scratch.costume = {}
scratch.metatables.costume = {}
scratch.metatables.costume.__index = function(_, key)
    return scratch.costume[key]
end

-- Use layerOrder = "auto" to have it automatically assigned
function scratch.costume.new(name, costumeData, fileType)
    name = name or "COSTUME_"..util.randomUID()
    fileType = fileType or "none"
    costumeData = costumeData or false
    if costumeData == false then
        print("Scratch: Tried to create a new costume without supplying data!")
        return nil
    end
    local hex = md5.sumhexa(costumeData)
    costum = table.deepcopy(scratch.default.costume)
    name = name or "COSTUME"..util.randomUID
    setmetatable(costum, scratch.metatables.costume)

    if fileType == "svg" then
        costum.dataFormat = "svg"
        costum.name = name
        costum.assetId = hex
        costum.md5ext = hex.."svg"
        costum.LIB_DATA = costumeData

        return costum
    end
    if fileType == "none" then
        print("Scratch: No file type supplied to costume.")
        return nil
    end
end


--[[Sound]]--
scratch.sound = {}
scratch.metatables.sound = {}
scratch.metatables.sound.__index = function(_, key)
    return scratch.sound[key]
end

function scratch.sound.new(name, wavdata)
    wavdata = wavdata or false
    if wavdata == false then
        print("Scratch: Tried to create a new sound without supplying data!")
        return nil
    end
    local hex = md5.sumhexa(wavdata)
    name = name or "SOUND_"..util.randomUID()
    local snd = table.deepcopy(scratch.default.sound)
    snd.name = name
    snd.assetId = hex
    snd.md5ext = hex..".wav"
    snd.rate = wav.getSampleRateOfData(wavdata)
    snd.LIB_DATA = wavdata
    setmetatable(snd, scratch.metatables.sound)
    return snd
end

return scratch