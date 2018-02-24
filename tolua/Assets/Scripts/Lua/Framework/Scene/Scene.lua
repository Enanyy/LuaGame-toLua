require("State")
require("UnityClass")

Scene = Class(State)

function Scene:ctor(name)
    
end


function Scene:OnEnter()

    SceneManager.LoadScene(self.name)

end

