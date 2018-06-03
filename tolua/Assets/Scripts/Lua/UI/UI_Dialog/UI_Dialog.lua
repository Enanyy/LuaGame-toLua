require("Class")
require("BaseWindow")

--UI_Dialog继承于BaseWindow
UI_Dialog = Class("UI_Dialog",BaseWindow)


local this = UI_Dialog

function this:ctor( path)
    self.path  = path
    self.windowType = WindowType.Pop --弹出行界面

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
