
WindowFade = {}
function WindowFade.Begin(window, duration, active, callback)

    if window == nil then
        return
    end

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
    
end
