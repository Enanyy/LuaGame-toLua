require("Class")

PlayerEffectMachine = Class()

function PlayerEffectMachine:ctor()

    self.mEffectStateList = {}

    self.mPause = false        --是否暂停
    
end

function PlayerEffectMachine:OnExecute()

    if self.mPause then
        return 
    end

    local list = {}
    for i,v in ipairs(self.mEffectStateList) do
       
        v:OnExecute()
  
        if v.isPlaying == false then
            
            table.insert(list, v)

        end
    end

    for i,v in ipairs(list) do
       
       self:Remove(v)
    end
end

function PlayerEffectMachine:Pause()
    
    self.mPause = true

    for i,v in ipairs(self.mEffectStateList) do
       
        v:OnPause()
    end
end

function PlayerEffectMachine:Resume()

    self.mPause = false
    
    for i,v in ipairs(self.mEffectStateList) do
       
        v:OnResume()
    end

end


function PlayerEffectMachine:Play(effectState)
    
    if effectState == nil then return end

    effectState:OnBegin()

    table.insert(self.mEffectStateList,effectState)

end


function PlayerEffectMachine:Remove(effectState)

    if effectState == nil then return end

    effectState:OnEnd()

    for i,v in ipairs(self.mEffectStateList) do
      
        if v == effectState then

            table.remove(self.mEffectStateList, i)

            break
        end
    end
end



