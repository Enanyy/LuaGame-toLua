require("PlayerSkillPlugin")

local Animation = UnityEngine.Animation
local AnimationState = UnityEngine.AnimationState
local WrapMode = UnityEngine.WrapMode

PlayerSkillAnimationPlugin = Class(PlayerSkillPlugin)

function PlayerSkillAnimationPlugin:ctor(name)
    
    self.mDone = false
    self.mAnimation = nil

end

function PlayerSkillAnimationPlugin:Init(configure)

    if configure == nil then return end

    self.mAnimationClip = configure.animationClip
    self.mLoop = configure.loop

    print("PlayerSkillAnimationPlugin:Init"..self.mAnimationClip)

end

function PlayerSkillAnimationPlugin:OnEnter()
    print("PlayerSkillAnimationPlugin:OnEnter")
    self.mDone = false
    self.mAnimationState = self:GetAnimationState()
    self:PlayAnimation()

end

function PlayerSkillAnimationPlugin:OnExecute()
          
    self:PlayAnimation()

end

function PlayerSkillAnimationPlugin:OnExit()
    print("PlayerSkillAnimationPlugin:OnExit")
    
    if self.mAnimationState then
        
        print(self.mAnimationClip .. ":" .. self.mAnimationState.length .. "," .. self.mAnimationState.time)
            
    end
end

function PlayerSkillAnimationPlugin:OnPause()
      
    if self.mAnimationState then
        
        self.mAnimation[self.mAnimationClip].speed = 0

     end
end

function PlayerSkillAnimationPlugin:OnResume()
    
    if  self.mAnimationState then
        
        self.mAnimationState.speed = self.mPlayerSkillState.mSpeed
   
    end
end

function PlayerSkillAnimationPlugin:PlayAnimation()

    if self.machine == nil then
        return 
    end

    local tmpPlayerCharacter = self.machine.mPlayerCharacter
    if tmpPlayerCharacter == nil then
        return
    end

    if self.mAnimation == nil then
        
        if tmpPlayerCharacter.mBody then
            self.mAnimation = tmpPlayerCharacter.mBody.transform:GetComponentInChildren(typeof(Animation))
    
        end
    end
    
    
    if self.mAnimation == nil then
        
        return
    end

    if self.mAnimationState == nil or self.mAnimationState.name ~= self.mAnimationClip then
        self.mAnimationState = self:GetAnimationState()
    end

    if  self.mAnimationState ~= nil then
        
        self.mAnimationState.speed = self.mPlayerSkillState.mSpeed
    end

    if self.mDone then
        
        return

    end

    if self.mLoop then
        self.mAnimation.wrapMode =  WrapMode.Loop 
    else
        self.mAnimation.wrapMode = WrapMode.Default
    end
 
        
    if  --self.mPlayerSkillState.mChangeAt == 0 and
        self.mPlayerSkillState.mFadeLength > 0 
    then
        
        self.mAnimation:CrossFade(self.mAnimationClip, self.mPlayerSkillState.mFadeLength)
        
    else
        
        if self.mAnimationState then
            self.mAnimationState.time = self.mPlayerSkillState.mRunTime
        end
        self.mAnimation:Play(self.mAnimationClip)
    end
    self.mDone = true

    print("PlayerSkillAnimationPlugin:PlayAnimation "..self.mAnimationClip .." Done")

end

function PlayerSkillAnimationPlugin:GetAnimationState()
    
    if self.mAnimation == nil then
        return nil
    end

    local it = self.mAnimation:GetEnumerator()
    while (it:MoveNext())
    do
        if it.Current.name == self.mAnimationClip then
           
            local tmpAnimationState = it.Current

            return tmpAnimationState
        end
    end

    return nil
end