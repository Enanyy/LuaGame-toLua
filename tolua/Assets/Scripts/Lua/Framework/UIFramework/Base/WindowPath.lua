require("UI_Main")
require("UI_PopWindow")
require("UI_FadeWindow")
require("UI_ScaleWindow")
require("UI_MoveWindow")
require("UI_Dialog")
require("UI_Widget")


WindowPath = {
    paths = {
        [UI_Main.GetType()]                         = "Assets/R/UI/UI_Main/UI_Main.prefab" , 
        [UI_FadeWindow.GetType()]                   = "Assets/R/UI/UI_FadeWindow/UI_FadeWindow.prefab" , 
        [UI_MoveWindow.GetType()]                   = "Assets/R/UI/UI_MoveWindow/UI_MoveWindow.prefab" , 
        [UI_PopWindow.GetType()]                    = "Assets/R/UI/UI_PopWindow/UI_PopWindow.prefab" , 
        [UI_ScaleWindow.GetType()]                  = "Assets/R/UI/UI_ScaleWindow/UI_ScaleWindow.prefab" , 
        [UI_Dialog.GetType()]                       = "Assets/R/UI/UI_Dialog/UI_Dialog.prefab" , 
        [UI_Widget.GetType()]                       = "Assets/R/UI/UI_Widget/UI_Widget.prefab" , 
    },
}
function WindowPath:Get(name)
    
    if self.paths then
        return self.paths[name]
    end

    return nil
end 