-- 序列化tablle表--將转成string
function serialize(obj)
    local str = ""
    local t = type(obj)
    if t == "number" then
        str = str .. obj
    elseif t == "boolean" then
        str = str .. tostring(obj)
    elseif t == "string" then
        str = str .. string.format("%q", obj)
    elseif t == "table" then
        str = str .. "{\n"
        for k, v in pairs(obj) do
            str = str .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
        end
        local metatable = getmetatable(obj)
        if metatable ~= nil and type(metatable.__index) == "table" then
            for k, v in pairs(metatable.__index) do
                str = str .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
            end
        end
        str = str .. "}"
    elseif t == "userdata" then
        str = str .."userdata"
    elseif t == "nil" then
        str = "nil"
    else
        str = "unknow type" 
        --error("can not serialize a " .. t .. " type.")
    end
    return str
end

function printf(t)

    print(serialize(t))

end
