require("PlayerEffectPlugin")


Ahri_PlayerEffectMovePlugin = Class(PlayerEffectPlugin)
 
function Ahri_PlayerEffectMovePlugin:ctor(name)

    self.mSpeed = 10
    self.mDistance = 10
    
    self.mParent = nil
    self.mGo = nil

end 


function Ahri_PlayerEffectMovePlugin:Init(configure)

    if configure == nil then return end

    self.mSpeed = configure.speed
    self.mDistance = configure.distance


end


function Ahri_PlayerEffectMovePlugin:OnEnter()
   
    if self.mGo == nil then

        self.mGo = self.machine.mPlayerCharacter.mFashionWeapon.mWeapon
        self.mParent = self.mGo.transform.parent

    end


    self.mGo.transform:SetParent(nil)


    self.mOriginalPosition =self.mGo.transform.position
    self.mDestination = self.mOriginalPosition + self.machine.mPlayerCharacter.transform.forward * self.mDistance

    self.mDuration = self.mDistance * 1.0 / self.mSpeed

end

function Ahri_PlayerEffectMovePlugin:OnExecute()

    if self.mDuration ~= 0 then

        local factor = self.mPlayerEffectState.mRunTime * 1.0 / self.mDuration
        self.mGo.transform.position = self.mOriginalPosition * (1 - factor) + self.mDestination * factor

        if factor >= 1 then

            self.mPlayerEffectState.isPlaying = false

        end
    end
end

function Ahri_PlayerEffectMovePlugin:OnExit()

    
    self.mGo.transform:SetParent(self.mParent)
    self.mGo.transform.localPosition = Vector3.zero

end

function Ahri_PlayerEffectMovePlugin:OnPause()


end


function Ahri_PlayerEffectMovePlugin:OnResume()



end
