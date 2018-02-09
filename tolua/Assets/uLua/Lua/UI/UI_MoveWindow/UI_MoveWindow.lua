require("Class")
require("BaseWindow")

--UI_MoveWindow继承于BaseWindow
UI_MoveWindow = Class(BaseWindow)
local this = UI_MoveWindow

function this:ctor(behaviour, path)
    self.path  = path
    self.windowType = 1 --普通界面

    self.base = BaseWindow.new(behaviour, self.path, self.windowType)


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
        WindowManager:Open(UI_Main,"UI_Main")
    end)

    local scaleWindow = self.transform:Find("ScaleWindow")
    self.behaviour:AddClick(scaleWindow.gameObject, function() 
        print("Click ScaleWindow")
        WindowManager:Open(UI_ScaleWindow,"UI_ScaleWindow")
    end)
    local fadeWindow = self.transform:Find("FadeWindow")
    self.behaviour:AddClick(fadeWindow.gameObject, function() 
        print("Click FadeWindow")
        WindowManager:Open(UI_FadeWindow,"UI_FadeWindow")
    end)
    local popWindow = self.transform:Find("PopWindow")
    self.behaviour:AddClick(popWindow.gameObject, function() 
        print("Click PopWindow")
        WindowManager:Open(UI_PopWindow,"UI_PopWindow")
    end)
   
    local close = self.transform:Find("Close")
    self.behaviour:AddClick(close.gameObject, function() 
        print("Click Close")        
       self:Close()
    end)
    
end

function this:OnEnter()
    if self.base then
        self.base:OnEnter()
    end
end

function this:OnPause()
    self.isPause = true
    
    if self.base then
        self.base:OnPause()
    end
end

function this:OnResume()
    self.isPause = false
    if self.base then
        self.base:OnResume()
    end
end

function this:OnExit()
    if self.base then
        self.base:OnExit()
    end
end

function this:Close()
    if self.base then
        self.base:Close()
    end
end