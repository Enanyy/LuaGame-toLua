require("PlayerSkillPlugin")
require("UnityClass")
require("PlayerEffectState")

PlayerSkillEffectPlugin = Class(PlayerSkillPlugin)

function PlayerSkillEffectPlugin:ctor(name)
    self.mBeginAt = 0

    self.mDone = false

    self.mEffectState = PlayerEffectState.new(name)
end

function PlayerSkillEffectPlugin:Init(configure)

    if configure == nil then return end

    self.mBeginAt = configure.beginAt

      --先设置状态和状态机
    self.mEffectState:SetPlayerSkillState(self.mPlayerSkillState)
    self.mEffectState:SetStateMachine(self.machine)
    self.mEffectState:Init(configure)

end

function PlayerSkillEffectPlugin:OnEnter()

    self.mDone = false

end


function PlayerSkillEffectPlugin:OnExecute()

    if self.mDone then return end

    if self.mPlayerSkillState.mRunTime >= self.mBeginAt then

        self.mDone = true

        self.machine.mPlayerCharacter.mEffectMachine:Play(self.mEffectState)
    end

end

