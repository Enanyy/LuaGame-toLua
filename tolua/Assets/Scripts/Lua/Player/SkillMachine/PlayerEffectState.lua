require("PlayerSkillPlugin")
require("UnityClass")

PlayerEffectState = Class(PlayerSkillPlugin)

function PlayerEffectState:ctor(name)
    
    self.mRunTime = 0

    self.mEffectPluginList = {}
    self.isPlaying = false
    

end 


function PlayerEffectState:Init(configure)

    if configure == nil then return end

    if configure.EffectPluginList then

        for i,v in ipairs(configure.EffectPluginList) do

            local plugin = v.class.new(v.name)
            --先设置状态和状态机
            plugin:SetPlayerSkillState(self.mPlayerSkillState)
            plugin:SetStateMachine(self.machine)
            plugin:SetPlayerEffectState(self)
            --根据配置初始化
            plugin:Init(v)
            
            table.insert (self.mEffectPluginList, plugin)
        end

    end

end

function PlayerEffectState:OnEnter()

    for i,v in ipairs(self.mEffectPluginList) do
       
        v:OnEnter()
  
    end

end

function PlayerEffectState:OnExecute()

    self.mRunTime = self.mRunTime + Time.deltaTime

    for i,v in ipairs(self.mEffectPluginList) do
       
        v:OnExecute()
  
    end
end

function PlayerEffectState:OnExit()

    for i,v in ipairs(self.mEffectPluginList) do
       
        v:OnExit()
  
    end
    
end


function PlayerEffectState:OnBegin()

    self.mRunTime = 0
    self.isPlaying = true

    for i,v in ipairs(self.mEffectPluginList) do
       
        v:OnBegin()
  
    end
end

function PlayerEffectState:OnEnd()

    for i,v in ipairs(self.mEffectPluginList) do
       
        v:OnEnd()
  
    end
end
