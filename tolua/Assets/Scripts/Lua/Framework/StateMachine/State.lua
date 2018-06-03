require("Class")

--定义状态类
State = Class("State")

function State:ctor(name)
    self.name = name
end

function State:SetStateMachine(machine)
    self.machine = machine
end

function State:OnEnter()

end

function State:OnExecute()

end

function State:OnExit()

end

function State:OnPause()

end

function State:OnResume()

end
