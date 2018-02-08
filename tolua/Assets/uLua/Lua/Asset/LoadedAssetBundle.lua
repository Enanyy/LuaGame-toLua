---
---加载完成的AssetBundle
---

LoadedAssetBundle = Class()

function LoadedAssetBundle:ctor(varManifest, varAssetBundleName, varAssetbundle )
    self.mAssetBundleName = varAssetBundleName
    self.mAssetbundle = varAssetbundle
    self.mManifest = varManifest
end 

function LoadedAssetBundle:LoadAsset(varAssetName)

    if self.mAssetbundle ~= nil then

        return self.mAssetbundle:LoadAsset(varAssetName)
    end

    return nil
end