local lex = require("./ScratchBlocksText/lexer")
local potato = require("./Scratch/potato")

script = [[event_whenflagclicked{looks_sayforsecs("This is a test!")(2)} # so cool!
"\"bc"]]

literal, def = lex(script)

for k, v in pairs(literal) do
    print("Literal: "..v.." Definition: "..def[k])
end