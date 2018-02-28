require("Class")

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

Tweener = Class()

function Tweener:ctor()
    self.method = TweenerMethod.Linear
    self.style = TweenerStyle.Once
    self.delay = 0
    self.duration = 1
    self.steeperCurves = false

    self.mStarted = false
    self.mStartTime = 0
    self.mDuration = 0
    self.mAmountPerDelta = 1000
    self.mFactor = 0

    self.onFinished = nil

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
            local sign = self.mAmountPerDelta / math.abs( self.mAmountPerDelta )
            self.mAmountPerDelta = math.abs( 1.0 /self.duration ) * sign
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

    self.mFactor = self.mFactor + self:GetAmountPerDelta() * delta

    if self.style == TweenerStyle.Loop then

        if self.mFactor > 1 then
            self.mFactor = self.mFactor - math.floor( self.mFactor )
        end
    elseif self.style == TweenerStyle.PingPong then

        if self.mFactor > 1 then
            self.mFactor = 1 - (self.mFactor - math.floor( self.mFactor ))
            self.mAmountPerDelta = -self.mAmountPerDelta
        elseif self.mFactor < 0 then
            self.mFactor =  -self.mFactor
            self.mFactor = self.mFactor - math.floor( self.mFactor )
            self.mAmountPerDelta = -self.mAmountPerDelta            
        end

    end


    if self.style == TweenerStyle.Once and (self.duration == 0 or self.mFactor > 1 or self.mFactor < 0) then

        if self.mFactor > 1 then self.mFactor = 1 end
        if self.mFactor < 0 then self.mFactor = 0 end

        self:Sample(self.mFactor, true)

        if self.onFinished then
            self.onFinished()
        end
        UpdateBeat:Remove(self.update,self)
    else
        self:Sample(self.mFactor, false)
    end

end

function Tweener:Sample(factor, isFinished)

    if factor > 1 then factor = 1 end
    if factor < 0 then factor = 0 end

    if self.method == TweenerMethod.EaseIn then

        factor = 1 - math.sin( 0.5 * 3.14159274 * (1 - factor))

        if self.steeperCurves then
            factor = factor * factor
        end

    elseif self.method == TweenerMethod.EaseOut then
        
        factor = math.sin( 0.5 * 3.14159274 * factor)
        if self.steeperCurves then
            factor = 1 - factor
            factor = 1 - factor * factor
        end
    
    elseif self.method == TweenerMethod.EaseInOut then
        local PI2 = 3.14159274 * 2
        factor = factor - math.sin( factor * PI2) / PI2

        if self.steeperCurves then
            factor = factor * 2 - 1
            local sign = factor / math.abs(factor)
            factor = 1 - math.abs(factor)
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
	
	if val < 0.363636 then                                      -- 0.363636 = (1/ 2.75)
		
		val = 7.5685 * val * val
		
	elseif val < 0.727272 then                                 -- 0.727272 = (2 / 2.75)
		val = val - 0.545454
		val = 7.5625 * (val) * val + 0.75                       -- 0.545454f = (1.5 / 2.75) 
		
    elseif val < 0.909090 then                                  -- 0.909090 = (2.5 / 2.75) 
		val = val -  0.818181
		val = 7.5625 * (val) * val + 0.9375         -- 0.818181 = (2.25 / 2.75) 
		
    else
        val = val - 0.9545454
        val = 7.5625 * (val ) * val + 0.984375      -- 0.9545454 = (2.625 / 2.75) 
	end
    return val
end

function Tweener:OnUpdate(factor, isFinished)

    print(factor ..".."..tostring(isFinished))

end

function Tweener:Play(forward)
   
    self.mAmountPerDelta = math.abs( self:GetAmountPerDelta() )

    if not forward then
        self.mAmountPerDelta = -self.mAmountPerDelta
    end

    self:Update()

    UpdateBeat:Add(self.update,self)	 
end

function Tweener:PlayForward() 
    self:Play(true)
end

function Tweener:PlayReverse()
    self:Play(false)
end