require("State")
require("UnityClass")

Scene = Class("Scene",State)


function Scene:ctor(name)
    
end


function Scene:OnEnter()

    SceneManager.LoadScene(self.name)

end

