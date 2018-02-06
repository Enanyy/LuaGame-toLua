require("LuaBehaviour")

UI_Main = {
    behaviour = nil,
}
UI_Main.__index = UI_Main

function UI_Main:Init(super)
    self.behaviour = super
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