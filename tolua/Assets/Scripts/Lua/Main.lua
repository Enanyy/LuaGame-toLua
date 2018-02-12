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
	--]]
	--self:TestOverWrite()
	
	--[[ 
	
	AssetManager:Load("assetbundle.unity3d", "Assets/R/UI/UI_Main/UI_Main.prefab", function (varObject) 
		if varObject then
			local go = GameObject.Instantiate(varObject)
		end
	end)
	--local dataPath = AssetManager.GetAssetBundlePath()
	--print(dataPath)
	--]]
	WindowManager:Open(UI_Main, "UI_Main")
	
end



--场景切换通知
function Main:OnLevelWasLoaded(level)
	collectgarbage("collect")

	print("Main:OnLevelWasLoaded")
	Time.timeSinceLevelLoad = 0

	local tmpPlayerInfo = PlayerInfo.new(1)
	tmpPlayerInfo.guid = 0
	tmpPlayerInfo.baseSpeed = 6
	tmpPlayerInfo.moveSpeedAddition = 0.3
	tmpPlayerInfo.character = "Ahri"
	tmpPlayerInfo.skin = "Ahri_shadowfox"

	local t = {}
	t[0] = "1111"

	PlayerManager:CreatePlayerCharacter(0, tmpPlayerInfo, function (varPlayerCharacter) 
	
	
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