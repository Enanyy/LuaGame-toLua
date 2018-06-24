require("Class")
require("EventID")
require("EventListener")

EventDispatch = {
    mListenerDic = {}
}


function EventDispatch:Register(eventid, listener,callback)

    if self.mListenerDic[eventid] == nil then
        self.mListenerDic[eventid] = {}
    end
    
    local list = self.mListenerDic[eventid]

    for i,v in ipairs(list) do
        
        if v.listener == listener and v.callback == callback then
            
            print("重复注册事件:",eventid, listener, callback)

            return
        end

    end

    table.insert( list, EventListener.new(listener,callback))

end

function EventDispatch:UnRegister(eventid,listener,callback)

    if self.mListenerDic[eventid] ~= nil then
        
        local list = self.mListenerDic[eventid]

        for i,v in ipairs(list) do
            
            if v.listener == listener and v.callback == callback then

                table.remove( list, i )
                break
            end

        end

    end
end

function EventDispatch:Dispatch(eventid, ...)

    if self.mListenerDic[eventid] then

        local list = self.mListenerDic[eventid]

        for i,v in ipairs(list) do
            
            v:Invoke(...)

        end

    end

end