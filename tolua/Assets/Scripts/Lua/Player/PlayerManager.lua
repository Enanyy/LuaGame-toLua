require("Class")
require("PlayerInfo")
require("PlayerCharacter")
require("SmoothFollow")
require("PlayerInput")
require("UnityClass")
require("UnityLayer")


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

    end

    return self
end

function  PlayerManager:CreatePlayerCharacter(varGuid,  varPlayerInfo, varCallback)
    
        local layer = UnityLayer.Player
    
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
                self.mCamera.depth = 0

                self.mSmoothFollow = SmoothFollow.new()
                self.mSmoothFollow.target = tmpPlayerCharacter.transform
                self.mSmoothFollow.followBehind = false
                self.mSmoothFollow.distance =3
                self.mSmoothFollow.height = 8

                local behaviour = camera:AddComponent(typeof(LuaBehaviour))
                behaviour:Init(self.mSmoothFollow)
                self.mSmoothFollow:Init(behaviour)

                self.mCamera.cullingMask = Helper.MakeMask( UnityLayer.Default, layer)
                NGUITools.SetLayer(camera, UnityLayer.Default)

              
                --输入控制
                self.mPlayerInput = PlayerInput.new(tmpPlayerCharacter,self.mCamera)
            end
		

			if varCallback ~= nil then

				varCallback (tmpPlayerCharacter)

            end
        end)

        local tmpFlag, tmpHit = NavMesh.SamplePosition(varPlayerInfo.position, nil, 10, NavMesh.AllAreas)
        if tmpFlag then
            tmpPlayerCharacter.transform.position = tmpHit.position
        end
        tmpPlayerCharacter.transform.rotation = Quaternion.Euler(varPlayerInfo.direction.x, varPlayerInfo.direction.y, varPlayerInfo.direction.z)

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

function PlayerManager:GetPlayerCharacter(varGuid)

    if self.mPlayerCharacterDic then

        for k,v in pairs(self.mPlayerCharacterDic) do
            if v.mGuid == varGuid then
                return v
            end
        end
    end

    return nil
end

function PlayerManager:RemovePlayerCharacter(varGuid)
    
    if self.mPlayerCharacterDic then
        local tmpPlayerCharacter = self.mPlayerCharacterDic[varGuid]
        table.remove( self.mPlayerCharacterDic, varGuid)

        if tmpPlayerCharacter then
           GameObject.Destroy(tmpPlayerCharacter.gameObject) 
        end
        tmpPlayerCharacter = nil

    end
end

--遍历mPlayerCharacterDic, func返回true跳出遍历
function PlayerManager:Foreach(func)

    if func == nil then return end

    if self.mPlayerCharacterDic then
        for k,v in pairs(self.mPlayerCharacterDic) do
           
            if func(v) then
                return 
            end
        end
    end
end