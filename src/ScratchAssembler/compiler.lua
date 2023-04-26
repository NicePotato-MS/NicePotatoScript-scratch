local compiler = {}
compiler.default = {}

local filesys = require("./../filesystem")
local md5 = require("./../md5")

local blank_costume_data = filesys.read_file("Assets/blank-costume.svg")
local blank_costume_hex = md5.sumhexa(blank_costume_data)

compiler.default.costume = {
    name = "NO_COSTUME",
    bitmapResolution = 1,
    dataFormat = "svg",
    assetId = blank_costume_hex,
    md5ext = blank_costume_hex..".svg",
    rotationCenterX = 0,
    rotationCenterY = 0
}

compiler.default.sprite = {
    isStage = false,
    name = "DUMMY",
    variables = {},
    lists = {},
    broadcasts = {},
    blocks = {},
    comments = {},
    currentCostume = 0,
    costumes = {}
}

compiler.default.project = {
    targets = {

    },
    monitors = {},
    extensions = {},
    meta = {
        semver = "3.0.0",
        vm = "1.5.29",
        agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
    }
}

compiler.extensionList = {
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