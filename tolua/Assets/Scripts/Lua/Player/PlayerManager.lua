require("Class")
require("PlayerInfo")
require("PlayerCharacter")

local GameObject = UnityEngine.GameObject
local Quaternion = UnityEngine.Quaternion
local Camera = UnityEngine.Camera

PlayerManager = Class(BehaviourBase).new()

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

        self.mPlayerCharacterDic = {} --人物列表

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

            if varGuid == 0 then
                local camera = GameObject("MainCamera")
                GameObject.DontDestroyOnLoad(camera)
                camera:AddComponent(typeof(Camera))
                self.mSmoothFollow = camera:AddComponent(typeof(SmoothFollow))
                self.mSmoothFollow.target = tmpPlayerCharacter.transform
                self.mSmoothFollow.followBehind = false
                self.mSmoothFollow.distance =3
                self.mSmoothFollow.height = 8
            end
		

			if varCallback ~= nil then

				varCallback (tmpPlayerCharacter)

            end
        end)

        if tmpPlayerCharacter == nil then
            print("tmpPlayerCharacter nil")
        end


       --if self.mPlayerCharacterDic == nil then self.mPlayerCharacterDic = {} end
       --able.insert(self.mPlayerCharacterDic, tmpPlayerCharacter)
       self.mPlayerCharacterDic[varGuid] = tmpPlayerCharacter
       
end


function PlayerManager:Update()

    --print("PlayerManager:Update")
    if self.mPlayerCharacterDic then

        for k,v in pairs(self.mPlayerCharacterDic) do

            v:Update()
            --print("PlayerManager:Update " .. k)
        end

    end

end