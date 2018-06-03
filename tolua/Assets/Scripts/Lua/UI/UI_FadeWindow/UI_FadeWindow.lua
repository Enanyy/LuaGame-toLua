require("Class")
require("BaseWindow")
require("WindowFade")

--UI_FadeWindow继承于BaseWindow
UI_FadeWindow = Class("UI_FadeWindow",BaseWindow)

local this = UI_FadeWindow

function this:ctor(path)
    self.path  = path
    self.windowType = WindowType.Normal --普通界面

end

function this:Awake()
    -- body
    print(self.behaviour.name..".Awake ")
end 

function this:Start()

    print(self.behaviour.name..".Start ")

    local mainWindow = self.transform:Find("MainWindow")

    self.behaviour:AddClick(mainWindow.gameObject, function() 
        print("Click MainWindow")
        WindowManager:Open(UI_Main)
    end)

    local scaleWindow = self.transform:Find("ScaleWindow")
    self.behaviour:AddClick(scaleWindow.gameObject, function() 
        print("Click ScaleWindow")
        WindowManager:Open(UI_ScaleWindow)
    end)
    local moveWindow = self.transform:Find("MoveWindow")
    self.behaviour:AddClick(moveWindow.gameObject, function() 
        print("Click MoveWindow")
        WindowManager:Open(UI_MoveWindow)
    end)
    local popWindow = self.transform:Find("PopWindow")
    self.behaviour:AddClick(popWindow.gameObject, function() 
        print("Click PopWindow")
        WindowManager:Open(UI_PopWindow)
    end)
   
    local close = self.transform:Find("Close")
    self.behaviour:AddClick(close.gameObject, function() 
        print("Click Close")        
       self:Close()
    end)
    
end


function this:OnEnter()
    self.panel = self.transform:GetComponent(typeof(UIPanel))

    --self.base = BaseWindow.new(self.path, self.windowType)
    --self.base:Init(self.behaviour)
    self.base:OnEnter()
end

function this:OnPause()
    self.isPause = true
    
    WindowFade.Begin(self, 0.4, false, function() self.base:OnPause() end)
    --[[ 
    if self.base then
        self.base:OnPause()
    end
    --]]
end

function this:OnResume()
    self.isPause = false
    WindowFade.Begin(self, 0.4, true, function() self.base:OnResume() end)
    --[[ 
    
    if self.base then
        self.base:OnResume()
    end
    --]]
    
end

function this:OnExit()

    WindowFade.Begin(self, 0.4, false, function() self.base:OnExit() end)
    --[[ 
    
    if self.base then
        self.base:OnExit()
    end
    --]]
    
end
