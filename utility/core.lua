function file_exists(path)
    local file_hundle, error_str, error_code = io.open(path, "rb")
    if file_hundle == nil then
        return false
    else
        return true
    end
end

function command(command_name, command_value)
    return "\\" .. command_name .. "{" .. command_value .. "}"
end