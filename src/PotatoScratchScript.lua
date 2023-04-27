math.randomseed(os.time())

package.path = "/usr/local/lib/lua/5.1/?.lua;"..package.path
package.cpath = "/usr/local/lib/lua/5.1/?.so;".."/usr/local/lib/lua/5.1/?.dll;"..package.cpath

require("./deepcopy") -- Used for copying tables
local wav = require("./wav")
local pfs = require("./pfs")
local md5 = require("./md5")
local asmCompiler = require("./ScratchAssembler/compiler")

local bytes = require("./bytes")

local debugData = pfs.readFile("./InternalAssets/Sounds/example.wav")
print(md5.sumhexa(debugData))
print(wav.getSampleRateOfData(debugData))