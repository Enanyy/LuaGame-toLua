require("PlayerSkillPlugin")

local NavMeshAgent =  UnityEngine.AI.NavMeshAgent

PlayerSkillMovePlugin = Class(PlayerSkillPlugin)

function PlayerSkillMovePlugin:ctor(name)
    
end 

function PlayerSkillMovePlugin:Init(configure)

    if configure == nil then return end

    self.mBeginAt = configure.mBeginAt
    self.mEndAt   = configure.mEndAt

end