require("Class")
require("WindowPath")
require("UnityClass")

--全局的WindowManager对象，继承于BehaviourBase
WindowManager = Class(BehaviourBase).new()

--初始化函数
function  WindowManager:Initialize()
    --确保只被初始化一次
    if  self.initialized  == nil or self.initialized == false then
    
        self.initialized = true

        self.uiLayer = LayerMask.NameToLayer("UI")              --UI显示层
        self.blurLayer = LayerMask.NameToLayer("Blur")          --背景模糊层 Unity没有该层的话请创建

        local go = GameObject('WindowManager')     
        GameObject.DontDestroyOnLoad(go)

        local behaviour = go:AddComponent(typeof(LuaBehaviour))  
        behaviour:Init(self)
        self:Init(behaviour)
        
        local p = NGUITools.CreateUI(false)
        p.transform:SetParent(behaviour.transform)

        self.uiCamera = p:GetComponentInChildren(typeof(UICamera))
        local camera = self.uiCamera:GetComponent( typeof( Camera ))
        camera.clearFlags = CameraClearFlags.Depth
        NGUITools.MakeMask(camera, self.uiLayer)
        NGUITools.SetLayer(self.uiCamera.gameObject, self.uiLayer)
        camera.depth = 2


        self.uiRoot = p:GetComponent(typeof(UIRoot))
        self.uiRoot.scalingStyle = UIRoot.Scaling.Constrained
        
        local DESIGN_WIDTH = 1280
        local DESIGN_HEIGHT = 720

        self.uiRoot.manualHeight = DESIGN_HEIGHT
        self.uiRoot.manualWidth = DESIGN_WIDTH

        local tmpScreenAspectRatio = (Screen.width * 1.0) / Screen.height
        local tmpDesignAspectRatio = (DESIGN_WIDTH * 1.0) / DESIGN_HEIGHT
        if (tmpScreenAspectRatio * 100) < (tmpDesignAspectRatio * 100) then
        
            self.uiRoot.fitWidth = true
            self. uiRoot.fitHeight = false

        elseif (tmpScreenAspectRatio * 100) > (tmpDesignAspectRatio * 100) then
        
            self.uiRoot.fitWidth = false
            self.uiRoot.fitHeight = true
        end


        local blurGo = GameObject.Instantiate(self.uiCamera.gameObject)
        blurGo.name = "BlurCamera"
        blurGo.transform:SetParent(self.uiRoot.transform)
        Object.Destroy(blurGo:GetComponent(typeof(AudioListener)))

        self.blurCamera = blurGo:GetComponent(typeof(UICamera))  
        local camera = self.blurCamera:GetComponent(typeof(Camera))
        camera.clearFlags = CameraClearFlags.Depth        
        NGUITools.MakeMask(camera,  self.blurLayer)
        NGUITools.SetLayer(blurGo,  self.blurLayer)
        camera.depth = 1
        self.blurCamera.enabled = false

        self.blurEffect = blurGo:AddComponent(typeof(BlurEffect))        
        self.blurEffect.enabled = false

        --Window栈容器
        self.mWindowStack = Stack.New()             --C#中的栈
        self.mTmpWindowStack = Stack.New()          --C#中的栈
    end

    return self
end

--是否可以点击
function  WindowManager:SetTouchable(touchable)
    if self.uiCamera then
        self.uiCamera.useTouch = touchable
        self.uiCamera.useMouse = touchable
    end
end

function WindowManager:Open(class, name, callback)

    self:SetTouchable(false)

    local t = self:Get(name)

    if  t then
    
        self.mTmpWindowStack:Clear();

        while (self.mWindowStack.Count > 0)
        do
            local window = self.mWindowStack:Pop()
            if  window == t then
            
                break
            else
            
                self.mTmpWindowStack:Push(window)
            end
        end

        while (self.mTmpWindowStack.Count > 0)
        do
            local window = self.mTmpWindowStack:Pop()

            self:SetLayer(window)

            self.mWindowStack:Push(window)
        end

        self.mTmpWindowStack:Clear()

        self:Push(t, callback)
    
    else
    
        local path = WindowPath:Get(name)

        if  path ~= nil then
        
            local tmpAssetBundleName = "assetbundle.unity3d"
            AssetManager:Load(tmpAssetBundleName, path, function (varGo)  
                if varGo then
                
                    local go = GameObject.Instantiate(varGo)

                    NGUITools.SetLayer(go,  self.uiLayer)

                    local tran = go.transform:Find(name)

                    tran:SetParent(self.uiRoot.transform)

                    GameObject.Destroy(go)

                    tran.localPosition = Vector3.zero
                    tran.localRotation = Quaternion.identity
                    tran.localScale = Vector3.one

                    tran.gameObject:SetActive(true)

                    local behaviour = tran:GetComponent(typeof(LuaBehaviour))
                    if behaviour == nil then
                        behaviour = tran.gameObject:AddComponent(typeof(LuaBehaviour))
                    end

                    t = class.new(behaviour, path)

                    behaviour:Init(t)

                    if  t.windowType == WindowType.Root then
                    
                        --查找看看是否已经有 root window
                        local window = self:Find(0)

                        if  window ~= nil then
                        
                            error("已经存在一个 windowType = 0 的界面，本界面将销毁.")
                            GameObject.Destroy(tran.gameObject)
                            self:SetTouchable(true)

                            return
                        end
                    end

                    t.path = path

                    t:OnEnter()

                    self:Push(t, callback)
                else
                    self:SetTouchable(true)
                end
            end)
            
        else
        
            self:SetTouchable(true);
        end
    end


