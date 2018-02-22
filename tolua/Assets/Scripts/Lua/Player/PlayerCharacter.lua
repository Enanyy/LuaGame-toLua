require("Class")
require("BehaviourBase")
require("FashionBody")
require("PlayerSKillMachine")

local GameObject = UnityEngine.GameObject
local Quaternion = UnityEngine.Quaternion

PlayerCharacter = Class(BehaviourBase)

function PlayerCharacter:ctor()

    self.mTargetPosition = Vector3.zero
    self.mFashionBody = nil

end

function PlayerCharacter:CreatePlayerCharacter( varGuid, varPlayerInfo, varCallback)

    self.mGuid = varGuid
    self.mProfession = varPlayerInfo.profession
    self.mPlayerInfo = varPlayerInfo
    self.mMoveSpeed = 0

    local tmpBody = GameObject ("FashionBody")
	tmpBody.transform:SetParent (self.transform)

	tmpBody.transform.localPosition = Vector3.zero
	tmpBody.transform.localScale = Vector3.one
	tmpBody.transform.transform.localRotation = Quaternion.identity

    self.mFashionBody = FashionBody.new()
    local behaviour = tmpBody:AddComponent (typeof(LuaBehaviour))
    behaviour:Init(self.mFashionBody)
    self.mFashionBody:Init(behaviour)

	self.mFashionBody:SetData (self, function (varBody)
		
			self:InitWithConfigure()
		
			if varCallback ~=nil then
			
				varCallback()
			end
	end)

end

function PlayerCharacter:InitWithConfigure()
    self.mSkillMachine = PlayerSKillMachine.new(self)
    self.mSkillMachine:Init(self.mPlayerInfo.configure)
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