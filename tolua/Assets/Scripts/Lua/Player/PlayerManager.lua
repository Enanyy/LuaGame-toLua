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

        AddLuaBehaviour(go, "PlayerManager", self)

        self.mPlayerCharacterList = {}           --人物列表

    end

    return self
end

function  PlayerManager:CreatePlayerCharacter(varGuid,  varPlayerInfo, varCallback)
    
        local layer = UnityLayer.Player
    
		local go =  GameObject (tostring(varGuid))
        NGUITools.SetLayer(go, layer)
      
        SetParent(go, self.transform)   
        SetLocalPosition(go, Vector3.zero)
        SetLocalRotation(go, Quaternion.identity)
        SetScale(go, Vector3.one)

        local tmpPlayerCharacter = PlayerCharacter.new()
        
        AddLuaBehaviour(go, "PlayerCharacter",tmpPlayerCharacter)

		tmpPlayerCharacter:CreatePlayerCharacter (varGuid, varPlayerInfo, function()

            if varGuid == 0 then
                local camera = GameObject("MainCamera")
                GameObject.DontDestroyOnLoad(camera)
                camera.tag = "MainCamera"
                self.mCamera = AddComponent(camera,typeof(Camera))
                self.mCamera.depth = 0

                self.mSmoothFollow = SmoothFollow.new()
                self.mSmoothFollow.target = tmpPlayerCharacter.gameObject
               
                self.mSmoothFollow.distance =3
                self.mSmoothFollow.height = 12
                self.mSmoothFollow.rotation = Vector3.New(76,0,0)

                AddLuaBehaviour(camera, "SmoothFollow", self.mSmoothFollow )

                self.mCamera.cullingMask = UnityLayer.MakeMask( UnityLayer.Default, layer)
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
            
            SetPosition(go,tmpHit.position)
        end
     
        SetEuler(go, varPlayerInfo.direction)

        table.insert( self.mPlayerCharacterList, tmpPlayerCharacter )
           
end


function PlayerManager:Update()

    if self.mPlayerCharacterList then

        for i,v in ipairs(self.mPlayerCharacterList) do

            v:Update()
        end

    end

    if self.mPlayerInput then
        self.mPlayerInput:Update()
    end
end

function PlayerManager:GetPlayerCharacter(varGuid)

    if self.mPlayerCharacterList then

       for i,v in ipairs(self.mPlayerCharacterList) do
            if v.mGuid == varGuid then

                return v

            end
       end

    end

    return nil
end

function PlayerManager:RemovePlayerCharacter(varGuid)
    
    local list = {}
    if self.mPlayerCharacterList then

        for i,v in ipairs(self.mPlayerCharacterList) do
            
            if v.mGuid == varGuid then

                table.insert( list, v)

                table.remove( self.mPlayerCharacterList, i )

                break

            end

        end

    end

    for i,v in ipairs(list) do

        if v then
            local current = v.mSkillMachine:GetCurrentState()
            if current ~= nil then
                current:OnExit()
            end

            v.mEffectMachine:Clear()

            GameObject.Destroy(v.gameObject) 
        end
    end
end

--遍历mPlayerCharacterList, func返回true跳出遍历
function PlayerManager:Foreach(func)

    if func == nil then return end

    if self.mPlayerCharacterList then
        for i,v in ipairs(self.mPlayerCharacterList) do
           
            if func(v) then
                return 
            end
        end
    end
end

function PlayerManager:Count()
    
    if self.mPlayerCharacterList then
        return table.getn(self.mPlayerCharacterList)
    end

    return 0
end