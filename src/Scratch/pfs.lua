--[[ Potato File System ]]--

local pfs = {}

function pfs.readFile(path)
    -- Get information about the file that required this module
    local info = debug.getinfo(2, "S")
    local source = info.source

    -- If the source is a string that starts with "@", remove it
    if source:sub(1, 1) == "@" then
        source = source:sub(2)
    end

    -- Get the directory containing the file that required this module
    local dir = source:match("^(.*/)")
    if not dir then
        dir = ""
    end

    -- Construct an absolute path to the file to read
    local absPath = dir .. path

    -- Open the file and read its contents
    local file = io.open(absPath, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

return pfs