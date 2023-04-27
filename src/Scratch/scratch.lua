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

if package.config:sub(1,1) == "\\" then
    -- Windows
    print("Fatal: Not compatible with Windows!")
    os.exit(-1)
 else
    -- Linux (Probably)
    package.path = "/usr/local/lib/lua/5.1/?.lua;"..package.path
    package.cpath = "/usr/local/lib/lua/5.1/?.so;"..package.cpath
    package.cpath = "/usr/local/lib/lua/5.1/?.dll;"..package.cpath
 end

local scratch = {}

scratch._VERSION = 0.1
scratch._LABEL = "early0.1"

scratch.default = {}

local pfs = require("./pfs")
local md5 = require("./md5")
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
        agent = config.AGENT
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

scratch.project = {}
scratch.metatables.project.__index = function(_, key)
    return scratch.project[key]
end

function scratch.project.new()
    local proj = table.deepcopy(scratch.default.project)
    setmetatable(proj, scratch.metatables.project)
    return proj
end

function scratch.project:addExtension(extension)
    extension = extension or false
    if extension == false then
        print("Scratch: Tried to add an extension to a project without supplying an extension!")
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

scratch.sprite = {}
scratch.metatables.sprite.__index = function(_, key)
    return scratch.sprite[key]
end

-- Use layerOrder = "auto" to have it automatically assigned
function scratch.sprite.new(name, requiredCostume, layerOrder, visible, x, y, size, direction, rotationStyle, draggable, volume)
    --[[
    layerOrder = 1,
    ]]--
    name = name or "SPRITE_"..util.randomUID
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
    return 
end

scratch.costume = {}
scratch.metatables.costume.__index = function(_, key)
    return scratch.costume[key]
end

-- Use layerOrder = "auto" to have it automatically assigned
function scratch.costume.new(name, costumeData, fileType)
    name = name or "COSTUME_"..util.randomUID
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

scratch.sound = {}
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
    name = name or "SOUND_"..util.randomUID
    local snd = table.deepcopy(scratch.default.sound)
    snd.name = name
    snd.assetId = hex
    snd.md5ext = hex..".wav"
    snd.rate = wav.getSampleRateOfData(wavdata)
    snd.LIB_DATA = wavdata
    setmetatable(snd, scratch.metatables.sound)
    return snd
end