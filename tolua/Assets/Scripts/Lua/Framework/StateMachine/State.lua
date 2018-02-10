require("Class")

--定义状态类
State = Class()

function State.ctor(name)
    self.name = name
end

function State:SetStateMachine(machine)
    self.machine = machine
end

function State:OnEnter()

end

function State:
