
WindowScale = {}
function WindowScale.Begin(window, duration, active, callback)

    if window == nil then
        return
    end

    if window.tween == nil then
        window.tween = Tweener.new()
    end

    window.tween:ResetToBeginning()    

    local current = window.transform.localScale
    local from = Vector3.zero
    local to = Vector3.zero
    if active then
        to = Vector3.one
        if window.tween.factor > 0 then
            from = current
        else
            from = Vector3.zero
        end
        window.tween.duration = math.abs( (to - from).magnitude * duration / Vector3.one.magnitude )
        if callback then
            callback()
        end
    else
        to = Vector3.zero
        if window.tween.factor > 0 then
            from = current
        else
            from = Vector3.one
        end
        window.tween.duration =  math.abs( (to - from).magnitude * duration / Vector3.one.magnitude )
        window.tween.onFinished = callback
        
    end

    window.tween.onUpdate = function(factor, isFinished)
        window.transform.localScale = from * (1 - factor) + to * factor
    end

    window.tween:PlayForward()
    --[[ 
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
    --]]
end
