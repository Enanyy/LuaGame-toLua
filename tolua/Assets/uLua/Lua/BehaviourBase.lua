require("Class")
---基类
---需要控制LuaBehaviour对象的都从BehaviourBase派生

---创建一个基类
BehaviourBase = Class()

---构造函数 Class函数构造调用
function BehaviourBase:ctor()
    self.behaviour = nil  ---保存C# LuaBehaviour类的对象
    self.gameObject = nil ---对应的gameObject
    self.transform = nil  ---对应的transform组件
end

---初始化函数，LuaBehaviour.cs中调用
function BehaviourBase:Init(behaviour)
    self.behaviour = behaviour
    self.gameObject = behaviour.gameObject
    self.transform = behaviour.transform
end
