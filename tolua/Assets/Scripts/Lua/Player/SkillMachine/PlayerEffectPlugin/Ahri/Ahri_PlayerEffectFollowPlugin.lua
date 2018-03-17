require("PlayerEffectPlugin")
require("Tweener")

Ahri_PlayerEffectFollowPlugin = Class(PlayerEffectPlugin)
 
function Ahri_PlayerEffectFollowPlugin:ctor(name)

    self.mSpeed = 10
    self.mDistance = 10
    
    self.mParent = nil
    self.mWeapon = nil
    self.mGo = nil
    self.mLockPlayerCharacter = nil

    self.mStateEnd = false
    self.mEffectEnd = false

    self.mFollow = false

    self.mPosition = Vector3.zero
    self.mTargetPosition = Vector3.zero
end 

function Ahri_PlayerEffectFollowPlugin:Init(behaviour)

    self.mBehaviour = behaviour or  self.mBehaviour
   
end

function Ahri_PlayerEffectFollowPlugin:InitWithConfig(configure)

    if configure == nil then return end

    self.mSpeed = configure.speed
    self.mDistance = configure.distance


end

function Ahri_PlayerEffectFollowPlugin:OnEnter()

    if self.mWeapon == nil then

        self.mWeapon = self.machine.mPlayerCharacter.mFashionWeapon.mWeapon
      
    end
    if self.mParent == nil then
        self.mParent = self.machine.mPlayerCharacter.mFashionBody.mBody.transform:Find(self.machine.mPlayerCharacter.mPlayerInfo.weaponBone)

    end

    if self.mGo == nil then
        self.mGo = Instantiate(self.mWeapon)
        self.mGo.name = self.mPlayerSkillState.mPlayerSkillType
        SetParent(self.mGo, self.mParent)
        SetScale(self.mGo, GetScale(self.mWeapon))
    end


    if self.mBehaviour == nil then

        self.mBehaviour = self.mGo:GetComponent(typeof(LuaBehaviour))
        if self.mBehaviour == nil then
            self.mBehaviour = self.mGo:AddComponent(typeof(LuaBehaviour))
        end
        self.mBehaviour.enabled = false

    end

    self.mBehaviour:Init(self)

    

    if self.mGo then
        SetParent(self.mGo, nil)
        
        SetActive(self.mGo, false)
    end

    SetActive(self.mWeapon, false)
    

    self.mStateEnd = false

    self.mPlayerSkillState.mTargetDirection = self.machine.mPlayerCharacter.transform.forward
    if self.machine.mPlayerCharacter.mLockPlayerCharacter then

        self.mLockPlayerCharacter = self.machine.mPlayerCharacter.mLockPlayerCharacter
       
        self.mTargetPosition = GetPosition(self.mLockPlayerCharacter.gameObject,self.mTargetPosition)
        
        self.mPosition = GetPosition(self.machine.mPlayerCharacter.gameObject,self.mPosition)
       
        self.mTargetPosition.y = self.mPosition.y
        if Vector3.Distance( self.mPosition, self.mTargetPosition) <= self.mDistance then
            self.mPlayerSkillState.mTargetDirection = self.mTargetPosition -  self.mPosition
        end

    end
end


