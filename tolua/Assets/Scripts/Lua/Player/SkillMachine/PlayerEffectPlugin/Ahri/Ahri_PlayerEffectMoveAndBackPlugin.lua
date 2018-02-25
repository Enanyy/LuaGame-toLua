require("PlayerEffectPlugin")

Ahri_PlayerEffectMoveAndBackPlugin = Class(PlayerEffectPlugin)

function Ahri_PlayerEffectMoveAndBackPlugin:ctor(name)
    self.mSpeed = 10
    self.mDistance = 10

    self.mMoveBack = false  
    self.mDone = false  
    
    self.mParent = nil
    self.mGo = nil
end

function Ahri_PlayerEffectMoveAndBackPlugin:Init(configure)

    if configure == nil then return end


    self.mSpeed = configure.speed
    self.mDistance = configure.distance

end


function Ahri_PlayerEffectMoveAndBackPlugin:OnBegin()
   
    if self.mGo == nil then

        self.mGo = self.machine.mPlayerCharacter.mFashionWeapon.mWeapon

    end
    if self.mParent == nil then
        self.mParent = self.machine.mPlayerCharacter.mFashionBody.mBody.transform:Find(self.machine.mPlayerCharacter.mPlayerInfo.weaponBone)

    end

    self.mMoveBack = false
    self.mDone = false 

    self.mGo.transform:SetParent(nil)


    self.mOriginalPosition = self.mParent.position

    self.mDestination = self.mOriginalPosition + self.machine.mPlayerCharacter.transform.forward * self.mDistance

    self.mDuration = self.mDistance * 1.0 / self.mSpeed

    self.mTween = TweenPosition.Begin(self.mGo, self.mDuration,self.mDestination)
    self.mTween.enabled = true    
    self.mTween.method = UITweener.Method.EaseOut
    self.mTween.onFinished:Clear()
    self.mTween:AddOnFinished(EventDelegate.New(function() 
        
        self.mMoveBack = true
       
    end))
    self.mTween:ResetToBeginning()
    self.mTween:PlayForward()

end

function Ahri_PlayerEffectMoveAndBackPlugin:OnExecute()

    if self.mMoveBack and self.mDone == false then

        local direction = self.mParent.position - self.mGo.transform.position

        if direction.magnitude > 0.1 then

            self.mGo.transform.position = self.mGo.transform.position + direction.normalized * self.mSpeed * Time.deltaTime
        else

            self.mDone = true
            self.mPlayerEffectState.isPlaying = false    

        end

    end

end

function Ahri_PlayerEffectMoveAndBackPlugin:OnEnd()

    self.mMoveBack = false
    
    if self.mGo then
        
        self.mGo:SetActive(true)

        self.mGo.transform:SetParent(self.mParent)
        self.mGo.transform.localPosition = Vector3.zero

    end
    if self.mTween then

        self.mTween.onFinished:Clear()
        self.mTween.enabled = false

    
    end
   
end

function Ahri_PlayerEffectMoveAndBackPlugin:OnExit()

    
end

function Ahri_PlayerEffectMoveAndBackPlugin:OnPause()


end


function Ahri_PlayerEffectMoveAndBackPlugin:OnResume()



end
