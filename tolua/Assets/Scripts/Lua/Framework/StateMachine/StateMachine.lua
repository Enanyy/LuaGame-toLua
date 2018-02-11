require("Class")

--定义一个状态机类
StateMachine = Class()

--构造函数
function StateMachine:ctor()
    self.currentState = nil     --当前状态
    self.previousState = nil    --前一个状态

    self.pause = false        --是否暂停
end

function StateMachine:ChangeState(state)

    if state == nil then
        return false
    end
    
    --退出前一个状态
    if  self.currentState ~= nil then
        self.currentState:OnExit()
    end

    self.previousState = self.currentState
    self.currentState = state

    --为状态设置状态机
    self.currentState:SetStateMachine(self)
    self.currentState:OnEnter()

    return true
end

--状态机更新
function StateMachine:OnExecute()
    
    if self.pause then
        return
    end

    if self.currentState ~= nil then
        print("StateMachine:OnExecute state:"..self.currentState.name )

        self.currentState:OnExecute()
    end
end

--切回前一个状态
function StateMachine:RevertPreviousState()

    self:ChangeState(self.previousState)

end
--获取当前状态
function StateMachine:GetCurrentState()
    return self.currentState
end

--获取前一个状态
function StateMachine:GetPreviousState()
    return self.previousState
end

--是否暂停状态

function StateMachine:isPause()
    return self.pause
end

--暂停状态机
function StateMachine:Pause()
    
    self.pause = true

    if self.currentState ~= nil then
        self.currentState:OnPause()
    end
end

--取消暂停
function StateMachine:Resume()

    self.pause = false

    if self.currentState ~= nil then
        self.currentState:OnResume()
    end
end