local GameObject = UnityEngine.GameObject
--主入口函数。从这里开始lua逻辑
LuaGame = {}
function LuaGame:Start()					
	print("logic start")
	print(self)
	--添加Lua逻辑更新
	UpdateBeat:Add(LuaGame.Update,self);	 		
	LateUpdateBeat:Add(LuaGame.LateUpate,self);	 		
	FixedUpdateBeat:Add(LuaGame.FixedUpdate,self);	 	
	
	local go = GameObject('UI_Main')
	local behaviour = go:AddComponent(typeof(LuaBehaviour))
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
	--print("logic update")
    --print(self)
end

function LuaGame:LateUpate()
	--print("logic LateUpate")

end

function LuaGame:FixedUpdate()
	--print("logic FixedUpdate")

end

return LuaGame