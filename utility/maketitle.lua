-- maketitle.lua
local maketitle = {}

local core = require("core")
local input = require("input")

local months = {
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
}

function maketitle.set()
    if input.title ~= "" then
        tex.sprint(core.command("title", input.title))
    end

    if input.author ~= "" then
        tex.sprint(core.command("author", input.author))
    end

    local day = os.date("%d")
    local month = tonumber(os.date("%m"))
    local year = os.date("%Y")

    local date_uk_format = day .. " " .. months[month] .. " " .. year

    if input.date == "\\today" then
        tex.sprint(core.command("date", input.date))
    else
        tex.sprint(core.command("date", date_uk_format))
    end
end

function maketitle.execute()
    if input.title and input.title ~= "" then
        tex.sprint("\\maketitle")
    end
end

return maketitle