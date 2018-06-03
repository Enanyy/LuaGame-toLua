require("Class")
require("BehaviourBase")
require("UnityClass")

local Instantiate = GameObject.Instantiate

FashionBody = Class("FashionBody",BehaviourBase)

function FashionBody:ctor()
    self.mBody  = nil 
end

function FashionBody:SetData(varPlayerCharacter, varCallback)

    self.mPlayerCharacter = varPlayerCharacter
    self.mCallback = varCallback
end

function FashionBody:Start()

 
    local tmpPlayerInfo = self.mPlayerCharacter.mPlayerInfo
    if tmpPlayerInfo == nil then return end 
    local tmpAssetBundleName = "assetbundle.unity3d"
    local tmpAssetName =tmpPlayerInfo.prefab 
    AssetManager:Load (tmpAssetBundleName, tmpAssetName, function(varObject) 
    
        if varObject then

            local go = AssetManager:Instantiate(tmpAssetBundleName,tmpAssetName, varObject)
            go:SetActive(true)
            NGUITools.SetLayer(go, self.gameObject.layer)
            
            SetParent(go, self.transform)   
            SetLocalPosition(go, Vector3.zero)
            SetLocalRotation(go, Quaternion.identity)
            SetScale(go, Vector3.one)

            local collider = AddComponent(go, typeof(CapsuleCollider))
            collider.isTrigger = true
            collider.height = tmpPlayerInfo.height
            collider.radius = tmpPlayerInfo.radius
            collider.center = Vector3.New(0, tmpPlayerInfo.height * 0.5, 0)
            self.mBody = go
        
        else
            print ("FashionBody:Start Can't Load :".. tmpAssetName)
        end

        if self.mCallback then
            self.mCallback(self)
        end
    end)


end