require("Class")
require("Mathf")

Tweener = Class("Tweener")
TweenerMethod = 
{
    Linear      = 0,
	EaseIn      = 1,
	EaseOut     = 2,
	EaseInOut   = 3,
	BounceIn    = 4,
	BounceOut   = 5,
}

TweenerStyle =
{
    Once        = 0,
	Loop        = 1,
	PingPong    = 2,
}

TweenerDirection = 
{
    Reverse     = -1,
	Toggle      = 0,
	Forward     = 1,
}

--缓存引用，避免不停的去查表
local PI            = 3.14159274
local Sign          = Mathf.Sign
local abs           = math.abs
local floor         = math.floor
local Clamp01       = Mathf.Clamp01
local sin           = math.sin 

function Tweener:ctor()
    self.method = TweenerMethod.Linear
    self.style = TweenerStyle.Once
    self.delay = 0
    self.duration = 1
    self.steeperCurves = false
    self.isPause = false

    self.mStarted = false
    self.mStartTime = 0
    self.mDuration = 0
    self.mAmountPerDelta = 1000

    self.factor = 0

    self.onFinished = nil
    self.onUpdate   = nil

    self.update = function ()
        self:Update()
    end
end 

function Tweener:GetAmountPerDelta()
    if self.duration == 0 then
        self.mAmountPerDelta  = 1000
    else
        if self.mDuration ~= self.duration then
            self.mDuration = self.duration
            local sign = Sign( self.mAmountPerDelta )
            local delta = 1000 
            if self.duration > 0 then delta = 1.0 /self.duration end
            self.mAmountPerDelta = abs( delta ) * sign
        end
    end

    return  self.mAmountPerDelta 
end

function Tweener:Update()

    local delta = Time.deltaTime
    local time = Time.time

    if self.mStarted == false then
        delta = 0
        self.mStarted = true
        self.mStartTime = time + self.delay
    end

    if time < self.mStartTime then return end

    self.factor = self.factor + self:GetAmountPerDelta() * delta

    if self.style == TweenerStyle.Loop then

        if self.factor > 1 then
            self.factor = self.factor - floor( self.factor )
        end
    elseif self.style == TweenerStyle.PingPong then

        if self.factor > 1 then
            self.factor = 1 - (self.factor - floor( self.factor ))
            self.mAmountPerDelta = -self.mAmountPerDelta
        elseif self.factor < 0 then
            self.factor =  -self.factor
            self.factor = self.factor - floor( self.factor )
            self.mAmountPerDelta = -self.mAmountPerDelta            
        end

    end


    if self.style == TweenerStyle.Once and (self.duration == 0 or self.factor > 1 or self.factor < 0) then

        self.factor = Clamp01(self.factor)

        self:Sample(self.factor, true)

        UpdateBeat:Remove(self.update,self)

        if self.onFinished then
            self.onFinished()
        end
    else
        self:Sample(self.factor, false)
    end

end

function Tweener:Sample(factor, isFinished)

    factor = Clamp01(factor)

    if self.method == TweenerMethod.EaseIn then
        factor = 1 - sin( 0.5 * PI * (1 - factor))
        if self.steeperCurves then
            factor = factor * factor
        end
    elseif self.method == TweenerMethod.EaseOut then
        factor = sin( 0.5 * PI * factor)
        if self.steeperCurves then
            factor = 1 - factor
            factor = 1 - factor * factor
        end
    elseif self.method == TweenerMethod.EaseInOut then
        local PI2 = PI * 2
        factor = factor - sin( factor * PI2) / PI2

        if self.steeperCurves then
            factor = factor * 2 - 1
            local sign = Sign(factor) 
            factor = 1 - abs(factor)
            factor = 1 - factor * factor
            factor = sign * factor * 0.5 + 0.5
        end
    elseif self.method == TweenerMethod.BounceIn then
        factor = self:BounceLogic(factor)
    elseif self.method == TweenerMethod.BounceOut then
        factor = 1 - self:BounceLogic(1 - factor)
    end

    self:OnUpdate(factor, isFinished)

end

function Tweener:BounceLogic ( val)
	
	if val < 0.363636 then                                     -- 0.363636 = (1/ 2.75)
		val = 7.5685 * val * val
	elseif val < 0.727272 then                                 -- 0.727272 = (2 / 2.75)
		val = val - 0.545454
		val = 7.5625 * val * val + 0.75                        -- 0.545454 = (1.5 / 2.75) 	
    elseif val < 0.909090 then                                 -- 0.909090 = (2.5 / 2.75) 
		val = val -  0.818181
		val = 7.5625 * val * val + 0.9375                      -- 0.818181 = (2.25 / 2.75) 
    else
        val = val - 0.9545454
        val = 7.5625 * val  * val + 0.984375                   -- 0.9545454 = (2.625 / 2.75) 
	end
    return val
end

function Tweener:OnUpdate(factor, isFinished)

   if  self.onUpdate then
        self.onUpdate(factor, isFinished)
   end

end

function Tweener:Play(forward)
   
    self.mAmountPerDelta = abs( self:GetAmountPerDelta() )

    if forward == false then
        self.mAmountPerDelta = -self.mAmountPerDelta
    end
    self.isPause = false
    self:Update()

    UpdateBeat:Add(self.update,self)	 
end

function Tweener:PlayForward() 
    self:Play(true)
end

function Tweener:PlayReverse()
    self:Play(false)
end

function Tweener:ResetToBeginning ()
	
    self.mStarted = false
    if self:GetAmountPerDelta() < 0 then
        self.factor = 1
    else
        self.factor = 0    
    end
	
	self:Sample(self.factor, false)
end

function Tweener:Pause()

    self.isPause = true
    UpdateBeat:Remove(self.update,self)

end
function Tweener:Resume()

    self.isPause = false
    UpdateBeat:Add(self.update,self)    

end

function Tweener:Clear()

    self.isPause = false
    self.onFinished = nil
    UpdateBeat:Remove(self.update,self)

end