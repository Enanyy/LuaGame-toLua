require("Class")

LoadAssetTask = Class()

function LoadAssetTask:ctor(varAssetName, varCallback)
    self.mAssetName = varAssetName
    self.mCallback = varCallback
end 