require("UI_Main")
require("UI_PopWindow")
require("UI_Dialog")

WindowPath = {
    paths = {
        ["UI_Main"]                         = "Assets/R/UI/UI_Main/UI_Main.prefab" , 
        ["UI_FadeWindow"]                   = "Assets/R/UI/UI_FadeWindow/UI_FadeWindow.prefab" , 
        ["UI_MoveWindow"]                   = "Assets/R/UI/UI_MoveWindow/UI_MoveWindow.prefab" , 
        ["UI_PopWindow"]                    = "Assets/R/UI/UI_PopWindow/UI_PopWindow.prefab" , 
        ["UI_ScaleWindow"]                  = "Assets/R/UI/UI_ScaleWindow/UI_ScaleWindow.prefab" , 
        ["UI_Dialog"]                       = "Assets/R/UI/UI_Dialog/UI_Dialog.prefab" , 
    },
}
function WindowPath:Get(name)
    
    if self.paths then
        return self.paths[name]
    end

    return nil
end 