require("Class")
require("File")
require("UnityClass")
require("LoadAssetTask")

---资源加载状态
LoadTaskState = 
{
    Waiting = 0,
    Loading = 1,
    Success = 2,
    Fail    = 3,
    Cancel  = 4,   
}

local LoadFromFile  = AssetBundle.LoadFromFile

--资源加载任务类
LoadTask = Class("LoadTask")


function LoadTask:ctor(varAssetBundleName)
    self.mAssetBundleName = varAssetBundleName                      ---AssetBundle名字
    self.mState           = LoadTaskState.Waiting                   ---加载状态 0、等待 1、加载中 2、加载完成 3、加载失败 4、取消加载
    self.mAssetBundle     = nil                                     ---加载完成的AssetBundle

    self.mLoadAssetTaskList = {}
  
end
--开始加载
function LoadTask:Load()
    self.mState = LoadTaskState.Loading
  
    local  tmpFullPath = AssetManager.GetAssetBundlePath() .. self.mAssetBundleName
    if File.Exists(tmpFullPath) then
        self.mAssetBundle = LoadFromFile(tmpFullPath)
        
        if self.mAssetBundle ~= nil then
            self.mState = LoadTaskState.Success --加载完成
              
        else
            self.mState = LoadTaskState.Fail    --加载失败
            print("Load AssetBundle:"..tmpFullPath.." Fail")
        end
    else
        self.mState = LoadTaskState.Fail --加载失败
        print("Can't find file:"..tmpFullPath)
    end

  
end

--异步加载
function LoadTask:LoadAsync()

    local  tmpFullPath = AssetManager.GetAssetBundlePath() .. self.mAssetBundleName
    if File.Exists(tmpFullPath) then

        local tmpRequest = AssetBundle.LoadFromFileAsync(tmpFullPath)
        self.mState = LoadTaskState.Loading     --加载中

        Yield(tmpRequest)

        if tmpRequest.isDone then
            self.mAssetBundle = tmpRequest.assetBundle
            self.mState = LoadTaskState.Success     --加载完成
        else
            self.mState = LoadTaskState.Fail        --加载失败
            print("Can't find file:"..tmpFullPath)
        end

    else
        self.mState = LoadTaskState.Fail            --加载失败
        print("Can't find file:"..tmpFullPath)
    end
end

function LoadTask:AddLoadAssetTask(varAssetName,varCallback)

    local tmpLoadAssetTask = LoadAssetTask.new(varAssetName, varCallback)

    table.insert( self.mLoadAssetTaskList, tmpLoadAssetTask )

end

function LoadTask:OnLoadFinish()

    for i,v in ipairs(self.mLoadAssetTaskList) do
        
        if v.mCallback then
            local tmpObject = self.mAssetBundle:LoadAsset(v.mAssetName)
            v.mCallback(tmpObject)
        end

    end
    self.mLoadAssetTaskList = {}

end

