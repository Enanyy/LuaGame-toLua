require("PlayerSkillPlugin")
require("UnityClass")

PlayerEffectPlugin = Class(PlayerSkillPlugin)

function PlayerEffectPlugin:ctor(name)
    
end

function PlayerEffectPlugin:SetPlayerEffectState(effectState)

    self.mPlayerEffectState = effectState

end

--特效开始显示
function PlayerEffectPlugin:OnBegin()

end

--特效结束显示
function PlayerEffectPlugin:OnEnd()

end