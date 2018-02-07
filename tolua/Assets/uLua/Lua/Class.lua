

local setmetatable = setmetatable

local class={}
 
----构造一个对象
function Class(super)
    local class_type = {}
    class_type.ctor =false
    class_type.super = super

    class_type.new=function(...) 
        local o = {}
        do
            local create 
            create = function(c, ...)
                if c.super then
                    create(c.super, ...)
                end
                if c.ctor then
                    c.ctor(o, ...)
                end
            end
 
            create(class_type, ...)
        end

        setmetatable(o, { __index= class[class_type] })
        return o
    end

    local vtbl={}
    class[class_type]=vtbl
 
    setmetatable(class_type,{__newindex = function(t, k, v) vtbl[k] = v end })
 
    if super then
        setmetatable(vtbl, {__index = function(t,k)
            local ret = class[super][k]
            vtbl[k] =ret
            return ret
        end})
    end
    
    return class_type
end
