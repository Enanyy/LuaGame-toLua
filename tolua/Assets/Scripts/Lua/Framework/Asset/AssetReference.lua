
require("Class")
require("BehaviourBase")


AssetReference = Class("AssetReference",BehaviourBase)

function AssetReference:ctor(varAssetBundleName,varAssetName)
    self.mAssetBundleName = varAssetBundleName
    self.mAssetName = varAssetName
end

function AssetReference:Start()
    local tmpLoadedAssetBundle = AssetManager:GetLoadedAssetBundle(self.mAssetBundleName)
    if tmpLoadedAssetBundle ~= nil then
    
        tmpLoadedAssetBundle:AddReference(self)
    end
end


function AssetReference:OnDestroy()
    AssetManager:Destroy(self)
end