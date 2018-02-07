require("Test")
require("Class")

UI_Main = Class:New()

function UI_Main:Init(behaviour)
    self.behaviour = behaviour
    print(self.behaviour.name)
end

function UI_Main:Awake()
    -- body
    print("UI_Main.Awake")
end 

function UI_Main:Start()

    print("UI_Main.Start")
    
end

return UI_Main