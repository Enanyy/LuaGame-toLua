require("Class")
require("BehaviourBase")
require("LoadTask")
require("LoadedAssetBundle")

local GameObject = UnityEngine.GameObject
local Application = UnityEngine.Application
local Queue = System.Collections.Queue

--Unity中的AssetBundle类
local AssetBundle = UnityEngine.AssetBundle


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
    end

    return self
 
end

function AssetManager:Awake()
    
    print("AssetManager:Awake，name = "..self.behaviour.name)

    local tmpAssetManifest = self.GetAssetBundlePath() .."StreamingAssets"

    print(tmpAssetManifest)
    if File.Exists(tmpAssetManifest) then

        self.mManifestAssetBundle = AssetBundle.LoadFromFile (tmpAssetManifest)

        if self.mManifestAssetBundle then

            self.mManifest = self.mManifestAssetBundle:LoadAsset("AssetBundleManifest")
            
            GameObject.DontDestroyOnLoad(self.mManifest)

            print(tmpAssetManifest.. " load done")
            
        end
    else
        print(tmpAssetManifest.. " not exists")
    end

end

function AssetManager:Start()
    print("AssetManager:Start")
end

function AssetManager:OnEnable()
    print("AssetManager:OnEnable")
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
            
                tmpLoadTask.mState = 2;                     --已经加载完成

                self.mLoadingAssetQueue:Dequeue ()
                tmpLoadTask = nil

                return
            end

            if tmpLoadTask.mState == 5 then                 --已经取消加载
            
                self.mLoadingAssetQueue:Dequeue ()
                tmpLoadTask = nil

                return
           
            elseif tmpLoadTask.mState == 0 then            --等待加载
            
                --同步加载
                tmpLoadTask:Load()
             
                --异步加载
                --StartCoroutine (tmpLoadTask:LoadAsync ())

                print("Start Load:"..tmpLoadTask.mAssetBundleName)

                return
            
            elseif tmpLoadTask.mState == 1 then            --加载中
            
                return
            
            elseif tmpLoadTask.mState == 2 then            --加载完成   
            
                self.mLoadingAssetQueue:Dequeue ()			
                tmpLoadTask = nil
            
            elseif tmpLoadTask.mState == 4 then            --加载失败
                          
                self.mLoadingAssetQueue:Dequeue()
                tmpLoadTask = nil

            end
        end
    end
end

function AssetManager:Load(varAssetBundleName, varAssetName, varCallback)

    local tmpAssetBundleName = string.lower( varAssetBundleName )

    local tmpLoadTask = nil


    if self:LoadAsset (tmpAssetBundleName, varAssetName, varCallback) then

        tmpLoadTask = LoadTask.new(varAssetBundleName);
        tmpLoadTask.mState = 2

        return tmpLoadTask
    end

    --tmpDependences的类型是C#的 string[]
    local tmpDependences = self.mManifest:GetAllDependencies (varAssetBundleName)
    print("tmpDependences Length =" .. tmpDependences.Length )

    if tmpDependences.Length > 0 then

        for  i = 0, tmpDependences.Length - 1 do

            local tmpDependentAssetBundleName = string.lower( tmpDependences:GetValue(i) )

            if self.mAssetBundleDic[tmpDependentAssetBundleName] == nil then
        
                self.mLoadingAssetQueue:Enqueue (LoadTask.new (tmpDependentAssetBundleName, nil, function (varAssetBundle)

                    if self.mAssetBundleDic[tmpAssetBundleName] ==  nil then 
                
                        self.mAssetBundleDic[tmpAssetBundleName] = LoadedAssetBundle.new (self.mManifest, tmpAssetBundleName, varAssetBundle)
                
                    else
                
                        print("Dependence "..tmpDependentAssetBundleName .." was Loaded.")
                    end
                end))
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

	if tmpLoadedAssetbundle ~= nil then

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

