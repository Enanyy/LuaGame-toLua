require("StateMachine")

PlayerSKillMachine = Class(StateMachine)

--没用base保存一个基类的对象
--不要重写StateMachine的函数了，不然会被覆盖掉的
--基类的函数就不起作用了

function PlayerSKillMachine:ctor(playerCharacter)
    self.playerSkillStates = {} --状态列表
    self.playerCharacter   = playerCharacter
end


function PlayerSKillMachine:Init(configure)

end


function PlayerSKillMachine:Cache(skillType)

    local state = self:GetPlayerSkillState(skillType)
    if state == nil then
        return false
    end


end

function PlayerSKillMachine:GetPlayerSkillState(skillType)

    if self.playerSkillStates ~= nil then

        return self.playerSkillStates[skillType]
    
    end
    return nil
end 

