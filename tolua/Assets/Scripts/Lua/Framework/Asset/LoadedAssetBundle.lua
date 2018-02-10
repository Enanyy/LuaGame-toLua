---
---加载完成的AssetBundle
---
--使用C#的ArrayList类
local ArrayList = System.Collections.ArrayList


---定义类
LoadedAssetBundle = Class()

--构造函数
function LoadedAssetBundle:ctor(varManifest, varAssetBundleName, varAssetbundle )
    self.mAssetBundleName = varAssetBundleName
    self.mAssetbundle = varAssetbundle
    self.mManifest = varManifest
    self.mReferenceList = ArrayList.New()                  --该AssetBundle的引用列表

end 

function LoadedAssetBundle:LoadAsset(varAssetName)

    if self.mAssetbundle ~= nil then

        return self.mAssetbundle:LoadAsset(varAssetName)
    end

    return nil
end

function LoadedAssetBundle:AddReference()

    if self.mManifest == null or self.mAssetbundle == null then
    
        return
    end


    local  tmpDependencesArray = self.mManifest:GetAllDependencies(self.mAssetBundleName);

    if tmpDependencesArray.Length > 0 then

        for i = 0, tmpDependencesArray.Length - 1 do
    
            local tmpDependence = string.lower( tmpDependencesArray:GetValue(i) )

            local tmpLoadedAssetbundle = AssetManager:GetLoadedAssetbundle(tmpDependence);

            if tmpLoadedAssetbundle ~= nil and tmpLoadedAssetbundle.mReferenceList:Contains(self) == false then
        
                tmpLoadedAssetbundle.mReferenceList:Add(self);
            end

        end
    end
end

function LoadedAssetBundle:RemoveReference()

    if self.mManifest == null or self.mAssetbundle == null then
    
        return;
    
    end
    local tmpDependencesArray = self.mManifest:GetAllDependencies(mAssetBundleName);

    if tmpDependencesArray.Length > 0 then
        for i = 0, tmpDependencesArray.Length - 1 do
    
            local tmpDependence = string.lower( tmpDependencesArray:GetValue(i) )

            local tmpLoadedAssetbundle = AssetManager:GetLoadedAssetbundle(tmpDependence);

            if tmpLoadedAssetbundle ~= nil and tmpLoadedAssetbundle.mReferenceList:Contains(self) then
        

                tmpLoadedAssetbundle.mReferenceList:Remove(self);
            end
        end
    end
end