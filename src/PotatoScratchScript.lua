--[[

PotatoScratchScript is a text based programming language for Scratch
Created by NicePotato

]]--

local PSS = {}
PSS._VERSION = 0.1
PSS._LABEL = "early0.1"


local wav = require("./Scratch/wav")
local pfs = require("./Scratch/pfs")
local md5 = require("./Scratch/md5")
local bytes = require("./Scratch/bytes")
local asmCompiler = require("./ScratchAssembler/scratchasm")

local debugData = pfs.readFile("./example.wav")
print(md5.sumhexa(debugData))
print(wav.getSampleRateOfData(debugData))

return PSS