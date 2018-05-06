require("Class")
require("BehaviourBase")
require("LoadTask")
require("LoadedAssetBundle")
require("AssetReference")
require("UnityClass")

--new 一个全局对象，该对象的类继承于BehaviourBase
AssetManager = Class(BehaviourBase).new()

function AssetManager:Initialize()

    --确保只被初始化一次
    if  self.initialized  == nil or self.initialized == false then
    
        self.initialized = true

        self.mManifestAssetBundle = nil
        self.mManifest = nil
        self.mAssetBundleDic = {}
        self.mLoadTaskQueue = Queue.New() --直接使用C#的队列
       
   
        local go = GameObject("AssetManager")     
        GameObject.DontDestroyOnLoad(go)

    
        AddLuaBehaviour(go, "AssetManager", self)
    end

    return self
 
end

function AssetManager:Awake()
    
    local tmpAssetManifest = self.GetAssetBundlePath() .."StreamingAssets"

    print(tmpAssetManifest)
    if File.Exists(tmpAssetManifest) then

        self.mManifestAssetBundle = AssetBundle.LoadFromFile (tmpAssetManifest)

        if self.mManifestAssetBundle then

            self.mManifest = self.mManifestAssetBundle:LoadAsset("AssetBundleManifest")
            
            GameObject.DontDestroyOnLoad(self.mManifest)

            print(tmpAssetManifest.. " load done")
            
           -- self:Load("assetbundle.unity3d", nil,nil)
        end
    else
        print(tmpAssetManifest.. " not exists")
    end

end

function AssetManager:Start()
    
end

function AssetManager:OnEnable()
   
end

function AssetManager:Update()

    if self.mLoadTaskQueue.Count > 0 then

        local tmpLoadTask = self.mLoadTaskQueue:Peek ()

        if tmpLoadTask == nil then
        
            self.mLoadTaskQueue:Dequeue ()

            return
         
        else
        
            local tmpAssetBundleName = string.lower(tmpLoadTask.mAssetBundleName)

            if self.mAssetBundleDic[tmpAssetBundleName] ~=nil then
            
                tmpLoadTask.mState = LoadTaskState.Success                     --已经加载完成
            
                tmpLoadTask.mAssetBundle = self.mAssetBundleDic[tmpAssetBundleName].mAssetbundle

                self:OnLoadTaskFinish(tmpLoadTask)

                self.mLoadTaskQueue:Dequeue ()
                tmpLoadTask = nil

                return
            end

            if tmpLoadTask.mState == LoadTaskState.Cancel then                 --已经取消加载
            
                self.mLoadTaskQueue:Dequeue ()
                tmpLoadTask = nil

                return
           
            elseif tmpLoadTask.mState == LoadTaskState.Waiting then            --等待加载
            
                --同步加载
                tmpLoadTask:Load()
             
                --异步加载
                --StartCoroutine (tmpLoadTask:LoadAsync ())
                return
            
            elseif tmpLoadTask.mState == LoadTaskState.Loading then            --加载中
            
                return
            
            elseif tmpLoadTask.mState == LoadTaskState.Success then            --加载完成   
            
                self:OnLoadTaskFinish(tmpLoadTask)

                self.mLoadTaskQueue:Dequeue ()			
                tmpLoadTask = nil
            
            elseif tmpLoadTask.mState == LoadTaskState.Fail then            --加载失败
                          
                self.mLoadTaskQueue:Dequeue()
                tmpLoadTask = nil

            end
        end
    end
end

function AssetManager:GetLoadTask(varAssetBundleName)

    local it = self.mLoadTaskQueue:GetEnumerator()

    while it:MoveNext() do

        if it.Current.mAssetBundleName == varAssetBundleName then
            return it.Current
        end

    end
    return nil
end

function AssetManager:GetAllDependencies(varAssetBundleName)
       
    if varAssetBundleName == nil or self.mManifest == nil then
        
        return nil
    end

    return self.mManifest:GetAllDependencies(varAssetBundleName)  --tmpDependences的类型是C#的 string[]

end

function AssetManager:OnLoadTaskFinish(varLoadTask)

    if varLoadTask == nil then
        return
    end

    local tmpAssetBundleName = string.lower( varLoadTask.mAssetBundleName )

    local tmpLoadedAssetBundle = self:GetLoadedAssetBundle(tmpAssetBundleName)

    if tmpLoadedAssetBundle == nil then

        tmpLoadedAssetBundle = LoadedAssetBundle.new (tmpAssetBundleName, varLoadTask.mAssetBundle)
        tmpLoadedAssetBundle:AddDependence()

        self.mAssetBundleDic[tmpAssetBundleName] = tmpLoadedAssetBundle
    else
        varLoadTask.mAssetBundle = tmpLoadedAssetBundle.mAssetBundle
    end

    varLoadTask:OnLoadFinish()
end

