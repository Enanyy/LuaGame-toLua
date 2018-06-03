require("Class")

LoadAssetTask = Class("LoadAssetTask")


function LoadAssetTask:ctor(varAssetName, varCallback)
    self.mAssetName = varAssetName
    self.mCallback = varCallback
end 