function Ahri_PlayerEffectFollowPlugin:OnBegin()
    
    if self.mGo == nil then
        return
    end

    self.mEffectEnd = false
    self.mFollow = false

    SetParent(self.mGo, nil)
    SetActive(self.mGo,true)
    self.mOriginalPosition = self.mParent.position
    self.mBehaviour.enabled = true

    local go = self.machine.mPlayerCharacter.gameObject
    local direction =GetForward(go)

    self.mPosition = GetPosition(go,self.mPosition)

    if self.machine.mPlayerCharacter.mLockPlayerCharacter then

        self.mLockPlayerCharacter = self.machine.mPlayerCharacter.mLockPlayerCharacter
       
        self.mTargetPosition = GetPosition(self.mLockPlayerCharacter.gameObject, self.mTargetPosition)
        self.mTargetPosition.y = self.mPosition.y

        if Vector3.Distance(self.mPosition, self.mTargetPosition) <= self.mDistance  then
            direction = ( self.mTargetPosition- self.mPosition).normalized
            self.mFollow = true
        end
       
    end

    if self.mFollow == false then

        self.mPosition.y = self.mOriginalPosition.y
        self.mDestination = self.mPosition + direction * self.mDistance
        self.mDuration = self.mDistance * 1.0 / self.mSpeed

        if self.mTween == nil then

            self.mTween = Tweener.new()
            self.mTween.method = TweenerMethod.EaseOut
            self.mTween.onFinished = function() 
                if self.mStateEnd and self.mEffectEnd then
                    self:Reset()
                else
                    self.mGo:SetActive(false)
                    self.mPlayerEffectState.isPlaying = false   
                end
            end
            self.mTween.onUpdate = function (factor, isFinished)

                SetPosition(self.mGo, self.mOriginalPosition * (1-factor) + self.mDestination * factor)
                
            end
        end
        self.mTween:ResetToBeginning()
        self.mTween.duration = self.mDuration
        self.mTween:PlayForward()
    end
end

function Ahri_PlayerEffectFollowPlugin:OnExecute()

    if self.mFollow and self.mLockPlayerCharacter then
       
        SetActive(self.mGo, true)
        
       
        self.mTargetPosition = GetPosition(self.mLockPlayerCharacter.gameObject,self.mTargetPosition)
        self.mPosition = GetPosition(self.mGo,self.mPosition)
        self.mTargetPosition.y = self.mTargetPosition.y + self.mLockPlayerCharacter.mPlayerInfo.height * 0.5
        
        local direction = self.mTargetPosition - self.mPosition

       
        if direction.magnitude > 0.1 then

            local position = self.mPosition + direction.normalized * self.mSpeed * Time.deltaTime
            SetPosition(self.mGo, position)
        else
            SetActive( self.mGo, false)
            self.mFollow = false
            self.mPlayerEffectState.isPlaying = false    

        end

    end
end

function Ahri_PlayerEffectFollowPlugin:OnEnd()
  
    self.mEffectEnd = true
    self.mFollow = false

    if self.mTween then
        self.mTween:Pause()
        self.mTween:ResetToBeginning()
    end
    
    if self.mStateEnd then

        self:Reset()
   
    end
   
end
--动作状态机退出
function Ahri_PlayerEffectFollowPlugin:OnExit()
   
    self.mStateEnd = true
    
    if self.mEffectEnd then
       self:Reset()
    end
end

function Ahri_PlayerEffectFollowPlugin:Reset()

    if self.mGo then
        SetParent(self.mGo,self.mParent)
        SetLocalPosition(self.mGo, Vector3.zero)
        SetActive(self.mGo,false)
    end

    SetActive(self.mWeapon,true)
   
    if self.mBehaviour then
        self.mBehaviour.enabled = false
    end
end

function Ahri_PlayerEffectFollowPlugin:OnPause()

    if self.mTween then
        self.mTween:Pause()
    end
end


function Ahri_PlayerEffectFollowPlugin:OnResume()

    if self.mTween then
        self.mTween:Resume()
    end

end

function Ahri_PlayerEffectFollowPlugin:OnTriggerEnter(other)
   
    if other == nil or other.transform.parent ==nil then
        return
    end 

    local behaviour = other.transform.parent:GetComponent(typeof(LuaBehaviour))
    if behaviour == nil then
        return
    end

    local fashionBody = behaviour.luaTable
    if fashionBody == nil or fashionBody.mPlayerCharacter == nil then

        return 
    end 

    if fashionBody.mPlayerCharacter.mPlayerInfo.guid ~= self.machine.mPlayerCharacter.mPlayerInfo.guid then
        --print(fashionBody.mPlayerCharacter.mPlayerInfo.guid)
    end

end
