require("Class")
require("File")
require("UnityClass")

--资源加载任务类
LoadTask = Class()

function LoadTask:ctor(varAssetBundleName, varAssetName, varCallback)
    self.mAssetBundleName = varAssetBundleName  ---AssetBundle名字
    self.mAssetName       = varAssetName        ---资源名字
    self.mState           = 0                   ---加载状态 0、等待 1、加载中 2、加载完成 3、加载失败 4、取消加载
    self.mAssetBundle     = nil                 ---加载完成的AssetBundle
    self.mCallback        = varCallback         ---加载完成回调函数
end
--开始加载
function LoadTask:Load()
    self.mState = 1

    local  tmpFullPath = AssetManager.GetAssetBundlePath() .. self.mAssetBundleName
    if File.Exists(tmpFullPath) then
        self.mAssetBundle = AssetBundle.LoadFromFile(tmpFullPath)
        
        if self.mAssetBundle ~= nil then
            self.mState = 2 --加载完成
        else
            self.mState = 3 --加载失败
        end
    else
        self.mState = 3 --加载失败
        error("Can't find file:"..tmpFullPath)
    end

    if self.mCallback ~= nil then

        self.mCallback(self.mAssetBundle)

    end
end

--异步加载
function LoadTask:LoadAsync()

    local  tmpFullPath = AssetManager.GetAssetBundlePath() .. self.mAssetBundleName
    if File.Exists(tmpFullPath) then

        local tmpRequest = AssetBundle.LoadFromFileAsync(tmpFullPath)
        self.mState = 1     --加载中

        Yield(tmpRequest)

        if tmpRequest.isDone then
            self.mAssetBundle = tmpRequest.assetBundle
            self.mState = 2  --加载完成
        else
            self.mState = 3  --加载失败
            error("Can't find file:"..tmpFullPath)
        end

        if self.mCallback ~= nil then

            self.mCallback(self.mAssetBundle)
    
        end
    else
        self.mState = 3 --加载失败
        if self.mCallback ~= nil then

            self.mCallback(self.mAssetBundle)
    
        end
        error("Can't find file:"..tmpFullPath)
    end
end

