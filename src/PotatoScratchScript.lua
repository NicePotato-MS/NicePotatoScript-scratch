local wav = require("./Scratch/wav")
local pfs = require("./Scratch/pfs")
local md5 = require("./Scratch/md5")
local bytes = require("./Scratch/bytes")
local asmCompiler = require("./ScratchAssembler/compiler")

local debugData = pfs.readFile("./example.wav")
print(md5.sumhexa(debugData))
print(wav.getSampleRateOfData(debugData))