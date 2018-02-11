require("Class")
require("PlayerInfo")
require("PlayerCharacter")

local GameObject = UnityEngine.GameObject
local Quaternion = UnityEngine.Quaternion

PlayerManager = Class(BehaviourBase).new()

function PlayerManager:ctor()

    self.mPlayerCharacterDic = {} --人物列表

end

--初始化函数
function  PlayerManager:Initialize()

     --确保只被初始化一次
    if  self.initialized  == nil or self.initialized == false then
    
        self.initialized = true
        local go = GameObject('PlayerManager')     
        GameObject.DontDestroyOnLoad(go)

        local behaviour = go:AddComponent(typeof(LuaBehaviour))  
        behaviour:Init(self)
        self:Init(behaviour)

    end

    return self
end

function  PlayerManager:CreatePlayerCharacter(varGuid,  varPlayerInfo, varCallback)
	
		local go =  GameObject (tostring(varGuid))

		go.transform:SetParent (self.transform)
		go.transform.localScale = Vector3.one
		go.transform.localPosition = Vector3.zero
		go.transform.localRotation = Quaternion.identity

        local behaviour = go:AddComponent(typeof(LuaBehaviour))
        local tmpPlayerCharacter = PlayerCharacter.new()

        behaviour:Init(tmpPlayerCharacter)
        tmpPlayerCharacter:Init(behaviour)

		tmpPlayerCharacter:CreatePlayerCharacter (varGuid, varPlayerInfo, function()

			--[[
			SmoothFollow tmpSmoothFollow = Camera.main.GetComponent<SmoothFollow>()
			if(tmpSmoothFollow == null)tmpSmoothFollow = Camera.main.gameObject.AddComponent<SmoothFollow>()
			tmpSmoothFollow.target = tmpPlayerCharacter.transform
			tmpSmoothFollow.followBehind = false
			tmpSmoothFollow.distance =3
			tmpSmoothFollow.height = 8

		    --]]

			if varCallback ~= nil then

				varCallback (tmpPlayerCharacter)

            end
        end)

        if tmpPlayerCharacter == nil then
            print("tmpPlayerCharacter nil")
        end


       if self.mPlayerCharacterDic == nil then self.mPlayerCharacterDic = {} end
       --table.insert(self.mPlayerCharacterDic, tmpPlayerCharacter)
       self.mPlayerCharacterDic[varGuid] = tmpPlayerCharacter
       
end


function PlayerManager:Update()


end