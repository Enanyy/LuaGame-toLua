require("Class")
require("BehaviourBase")
require("UnityClass")

FashionWeapon = Class("FashionWeapon",BehaviourBase)

function FashionWeapon:ctor()
    self.mWeapon = nil
end

function FashionWeapon:SetData(varPlayerCharacter, varCallback)

    self.mPlayerCharacter = varPlayerCharacter
    self.mCallback = varCallback
end


function FashionWeapon:Start()

    local tmpPlayerInfo = self.mPlayerCharacter.mPlayerInfo
    if tmpPlayerInfo == nil then return end 

    local tmpWeaponBone = self.mPlayerCharacter.mFashionBody.mBody.transform:Find(tmpPlayerInfo.weaponBone)

    if tmpWeaponBone == nil then return end

    local tmpAssetBundleName = "assetbundle.unity3d"

    local tmpAssetName =  tmpPlayerInfo.weapon

    AssetManager:Load (tmpAssetBundleName, tmpAssetName, function(varObject) 
    
        if varObject then

            local go =AssetManager:Instantiate(tmpAssetBundleName,tmpAssetName, varObject)
			go:SetActive(true)
          
 
            SetParent(go, tmpWeaponBone)   
            SetLocalPosition(go, Vector3.zero)
            SetLocalRotation(go, Quaternion.identity)
            SetScale(go, Vector3.New(0.1, 0.1, 0.1))
            self.mWeapon = go
        
        else
            print ("FashionWeapon:Start Can't Load :".. tmpAssetBundleName)
        end

        if self.mCallback then
            self.mCallback(self)
        end
    end)
end

