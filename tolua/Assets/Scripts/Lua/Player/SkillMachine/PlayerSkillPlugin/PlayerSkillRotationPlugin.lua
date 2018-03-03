require("PlayerSkillPlugin")
require("UnityClass")
require("UnityLayer")

PlayerSkillRotationPlugin = Class(PlayerSkillPlugin)

function PlayerSkillRotationPlugin:ctor(name)

    self.mDuration = 0.2

    self.mImmediately = false

end


function PlayerSkillRotationPlugin:InitWithConfig(configure)

    if configure == nil then return end

    self.mDuration = configure.duration or self.mDuration
    self.mImmediately = configure.immediately or self.mImmediately

end


function PlayerSkillRotationPlugin:OnEnter()

    self.mWantedRotation = nil
  
end

function PlayerSkillRotationPlugin:OnExecute()

    if self.mPlayerSkillState.mTargetDirection ~= Vector3.zero then

      
        if self.mWantedRotation == nil then
            self.mWantedRotation = Quaternion.LookRotation (self.mPlayerSkillState.mTargetDirection)
        end

        if self.mPlayerSkillState.mRunTime <= self.mDuration and self.mImmediately == false then
            
            local factor = self.mPlayerSkillState.mRunTime / self.mDuration

            self.machine.mPlayerCharacter.transform.rotation = Quaternion.Lerp(self.machine.mPlayerCharacter.transform.rotation, self.mWantedRotation, factor)
        else

            self.machine.mPlayerCharacter.transform.rotation = self.mWantedRotation
        end
    end
end


function PlayerSkillRotationPlugin:OnExit()
  
    self.mWantedRotation = nil

end