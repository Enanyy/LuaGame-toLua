
WindowScale = {}
function WindowScale.Begin(window, duration, active, callback)

    if window == nil then
        return
    end

    local tween = window.transform:GetComponent(typeof(TweenScale))
    if tween == nil then
        tween = window.gameObject:AddComponent(typeof(TweenScale))
    end
    tween.onFinished:Clear()

    if tween.tweenFactor > 0 then
        tween.value = tween.value
    else
        if active then
            tween.value = Vector3.zero
        else
            tween.value = Vector3.one
        end
    end

    tween.from = tween.value
    if active then
        tween.to = Vector3.one
        if tween.value == Vector3.zero then
            tween.duration = duration
        else
            tween.duration = tween.value.magnitude * duration / Vector3.one.magnitude
        end
        if callback then
            callback()
        end
    else
        tween.to = Vector3.zero
        if tween.value == Vector3.one then
            tween.duration = duration
        else
            tween.duration = (Vector3.one- tween.value).magnitude * duration / Vector3.one.magnitude
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
