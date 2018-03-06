require("Class")
require("UnityLayer")
PlayerInput = Class()

function PlayerInput:ctor(varPlayerCharacter, varCamera)
    self.mPlayerCharacter = varPlayerCharacter
    self.mCamera = varCamera
    self.mAttackIndex  = 0
end

function PlayerInput:Update()

    if self.mPlayerCharacter == nil then return end

    
    if self.mCamera then

        if Input.GetMouseButtonDown (1) then
           
            --点击了UI
            if UICamera.Raycast(Input.mousePosition) == true then
            
                return
            end

            local tmpRay = self.mCamera:ScreenPointToRay (Input.mousePosition)
            
            local tmpLayer = UnityLayer.MakeMask(UnityLayer.Default)

            local tmpFlag, tmpHit = Physics.Raycast(tmpRay,nil, 5000, tmpLayer)
         
            
            if tmpFlag then
               
                if tmpHit.collider.gameObject.layer == UnityLayer.Default then
                    if self.mPlayerCharacter then
                        self.mPlayerCharacter:MoveToPoint(tmpHit.point)
                    end    
                end
            end
        elseif Input.GetMouseButtonDown (0) then

            if UICamera.Raycast(Input.mousePosition) == true then
            
                return
            end

            local tmpRay = self.mCamera:ScreenPointToRay (Input.mousePosition)
            
            local tmpLayer = UnityLayer.MakeMask(UnityLayer.Player, UnityLayer.NPC, UnityLayer.Monster)

            local tmpFlag, tmpHit = Physics.Raycast(tmpRay,nil, 5000, tmpLayer)
         
            
            if tmpFlag then
                local layer = tmpHit.collider.gameObject.layer 
                if  layer == UnityLayer.Player or 
                    layer == UnityLayer.NPC or 
                    layer == UnityLayer.Monster
                then
                   
                    self:OnClick(tmpHit.collider.gameObject)
                 
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

   
    
    if  Input.GetKeyDown (KeyCode.P) then 
        if self.mPlayerCharacter:isPause() then
            self.mPlayerCharacter:Resume()
        else
            self.mPlayerCharacter:Pause()
        end
    end

    if  Input.GetKeyDown (KeyCode.Space) then 
        self.mPlayerCharacter:PlaySkill (PlayerSkillType.Idle)
        self.mPlayerCharacter:SetLockPlayerCharacter(nil)
    end

    --移除一个人物
    if  Input.GetKeyDown (KeyCode.V) then 
        PlayerManager:RemovePlayerCharacter(2)
    end

    ---切换控制目标
    if  Input.GetKeyDown (KeyCode.LeftShift) then 
        
        if self.mLastGuid == nil then
            self.mLastGuid = self.mPlayerCharacter.mGuid
        end

        local tmpLastPlayerCharacter

        PlayerManager:Foreach(function (varPlayerCharacter) 
            
            if varPlayerCharacter and varPlayerCharacter.mGuid ~= self.mPlayerCharacter.mGuid then

                tmpLastPlayerCharacter = varPlayerCharacter
                if tmpLastPlayerCharacter.mGuid ~= self.mLastGuid then
                    return true
                end
              
            end

        end)

        if tmpLastPlayerCharacter then
            self.mLastGuid = self.mPlayerCharacter.mGuid

            self.mPlayerCharacter = tmpLastPlayerCharacter 

            local tmpSmoothFollow = PlayerManager.mSmoothFollow
            if tmpSmoothFollow then
                tmpSmoothFollow.target = self.mPlayerCharacter.transform
            end
        end
    end

end

function PlayerInput:OnClick(gameObject)

    if gameObject == nil or  gameObject.transform.parent == nil then
        return
    end

    local behaviour = gameObject.transform.parent:GetComponent(typeof(LuaBehaviour))
    if behaviour == nil then
        return
    end

    local fashionBody = behaviour.luaTable
    if fashionBody == nil or  fashionBody.mPlayerCharacter == nil then

        return 
    end 
    if fashionBody.mPlayerCharacter.mPlayerInfo.guid == self.mPlayerCharacter.mPlayerInfo.guid then
        return
    end

    self.mPlayerCharacter:SetLockPlayerCharacter(fashionBody.mPlayerCharacter)

end