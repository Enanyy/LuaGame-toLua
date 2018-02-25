require("PlayerSkillPlugin")

PlayerSkillFlashMovePlugin = Class(PlayerSkillPlugin)

function PlayerSkillFlashMovePlugin:ctor(name)

    self.mDistance = 5
    self.mDuration = 0.1

end

function PlayerSkillFlashMovePlugin:Init(configure)

    if configure == nil then return end
    
    self.mDistance = configure.distance or self.mDistance
    self.mDuration = configure.duration or self.mDuration

end

function PlayerSkillFlashMovePlugin:OnEnter()

    self.mOriginalPosition  = self.machine.mPlayerCharacter.transform.position
    if self.mNavMeshAgent == nil then

        self.mNavMeshAgent = self.machine.mPlayerCharacter.gameObject:GetComponent(typeof(NavMeshAgent))
    end

    if self.mNavMeshAgent then
        self.mNavMeshAgent.enabled = false
    end
    
end


function PlayerSkillFlashMovePlugin:OnExecute()

     
    if self.mDuration ~= 0 then

        self.mTargetPosition = self.mOriginalPosition + self.machine.mPlayerCharacter.transform.forward* self.mDistance

        if self.mPlayerSkillState.mRunTime <= self.mDuration then
            local factor = self.mPlayerSkillState.mRunTime * 1.0 / self.mDuration
            self.machine.mPlayerCharacter.transform.position = self.mOriginalPosition * (1 - factor) + self.mTargetPosition * factor

        else
            self.machine.mPlayerCharacter.transform.position = self.mTargetPosition
        end
    end

end


function PlayerSkillFlashMovePlugin:OnExit()

    if self.mNavMeshAgent then
        self.mNavMeshAgent.enabled = true
    end
    
end