require("Class")
require("PlayerInfo")
require("PlayerCharacter")
require("PlayerInput")

local GameObject = UnityEngine.GameObject
local Quaternion = UnityEngine.Quaternion
local Camera = UnityEngine.Camera

--local NavMesh = UnityEngine.AI.NavMesh    -- Unity5.6
--local NavMeshHit = UnityEngine.AI.NavMeshHit --Unity5.6
local NavMesh = UnityEngine.NavMesh    
local NavMeshHit = UnityEngine.NavMeshHit

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

        self.mPlayerCharacterDic = {}           --人物列表

        self.mPlayerCharacterSelf = nil         --自己

    end

    return self
end

function  PlayerManager:CreatePlayerCharacter(varGuid,  varPlayerInfo, varCallback)
    
        local layer = LayerMask.NameToLayer("Default")
    
		local go =  GameObject (tostring(varGuid))
        NGUITools.SetLayer(go, layer)

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
                camera.tag = "MainCamera"
                self.mCamera = camera:AddComponent(typeof(Camera))
                self.mSmoothFollow = camera:AddComponent(typeof(SmoothFollow))
                self.mSmoothFollow.target = tmpPlayerCharacter.transform
                self.mSmoothFollow.followBehind = false
                self.mSmoothFollow.distance =3
                self.mSmoothFollow.height = 8

                NGUITools.MakeMask(self.mCamera, layer)
                NGUITools.SetLayer(camera, layer)

                self.mPlayerCharacterSelf = tmpPlayerCharacter
                --输入控制
                self.mPlayerInput = PlayerInput.new(tmpPlayerCharacter,self.mCamera)
            end
		

			if varCallback ~= nil then

				varCallback (tmpPlayerCharacter)

            end
        end)

        local tmpFlag, tmpHit = NavMesh.SamplePosition(Vector3.zero, nil, 10, NavMesh.AllAreas)
        if tmpFlag then
            tmpPlayerCharacter.transform.position = tmpHit.position
        end

        self.mPlayerCharacterDic[varGuid] = tmpPlayerCharacter
       
end


function PlayerManager:Update()

    if self.mPlayerCharacterDic then

        for k,v in pairs(self.mPlayerCharacterDic) do

            v:Update()
        end

    end

    if self.mPlayerInput then
        self.mPlayerInput:Update()
    end
end