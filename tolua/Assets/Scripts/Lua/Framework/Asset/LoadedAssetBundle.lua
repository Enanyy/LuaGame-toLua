---
---加载完成的AssetBundle
---



---定义类
LoadedAssetBundle = Class()

--构造函数
function LoadedAssetBundle:ctor( varAssetBundleName, varAssetBundle )
    self.mAssetBundleName = varAssetBundleName
    self.mAssetBundle = varAssetBundle


    self.mDependenceList = {} --该资源所依赖别的资源
    self.mReferenceList = {}  --场景中实例化出来的,即引用

end 

function LoadedAssetBundle:GetDependenceCount()

    return table.getn(self.mDependenceList)

end

function LoadedAssetBundle:GetReferenceCount()

    return table.getn(self.mReferenceList)

end

function LoadedAssetBundle:LoadAsset(varAssetName)

    if self.mAssetBundle ~= nil then

        return self.mAssetBundle:LoadAsset(varAssetName)
    end

    return nil
end

function LoadedAssetBundle:AddReference(varReference)
    
    if varReference == nil then
        return
    end

    if self:ExistReference(varReference)==false then
    
        table.insert( self.mReferenceList, varReference)

    end

    print("AddReference ".. self.mAssetBundleName .." referenceCount:"..self:GetReferenceCount())
end

function LoadedAssetBundle:RemoveReference(varReference)
    
    if varReference == nil then
        return
    end

    for i = self:GetReferenceCount(), 1, -1 do
      
        local reference = self.mReferenceList[i]
        if reference == nil or reference == varReference then
            table.remove( self.mReferenceList, i )
        end
    end
    print("RemoveReference " .. self.mAssetBundleName .." referenceCount:"..self:GetReferenceCount())
end

function LoadedAssetBundle:AddDependence()

    if self.mManifest == null or self.mAssetBundle == null then
    
        return
    end


    local  tmpDependencesArray =  AssetManager:GetAllDependencies(string.lower(self.mAssetBundleName))

    if tmpDependencesArray ~= nil and tmpDependencesArray.Length > 0 then

        for i = 0, tmpDependencesArray.Length - 1 do
    
            local tmpDependentAssetBundleName = string.lower( tmpDependencesArray:GetValue(i) )

            local tmpLoadedAssetBundle = AssetManager:GetLoadedAssetBundle(tmpDependentAssetBundleName)

            if tmpLoadedAssetBundle ~= nil and self:ExistDependence(tmpLoadedAssetBundle) == false then
        
                table.insert( self.mDependenceList, tmpLoadedAssetBundle)   

            end

        end
    end

    local log = self.mAssetBundleName .." dependence: " ..self:GetDependenceCount()
    for i,v in ipairs(self.mDependenceList) do
       log = log.. "\n            "..v.mAssetBundleName
    end

    print(log)
end

function LoadedAssetBundle:ExistDependence(varLoadedAssetBundle)

    for i,v in ipairs( self.mDependenceList) do
        if v == varLoadedAssetBundle then
            return true
        end
    end

    return false
end

function LoadedAssetBundle:ExistReference(varReference)

    for i,v in ipairs(self.mReferenceList) do
       
        if v == varReference then
            return true
        end
    end

    return false
end

function LoadedAssetBundle:Dependence( varAssetBundleName)

    if not varAssetBundleName  then
    
        return false

    end

    for i,v in ipairs(self.mDependenceList) do

        if v.mAssetBundleName == varAssetBundleName then
            return true
        end

    end
   
    return false
end

function LoadedAssetBundle:UnLoad()

    self.mAssetBundleName = nil 
    if self.mAssetBundle ~= nil then
        
        self.mAssetBundle:Unload (true)
        self.mAssetBundle = nil
    end

    --卸载依赖
    for i,v in ipairs(self.mDependenceList) do
    
        if AssetManager:OtherDependence(v.mAssetBundleName) == false then
        
            AssetManager:UnLoad(v.mAssetBundleName)

        end
    end
    self.mDependenceList = nil
end