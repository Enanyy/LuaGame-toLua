require("PlayerEffectPlugin")

local Slerp =  Quaternion.Slerp
local LookRotation = Quaternion.LookRotation

Ahri_PlayerEffectMoveAndBackPlugin = Class(PlayerEffectPlugin)

function Ahri_PlayerEffectMoveAndBackPlugin:ctor(name)
    self.mSpeed = 10
    self.mDistance = 10

    self.mMoveBack = false  
    self.mDone = false  
    
    self.mParent = nil
    self.mWeapon = nil    
    self.mGo = nil

    self.mStateEnd = false
    self.mEffectEnd = false

    self.mDistanceOffset = 1

    self.mRotation = Quaternion.identity
    self.mForward = Vector3.zero
    self.mPosition = Vector3.zero

end
function Ahri_PlayerEffectMoveAndBackPlugin:Init(behaviour)

    self.mBehaviour = behaviour or  self.mBehaviour
   
end
function Ahri_PlayerEffectMoveAndBackPlugin:InitWithConfig(configure)

    if configure == nil then return end


    self.mSpeed = configure.speed or self.mSpeed
    self.mDistance = configure.distance or self.mDistance

end

function Ahri_PlayerEffectMoveAndBackPlugin:OnEnter()
    
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

        self.mBehaviour = AddLuaBehaviour(self.mGo, "Ahri_PlayerEffectMoveAndBackPlugin", self)
       
        self.mBehaviour.enabled = false
    end


 
    if self.mGo then
        SetParent(self.mGo,nil)
        
        SetActive(self.mGo,false)
    end

    SetActive(self.mWeapon,false)

    self.mStateEnd = false

    self.mPlayerSkillState.mTargetDirection = GetForward(self.machine.mPlayerCharacter.gameObject,self.mPlayerSkillState.mTargetDirection)
    if self.machine.mPlayerCharacter.mLockPlayerCharacter then

        local target = GetPosition(self.machine.mPlayerCharacter.mLockPlayerCharacter.gameObject)
        local original = GetPosition(self.machine.mPlayerCharacter.gameObject)

        target.y = original.y
        if Vector3.Distance(original, target) <= (self.mDistance + self.mDistanceOffset) then
            self.mPlayerSkillState.mTargetDirection = target - original
        end

    end

end


function Ahri_PlayerEffectMoveAndBackPlugin:OnBegin()
   
    self.mEffectEnd = false
    
    if self.mGo == nil then return end 

    self.mMoveBack = false
    self.mDone = false 
    
    SetParent(self.mGo,nil)
    SetActive(self.mGo,true)
    self.mBehaviour.enabled = true

    self.mOriginalPosition = self.mParent.position

    local go = self.machine.mPlayerCharacter.gameObject
    local direction = GetForward(go)
    local original = GetPosition(go)

    if self.machine.mPlayerCharacter.mLockPlayerCharacter then

        local target = GetPosition(self.machine.mPlayerCharacter.mLockPlayerCharacter.gameObject)
       
        target.y = original.y
       
        if Vector3.Distance(original, target) <= (self.mDistance + self.mDistanceOffset) then
            direction = ( target- original).normalized
        end
    end

    original.y = self.mOriginalPosition.y
    
    self.mDestination = original + direction * self.mDistance
    self.mDuration = self.mDistance * 1.0 / self.mSpeed

    self.mGo.transform.forward = ( self.mDestination - self.mParent.position).normalized

    if self.mTween == nil then

        self.mTween = Tweener.new()
        self.mTween.method = TweenerMethod.EaseOut
        self.mTween.onFinished = function() 
            self.mMoveBack = true
            self.mGo.transform.forward = (self.mParent.position - self.mGo.transform.position).normalized
        end
        self.mTween.onUpdate = function (factor, isFinished)

            local position = self.mOriginalPosition * (1-factor) + self.mDestination * factor
            SetPosition(self.mGo, position)
        end
    end
    self.mTween:ResetToBeginning()
    self.mTween.duration = self.mDuration
    self.mTween:PlayForward()

end

function Ahri_PlayerEffectMoveAndBackPlugin:OnExecute()

    if self.mMoveBack and self.mDone == false then

       
        self.mPosition= GetPosition(self.mGo,self.mPosition)

        local direction = self.mParent.position - self.mPosition

        local distance =  direction.magnitude
       
        self.mRotation= GetRotation(self.mGo,self.mRotation)

        self.mRotation = Slerp (self.mRotation,  LookRotation(direction), Time.deltaTime * 100);

        SetRotation(self.mGo, self.mRotation)
        
        if distance > 0.2 then

           
            self.mForward= GetForward(self.mGo,self.mForward)

            local position = self.mPosition + self.mForward * self.mSpeed * Time.deltaTime
            SetPosition(self.mGo, position)
        else

            self.mDone = true
            self.mPlayerEffectState.isPlaying = false    

        end

    end

end

function Ahri_PlayerEffectMoveAndBackPlugin:OnEnd()

    self.mEffectEnd = true
    self.mDone = true
    self.mMoveBack = false
    if self.mTween then
        self.mTween:Pause()        
        --self.mTween:ResetToBeginning()        
    end

    if self.mStateEnd then
        self:Reset()
    end
   
end

function Ahri_PlayerEffectMoveAndBackPlugin:OnExit()

    self.mStateEnd = true

    if self.mEffectEnd then
       self:Reset()
    end
    
end

function Ahri_PlayerEffectMoveAndBackPlugin:Reset()

    if self.mGo then
        SetParent(self.mGo,self.mParent)
        SetLocalPosition(self.mGo, Vector3.zero)
        SetActive(self.mGo,false)
    end
    if  (not self.mEffectMachine:IsPlaying(PlayerSkillType.Skill_3))  and 
        (not self.mEffectMachine:IsPlaying(PlayerSkillType.Attack_1)) and 
        (not self.mEffectMachine:IsPlaying(PlayerSkillType.Attack_2)) and
        (not self.mEffectMachine:IsPlaying(PlayerSkillType.Attack_3))
    then
        SetActive(self.mWeapon,true)
    end
    if self.mBehaviour then
        self.mBehaviour.enabled = false
    end
end

function Ahri_PlayerEffectMoveAndBackPlugin:OnPause()

    if self.mTween then
        self.mTween:Pause()
    end
end


function Ahri_PlayerEffectMoveAndBackPlugin:OnResume()


    if self.mTween then
        self.mTween:Resume()
    end
    
end
function Ahri_PlayerEffectMoveAndBackPlugin:OnTriggerEnter(other)
    if other == nil or other.transform.parent ==nil then
        return
    end 

    local behaviour = other.transform.parent:GetComponent(typeof(LuaBehaviour))
    if behaviour == nil then
        return
    end

    local fashionBody = behaviour:GetLuaTable("FashionBody")
    if fashionBody == nil or fashionBody.mPlayerCharacter ==nil then

        return 
    end 

    if fashionBody.mPlayerCharacter.mPlayerInfo.guid ~= self.machine.mPlayerCharacter.mPlayerInfo.guid then
        --print(fashionBody.mPlayerCharacter.mPlayerInfo.guid)
    end
end
