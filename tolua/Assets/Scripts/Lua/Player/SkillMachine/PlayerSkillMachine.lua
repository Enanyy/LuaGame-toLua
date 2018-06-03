require("StateMachine")
require("PlayerSkillState")
require("PlayerSkillType")
--包含所有配置
require("Configures")


PlayerSKillMachine = Class("PlayerSKillMachine",StateMachine)

--没用base保存一个基类的对象
--不要重写StateMachine的函数了，不然会被覆盖掉的
--基类的函数就不起作用了

function PlayerSKillMachine:ctor(varPlayerCharacter)
    self.name = "None"
    self.mPlayerSkillStateDic = {} --状态列表
    self.mPlayerCharacter   = varPlayerCharacter
end


function PlayerSKillMachine:InitWithConfig(configure)

    if configure == nil or configure.StateList == nil then return end

    self.name = configure.name

    for i,v in ipairs(configure.StateList) do
       local skillType = v.enum
       local state = PlayerSkillState.new(v.name)
       --先设置状态机
       state:SetStateMachine(self)
       --根据配置初始化
       state:InitWithConfig(v)
       self.mPlayerSkillStateDic[skillType] = state
    end

  
end


function PlayerSKillMachine:Cache(skillType)

    local state = self:GetPlayerSkillState(skillType)
    if state == nil then
          
        return false
    end
    local current = self:GetCurrentState()
    if current == nil then
      
        self:ChangeState(state)

        return true
    else

        local result = current:Cache(state)
        
        --print("PlayerSKillMachine:ChangeState current = "..current.name .." Cache:" ..skillType .. ".."..tostring(result))
        
        return result
    end

end

function PlayerSKillMachine:GetPlayerSkillState(skillType)

    if self.mPlayerSkillStateDic ~= nil then

        return self.mPlayerSkillStateDic[skillType]
    
    end
    return nil
end 

