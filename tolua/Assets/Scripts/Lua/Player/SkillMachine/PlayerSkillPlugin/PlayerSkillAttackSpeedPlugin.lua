require("PlayerSkillPlugin")

PlayerSkillAttackSpeedPlugin = Class(PlayerSkillPlugin)

function PlayerSkillAttackSpeedPlugin:ctor(name)

    self.mBeginAt = -1
end


function PlayerSkillAttackSpeedPlugin:OnExecute()

    if self.mPlayerSkillState.mChanging then
        return
    end

    local tmpPlayerCharacter = self.machine.mPlayerCharacter

    if tmpPlayerCharacter == nil then return end


    if self.mBeginAt < 0 then
    
        --获取前一个状态
        local tmpPreviousSkillState = self.machine:GetPreviousState()

        if tmpPreviousSkillState then
        
            --获取前一个状态切换到当前状态的转换配置
            local tmpSkillChange = tmpPreviousSkillState:GetSkillChange(self.mPlayerSkillState.mPlayerSkillType)
            if tmpSkillChange ~= nil then
                
                self.mBeginAt = tmpSkillChange.mBeginAt
            end
        end
    end

    if self.mPlayerSkillState.mRunTime > self.mBeginAt then
    
        self.mPlayerSkillState.mSpeed = 1 + tmpPlayerCharacter.mPlayerInfo.attackSpeedAddition
    end
end