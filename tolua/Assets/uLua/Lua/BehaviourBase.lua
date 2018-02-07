require("Class")
---基类
---需要控制LuaBehaviour对象的都从BehaviourBase派生

---创建一个基类
BehaviourBase = Class()

---构造函数
function BehaviourBase:ctor()
    self.behaviour = nil  ---保存C# LuaBehaviour类的对象
    self.gameObject = nil ---对应的gameObject
    self.transform = nil  ---对应的transform组件
end

---初始化函数，LuaBehaviour中调用
function BehaviourBase:Init(behaviour)
    self.behaviour = behaviour
    self.gameObject = behaviour.gameObject
    self.transform = behaviour.transform
end
