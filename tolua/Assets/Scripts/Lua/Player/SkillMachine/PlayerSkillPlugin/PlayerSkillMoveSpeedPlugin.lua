require("PlayerSkillPlugin")

PlayerSkillMoveSpeedPlugin = Class(PlayerSkillPlugin)

function PlayerSkillMoveSpeedPlugin:ctor(name)

    self.mBeginAt = -1

end

function PlayerSkillMoveSpeedPlugin:OnExecute()

    if self.mPlayerSkillState.mChanging then
    
        return

    end

    local tmpPlayerCharacter = self.machine.mPlayerCharacter

    if self.mBeginAt < 0 then
    
        if self.mPlayerSkillState.mPreviousSkillState ~= nil then
        
            local tmpSkillChange = self.mPlayerSkillState.mPreviousSkillState:GetSkillChange(self.mPlayerSkillState.mPlayerSkillType)
            if tmpSkillChange ~= nil then
                
                self.mBeginAt = tmpSkillChange.mBeginAt
            end
        end
    end

    if self.mPlayerSkillState.mRunTime > self.mBeginAt then
    
        self.mPlayerSkillState.mSpeed = 1 + tmpPlayerCharacter.mPlayerInfo.moveSpeedAddition
        tmpPlayerCharacter.moveSpeed = tmpPlayerCharacter.mPlayerInfo.baseSpeed * self.mPlayerSkillState.mSpeed
    end

end