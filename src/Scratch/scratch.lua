--[[

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

scratch.default = {}

local pfs = require("./pfs")
local md5 = require("./md5")
local wav = require("./wav")
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
    rotationCenterY = 0
}

scratch.default.sound = {
    name = "NO_SOUND",
    assetId = blank_sound_hex,
    dataFormat = "wav",
    --format = nil
    rate = wav.getSampleRateOfData(blank_sound_data), -- Maybe not required, but it takes next to no processing time to compute
    sampleCount = 0, -- Scratch will fill this in for us
    md5ext = blank_costume_hex..".wav"
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

scratch.metatables.__index = function(_, key)
    return scratch[key]
end

scratch.project = {}

function scratch.project.new()
    local proj = table.deepcopy(scratch.default.project)
    
    return 
end

scratch.sprite = {}
scratch.costume = {}
scratch.sound = {}