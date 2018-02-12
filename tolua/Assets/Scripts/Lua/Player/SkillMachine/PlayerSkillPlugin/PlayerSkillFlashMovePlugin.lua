require("PlayerSkillPlugin")

PlayerSkillFlashMovePlugin = Class(PlayerSkillPlugin)

function PlayerSkillFlashMovePlugin:ctor(name)
    
end

function PlayerSkillFlashMovePlugin:Init(configure)



end

function PlayerSkillFlashMovePlugin:OnEnter()

    self.mOriginalPosition  = self.machine.mPlayerCharacter.transform.position

end