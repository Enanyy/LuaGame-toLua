require("Class")
require("BehaviourBase")
require("WindowType")
require("UnityClass")

BaseWindow = Class("BaseWindow",BehaviourBase)


function BaseWindow:ctor(path, wondowType)
  
   self.path = path
   --window类型
  
   self.wondowType = wondowType  
   self.isPause = false
   self.useMask = true
end 


function BaseWindow:OnEnter()

    if self.useMask then
        self:CreateMask()
    end
    self.panel = self.transform:GetComponent(typeof(UIPanel))
end

function BaseWindow:CreateMask()

    local go = GameObject("Mask")
    SetParent(go, self.transform)
    SetLocalPosition(go, Vector3.zero)
    SetScale(go, Vector3.one)
    SetLocalRotation(go, Quaternion.identity)
  
    go.transform:SetAsFirstSibling()
  
    self.mask = go

    local box = go:AddComponent(typeof(BoxCollider))
    box.center = Vector3.zero

    local widget = go:AddComponent(typeof(UIWidget))
    widget.depth = -1

    local root = WindowManager.uiRoot

    widget.width = root.manualWidth
    widget.height = root.manualHeight
    widget.autoResizeBoxCollider = true
    widget:SetAnchor(gameObject,0,0,0,0)
  
    widget:ResizeCollider()

end

function BaseWindow:OnPause()
    self.isPause = true

    if self.panel == nil then
        self.panel = self.transform:GetComponent(typeof(UIPanel))
    end
    if self.panel then
        self.panel.alpha = 0
    end
end


function BaseWindow:OnResume()
    self.isPause = false

    if self.panel == nil then
        self.panel = self.transform:GetComponent(typeof(UIPanel))
    end
    if self.panel then
        self.panel.alpha = 1
    end

    self.transform:SetAsLastSibling()
    WindowManager:SetBlur()
    
end

function BaseWindow:OnExit()
    if self.gameObject then
        GameObject.Destroy(self.gameObject)
    end
    WindowManager:SetBlur()
end

function BaseWindow:Close()
    WindowManager:Close()
end