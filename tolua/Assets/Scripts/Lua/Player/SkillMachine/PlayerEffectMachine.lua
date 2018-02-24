require("Class")

PlayerEffectMachine = Class()

function PlayerEffectMachine:ctor()

    self.mEffectStateList = {}
    
end

function PlayerEffectMachine:OnExecute()

    local list = {}
    for i,v in ipairs(self.mEffectStateList) do
       
        v:OnExecute()
  
        if v:isPlaying() == false then
            
            table.insert(list, v)

        end
    end

    for i,v in ipairs(list) do
       self:Remove(v)
    end
end


function PlayerEffectMachine:Play(effectState)
    
    table.insert(self.mEffectStateList,effectState)

end


function PlayerEffectMachine:Remove(effectState)

    table.remove(self.mEffectStateList,effectState)
end