function AssetManager:Load(varAssetBundleName, varAssetName, varCallback)
    
    local tmpAssetBundleName = string.lower( varAssetBundleName )
   
    local tmpLoadTask = nil

    --Editor模式
    if Main:AssetMode() == 0 then

        local o = LuaGame.LoadAssetAtPath(varAssetName)
        
        if varCallback then
            varCallback(o)
        end
        tmpLoadTask = LoadTask.new(tmpAssetBundleName, varAssetName,nil)
        tmpLoadTask.state = LoadTaskState.Success
        
        return tmpLoadTask
    end


    local tmpLoadedAssetBundle = self:GetLoadedAssetBundle(tmpAssetBundleName)

    if  tmpLoadedAssetBundle ~= nil then

        local tmpObject = tmpLoadedAssetBundle:LoadAsset(varAssetName)

        if varCallback ~= nil then

            varCallback(tmpObject)

        end

        tmpLoadTask = LoadTask.new(tmpAssetBundleName)
        tmpLoadTask.mState = LoadTaskState.Success

        return tmpLoadTask
    end

    local tmpLoadTask = self:GetLoadTask(tmpAssetBundleName)

    
    if tmpLoadTask ~= nil then

        tmpLoadTask:AddLoadAssetTask(varAssetName, varCallback)
       
        return tmpLoadTask
    end

    if self.mManifest then
     
        local tmpDependences = self:GetAllDependencies  (tmpAssetBundleName)    
       
        --print(tmpAssetBundleName.." Dependences Length =" .. tmpDependences.Length )

        if tmpDependences ~=nil and tmpDependences.Length > 0 then

            for  i = 0, tmpDependences.Length - 1 do

                local tmpDependentAssetBundleName = string.lower( tmpDependences:GetValue(i) )

                if self:GetLoadedAssetBundle(tmpDependentAssetBundleName) == nil and self:GetLoadTask(tmpDependentAssetBundleName) == nil then
        
                    local tmpDependentLoadTask = LoadTask.new (tmpDependentAssetBundleName)
                    self.mLoadTaskQueue:Enqueue (tmpDependentLoadTask)

                end
            end		
        end
    end

    tmpLoadTask =  LoadTask.new (tmpAssetBundleName)
    tmpLoadTask:AddLoadAssetTask(varAssetName, varCallback)

    self.mLoadTaskQueue:Enqueue (tmpLoadTask)

    return tmpLoadTask

end



function AssetManager:GetLoadedAssetBundle(varAssetBundleName)
    
    if self.mAssetBundleDic == nil then
        return nil
    end
    
	local tmpLoadedAssetBundle = self.mAssetBundleDic[string.lower( varAssetBundleName )]

    return tmpLoadedAssetBundle
end


function AssetManager:UnLoad(varAssetBundleName)

    if not varAssetBundleName then
        return
    end

    print("UnLoad:".. varAssetBundleName)


    local tmpAssetBundleName = string.lower( varAssetBundleName ) 
    local tmpLoadedAssetBundle = self:GetLoadedAssetBundle (tmpAssetBundleName)
    if tmpLoadedAssetBundle == nil then
        return
    end
    --先移除
    self.mAssetBundleDic[tmpAssetBundleName] = nil

    --卸载本身以及单独的依赖
    tmpLoadedAssetBundle:UnLoad()

    
end

function AssetManager:OtherDependence(varAssetBundleName)

    for k,v in pairs(self.mAssetBundleDic) do
      
        if v ~= nil and v:Dependence(varAssetBundleName) then
            return true
        end

    end
   
    return false
end

function AssetManager:Instantiate(varAssetBundleName,varAssetName, varObject)

    if varObject == nil then

        print("Trying Instantiate object is NULL!");
        return nil
    end

    local go = Instantiate(varObject)
    local reference = AssetReference.new(varAssetBundleName, varAssetName)

    AddLuaBehaviour(go, "AssetReference", reference)

    return go
end
function AssetManager:Destroy(varReference)
    
    if varReference == nil then
        
        return
    end
      
    local tmpLoadedAssetBundle = self:GetLoadedAssetBundle(varReference.mAssetBundleName)
        
    if tmpLoadedAssetBundle ~= nil then
              
        tmpLoadedAssetBundle:RemoveReference(varReference)

        if tmpLoadedAssetBundle:GetReferenceCount() == 0 then
            
            self:UnLoad(varReference.mAssetBundleName)
        
        end
    end
end

function AssetManager:OnDestroy()
    print("AssetManager:OnDestroy")

    local tmpAssetBundleArray = {}
    for k,v in pairs(self.mAssetBundleDic) do
        table.insert( tmpAssetBundleArray, k )
    end

    for i,v in ipairs(tmpAssetBundleArray) do
        self:UnLoad(v)
    end

    tmpAssetBundleArray = nil
    self.mAssetBundleDic = nil
    self.mManifestAssetBundle:Unload(true)
    self.mManifestAssetBundle = nil
    self.mManifest = nil
end

---AssetBundle路径
function AssetManager.GetAssetBundlePath()
    return Application.dataPath .. "/../StreamingAssets/"
end

