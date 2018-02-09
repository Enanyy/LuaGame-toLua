require("Class")
require("BaseWindow")

--UI_Main继承于BaseWindow
UI_Main = Class(BaseWindow)

function UI_Main:ctor(behaviour, path)
    self.path  = path
    self.windowType = 0 --主界面

    self.base = BaseWindow.new(behaviour, self.path, self.windowType)


end

function UI_Main:Awake()
    -- body
    print("UI_Main.Awake"..self.behaviour.name..(self.data or "nil"))
end 

function UI_Main:Start()

    print("UI_Main.Start"..self.behaviour.name..(self.data or "nil"))
    
end

return UI_Main