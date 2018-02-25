require("PlayerEffectPlugin")


Ahri_PlayerEffectMovePlugin = Class(PlayerEffectPlugin)
 
function Ahri_PlayerEffectMovePlugin:ctor(name)

    self.mSpeed = 10
    self.mDistance = 10
    
    self.mParent = nil
    self.mGo = nil

end 


function Ahri_PlayerEffectMovePlugin:Init(configure)

    if configure == nil then return end

    self.mSpeed = configure.speed
    self.mDistance = configure.distance


end


function Ahri_PlayerEffectMovePlugin:OnBegin()
   
    if self.mGo == nil then

        self.mGo = self.machine.mPlayerCharacter.mFashionWeapon.mWeapon
        self.mParent = self.mGo.transform.parent

    end


    self.mGo.transform:SetParent(nil)


    self.mOriginalPosition =self.mGo.transform.position
    self.mDestination = self.mOriginalPosition + self.machine.mPlayerCharacter.transform.forward * self.mDistance

    self.mDuration = self.mDistance * 1.0 / self.mSpeed

    self.mTween = TweenPosition.Begin(self.mGo, self.mDuration,self.mDestination)
    self.mTween.enabled = true    
    self.mTween.method = UITweener.Method.EaseOut
    self.mTween.onFinished:Clear()
    self.mTween:AddOnFinished(EventDelegate.New(function() 
        self.mGo:SetActive(false)
    end))
    self.mTween:ResetToBeginning()
    self.mTween:PlayForward()

end

function Ahri_PlayerEffectMovePlugin:OnExecute()

    --[[ 
    if self.mDuration ~= 0 then

        local factor = self.mPlayerEffectState.mRunTime * 1.0 / self.mDuration
        self.mGo.transform.position = self.mOriginalPosition * (1 - factor) + self.mDestination * factor

        if factor >= 1.0 then

            self.mGo:SetActive(false)
        end
    end
    --]]
end

function Ahri_PlayerEffectMovePlugin:OnEnd()

    if self.mGo then
        
        self.mGo:SetActive(true)

        self.mGo.transform:SetParent(self.mParent)
        self.mGo.transform.localPosition = Vector3.zero

    end

   
end

function Ahri_PlayerEffectMovePlugin:OnExit()

    if self.mTween then

        self.mTween.onFinished:Clear()
        self.mTween.enabled = false

    end

    self.mPlayerEffectState.isPlaying = false    

end

function Ahri_PlayerEffectMovePlugin:OnPause()


end


function Ahri_PlayerEffectMovePlugin:OnResume()



end
