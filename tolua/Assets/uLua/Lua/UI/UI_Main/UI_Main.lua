require("Class")
require("BehaviourBase")

--UI_Main继承于BehaviourBase
UI_Main = Class(BehaviourBase)

function UI_Main:Awake()
    -- body
    print("UI_Main.Awake"..self.behaviour.name..(self.data or "nil"))
end 

function UI_Main:Start()

    print("UI_Main.Start"..self.behaviour.name..(self.data or "nil"))
    
end

return UI_Main