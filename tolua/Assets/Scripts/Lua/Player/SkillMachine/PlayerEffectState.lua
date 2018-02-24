require("PlayerSkillPlugin")
require("UnityClass")

PlayerEffectState = Class(PlayerSkillPlugin)

function PlayerEffectState:ctor(name)
    
    self.mEffectTime = 0
    self.mRunTime = 0

    self.mEffectPluginList = {}

end 


function PlayerEffectState:isPlaying()

    return self.mRunTime < self.mEffectTime

end

function PlayerEffectState:Init(configure)

    if configure == nil then return end

    self.mEffectTime = configure.duration

    if configure.EffectPluginList then

        for i,v in ipairs(configure.EffectPluginList) do

            local plugin = v.class.new(v.name)
            --先设置状态和状态机
            plugin:SetPlayerSkillState(self.mPlayerSkillState)
            plugin:SetStateMachine(self.machine)
            --根据配置初始化
            plugin:Init(v)
            
            table.insert (self.mEffectPluginList, plugin)
        end

    end

end

function PlayerEffectState:OnEnter()

    self.mRunTime = 0

end

function PlayerEffectState:OnExecute()

    for i,v in ipairs(self.mEffectPluginList) do
       
        v:OnExecute()
  
    end
end


