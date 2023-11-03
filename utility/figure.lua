-- figure.lua
local figure = {}

local core = require("core")

function figure.include(filename, caption, label, scale)
    scale = scale or 1.0
    local figure_env = core.env("figure", "htbp")
    tex.sprint(figure_env[1])
    tex.sprint("\\centering")
    local width = string.format("width=%.2fsp", tex.dimen.textwidth * scale)
    tex.sprint(core.command("includegraphics", filename, width))
    tex.sprint(core.command("caption", caption))
    tex.sprint(core.command("label", "fig:" .. label))
    tex.sprint(figure_env[2])
end

return figure