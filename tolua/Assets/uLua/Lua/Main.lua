require("class")

----
----Lua表不要与C# 需要Wrap的类同名
----

local GameObject = UnityEngine.GameObject
--主入口函数。从这里开始lua逻辑
--LuaGame.cs会调用Main.lua执行Lua逻辑
Main = {}
function Main:Start()					
	print("Main start")
	
	--添加Lua逻辑更新
	UpdateBeat:Add(Main.Update,self)	 		
	LateUpdateBeat:Add(Main.LateUpate,self)	 		
	FixedUpdateBeat:Add(Main.FixedUpdate,self)	 	
	
	self.TestGameObject()
	
end



--场景切换通知
function Main:OnLevelWasLoaded(level)
	collectgarbage("collect")
	Time.timeSinceLevelLoad = 0
end

function Main:OnApplicationQuit()
end
--Lua逻辑更新
function Main:Update()
	--print("LuaGame update")
    --print(self)
end

function Main:LateUpate()
	--print("LuaGame LateUpate")

end

function Main:FixedUpdate()
	--print("LuaGame FixedUpdate")

end

-------------------------------------------Test Start-----------------------------------------
function Main.Test(self, go)

	self:Test1()
	print(go.name)
end

function Main:Test1()

	print("test1")
	print(self)
	
end

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

-------------------------------------------Test End-----------------------------------------


return Main