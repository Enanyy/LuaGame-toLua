require("Class")
require("UnityClass")
require("BehaviourBase")
require("FashionBody")
require("FashionWeapon")
require("PlayerSKillMachine")
require("PlayerEffectMachine")
require("UnityLayer")

PlayerCharacter = Class(BehaviourBase)

function PlayerCharacter:ctor()

    self.mGuid = 0
    self.mProfession = 0
    self.mPlayerInfo = nil
    self.mMoveSpeed = 0
    self.mCallback = nil
    self.mLockPlayerCharacter = nil
    

    self.mTargetPosition = Vector3.zero
    self.mFashionBody = nil
    self.mFashionWeapon = nil

end

function PlayerCharacter:CreatePlayerCharacter( varGuid, varPlayerInfo, varCallback)

    self.mGuid = varGuid
    self.mProfession = varPlayerInfo.profession
    self.mPlayerInfo = varPlayerInfo
    self.mMoveSpeed = 0

    self.mCallback = varCallback

    self:CreateFashionBody()

end

function PlayerCharacter:CreateFashionBody()

    local tmpBody = GameObject ("FashionBody")
	tmpBody.transform:SetParent (self.transform)
    NGUITools.SetLayer(tmpBody, self.gameObject.layer)

	tmpBody.transform.localPosition = Vector3.zero
	tmpBody.transform.localScale = Vector3.one
	tmpBody.transform.transform.localRotation = Quaternion.identity

    self.mFashionBody = FashionBody.new()
    local behaviour = tmpBody:AddComponent (typeof(LuaBehaviour))
    behaviour:Init(self.mFashionBody)
    self.mFashionBody:Init(behaviour)

	self.mFashionBody:SetData (self, function (varBody)
		
			self:InitWithConfig()
        
            self:CreateFashionWeapon()
            
			if self.mCallback ~=nil then
			
				self.mCallback()
            end
            
            self.mCallback = nil
	end)
end

function PlayerCharacter:CreateFashionWeapon()

    local tmpWeapnon = GameObject ("FashionWeapnon")
	tmpWeapnon.transform:SetParent (self.transform)
    NGUITools.SetLayer(tmpWeapnon, self.gameObject.layer)
    
	tmpWeapnon.transform.localPosition = Vector3.zero
	tmpWeapnon.transform.localScale = Vector3.one
	tmpWeapnon.transform.transform.localRotation = Quaternion.identity

    self.mFashionWeapon = FashionWeapon.new()
    local behaviour = tmpWeapnon:AddComponent (typeof(LuaBehaviour))
    behaviour:Init(self.mFashionWeapon)
    self.mFashionWeapon:Init(behaviour)

	self.mFashionWeapon:SetData (self, function (varWeapon)
		
			
	end)

end

function PlayerCharacter:InitWithConfig()
    self.mSkillMachine = PlayerSKillMachine.new(self)
    self.mSkillMachine:InitWithConfig(self.mPlayerInfo.configure)
    
    self.mEffectMachine = PlayerEffectMachine.new()

end

function PlayerCharacter:Update()

    --print("PlayerCharacter:Update")
    if self.mSkillMachine then

        local current = self.mSkillMachine:GetCurrentState()

        if current == nil then
            self.mSkillMachine:Cache(PlayerSkillType.Idle)
        end

        self.mSkillMachine:OnExecute()

    end

    if self.mEffectMachine then

        self.mEffectMachine:OnExecute()
    
    end

end


function PlayerCharacter:MoveToPoint(varTargetPosition, varSuccessAction,varFailAction)

    local tmpDistance = Vector3.Distance (self.transform.position, Vector3.New (varTargetPosition.x, self.transform.position.y, varTargetPosition.z))

    if tmpDistance > 0.1 then


        self.mMoveSuccessAction = varSuccessAction
        self.mMoveFailAction    = varFailAction
        self.mTargetPosition    = varTargetPosition

        self:PlaySkill (PlayerSkillType.Run)
    end

end

function PlayerCharacter:PlaySkill(varSkillType)
	
	if self.mSkillMachine == nil then
		error ("PlayerSkillMachine is NULL.")
		return false
	end


	return	self.mSkillMachine:Cache (varSkillType)
end

function PlayerCharacter:Pause()
    if self.mSkillMachine then
        self.mSkillMachine:Pause()
    end

    if self.mEffectMachine then
        self.mEffectMachine:Pause()
    end
end

function PlayerCharacter:Resume()

    if self.mSkillMachine then
        self.mSkillMachine:Resume()
    end
    if self.mEffectMachine then 
        self.mEffectMachine:Resume()
    end
end

function PlayerCharacter:isPause()

    if self.mSkillMachine then
        return self.mSkillMachine:isPause()
    end 

    return false
end

function PlayerCharacter:OnMoveToPointSuccess()
    print("移动成功")

    if self.mMoveSuccessAction then
        self.mMoveSuccessAction()
        self.mMoveSuccessAction = nil
    end
end

function PlayerCharacter:OnMoveToPointFail()
    print("移动失败")

    if self.mMoveFailAction then
        self.mMoveFailAction()
        self.mMoveFailAction = nil
    end
end

function PlayerCharacter:LockPlayerCharacter(varPlayerCharacter)

    self.mLockPlayerCharacter = varPlayerCharacter

end