require("Class")
require("BehaviourBase")
require("FashionBody")
require("PlayerSKillMachine")

local GameObject = UnityEngine.GameObject
local Quaternion = UnityEngine.Quaternion

PlayerCharacter = Class(BehaviourBase)

function PlayerCharacter:ctor()

    

end

function PlayerCharacter:CreatePlayerCharacter( varGuid, varPlayerInfo, varCallback)

    self.mGuid = varGuid
    self.mProfession = varPlayerInfo.profession
    self.mPlayerInfo = varPlayerInfo

    local tmpBody = GameObject ("FashionBody")
	tmpBody.transform:SetParent (self.transform)

	tmpBody.transform.localPosition = Vector3.zero
	tmpBody.transform.localScale = Vector3.one
	tmpBody.transform.transform.localRotation = Quaternion.identity

    self.mBody = FashionBody.new()
    local behaviour = tmpBody:AddComponent (typeof(LuaBehaviour))
    behaviour:Init(self.mBody)
    self.mBody:Init(behaviour)

	self.mBody:SetData (self, function (varBody)
		
			self:InitWithConfigure()
		
			if varCallback ~=nil then
			
				varCallback()
			end
	end)

end

function PlayerCharacter:InitWithConfigure()
    self.mSkillMachine = PlayerSKillMachine.new(self)
    self.mSkillMachine:Init(Role_Configure_Ahri)
end

function PlayerCharacter:Update()

    if self.mSkillMachine then
        self.mSkillMachine:OnExecute()
    end


end


function PlayerCharacter:MoveToPoint(varTargetPosition, varSuccessAction,varFailAction)

    local tmpDistance = Vector3.Distance (self.transform.position, Vector3.New (varTargetPosition.x, self.transform.position.y, varTargetPosition.z))

    if tmpDistance > 0.1 then


        self.targetPosition = varTargetPosition

        self:PlaySkill (PlayerSkillType.Run)
    end

end

function PlayerCharacter:PlaySkill(varSkillType)
	
	if self.mSkillMachine == nil then
		error ("PlayerSkillMachine is NULL.")
		return false
	end


	return	self.mSkillMachine.Cache (varSkillType)
end