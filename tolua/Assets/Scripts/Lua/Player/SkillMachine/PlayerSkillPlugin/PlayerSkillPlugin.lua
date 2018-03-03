require("Class")
require("State")
require("PlayerSkillType")


PlayerSkillPlugin = Class(State)

function PlayerSkillPlugin:ctor(name)
    self.mPlayerSkillState = nil
end

function PlayerSkillPlugin:SetPlayerSkillState(state)

    self.mPlayerSkillState = state

end

function PlayerSkillPlugin:InitWithConfig(configure)


end