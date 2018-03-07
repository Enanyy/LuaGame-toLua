
local abs = math.abs

WindowFade = {}
function WindowFade.Begin(window, duration, active, callback)

    if window == nil then
        return
    end

    if window.tween == nil then
        window.tween = Tweener.new()
    end

    window.tween:ResetToBeginning()    
    window.tween.onFinished = nil
    
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
        window.tween.duration = abs( (to - from) * duration / 1.0 )
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
        window.tween.duration =  abs( (to - from) * duration / 1.0 )
        window.tween.onFinished = callback
        
    end

    window.tween.onUpdate = function(factor, isFinished)
        window.panel.alpha = from * (1 - factor) + to * factor
    end

    window.tween:PlayForward()
   
end
