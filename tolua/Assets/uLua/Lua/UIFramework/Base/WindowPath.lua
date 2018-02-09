
WindowPath = {
    paths = {
        ["UI_Main"] = "Assets/R/UI/UI_Main/UI_Main.prefab" , 
    },
}
function WindowPath:Get(name)
    
    if self.paths then
        return self.paths[name]
    end

    return nil
end 