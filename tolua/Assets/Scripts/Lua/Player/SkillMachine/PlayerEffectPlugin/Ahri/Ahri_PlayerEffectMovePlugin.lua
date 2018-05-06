require("PlayerEffectPlugin")
require("Tweener")

Ahri_PlayerEffectMovePlugin = Class(PlayerEffectPlugin)
 
function Ahri_PlayerEffectMovePlugin:ctor(name)

    self.mSpeed = 10
    self.mDistance = 10
    
    self.mParent = nil
    self.mWeapon = nil
    self.mGo = nil

    self.mStateEnd = false
    self.mEffectEnd = false

    self.mDistanceOffset = 2
end 

function Ahri_PlayerEffectMovePlugin:Init(behaviour)

    self.mBehaviour = behaviour or  self.mBehaviour
   
end

function Ahri_PlayerEffectMovePlugin:InitWithConfig(configure)

    if configure == nil then return end

    self.mSpeed = configure.speed or self.mSpeed
    self.mDistance = configure.distance or self.mDistance


end

function Ahri_PlayerEffectMovePlugin:OnEnter()

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

        self.mBehaviour = AddLuaBehaviour(self.mGo, "Ahri_PlayerEffectMovePlugin", self )
       
        self.mBehaviour.enabled = false

    end


   
    if self.mGo then
        SetParent( self.mGo, nil)
        
        SetActive(self.mGo,false)
    end
    SetActive(self.mWeapon,false)

    self.mStateEnd = false

    self.mPlayerSkillState.mTargetDirection = self.machine.mPlayerCharacter.transform.forward
    if self.machine.mPlayerCharacter.mLockPlayerCharacter then

        local target = GetPosition( self.machine.mPlayerCharacter.mLockPlayerCharacter.gameObject)
        local original = GetPosition( self.machine.mPlayerCharacter.gameObject)

        target.y = original.y
        if Vector3.Distance(original, target) <= (self.mDistance + self.mDistanceOffset) then
            self.mPlayerSkillState.mTargetDirection = target - original
        end

    end
end


function Ahri_PlayerEffectMovePlugin:OnBegin()
    
    if self.mGo == nil then
        return
    end

    self.mEffectEnd = false

   

    SetParent(self.mGo,nil)
    SetActive(self.mGo,true)
    self.mOriginalPosition = self.mParent.position
    self.mBehaviour.enabled = true

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

    if self.mTween == nil then

        self.mTween = Tweener.new()
        self.mTween.method = TweenerMethod.EaseOut
        self.mTween.onFinished = function() 
            
            self.mPlayerEffectState.isPlaying = false  
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

function Ahri_PlayerEffectMovePlugin:OnExecute()

   
end

function Ahri_PlayerEffectMovePlugin:OnEnd()
    
    self.mEffectEnd = true

    if self.mTween then
        self.mTween:Pause()
        self.mTween:ResetToBeginning()
    end
    
    if self.mStateEnd then

        self:Reset()
   
    end
   
end
--动作状态机退出
function Ahri_PlayerEffectMovePlugin:OnExit()

    self.mStateEnd = true
    
    if self.mEffectEnd then
       self:Reset()
    end
end

function Ahri_PlayerEffectMovePlugin:Reset()

    if self.mGo then
        SetParent(self.mGo,self.mParent)
        
        SetLocalPosition(self.mGo, Vector3.zero)
        SetActive(self.mGo,false)
    end
    

    if  (not self.mEffectMachine:IsPlaying(PlayerSkillType.Skill_1))  and 
        (not self.mEffectMachine:IsPlaying(PlayerSkillType.Attack_1)) and 
        (not self.mEffectMachine:IsPlaying(PlayerSkillType.Attack_2)) and
        (not self.mEffectMachine:IsPlaying(PlayerSkillType.Attack_3))
    then
        SetActive(self.mWeapon, true)
    end
    
   
    if self.mBehaviour then
        self.mBehaviour.enabled = false
    end
end

function Ahri_PlayerEffectMovePlugin:OnPause()

    if self.mTween then
        self.mTween:Pause()
    end
end


function Ahri_PlayerEffectMovePlugin:OnResume()

    if self.mTween then
        self.mTween:Resume()
    end

end

function Ahri_PlayerEffectMovePlugin:OnTriggerEnter(other)
   
    if other == nil or other.transform.parent ==nil then
        return
    end 

    local behaviour = other.transform.parent:GetComponent(typeof(LuaBehaviour))
    if behaviour == nil then
        return
    end

    local fashionBody = behaviour:GetLuaTable("FashionBody")
    if fashionBody == nil  or fashionBody.mPlayerCharacter == nil then

        return 
    end 

    if fashionBody.mPlayerCharacter.mPlayerInfo.guid ~= self.machine.mPlayerCharacter.mPlayerInfo.guid then
        --print(fashionBody.mPlayerCharacter.mPlayerInfo.guid)
        if  self.mTween.onFinished then
            self.mTween.onFinished()
        end
    end

end

