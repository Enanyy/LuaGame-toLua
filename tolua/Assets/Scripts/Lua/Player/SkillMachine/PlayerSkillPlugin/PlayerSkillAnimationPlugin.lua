require("PlayerSkillPlugin")

local Animation = UnityEngine.Animation
local WrapMode = UnityEngine.WrapMode

PlayerSkillAnimationPlugin = Class(PlayerSkillPlugin)

function PlayerSkillAnimationPlugin:ctor(name)
    
    self.mDone = false
    self.mAnimation = nil

end

function PlayerSkillAnimationPlugin:Init(configure)

    if configure == nil then return end

    self.mAnimationClip = self.animationClip
    self.mLoop = self.loop

end

function PlayerSkillAnimationPlugin:OnEnter()
    
    self.mDone = false
    self:PlayAnimation()

end

function PlayerSkillAnimationPlugin:OnExecute()
          
    self:PlayAnimation()

end

function PlayerSkillAnimationPlugin:OnExit()
    
    if self.mAnimation and self.mAnimation[self.mAnimationClip] then
        
        print(self.mAnimationClip .. ":" .. self.mAnimation[self.mAnimationClip].length .. "," .. self.mAnimation[self.mAnimationClip].time)
            
    end
end

function PlayerSkillAnimationPlugin:OnPause()
      
    if self.mAnimation then
        
        self.mAnimation[self.mAnimationClip].speed = 0

     end
end

function PlayerSkillAnimationPlugin:OnResume()
    
    if  self.mAnimation then
        
        self.mAnimation[self.mAnimationClip].speed = self.mPlayerSkillState.mSpeed
   
    end
end

function PlayerSkillAnimationPlugin:PlayAnimation()

    if self.mPlayerSkillState == nil
     or self.mPlayerSkillState.machine == nil
    then
        return 
    end

    local tmpPlayerCharacter = self.mPlayerSkillState.machine.mPlayerCharacter
    if tmpPlayerCharacter == nil then
        return
    end

    if self.mAnimation == nil then
        
        if tmpPlayerCharacter.mBody then
            self.mAnimation = tmpPlayerCharacter.mBody:GetComponentInChildren(typeof(Animation))
    
        end
    end
    
    if self.mAnimation == nil then
        
        return
    end

    if  self.mAnimation and self.mAnimation[self.mAnimationClip] then
        
        self.mAnimation[self.mAnimationClip].speed = self.mPlayerSkillState.mSpeed
    end

    if self.mDone then
        
        return

    end

    if self.mLoop then
        self.mAnimation.wrapMode =  WrapMode.Loop 
    else
        self.mAnimation.wrapMode = WrapMode.Default
    end
    print("Begin Animation " .. self.mAnimationClip .. ": " .. self.mPlayerSkillState.mChangeAt)
        

    if  --self.mPlayerSkillState.mChangeAt == 0 and
        self.mPlayerSkillState.mFadeLength > 0 
    then
           
        print(self.mPlayerSkillState.mPlayerSkillType .. " CrossFade " .. self.mAnimationClip .." " + self.mPlayerSkillState.mFadeLength)
        self.mAnimation:CrossFade(self.mAnimationClip, self.mPlayerSkillState.mFadeLength)
        
    else
        
        print(self.mPlayerSkillState.mPlayerSkillType .." Play " .. self.mAnimationClip)
        self.mAnimation[self.mAnimationClip].time = self.mPlayerSkillState.mRunTime
        self.mAnimation:Play(self.mAnimationClip);
    end
    self.mDone = true;

end