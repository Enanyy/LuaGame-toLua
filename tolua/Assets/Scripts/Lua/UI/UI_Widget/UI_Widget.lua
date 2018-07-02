require("Class")
require("BaseWindow")

--UI_Widget继承于BaseWindow
UI_Widget = Class("UI_Widget",BaseWindow)


local this = UI_Widget

function this:ctor( path)
    self.path  = path
    self.windowType = WindowType.Widget --widget界面
    self.useMask = false --可以点击背景后面
    self.depth = 0      --可以设置depth

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

    

    local close = self.transform:Find("Close")
    self.behaviour:AddClick(close.gameObject, function() 
        print("Click Close")        
       self:Close()
    end)
   
end

function this:OnEnter()

    self.panel = self.transform:GetComponent(typeof(UIPanel))

    self.base.useMask = self.useMask
    self.base:OnEnter()
    
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
