require("PlayerSkillPlugin")
require("UnityClass")

PlayerEffectPlugin = Class(PlayerSkillPlugin)

function PlayerEffectPlugin:ctor(name)
    
end

function PlayerEffectPlugin:SetPlayerEffectState(effectState)

    self.mPlayerEffectState = effectState

end

function PlayerEffectPlugin:SetPlayerEffectMachine(effectMachine)
    
    self.mEffectMachine = effectMachine

    if self.mEffectMachine ==nil then
        print("mEffectMachine nil")
    end
end

--特效开始显示
function PlayerEffectPlugin:OnBegin()

end

--特效结束显示
function PlayerEffectPlugin:OnEnd()

end