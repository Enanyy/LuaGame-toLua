require("Class")

EventListener = Class("EventListener")
function EventListener:ctor(listener,callback)
    
    self.listener = listener
    self.callback = callback

end 

function EventListener:Invoke(...)

    if self.callback ~= nil and self.listener ~= nil then

        self.callback(self.listener, ...)

    end

end