----
----用来创建一个类，如：A = Class()，实例化 local a = A.new()
----如要初始化需定义构造函数，如：A:ctor(...), new(...)的时候会调用ctor(...)来初始化
----继承：B = Class(A)，类B继承于类A，local b = B.new() 实例化一个B的对象
----
local setmetatable = setmetatable
local class={}

----构造一个类
function Class(name,super)
    local class_type = {}
    class_type.ctor = false
    class_type.super = super

    class_type.new = function(...) 
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

        o.GetType = function()
            return class_type.GetType()
        end
        if class_type.super then
            o.base = class_type.super.new(...)
        end

        setmetatable(o, { __index= class[class_type] })
        return o
    end

    ---需要重写该方法来获取该类的实际类型
    class_type.GetType =  function()
        return name
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
