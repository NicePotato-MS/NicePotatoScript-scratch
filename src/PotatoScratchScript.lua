--[[

PotatoScratchScript is a text based programming language for Scratch
Created by NicePotato

]]--

local PSS = {}
PSS._VERSION = 0.1
PSS._LABEL = "early0.1"


local wav = require("./Scratch/wav")
local pfs = require("./Scratch/pfs")
--local md5 = require("./Scratch/md5")
local bytes = require("./Scratch/bytes")
local potato = require("./Scratch/potato")
local scratch = require("./Scratch/scratch")
--local asmCompiler = require("./ScratchAssembler/scratchasm")

local md5
-- Check for quick MD5 library
local ok, cmd5 = pcall(require, 'md5')
if not ok then
    md5 = require("./Scratch/luamd5")
else
    md5 = require("md5")
end

local debugData = pfs.readFile("./example.wav")
print(md5.sumhexa(debugData))
print(wav.getSampleRateOfData(debugData))

return PSS