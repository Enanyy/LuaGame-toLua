require("Class")
require("StateMachine")
require("SceneType")
require("Pvp_000")
require("Pvp_001")
require("Pvp_002")
require("Pvp_003")
require("Pvp_004")
require("Pvp_005")

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

---注册场景列表
function SceneMachine:Init()

    self.mSceneDic[SceneType.Pvp_000] = Pvp_000.new(SceneType.Pvp_000)
    self.mSceneDic[SceneType.Pvp_001] = Pvp_001.new(SceneType.Pvp_001)
    self.mSceneDic[SceneType.Pvp_002] = Pvp_002.new(SceneType.Pvp_002)
    self.mSceneDic[SceneType.Pvp_003] = Pvp_003.new(SceneType.Pvp_003)
    self.mSceneDic[SceneType.Pvp_004] = Pvp_004.new(SceneType.Pvp_004)
    self.mSceneDic[SceneType.Pvp_005] = Pvp_005.new(SceneType.Pvp_005)

end

function SceneMachine:ChangeScene(sceneType)

    local current = self:GetCurrentState()

    if current then

        if current.name == sceneType then

            return;
        end
    end

    local scene = self.mSceneDic[sceneType]

    if scene == nil then
        return
    end

    self:ChangeState(scene)
    
end

