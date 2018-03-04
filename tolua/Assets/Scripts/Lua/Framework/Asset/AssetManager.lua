require("Class")
require("BehaviourBase")
require("LoadTask")
require("LoadedAssetBundle")
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
        self.mLoadingAssetQueue = Queue.New() --直接使用C#的队列
       
   
        local go = GameObject('AssetManager')     
        GameObject.DontDestroyOnLoad(go)

        local behaviour = go:AddComponent(typeof(LuaBehaviour))  
        behaviour:Init(self)
        self:Init(self)
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

    if self.mLoadingAssetQueue.Count > 0 then

        local tmpLoadTask = self.mLoadingAssetQueue:Peek ()

        if tmpLoadTask == nil then
        
            self.mLoadingAssetQueue:Dequeue ()

            return
         
        else
        
            local tmpAssetName = string.lower(tmpLoadTask.mAssetBundleName)

            if self.mAssetBundleDic[tmpAssetName] ~=nil then
            
                tmpLoadTask.mState = LoadTaskState.Success                     --已经加载完成
                
                if tmpLoadTask.mCallback then

                    local tmpAssetBundle = self.mAssetBundleDic[tmpAssetName].mAssetbundle
                   
                    tmpLoadTask.mCallback(tmpAssetBundle)
                    
                end

                self.mLoadingAssetQueue:Dequeue ()
                tmpLoadTask = nil

                return
            end

            if tmpLoadTask.mState == LoadTaskState.Cancel then                 --已经取消加载
            
                self.mLoadingAssetQueue:Dequeue ()
                tmpLoadTask = nil

                return
           
            elseif tmpLoadTask.mState == LoadTaskState.Waiting then            --等待加载
            
                --同步加载
                tmpLoadTask:Load()
             
                self.mLoadingAssetQueue:Dequeue ()
                tmpLoadTask = nil

                --异步加载
                --StartCoroutine (tmpLoadTask:LoadAsync ())
                return
            
            elseif tmpLoadTask.mState == LoadTaskState.Loading then            --加载中
            
                return
            
            elseif tmpLoadTask.mState == LoadTaskState.Success then            --加载完成   
            
                self.mLoadingAssetQueue:Dequeue ()			
                tmpLoadTask = nil
            
            elseif tmpLoadTask.mState == LoadTaskState.Fail then            --加载失败
                          
                self.mLoadingAssetQueue:Dequeue()
                tmpLoadTask = nil

            end
        end
    end
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
        tmpLoadTask = LoadTask.new(varAssetBundleName, varAssetName,nil)
        tmpLoadTask.state = LoadTaskState.Success
        
        return tmpLoadTask
    end



    if self:LoadAsset (tmpAssetBundleName, varAssetName, varCallback) then

        tmpLoadTask = LoadTask.new(varAssetBundleName);
        tmpLoadTask.mState = LoadTaskState.Success

        return tmpLoadTask
    end

    if self.mManifest then
     
        local tmpDependences = self.mManifest:GetAllDependencies (varAssetBundleName)     --tmpDependences的类型是C#的 string[]
        print("tmpDependences Length =" .. tmpDependences.Length )

        if tmpDependences.Length > 0 then

            for  i = 0, tmpDependences.Length - 1 do

                local tmpDependentAssetBundleName = string.lower( tmpDependences:GetValue(i) )

                if self.mAssetBundleDic[tmpDependentAssetBundleName] == nil then
        
                    local tmpDependentLoadTask = LoadTask.new (tmpDependentAssetBundleName, nil, function (varAssetBundle)

                        local tmpLoadedAssetbundle = LoadedAssetBundle.new (self.mManifest, tmpDependentAssetBundleName, varAssetBundle)
                        if self.mAssetBundleDic[tmpDependentAssetBundleName] ==  nil then 
                
                            self.mAssetBundleDic[tmpDependentAssetBundleName] = tmpLoadedAssetbundle
                
                        else
                            self.mAssetBundleDic[tmpDependentAssetBundleName] = nil
                            self.mAssetBundleDic[tmpDependentAssetBundleName] = tmpLoadedAssetbundle

                            print("Dependence "..tmpDependentAssetBundleName .." was Loaded.")
                        end
                    end)
                    self.mLoadingAssetQueue:Enqueue (tmpDependentLoadTask)
                end
            end		
        end
    end

    tmpLoadTask =  LoadTask.new (varAssetBundleName, varAssetName, function (varAssetBundle)
    
        if varAssetBundle ~=nil then
        
            local tmpLoadedAssetbundle = LoadedAssetBundle.new (self.mManifest, tmpAssetBundleName, varAssetBundle)

            if  self.mAssetBundleDic[tmpAssetBundleName] == nil then 
            
                self.mAssetBundleDic[tmpAssetBundleName] = tmpLoadedAssetbundle
            
            else
                self.mAssetBundleDic[tmpAssetBundleName] = nil
                self.mAssetBundleDic[tmpAssetBundleName] = tmpLoadedAssetbundle
            end

            tmpLoadedAssetbundle:AddReference()

            self:LoadAsset (tmpAssetBundleName, varAssetName, varCallback)

        else
        
            if varCallback ~= null then

                varCallback (nil)
            end
        end
    end)
    
    
    self.mLoadingAssetQueue:Enqueue (tmpLoadTask)

    return tmpLoadTask

end

function AssetManager:LoadAsset(varAssetBundleName,varAssetName,varCallback)

  
    local tmpObject = nil
	
	local tmpAssetBundleName = string.lower( varAssetBundleName )

	local tmpLoadedAssetbundle = self.mAssetBundleDic[tmpAssetBundleName] 

	if tmpLoadedAssetbundle ~= nil and varAssetName ~=nil then

        tmpObject = tmpLoadedAssetbundle:LoadAsset(varAssetName);
      
        if varCallback ~=nil then

            varCallback(tmpObject)
        end

    end
    return tmpObject ~= nil

end

function AssetManager:GetLoadedAssetbundle(varAssetbundleName)
	
	local tmpLoadedAssetBundle = self.mAssetBundleDic[string.lower( varAssetBundleName )]

    return tmpLoadedAssetBundle
end

function AssetManager:OnDestroy()
    print("AssetManager:OnDestroy")
end

---AssetBundle路径
function AssetManager.GetAssetBundlePath()
    return Application.dataPath .. "/../StreamingAssets/"
end

