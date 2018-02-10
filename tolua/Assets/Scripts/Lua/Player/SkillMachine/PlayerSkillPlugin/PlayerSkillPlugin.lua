require("Class")
require("State")

PlayerSkillPlugin = Class(State)

function PlayerSkillPlugin:ctor(name)
    self.mPlayerSkillState = nil
end

function PlayerSkillPlugin:SetPlayerSkillState(state)

    self.mPlayerSkillState = state

end

function PlayerSkillPlugin:Init(configure)

    
end