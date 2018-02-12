require("Class")
require("AssetManager")
require("WindowManager")
require("PlayerManager")
----
----Lua表不要与C#中需要Wrap的类同名，会引起混乱
----

local GameObject = UnityEngine.GameObject
local Stack = System.Collections.Stack
local Time = UnityEngine.Time

--主入口函数。从这里开始lua逻辑
--LuaGame.cs会调用Main.lua执行Lua逻辑
Main = {}

function Main:DebugMode()
	
	return true
end

function Main:AssetMode()
	local assetmode = UnityEngine.PlayerPrefs.GetInt("assetmode")
	return assetmode
end

function Main:Start()					
	print("Main start")
	
	--初始化资源管理器
	AssetManager:Initialize()
	--初始化窗口管理器
	WindowManager:Initialize()
	--初始化人物管理器
	PlayerManager:Initialize()

	--添加Lua逻辑更新
	UpdateBeat:Add(Main.Update,self)	 		
	LateUpdateBeat:Add(Main.LateUpate,self)	 		
	FixedUpdateBeat:Add(Main.FixedUpdate,self)	 	
	
	--[[ 
	--self.TestGameObject()
	--self.TestStack()
	--]]

	--[[ 
	--测试是否单例模式
	local a = AssetManager:Initialize()
	local b = AssetManager:Initialize()

	if a == b then
		print("a == b")
	else
		print("a != b")		
	end
	
	--self:TestOverWrite()
		
	--]]
	WindowManager:Open(UI_Main, "UI_Main")
	
end



--场景切换通知
function Main:OnLevelWasLoaded(level)
	collectgarbage("collect")

	Time.timeSinceLevelLoad = 0

	local tmpPlayerInfo = PlayerInfo.new(1)
	tmpPlayerInfo.guid = 0
	tmpPlayerInfo.position = Vector3.New(4,0, 8)
	tmpPlayerInfo.baseSpeed = 6
	tmpPlayerInfo.moveSpeedAddition = 0.3
	tmpPlayerInfo.character = "Ahri"
	tmpPlayerInfo.skin = "Ahri_shadowfox"


	PlayerManager:CreatePlayerCharacter(tmpPlayerInfo.guid, tmpPlayerInfo, function (varPlayerCharacter) 
	
	
	end)

	local tmpPlayerInfo1 = PlayerInfo.new(1)
	tmpPlayerInfo1.guid = 1
	tmpPlayerInfo1.position = Vector3.New(5,0, 6)
	tmpPlayerInfo1.baseSpeed = 6
	tmpPlayerInfo1.moveSpeedAddition = 0.3
	tmpPlayerInfo1.character = "Ahri"
	tmpPlayerInfo1.skin = "Ahri"

	PlayerManager:CreatePlayerCharacter(tmpPlayerInfo1.guid, tmpPlayerInfo1, function (varPlayerCharacter) 
	
	
	end)

	local tmpPlayerInfo2 = PlayerInfo.new(1)
	tmpPlayerInfo2.guid = 2
	tmpPlayerInfo2.position = Vector3.New(5,0, 8)
	tmpPlayerInfo2.baseSpeed = 6
	tmpPlayerInfo2.moveSpeedAddition = 0.3
	tmpPlayerInfo2.character = "Ahri"
	tmpPlayerInfo2.skin = "Ahri_hanbok"

	PlayerManager:CreatePlayerCharacter(tmpPlayerInfo2.guid, tmpPlayerInfo2, function (varPlayerCharacter) 
	
	
	end)
end

function Main:OnApplicationQuit()
end
--Lua逻辑更新
function Main:Update()
	--print("LuaGame update")

	--资源管理器更新
	AssetManager:Update()

	--人物管理器更新
	PlayerManager:Update()


end

function Main:LateUpate()

end

function Main:FixedUpdate()

end

-------------------------------------------Test Start-----------------------------------------
--测试static函数
function Main.Test(self, go)

	self:Test1()
	print(go.name)
end


---测试 C# string[] 数组 array 是C#中传入的数组
function Main:Test1(array)

	print("array length =" .. array.Length)
	for i = 0, array.Length - 1 do
		print("array[".. i .."] =" .. array:GetValue(i))
	end
	
	

	print(self)
	
end
--测试创建GameObject
function Main:TestGameObject()

    LuaGame.DoFile("UI_Main")
	
	local mainGo = GameObject('UI_Main')
	local mainBehaviour = mainGo:AddComponent(typeof(LuaBehaviour))
	local mainUI = UI_Main.new()
	mainUI.data = "AAAAAAA"

	mainBehaviour:Init(mainUI)

	local mainGo1 = GameObject('UI_Main1')
	local mainBehaviour1 = mainGo1:AddComponent(typeof(LuaBehaviour))
	local mainUI1 = UI_Main.new()
	mainUI1.data = "BBBBBBB"
	mainBehaviour1:Init(mainUI1)

	
	
	if mainUI ~= mainUI1 then
		print("mainUI!=mainUI1")
	else
		print("mainUI==mainUI1")
	end

end


----测试C#导出栈类
function Main.TestStack()
    
    local stack = Stack.New()
    stack:Push(1)
    stack:Push(2)
    stack:Push(3)

    print("top:"..stack:Peek())

end

--测试继承和重写
A = Class()
function A:print()
	print("A:print")
end

B = Class(A)

function B:ctor()
	--self.base = A.new()
end
--[[
function B:print()
	print("B:print")

	self.base:print()
end
--]]
function Main:TestOverWrite()

	local a = A.new()
	a:print()

	--没有重写 调用A的print
	local b = B.new()
	b:print()

end

-------------------------------------------Test End-----------------------------------------


return Main