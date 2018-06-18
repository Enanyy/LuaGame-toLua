require("Class")
require("BaseWindow")
require("WindowScale")

--UI_ScaleWindow继承于BaseWindow
UI_ScaleWindow = Class("UI_ScaleWindow",BaseWindow)

local this = UI_ScaleWindow

function this:ctor( path)
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

    local fadeWindow = self.transform:Find("FadeWindow")
    self.behaviour:AddClick(fadeWindow.gameObject, function() 
        print("Click FadeWindow")
        WindowManager:Open(UI_FadeWindow)
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
    print(self.base:GetType())
    self.base:OnEnter()
end

function this:OnPause()
    self.isPause = true
    WindowScale.Begin(self,0.3,false, function() self.base:OnPause() end)
    --[[ 
    
    if self.base then
        self.base:OnPause()
    end
    --]]
end

function this:OnResume()
    self.isPause = false
    WindowScale.Begin(self,0.3,true,function() self.base:OnResume() end)
    --[[ 
    
    if self.base then
        self.base:OnResume()
    end
    --]]
    
end

function this:OnExit()
    WindowScale.Begin(self,0.3,false, function() self.base:OnExit() end)
    --[[ 
    
    if self.base then
        self.base:OnExit()
    end
    --]]
    
end

