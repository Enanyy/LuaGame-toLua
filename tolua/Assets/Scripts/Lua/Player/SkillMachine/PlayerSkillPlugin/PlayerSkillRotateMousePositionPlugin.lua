require("PlayerSkillPlugin")
require("UnityClass")



PlayerSkillRotateMousePositionPlugin = Class(PlayerSkillPlugin)

function PlayerSkillRotateMousePositionPlugin:ctor(name)

end
function PlayerSkillRotateMousePositionPlugin:InitWithConfig(configure)

    if configure == nil then return end

   
end


function PlayerSkillRotateMousePositionPlugin:OnEnter()

    local tmpRay = PlayerManager.mCamera:ScreenPointToRay (Input.mousePosition)
            
    local tmpLayer = UnityLayer.MakeMask(UnityLayer.Default, UnityLayer.Player)

    local tmpFlag, tmpHit = Physics.Raycast(tmpRay,nil, 5000, tmpLayer)
 
    
    if tmpFlag then
        local tmpPosition = tmpHit.point
        tmpPosition.y = self.machine.mPlayerCharacter.transform.position.y
        self.mPlayerSkillState.mTargetDirection = tmpPosition  - self.machine.mPlayerCharacter.transform.position
    end
  
end