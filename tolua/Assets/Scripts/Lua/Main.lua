require("Class")
require("UnityClass")
require("DatabaseManager")
require("AssetManager")
require("WindowManager")
require("PlayerManager")
require("SceneMachine")


require("Test")


----
----Lua表不要与C#中需要Wrap的类同名，会引起混乱
----

--主入口函数。从这里开始lua逻辑
--LuaGame.cs会调用Main.lua执行Lua逻辑
Main = {}

function Main.GetType()
	return "Main"
end

function Main:DebugMode()
	
	return true

end

--资源读取方式
function Main:AssetMode()

	local assetmode = 1
	if LuaGame.EditorMode() then
		assetmode =  UnityEngine.PlayerPrefs.GetInt("assetmode")
	end
	return assetmode
end

function Main:Start()

	Test:onTest()

	print("assetmode = ",self:AssetMode())
	LuaGame.Log(AssetManager.GetAssetBundlePath())
	--初始化资源管理器
	AssetManager:Initialize()
	--初始化窗口管理器
	WindowManager:Initialize()
	--初始化人物管理器
	PlayerManager:Initialize()
	--初始化场景状态机
	SceneMachine:Initialize()
	--数据管理器
	DatabaseManager:Initialize()

	--添加Lua逻辑更新
	self.update = UpdateBeat:CreateListener(self.Update,self)		
	self.lateUpate = LateUpdateBeat:CreateListener(Main.LateUpate,self)	 		
	self.fixedUpdate = FixedUpdateBeat:CreateListener(Main.FixedUpdate,self)	 	
	
	UpdateBeat:AddListener(self.update)
	LateUpdateBeat:AddListener(self.lateUpate)
	FixedUpdateBeat:AddListener(self.fixedUpdate)

	SceneMachine:ChangeScene(Pvp_001)

end



--场景切换通知
function Main:OnLevelWasLoaded(level)
	collectgarbage("collect")

	Time.timeSinceLevelLoad = 0

	WindowManager:Open(UI_Main)

	self:CreatePlayer()

end


function Main:CreatePlayer()

	local mode = 0
	for i = 0, 3 do
		
		local tmpPlayerInfo = PlayerInfo.new(i)
		tmpPlayerInfo.guid = i
		tmpPlayerInfo.position = Vector3.New(55-1*i,0, 30+1*i)
		tmpPlayerInfo.direction = Vector3.New(0, -120+ i*10, 0)
		tmpPlayerInfo.baseSpeed = 6
		tmpPlayerInfo.moveSpeedAddition = 0.3

		mode = i % 3
		if mode == 0 then
			tmpPlayerInfo.prefab = string.format("Assets/R/Character/Ahri/Prefabs/%s.prefab","Ahri_shadowfox")
		elseif mode == 1 then
			tmpPlayerInfo.prefab = string.format("Assets/R/Character/Ahri/Prefabs/%s.prefab","Ahri")	
		else
			tmpPlayerInfo.prefab = string.format("Assets/R/Character/Ahri/Prefabs/%s.prefab","Ahri_hanbok")	
		end

		tmpPlayerInfo.weapon ="Assets/R/Weapon/Ahri/Ahri.prefab"

		tmpPlayerInfo.configure = Role_Configure_Ahri
		
	
		PlayerManager:CreatePlayerCharacter(tmpPlayerInfo.guid, tmpPlayerInfo, function (varPlayerCharacter) 
		
		
		end)
		
	end
end

function Main:OnApplicationQuit()
end
--Lua逻辑更新
function Main:Update()
	--print("LuaGame update")

	--local start = os.clock()
	--资源管理器更新
	AssetManager:Update()

	--人物管理器更新
	PlayerManager:Update()
	--print("Main Update: " .. ((os.clock() - start) * 1000))

	--NetWorkManager:Update()
	
end

function Main:LateUpate()

end

function Main:FixedUpdate()

end

return Main