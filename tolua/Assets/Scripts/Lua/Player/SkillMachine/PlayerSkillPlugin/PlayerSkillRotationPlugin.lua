require("PlayerSkillPlugin")
require("UnityClass")

PlayerSkillRotationPlugin = Class(PlayerSkillPlugin)

function PlayerSkillRotationPlugin:ctor(name)

    self.mDuration = 0.1

    self.mTargetPosition = Vector3.zero

end


function PlayerSkillRotationPlugin:Init(configure)

    if configure == nil then return end

    self.mDuration = configure.duration

end


function PlayerSkillRotationPlugin:OnEnter()

    local tmpRay = PlayerManager.mCamera:ScreenPointToRay (Input.mousePosition)
    local tmpLayer = 2 ^ LayerMask.NameToLayer("Default")                

    local tmpFlag, tmpHit = Physics.Raycast(tmpRay,nil, 5000, tmpLayer)
         
    self.mTargetPosition = Vector3.zero
    if tmpFlag then
        self.mTargetPosition = tmpHit.point
        self.mWantedRotation = Quaternion.LookRotation (self.mTargetPosition - self.machine.mPlayerCharacter.transform.position)
        
    end


end

function PlayerSkillRotationPlugin:OnExecute()

    if self.mTargetPosition ~= Vector3.zero then


        if self.mPlayerSkillState.mRunTime <= self.mDuration then
            
            local factor = self.mPlayerSkillState.mRunTime / self.mDuration

            self.machine.mPlayerCharacter.transform.rotation = Quaternion.Lerp(self.machine.mPlayerCharacter.transform.rotation, self.mWantedRotation, factor)
        else

            self.machine.mPlayerCharacter.transform.rotation = self.mWantedRotation
        end
    end
end


function PlayerSkillRotationPlugin:OnExit()
  
    self.mTargetPosition = Vector3.zero

end