end

function WindowManager:Push(t, callback)

    if t ~= nil then
        
        if self.mWindowStack.Count > 0 then

                --打开Root 关闭其他的
                if  t.windowType == WindowType.Root then
                
                    while (self.mWindowStack.Count > 0)
                    do
                        local window =self.mWindowStack:Pop()

                        if window then
                        
                            if window ~= t then
                            
                                window:OnExit()
                            end
                        end
                    end
                
                elseif t.windowType == WindowType.Pop then
                
                    --Pop类型的不需要暂停上一个窗口
                
                else
                
                    --暂停上一个界面
                    local window = self.mWindowStack:Peek()

                    if window and window.isPause == false then
                    
                        window:OnPause()
                    end
                end
        
        end

        self:SetLayer(t)

        self.mWindowStack:Push(t)

        t:OnResume()
    end

    self:SetTouchable(true)

    if callback ~= nil then
        callback(t)
    end
end

function WindowManager:Get(name)

    local path = WindowPath:Get(name)

    if path then

        local it = self.mWindowStack:GetEnumerator()

        while (it:MoveNext())
        do
            if it.Current.path == path then
                return it.Current
            end
        end
    end

    return nil
end


function WindowManager:Find(windowType)
    if self.mWindowStack == nil then
        return nil
    end

    local it = self.mWindowStack:GetEnumerator()

    while (it:MoveNext())
    do
        if it.Current.windowType == windowType then
            return it.Current
        end
    end

    return nil
end

function WindowManager:SetLayer(window)

    if window then

        if self.mWindowStack.Count > 0 then

            local  top = self.mWindowStack:Peek()

            window.panel.depth = top.panel.depth + 50

        else 
            window.panel.depth = 100
        end
    end
end

function WindowManager:Close()

    if self.mWindowStack == nil then
        return
    end

    if self.mWindowStack.Count > 0 then

        self:SetTouchable(false)

        local window = self.mWindowStack:Pop()

        --主界面不关闭
        if window and window.windowType ~= WindowType.Root then 
            window:OnExit()
        end 

        if self.mWindowStack.Count > 0 then
            window = self.mWindowStack:Peek()
            --显示栈顶窗口
            if window and window.isPause then
                window:OnResume()
            end
        end

        self:SetTouchable(true)
    end

end

-- <summary>
-- 暂停所有窗口
-- </summary>
function WindowManager:Hide()

    local it = self.mWindowStack:GetEnumerator()

    while (it:MoveNext())
    do
        if it.Current.isPause == false then
        
            it.Current:OnPause()
        end
    end
end

-- <summary>
-- 显示栈顶的窗口
-- </summary>
function WindowManager:Show()

   if self.mWindowStack.Count > 0 then
    
        local window = self.mWindowStack:Pop()
        if window  then

           
            --弹出类型
            if window.windowType == WindowType.Pop then

                self.mTmpWindowStack:Clear()

                while ( self.mWindowStack.Count > 0)
                do
                    local w = self.mWindowStack:Peek()
                    if w.windowType ~= WindowType.Pop then
                        w:OnResume()
                        break
                    else
                        w = self.mWindowStack:Pop()
                        w:OnResume()
                        self.mTmpWindowStack:Push(w)
                    end
                
                end
   
                while (self.mTmpWindowStack.Count > 0)
                do
                    self.mWindowStack:Push(self.mTmpWindowStack:Pop())
                end
                self.mTmpWindowStack:Clear()

            end
            
            self.mWindowStack:Push(window)
            if window.isPause then
                window:OnResume()
            end
        end
    end
end

function WindowManager:CloseAll()

    if self.mWindowStack == nil then
        return 
    end

    while( self.mWindowStack.Count > 0)
    do
        local window =  self.mWindowStack:Pop()

        if window then
        
            window:OnExit()
        end
    end

    self.mWindowStack:Clear()
end

function WindowManager:SetBlur()

    if self.mWindowStack == nil then
        return 
    end

    if self.mWindowStack.Count > 0 then
    
        local w = self.mWindowStack:Pop()
        NGUITools.SetLayer(w.gameObject,  self.uiLayer)

        if self.mWindowStack.Count > 0 then
        
            local b = self.mWindowStack:Peek()
            NGUITools.SetLayer(b.gameObject,  self.blurLayer)
        end

        self.mWindowStack:Push(w)
    end
    self.blurEffect.enabled = self.mWindowStack.Count > 1
    
    if Camera.main then 
        local blurEffect = Camera.main:GetComponent(typeof(BlurEffect))
        if blurEffect == nil then blurEffect = Camera.main.gameObject:AddComponent(typeof(BlurEffect)) end

        blurEffect.enabled = self.blurEffect.enabled
    end
end
