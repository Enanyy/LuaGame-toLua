require("PlayerSkillPlugin")
require("UnityClass")


local Raycast = Physics.Raycast

PlayerSkillRotateMousePositionPlugin = Class("PlayerSkillRotateMousePositionPlugin",PlayerSkillPlugin)

function PlayerSkillRotateMousePositionPlugin:ctor(name)
    self.mGo = nil
    self.mPosition = Vector3.zero
end
function PlayerSkillRotateMousePositionPlugin:InitWithConfig(configure)

    if configure == nil then return end

   
end


function PlayerSkillRotateMousePositionPlugin:OnEnter()

    if self.mGo == nil then
        self.mGo = self.machine.mPlayerCharacter.gameObject
    end

    local tmpRay = PlayerManager.mCamera:ScreenPointToRay (Input.mousePosition)
            
    local tmpLayer = UnityLayer.MakeMask(UnityLayer.Default, UnityLayer.Player)

    local tmpFlag, tmpHit = Raycast(tmpRay,nil, 5000, tmpLayer)
 
    
    if tmpFlag then
        local tmpPosition = tmpHit.point
        local x, y, z = Helper.GetPosition(self.mGo, nil, nil, nil)
        self.mPosition:Set(x, y, z)
        tmpPosition.y = y
        
        self.mPlayerSkillState.mTargetDirection = tmpPosition  - self.mPosition
    end
  
end