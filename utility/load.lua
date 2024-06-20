-- load.lua
local load = {}
local core = require("core")

load.SubFile = {}
load.SubFile.__index = load.SubFile

function load.SubFile:new(sub, n_range_min, n_range_max)
    local obj = {
        n_range_min = n_range_min, n_range_max = n_range_max, sub = sub,
        part="part", chapter="chapter", section="section"
    }
    setmetatable(obj, load.SubFile)
    return obj
end

function load.SubFile:book()
    for i = self.n_range_min, self.n_range_max do
        for j = self.n_range_min, self.n_range_max do
            for k = self.n_range_min, self.n_range_max do
                local path = self.sub .. "/" .. self.part .. i .. "/" .. self.chapter .. j .. "/" .. self.section .. k .. ".tex"
                if core.file_exists(path) then
                    tex.sprint(core.command("subfile", path))
                end
            end
        end
    end
end

function load.SubFile:report()
    for i = self.n_range_min, self.n_range_max do
        for j = self.n_range_min, self.n_range_max do
            local path = self.sub .. "/" .. self.chapter .. i .. "/" .. self.section .. j .. ".tex"
            if core.file_exists(path) then
                tex.sprint(core.command("subfile", path))
            end
        end
    end
end

function load.SubFile:article()
    for i = self.n_range_min, self.n_range_max do
        for j = self.n_range_min, self.n_range_max do
            local path = self.sub .. "/" .. self.part .. i .. "/" .. self.section .. j .. ".tex"
            if core.file_exists(path) then
                tex.sprint(core.command("subfile", path))
            end
        end
    end
end

function load.SubFile:beamer()
    for i = self.n_range_min, self.n_range_max do
        local path = self.sub .. "/" .. self.section .. i .. ".tex"
        if core.file_exists(path) then
            tex.sprint(core.command("subfile", path))
        end
    end
end

function load.SubFile:revtex()
    for i = self.n_range_min, self.n_range_max do
        local path = self.sub .. "/" .. self.section .. i .. ".tex"
        if core.file_exists(path) then
            tex.sprint(core.command("subfile", path))
        end
    end
end

return load