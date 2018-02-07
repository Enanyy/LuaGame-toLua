
--构造类
local setmetatable = setmetatable

Class = {}

function Class:New(super)
    local o = {}
    o.__index = o

    local t = {}
    setmetatable(o,t)
    if super then
        t.__index = super
    end

    return o;
end

return Class