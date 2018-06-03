require("PlayerSkillPlugin")
require("UnityClass")



PlayerSkillMovePlugin = Class("PlayerSkillMovePlugin",PlayerSkillPlugin)

local MAX_PATHPENDGING_TIME = 1
local STOPING_DISTANCE = 0.01

function PlayerSkillMovePlugin:ctor(name)
   
    self.mStopDistance = STOPING_DISTANCE
    self.mRemainingDistance = 0

    self.mBeginMove =false
    self.mFindPath =false

    
    self.mPathPendingTime = 0  --mNavMeshAgent计算路径的时长，超过1s寻路失败
    
    self.mGo = nil
    self.mPosition = Vector3.zero

end 

function PlayerSkillMovePlugin:InitWithConfig(configure)

    if configure == nil then return end

    self.mBeginAt = configure.beginAt
    self.mEndAt   = configure.endAt

    self.mGo = self.machine.mPlayerCharacter.gameObject

    if self.mNavMeshAgent == nil then

        self.mNavMeshAgent = GetComponent( self.mGo, typeof(NavMeshAgent))
        if self.mNavMeshAgent == nil then
            self.mNavMeshAgent = AddComponent( self.mGo,typeof(NavMeshAgent))
        end
    
        self.mNavMeshAgent.stoppingDistance = self.mStopDistance
        self.mNavMeshAgent.angularSpeed = 720000
        self.mNavMeshAgent.acceleration = 100
        self.mNavMeshAgent.speed = self.machine.mPlayerCharacter.mPlayerInfo.baseSpeed
        self.mNavMeshAgent.enabled = false   
    end
    
end

function PlayerSkillMovePlugin:OnEnter ()

    self.mRemainingDistance = 0
    self.mBeginMove = false
    self.mFindPath = false
     
    self.mNavMeshAgent.enabled = true
    self.mPathPendingTime = 0

end

function PlayerSkillMovePlugin:OnExecute ()

    local tmpPlayerCharacter = self.machine.mPlayerCharacter

    if tmpPlayerCharacter == nil then return end
    if self.mPlayerSkillState == nil then return end

    self.mPosition = GetPosition(self.mGo, self.mPosition)

    if tmpPlayerCharacter.mTargetPosition ~= self.mNavMeshAgent.destination then
     
        if  self.mPlayerSkillState.mRunTime >=  self.mBeginAt 
            and self.mPlayerSkillState.mRunTime <  self.mEndAt 
        then
         
            local tmpDistance = Vector3.Distance (self.mPosition, tmpPlayerCharacter.mTargetPosition)

            if  tmpDistance > 0.5 then 
            
                if UnityVersionNewer("5.6") then
                  self.mNavMeshAgent.isStopped = false  --Unity 5.6 or Hither
                else
                  self.mNavMeshAgent:Resume ()
                end

                if self.mNavMeshAgent:SetDestination (tmpPlayerCharacter.mTargetPosition) then
                    self.mFindPath = true
                 
                else 
                    
                   -- print ("SetDestination Fail: " .. tmpPlayerCharacter.mTargetPosition)
                   
                end
            else 
               -- print ("Distance is : " ..tmpDistance .. " less  0.5f")          
            end
        else 
            self:StopMove()	
        end
    end

    if self.mBeginMove == false then
        if self.mFindPath then
            
            if self.mNavMeshAgent.pathPending then

                self.mPathPendingTime = self.mPathPendingTime + Time.deltaTime
                --1s内都没计算出来就寻路失败吧
                if self.mPathPendingTime < MAX_PATHPENDGING_TIME then
                    --是在计算过程中的路径，但尚未准备好
                    return
                end
            end

            self.mPathPendingTime = 0

            if self.mNavMeshAgent.hasPath and self.mNavMeshAgent.pathStatus == NavMeshPathStatus.PathComplete then

                self.mBeginMove = true

            elseif 
                --self.mNavMeshAgent.hasPath == false or
                self.mNavMeshAgent.pathStatus ~= NavMeshPathStatus.PathComplete
            then
                        
                self.mFindPath = false
                tmpPlayerCharacter.mTargetPosition = GetPosition(self.mGo, tmpPlayerCharacter.mTargetPosition)
                self.mNavMeshAgent.destination = tmpPlayerCharacter.mTargetPosition
                tmpPlayerCharacter:OnMoveToPointFail()
                tmpPlayerCharacter:PlaySkill(PlayerSkillType.Idle)
              
            end
        else 

            
            local tmpTargetPosition = tmpPlayerCharacter.mTargetPosition
            tmpTargetPosition.y = self.mPosition.y
            local tmpRemainingDistance = Vector3.Distance (self.mPosition, tmpTargetPosition)

            if tmpRemainingDistance <= self.mStopDistance or ( (tmpRemainingDistance - self.mRemainingDistance)  < STOPING_DISTANCE and self.mNavMeshAgent.velocity == Vector3.zero) then

                tmpPlayerCharacter:PlaySkill(PlayerSkillType.Idle)

            else 
                self.mRemainingDistance = tmpRemainingDistance
            end
        end
    end

    if self.mBeginMove then

        local tmpMoveSpeed = tmpPlayerCharacter.mPlayerInfo.baseSpeed *(1 + tmpPlayerCharacter.mPlayerInfo.moveSpeedAddition)

        tmpPlayerCharacter.moveSpeed = tmpMoveSpeed
        
        if self.mNavMeshAgent.speed ~= tmpPlayerCharacter.moveSpeed then
            self.mNavMeshAgent.speed = tmpPlayerCharacter.moveSpeed
        end

        tmpPlayerCharacter.mTargetPosition.y = self.mPosition.y

        local tmpTargetPosition = tmpPlayerCharacter.mTargetPosition
        tmpTargetPosition.y = self.mPosition.y

        local tmpRemainingDistance = Vector3.Distance(self.mPosition, tmpTargetPosition)

        if tmpRemainingDistance <= self.mStopDistance
            or self.mNavMeshAgent.remainingDistance <= self.mStopDistance
            or tmpPlayerCharacter.targetPosition == Vector3.zero
            or ((tmpRemainingDistance - self.mRemainingDistance)  < STOPING_DISTANCE and self.mNavMeshAgent.velocity == Vector3.zero)
        then

                self.mBeginMove = false
                self.mFindPath = false
                self.mStopDistance = STOPING_DISTANCE

            if (tmpRemainingDistance - self.mRemainingDistance)  < STOPING_DISTANCE then
               
                  --print (self.mRemainingDistance .. "==" .. tmpRemainingDistance)
            end

            tmpPlayerCharacter:OnMoveToPointSuccess()

            tmpPlayerCharacter:PlaySkill(PlayerSkillType.Idle)

        else 

            self.mRemainingDistance = tmpRemainingDistance
           
        end
    end
end
    
function PlayerSkillMovePlugin:OnExit()

    self:StopMove()

end

function PlayerSkillMovePlugin:OnPause()

    self:StopMove()

end

function PlayerSkillMovePlugin:StopMove()

    self.mNavMeshAgent:ResetPath()
    if UnityVersionNewer("5.6") then
        self.mNavMeshAgent.isStopped = true --Unity5.6 or Hither
    else
        self.mNavMeshAgent:Stop()
    end
    
    self.mBeginMove = false
    self.mFindPath = false
end