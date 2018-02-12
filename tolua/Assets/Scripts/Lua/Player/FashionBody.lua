require("Class")
require("BehaviourBase")
local GameObject = UnityEngine.GameObject

FashionBody = Class(BehaviourBase)

function FashionBody:ctor()
    self.mBody  = nil 
end

function FashionBody:SetData(varPlayerCharacter, varCallback)

    self.mPlayerCharacter = varPlayerCharacter
    self.mCallback = varCallback
end

function FashionBody:Start()

    print("FashionBody:Start")
    local tmpPlayerInfo = self.mPlayerCharacter.mPlayerInfo
    if tmpPlayerInfo == nil then return end 
    local tmpPath = string.format("Assets/R/Character/%s/Prefabs/%s.prefab",tmpPlayerInfo.character, tmpPlayerInfo.skin) 
    AssetManager:Load ("assetbundle.unity3d", tmpPath, function(varObject) 
    
        if varObject then

            local go = GameObject.Instantiate(varObject)
			go:SetActive(true)
            go.transform:SetParent(self.transform)
            NGUITools.SetLayer(go, self.gameObject.layer)
			go.transform.localPosition = Vector3.zero
			go.transform.localRotation = Quaternion.identity
			go.transform.localScale = Vector3.one
            self.mBody = go
        
        else
            print ("FashionBody:Start Can't Load :".. tmpPath)
        end

        if self.mCallback then
            self.mCallback(self)
        end
    end)


end