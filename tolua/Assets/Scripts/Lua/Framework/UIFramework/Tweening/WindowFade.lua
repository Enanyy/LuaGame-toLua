
WindowFade = {}
function WindowFade.Begin(window, duration, active, callback)

    if window == nil then
        return
    end

    if window.tween == nil then
        window.tween = Tweener.new()
    end

    window.tween:ResetToBeginning()    

    local current = window.panel.alpha
    local from = 0
    local to = 0
    if active then
        to = 1
        if window.tween.factor > 0 then
            from = current
        else
            from = 0
        end
        window.tween.duration = math.abs( (to - from) * duration / 1.0 )
        if callback then
            callback()
        end
    else
        to = 0
        if window.tween.factor > 0 then
            from = current
        else
            from = 1
        end
        window.tween.duration =  math.abs( (to - from) * duration / 1.0 )
        window.tween.onFinished = callback
        
    end

    window.tween.onUpdate = function(factor, isFinished)
        window.panel.alpha = from * (1 - factor) + to * factor
    end

    window.tween:PlayForward()
    --[[

    local tween = window.transform:GetComponent(typeof(TweenAlpha))
    if tween == nil then
        tween = window.gameObject:AddComponent(typeof(TweenAlpha))
    end
    tween.onFinished:Clear()

    if tween.tweenFactor > 0 then
        tween.value = tween.value
    else
        if active then
            tween.value = 0
        else
            tween.value = 1
        end
    end

    tween.from = tween.value
    if active then
        tween.to = 1
        if tween.value == 0 then
            tween.duration = duration
        else
            tween.duration = tween.value * duration / 1.0
        end
        if callback then
            callback()
        end
    else
        tween.to = 0
        if tween.value == 1 then
            tween.duration = duration
        else
            tween.duration = (1 - tween.value) * duration / 1.0
        end
        tween.onFinished:Add(EventDelegate.New(function()
            if callback then
                callback()
            end
        end))
    end
    tween:ResetToBeginning()
    tween:PlayForward()
     --]]
end
