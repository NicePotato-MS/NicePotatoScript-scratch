--[[

Lexer for ScratchBlocksText

--Objectives

Comments #


]]--

require("./language")

local function lexer(script)
    local literal = {}
    local def = {}
    script = script:gsub("\t","    ")
    local opcodeBuffer = ""
    local pointer = 1
    for i = 1, #script do
        local char = script:sub(i, i)
        print(char)
    end

    return literal, def
end

return lexer