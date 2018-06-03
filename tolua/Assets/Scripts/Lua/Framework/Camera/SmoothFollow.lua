require("Class")
require("BehaviourBase")
require("UnityClass")

SmoothFollow = Class("SmoothFollow",BehaviourBase)

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
    
    self.update = UpdateBeat:CreateListener(function() self:Update() end, self)
   
    self.lateUpdate = LateUpdateBeat:CreateListener(function() self:LateUpdate() end, self)
      
end

function this:Start()

    --添加Lua逻辑更新	
    UpdateBeat:AddListener(self.update)	 		
	LateUpdateBeat:AddListener(self.lateUpdate)	 		

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
	
	self.targetPosition = GetPosition(self.target,self.targetPosition)
		
	self.wantedPosition = self.targetPosition + Vector3.forward * self.distance * (-1)
	self.wantedPosition.y =self.targetPosition.y + self.height
    
	SetPosition(self.gameObject,self.wantedPosition)
	
	SetEuler(self.gameObject, self.rotation)
	
end

function this:OnDestroy()
    --移除Lua逻辑更新
    UpdateBeat:RemoveListener(self.update)
    LateUpdateBeat:RemoveListener(self.lateUpdate)
   
end