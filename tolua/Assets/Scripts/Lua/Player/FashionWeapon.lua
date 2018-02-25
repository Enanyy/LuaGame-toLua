require("Class")
require("BehaviourBase")
require("UnityClass")

FashionWeapon = Class(BehaviourBase)

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

    local tmpPath = string.format("Assets/R/Weapon/%s/%s.prefab",tmpPlayerInfo.character, tmpPlayerInfo.weapon) 

    AssetManager:Load ("assetbundle.unity3d", tmpPath, function(varObject) 
    
        if varObject then

            local go = GameObject.Instantiate(varObject)
			go:SetActive(true)
            go.transform:SetParent(tmpWeaponBone)
            
            NGUITools.SetLayer(go, self.gameObject.layer)
			go.transform.localPosition = Vector3.zero
			go.transform.localRotation = Quaternion.identity
		
            self.mWeapon = go
        
        else
            print ("FashionWeapon:Start Can't Load :".. tmpPath)
        end

        if self.mCallback then
            self.mCallback(self)
        end
    end)
end

