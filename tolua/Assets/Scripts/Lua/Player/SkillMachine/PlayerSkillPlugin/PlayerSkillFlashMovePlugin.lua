require("PlayerSkillPlugin")

local SamplePosition = NavMesh.SamplePosition

PlayerSkillFlashMovePlugin = Class(PlayerSkillPlugin)


function PlayerSkillFlashMovePlugin:ctor(name)

    self.mDistance = 5
    self.mDuration = 0.1

    self.mGo = nil

    self.mOriginalPosition = Vector3.zero
    self.mTargetPosition = Vector3.zero
    self.mPosition = Vector3.zero
end

function PlayerSkillFlashMovePlugin:InitWithConfig(configure)

    if configure == nil then return end
    
    self.mDistance = configure.distance or self.mDistance
    self.mDuration = configure.duration or self.mDuration

end

function PlayerSkillFlashMovePlugin:OnEnter()

    if self.mGo ==nil then
        self.mGo = self.machine.mPlayerCharacter.gameObject
    end

    self.mOriginalPosition= GetPosition(self.mGo,self.mOriginalPosition)

    if self.mNavMeshAgent == nil then

        self.mNavMeshAgent = self.mGo:GetComponent(typeof(NavMeshAgent))
    end

   

    if self.mNavMeshAgent then
        self.mNavMeshAgent.enabled = false
    end
    
end


function PlayerSkillFlashMovePlugin:OnExecute()

     
    if self.mDuration ~= 0 then

        self.mTargetPosition = self.mOriginalPosition + self.machine.mPlayerCharacter.transform.forward* self.mDistance

        --self.mTargetPosition = self:CheckFlashPosition(self.mTargetPosition)

        if self.mPlayerSkillState.mRunTime <= self.mDuration then

            local factor = self.mPlayerSkillState.mRunTime * 1.0 / self.mDuration
            self.mPosition = self.mOriginalPosition * (1 - factor) + self.mTargetPosition * factor
            SetPosition(self.mGo, self.mPosition)

        else
            SetPosition(self.mGo, self.mTargetPosition)
        end
    end

end


function PlayerSkillFlashMovePlugin:OnExit()

    if self.mNavMeshAgent then
        self.mNavMeshAgent.enabled = true
    end

end

function PlayerSkillFlashMovePlugin:CheckFlashPosition(targetPosition)

    local tmpFlag, tmpHit = SamplePosition(targetPosition, nil, 0.1, NavMesh.AllAreas)
    if tmpFlag then

        print(1)
       return targetPosition

    else

        local tmpPosition = targetPosition + self.machine.mPlayerCharacter.transform.forward* self.mDistance * 0.5

        tmpFlag, tmpHit = SamplePosition(targetPosition, nil, 0.1, NavMesh.AllAreas)

        if tmpFlag then

            print(2)
            
            return tmpPosition

        else

            print(3)
            
            return self.machine.mPlayerCharacter.transform.position
        end

    end
end