
WindowScale = {}
function WindowScale.Begin(window, duration, active, callback)

    if window == nil then
        return
    end

    if window.tween == nil then
        window.tween = Tweener.new()
    end

    window.tween:ResetToBeginning()    
    window.tween.onFinished = nil
    
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
    
end
