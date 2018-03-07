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
	self.damping = 1.0
	self.smoothRotation = false
	self.followBehind = false
	self.rotationDamping = 10.0
    self.smoothPosition = false
    self.onLateUpdate = true

    self.rotation = Vector3.New(67,0,0)
	
	self.wantedPosition = Vector3.zero
	
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


	if self.followBehind then

		self.wantedPosition = self.target:TransformPoint (0, self.height, -self.distance)
	
	else 
		--wantedPosition = target.TransformPoint (0, height, distance);
		self.wantedPosition = self.target.position + Vector3.forward * self.distance * (-1)
		self.wantedPosition.y =self.height
    end
    
	if self.smoothPosition then

		self.transform.position =  Lerp (self.transform.position, self.wantedPosition, Time.deltaTime * self.damping)

	else 
		self.transform.position = self.wantedPosition
	end

	if self.smoothRotation then
		self.wantedRotation = LookRotation (self.target.position - self.transform.position, self.target.up)
		self.transform.rotation = Slerp (self.transform.rotation, self.wantedRotation, Time.deltaTime * self.rotationDamping)
    
     else 
		--transform.LookAt (target, target.up)
		self.transform.rotation = Euler(self.rotation.x, self.rotation.y, self.rotation.z)

	end
end

function this:OnDestroy()
    --移除Lua逻辑更新
    UpdateBeat:Remove(self.update,self)	 		
    LateUpdateBeat:Remove(self.lateUpdate,self)
end