--[[

Lexer for ScratchBlocksText

--Objectives

Comments #


]]--

-- I am too lazy to make a state machine 🤯

local path = debug.getinfo(1, "S").source:sub(2)
local dir = path:match("(.*[/\\])")
package.path = package.path .. ";" .. dir .. "?.lua"

require("language")

local literal
local def
local char
local buffer
local mode

local function clearBuffer()
    buffer = buffer:gsub(" ","")
    buffer = buffer:gsub("\n","")
    if buffer ~= "" then
        if tonumber(buffer) then
            table.insert(literal, buffer)
            table.insert(def, "number")
            buffer = ""
        else
            table.insert(literal, buffer)
            table.insert(def, "opcode")
            buffer = ""
        end
    end
end

local function lexer(script)
    literal = {}
    def = {}
    script = script:gsub("\t","    ")
    mode = "normal"
    buffer = ""
    local pointer = 1
    for i = 1, #script do
        char = script:sub(i, i)
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
            elseif char == '"' then
                clearBuffer()
                mode = "string"
                buffer = '"'
            elseif char == '*' then
                clearBuffer()
                mode = "literal"
                buffer = '*'
            elseif char == "#" then
                clearBuffer()
                mode = "comment"
            elseif char == " " then
                clearBuffer()  
            else
                buffer = buffer..char
            end
        elseif mode == "string" then
            if char == '"' then
                table.insert(literal, buffer..'"')
                table.insert(def, "string")
                buffer = ""
                mode = "normal"
            elseif char == '\\' then
                i = i+1
                buffer = buffer..char..script:sub(i,i)
            else
                buffer = buffer..char
            end
        elseif mode == "literal" then
            if char == '*' then
                table.insert(literal, buffer..'*')
                table.insert(def, "literal")
                buffer = ""
                mode = "normal"
            elseif char == '\\' then
                i = i+1
                buffer = buffer..char..script:sub(i,i)
            else
                buffer = buffer..char
            end
        elseif mode == "comment" then
            if char == "\n" then mode = "normal" end
        end
    end

    return literal, def
end

return lexer