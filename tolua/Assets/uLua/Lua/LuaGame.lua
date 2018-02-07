require("Class")

local GameObject = UnityEngine.GameObject
--主入口函数。从这里开始lua逻辑
--LuaGame.cs会调用LuaGame.lua执行Lua逻辑
LuaGame = {}
function LuaGame:Start()					
	print("LuaGame start")
	
	--添加Lua逻辑更新
	UpdateBeat:Add(LuaGame.Update,self)	 		
	LateUpdateBeat:Add(LuaGame.LateUpate,self)	 		
	FixedUpdateBeat:Add(LuaGame.FixedUpdate,self)	 	
	
	self.TestGameObject()
	
end



--场景切换通知
function LuaGame:OnLevelWasLoaded(level)
	collectgarbage("collect")
	Time.timeSinceLevelLoad = 0
end

function LuaGame:OnApplicationQuit()
end
--Lua逻辑更新
function LuaGame:Update()
	--print("LuaGame update")
    --print(self)
end

function LuaGame:LateUpate()
	--print("LuaGame LateUpate")

end

function LuaGame:FixedUpdate()
	--print("LuaGame FixedUpdate")

end

-------------------------------------------Test Start-----------------------------------------
function LuaGame.Test(self, go)

	self:Test1()
	print(go.name)
end

function LuaGame:Test1()

	print("test1")
	print(self)
	
end

function LuaGame:TestGameObject()


	local mainGo = GameObject('UI_Main')
	local mainBehaviour = mainGo:AddComponent(typeof(LuaBehaviour))
	local mainUI = Class:New(UI_Main)

	mainBehaviour:Init(mainUI)

	local mainGo1 = GameObject('UI_Main')
	local mainBehaviour1 = mainGo1:AddComponent(typeof(LuaBehaviour))
	local mainUI1 = Class:New(UI_Main)
	mainBehaviour1:Init(mainUI1)

	
	
	if mainUI ~= mainUI1 then
		print("mainUI!=mainUI1")
	else
		print("mainUI==mainUI1")
	end

end

-------------------------------------------Test End-----------------------------------------


return LuaGame