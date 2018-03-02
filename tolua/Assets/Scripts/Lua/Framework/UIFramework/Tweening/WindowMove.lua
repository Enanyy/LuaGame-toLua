require("Tweener")

WindowMove = {}
function WindowMove.Begin(window, pos, duration, active, callback)

    if window == nil then
        return
    end

    if window.tween == nil then
        window.tween = Tweener.new()
    end

    window.tween:ResetToBeginning()    

    local current = window.transform.position
    local from = Vector3.zero
    local to = Vector3.zero
    if active then
        to = Vector3.zero
        if window.tween.factor > 0 then
            from = current
        else
            from = pos
        end
        window.tween.duration = math.abs( (to - from).magnitude * duration / (to - pos).magnitude )
        if callback then
            callback()
        end
    else
        to = pos
        if window.tween.factor > 0 then
            from = current
        else
            from = Vector3.zero
        end
        window.tween.duration =  math.abs( (to - from).magnitude * duration / to.magnitude )
        window.tween.onFinished = callback
        
    end

    window.tween.onUpdate = function(factor, isFinished)
        window.transform.localPosition = from * (1 - factor) + to * factor
    end

    window.tween:PlayForward()


    --[[ 
    local tween = window.transform:GetComponent(typeof(TweenPosition))
    if tween == nil then
        tween = window.gameObject:AddComponent(typeof(TweenPosition))
    end
    tween.onFinished:Clear()

    if tween.tweenFactor > 0 then
        tween.value = tween.value
    else
        if active then
            tween.value = pos
        else
            tween.value = Vector3.zero
        end
    end

    tween.from = tween.value
    if active then
        tween.to = Vector3.zero
        if tween.value == pos then
            tween.duration = duration
        else
            tween.duration = (pos - tween.value).magnitude * duration / pos.magnitude 
        end
        if callback then
            callback()
        end
    else
        tween.to = pos
        if tween.value == Vector3.zero then
            tween.duration = duration
        else
            tween.duration = tween.value.magnitude * duration / pos.magnitude
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

WindowPivot = {
    Top         = 1,
    Bottom      = 2,
    Left        = 3,
    Right       = 4,
    TopLeft     = 5,
    TopRight    = 6,
    BottomLeft  = 7,
    BottomRight = 8,
}

function WindowMove.GetPivot(pivot)
    
    local pos = Vector3.New()

    local root = WindowManager.uiRoot
 
    if pivot == WindowPivot.Top then
        pos.y = root.manualHeight 
    elseif pivot == WindowPivot.Bottom then
        pos.y = -root.manualHeight
    elseif pivot == WindowPivot.Left then
        pos.x = -root.manualWidth
    elseif pivot == WindowPivot.Right then
        pos.x = root.manualWidth
    elseif pivot == WindowPivot.TopLeft then
        pos.x = -root.manualWidth
        pos.y = root.manualHeight
    elseif pivot == WindowPivot.TopRight then
        pos.x = root.manualWidth
        pos.y = root.manualHeight
    elseif pivot == WindowPivot.BottomLeft then
        pos.x = -root.manualWidth
        pos.y = -root.manualHeight
    elseif pivot == WindowPivot.BottomRight then
        pos.x = root.manualWidth
        pos.y = -root.manualHeight
    end
        
    return pos
end