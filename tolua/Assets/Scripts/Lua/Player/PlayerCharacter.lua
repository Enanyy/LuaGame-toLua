require("Class")
require("UnityClass")
require("BehaviourBase")
require("FashionBody")
require("FashionWeapon")
require("PlayerSKillMachine")
require("PlayerEffectMachine")
require("UnityLayer")

PlayerCharacter = Class("PlayerCharacter",BehaviourBase)

function PlayerCharacter:ctor()

    self.mGuid = 0
    self.mProfession = 0
    self.mPlayerInfo = nil
    self.mMoveSpeed = 0
    self.mAttackTimeInterval = 1
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

    local go = GameObject ("FashionBody")
	
    NGUITools.SetLayer(go, self.gameObject.layer)

    SetParent(go, self.transform)   
    SetLocalPosition(go, Vector3.zero)
    SetLocalRotation(go, Quaternion.identity)
    SetScale(go, Vector3.one)

    self.mFashionBody = FashionBody.new()
 
    AddLuaBehaviour(go, self.mFashionBody)

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

    local go = GameObject ("FashionWeapnon")

    NGUITools.SetLayer(go, self.gameObject.layer)

    SetParent(go, self.transform)   
    SetLocalPosition(go, Vector3.zero)
    SetLocalRotation(go, Quaternion.identity)
    SetScale(go, Vector3.one)

    self.mFashionWeapon = FashionWeapon.new()

    AddLuaBehaviour(go,self.mFashionWeapon)

	self.mFashionWeapon:SetData (self, function (varWeapon)
		
			
	end)

end

function PlayerCharacter:InitWithConfig()

    self.mEffectMachine = PlayerEffectMachine.new()

    self.mSkillMachine = PlayerSKillMachine.new(self)

    self.mSkillMachine:InitWithConfig(self.mPlayerInfo.configure)
    
end

function PlayerCharacter:Update()

    if self.mAttackTimeInterval > 0 then
        self.mAttackTimeInterval = self.mAttackTimeInterval - Time.deltaTime
    end
    if self.mAttackTimeInterval < 0 then
        self.mAttackTimeInterval = 0
    end

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

    local position = GetPosition(self.gameObject)
    local tmpDistance = Vector3.Distance (position, Vector3.New (varTargetPosition.x, position.y, varTargetPosition.z))

    if tmpDistance > 0.1 then


        self.mMoveSuccessAction = varSuccessAction
        self.mMoveFailAction    = varFailAction
        self.mTargetPosition    = varTargetPosition

        self:PlaySkill (PlayerSkillType.Run)
    else
        if varSuccessAction then
            varSuccessAction()
        end
    end

end

function PlayerCharacter:PlaySkill(varSkillType)
	
	if self.mSkillMachine == nil then
		error ("PlayerSkillMachine is NULL.")
		return false
	end

    if  varSkillType == PlayerSkillType.Attack_1 or 
        varSkillType == PlayerSkillType.Attack_2 or 
        varSkillType == PlayerSkillType.Attack_3 then

        if self.mAttackTimeInterval > 0 then
            return false
        end

        self.mAttackTimeInterval = self.mPlayerInfo.attackTimeInterval * (1 - self.mPlayerInfo.attackSpeedAddition)
        
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

    if self.mMoveSuccessAction then
        self.mMoveSuccessAction()
        self.mMoveSuccessAction = nil
    end
end

function PlayerCharacter:OnMoveToPointFail()
   
    if self.mMoveFailAction then
        self.mMoveFailAction()
        self.mMoveFailAction = nil
    end
end

function PlayerCharacter:SetLockPlayerCharacter(varPlayerCharacter)

    self.mLockPlayerCharacter = varPlayerCharacter

end