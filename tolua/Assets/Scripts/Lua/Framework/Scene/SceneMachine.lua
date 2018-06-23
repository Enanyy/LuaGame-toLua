require("Class")
require("StateMachine")
require("Pvp_001")


SceneMachine = Class("SceneMachine",StateMachine).new()


function SceneMachine:Initialize()

    --确保只被初始化一次
   if  self.initialized  == nil or self.initialized == false then
   
       self.initialized = true
      
       self.mSceneDic = {}           --场景
   
       self:Init()
       
    end

   return self
end

function SceneMachine:RegisterScene(scene)

    local name = scene.GetType()

    self.mSceneDic[name] = scene.new(name)

end
---注册场景列表
function SceneMachine:Init()

    self:RegisterScene(Pvp_001)

end

function SceneMachine:ChangeScene(scene)

    local current = self:GetCurrentState()

    local sceneType = scene.GetType()

    if current then

        if current.name == sceneType then

            return;
        end
    end

    local state = self.mSceneDic[sceneType]

    if state == nil then
        return
    end

    self:ChangeState(state)
    
end

