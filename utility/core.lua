package.preload['core'] = function()
    local core = {}

    function core.file_exists(path)
        local file_handle = io.open(path, "rb")
        if file_handle == nil then
            return false
        else
            file_handle:close()
            return true
        end
    end

    function core.command(name, value, option)
        if option == nil then
            return "\\" .. name .. "{" .. value .. "}"
        else
            return "\\" .. name .. "[" .. option .. "]{" .. value .. "}"
        end
    end

    function core.env(name, option)
        if option == nil then
            return {core.command("begin", name), core.command("end", name)}
        else
            return {core.command("begin", name) .. "[" .. option .. "]", core.command("end", name)}
        end
    end

    return core
end