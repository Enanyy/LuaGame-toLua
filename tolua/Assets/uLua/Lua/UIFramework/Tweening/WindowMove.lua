
WindowMove = {}
function WindowMove.Begin(window, from, duration, active, callback)

    if window == nil then
        return
    end

    local pos = WindowMove.GetPivot(from)

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
            tween.duration = (pos - tween.value).magnitude * duration / from.magnitude 
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
end

function WindowMove.GetPivot(pivot)
    
    local pos = Vector3.New()

    local root = WindowManager.uiRoot
 
    if pivot == "Top" then
        pos.y = root.manualHeight 
    elseif pivot == "Bottom" then
        pos.y = -root.manualHeight
    elseif pivot == "Left" then
        pos.x = -root.manualWidth
    elseif pivot == "Right" then
        pos.x = root.manualWidth
    elseif pivot == "TopLeft" then
        pos.x = -root.manualWidth
        pos.y = root.manualHeight
    elseif pivot == "TopRight" then
        pos.x = root.manualWidth
        pos.y = root.manualHeight
    elseif pivot == "BottomLeft" then
        pos.x = -root.manualWidth
        pos.y = -root.manualHeight
    elseif pivot == "BottomRight" then
        pos.x = root.manualWidth
        pos.y = -root.manualHeight
    end
        
    return pos;
end