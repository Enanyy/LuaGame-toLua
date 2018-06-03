---基类
---需要控制LuaBehaviour对象的都从BehaviourBase派生
---
---创建一个基类
BehaviourBase = Class( "BehaviourBase")


---构造函数 Class函数构造调用
function BehaviourBase:ctor()
   

end

---初始化函数，LuaBehaviour.cs中调用
function BehaviourBase:Init(behaviour)
    self.behaviour = behaviour or nil
    if self.behaviour then 
        self.gameObject = self.behaviour.gameObject 
        self.transform = self.behaviour.transform
    else
        error("BehaviourBase:Init behaviour nil")
    end
    if self.base then
        self.base:Init(behaviour)
    end
end
