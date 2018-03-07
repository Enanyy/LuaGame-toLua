require("Class")
require("BehaviourBase")
require("UnityClass")

SmoothFollow = Class(BehaviourBase)
local this = SmoothFollow

local LookRotation 	= Quaternion.LookRotation
local Slerp 		= Quaternion.Slerp
local Lerp			= Vector3.Lerp
local Euler			= Quaternion.Euler

function this:ctor(behaviour)
    self.target = nil
    self.distance = 6.0
	self.height = 8.0

    self.onLateUpdate = true

    self.rotation = Vector3.New(67,0,0)
	
	self.wantedPosition = Vector3.zero
	self.targetPosition = Vector3.zero
	
    self.update = function ()
        self:Update()
    end
    self.lateUpdate = function()
        self:LateUpdate() 
    end
end

function this:Start()

    --添加Lua逻辑更新
	UpdateBeat:Add(self.update,self)	 		
	LateUpdateBeat:Add(self.lateUpdate,self)	 		

end

function this:Update()

    if self.onLateUpdate == false then
        self:FollowTarget()
    end
end

function this:LateUpdate()
    
    if self.onLateUpdate then
        self:FollowTarget()
    end

end

function this:FollowTarget()

	if self.target == nil then
			return
    end

		
	local x, y, z = Helper.GetPosition(self.target, nil, nil, nil)
	self.targetPosition:Set(x, y, z)
		
	self.wantedPosition = self.targetPosition + Vector3.forward * self.distance * (-1)
	self.wantedPosition.y =self.height
    
	Helper.SetPosition(self.gameObject,self.wantedPosition.x, self.wantedPosition.y, self.wantedPosition.z)
	
	Helper.SetRotation(self.gameObject, self.rotation.x, self.rotation.y, self.rotation.z)
	
end

function this:OnDestroy()
    --移除Lua逻辑更新
    UpdateBeat:Remove(self.update,self)	 		
    LateUpdateBeat:Remove(self.lateUpdate,self)
end