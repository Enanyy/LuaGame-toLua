require("Class")

local Input = UnityEngine.Input
local Physics = UnityEngine.Physics
local LayerMask = UnityEngine.LayerMask
local KeyCode = UnityEngine.KeyCode

PlayerInput = Class()

function PlayerInput:ctor(varPlayerCharacter, varCamera)
    self.mPlayerCharacter = varPlayerCharacter
    self.mCamera = varCamera
    self.mAttackIndex  = 0
end

function PlayerInput:Update()

    if self.mPlayerCharacter == nil then return end


    if self.mCamera then

        if Input.GetMouseButtonDown (0) then
           
            local tmpRay = self.mCamera:ScreenPointToRay (Input.mousePosition)
            local tmpLayer = 2 ^ LayerMask.NameToLayer("Default")                

            local tmpFlag, tmpHit = Physics.Raycast(tmpRay,nil, 5000, tmpLayer)
         

            if tmpFlag then
                if self.mPlayerCharacter then
                    self.mPlayerCharacter:MoveToPoint(tmpHit.point)
                end
            end
        end
    end
    
    if  Input.GetKeyDown (KeyCode.A) then 
  
        local tmpIndex = self.mAttackIndex % 3
        local tmpSkillType = PlayerSkillType.Attack_1
        if tmpIndex == 0 then
            tmpSkillType = PlayerSkillType.Attack_1
        elseif tmpIndex == 1 then
            tmpSkillType = PlayerSkillType.Attack_2
        elseif tmpIndex == 2 then
            tmpSkillType = PlayerSkillType.Attack_3
        end
        if self.mPlayerCharacter:PlaySkill(tmpSkillType) then
            self.mAttackIndex = self.mAttackIndex + 1
            if self.mAttackIndex > 2 then self.mAttackIndex = 0 end
        else 
            self.mAttackIndex = 0
        end
    end

    if  Input.GetKeyDown (KeyCode.Q) then 
        self.mPlayerCharacter:PlaySkill (PlayerSkillType.Skill_1)
    end
    if  Input.GetKeyDown (KeyCode.W) then 
        self.mPlayerCharacter:PlaySkill (PlayerSkillType.Skill_2)
    end
    if  Input.GetKeyDown (KeyCode.E) then 
        self.mPlayerCharacter:PlaySkill (PlayerSkillType.Skill_3)
    end
    if  Input.GetKeyDown (KeyCode.R) then 
        self.mPlayerCharacter:PlaySkill (PlayerSkillType.Skill_4)
    end

    if  Input.GetKeyDown (KeyCode.Space) then 
        self.mPlayerCharacter:PlaySkill (PlayerSkillType.Idle)
    end

end