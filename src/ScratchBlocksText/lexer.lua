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
    local mode = "normal"
    local buffer = ""
    local pointer = 1
    for i = 1, #script do
        local char = script:sub(i, i)
        if mode == "normal" then
            if char == "(" then
                clearBuffer()
                table.insert(literal, "(")
                table.insert(def, "openReporter")
            elseif char == ")" then
                clearBuffer()
                table.insert(literal, ")")
                table.insert(def, "closeReporter")
            elseif char == "[" then
                clearBuffer()
                table.insert(literal, "[")
                table.insert(def, "openMenu")
            elseif char == "]" then
                clearBuffer()
                table.insert(literal, "]")
                table.insert(def, "closeMenu")
            elseif char == "{" then
                clearBuffer()
                table.insert(literal, "{")
                table.insert(def, "openSub")
            elseif char == "}" then
                clearBuffer()
                table.insert(literal, "}")
                table.insert(def, "closeSub")
            elseif char == "<" then
                clearBuffer()
                table.insert(literal, "<")
                table.insert(def, "openBool")
            elseif char == ">" then
                clearBuffer()
                table.insert(literal, ">")
                table.insert(def, "closeBool")
            elseif char == "*" then
                clearBuffer()
                mode = "literal"
            end
        end
        if char == '"' then
            if mode == "string" then
                
            else
        end
    end

    return literal, def
end

local function clearBuffer()

end

return lexer