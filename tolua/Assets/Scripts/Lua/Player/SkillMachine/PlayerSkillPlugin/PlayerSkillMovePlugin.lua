require("PlayerSkillPlugin")

--local NavMeshAgent =  UnityEngine.AI.NavMeshAgent   --Unity5.6
--local NavMeshPathStatus = UnityEngine.AI.NavMeshPathStatus  --Unity5.6
local NavMeshAgent =  UnityEngine.NavMeshAgent
local NavMeshPathStatus = UnityEngine.NavMeshPathStatus

PlayerSkillMovePlugin = Class(PlayerSkillPlugin)

function PlayerSkillMovePlugin:ctor(name)
    self.STOPING_DISTANCE = 0.01
    self.mStopDistance = self.STOPING_DISTANCE
    self.mRemainingDistance = 0

    self.mBeginMove =false
    self.mFindPath =false
end 

function PlayerSkillMovePlugin:Init(configure)

    if configure == nil then return end

    self.mBeginAt = configure.beginAt
    self.mEndAt   = configure.endAt

    if self.mNavMeshAgent == nil then

        self.mNavMeshAgent = self.machine.mPlayerCharacter.gameObject:GetComponent(typeof(NavMeshAgent))
        if self.mNavMeshAgent == nil then
            self.mNavMeshAgent = self.machine.mPlayerCharacter.gameObject:AddComponent(typeof(NavMeshAgent))
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


end

function PlayerSkillMovePlugin:OnExecute ()

    local tmpPlayerCharacter = self.machine.mPlayerCharacter

    if tmpPlayerCharacter == nil then return end
    if self.mPlayerSkillState == nil then return end

    if tmpPlayerCharacter.mTargetPosition ~= self.mNavMeshAgent.destination then
     
        if  self.mPlayerSkillState.mRunTime >=  self.mBeginAt 
            and self.mPlayerSkillState.mRunTime <  self.mEndAt 
        then
         
            local tmpDistance = Vector3.Distance (tmpPlayerCharacter.transform.position, tmpPlayerCharacter.mTargetPosition)

            if  tmpDistance > 0.5 then 
            
                --self.mNavMeshAgent.isStopped = false  --Unity 5.6 Hither
                self.mNavMeshAgent:Resume ()
                
                if self.mNavMeshAgent:SetDestination (tmpPlayerCharacter.mTargetPosition) then
                    self.mFindPath = true
                 
                else 
                    
                    print ("SetDestination Fail: " .. tmpPlayerCharacter.mTargetPosition)
                   
                end
            else 
                print ("Distance is : " ..tmpDistance .. " less  0.5f")          
            end
        else 
            self:StopMove()	
        end
    end

    if self.mBeginMove == false then
        if self.mFindPath then
            if self.mNavMeshAgent.pathPending then
                --是在计算过程中的路径，但尚未准备好
                return
            end

            if self.mNavMeshAgent.hasPath and self.mNavMeshAgent.pathStatus == NavMeshPathStatus.PathComplete then


                self.mBeginMove = true

             elseif self.mNavMeshAgent.pathStatus == NavMeshPathStatus.PathInvalid
                    or self.mNavMeshAgent.pathStatus == NavMeshPathStatus.PathPartial 
             then
                        
                self.mFindPath = false
                tmpPlayerCharacter.mTargetPosition = tmpPlayerCharacter.transform.position
                self.mNavMeshAgent.destination = tmpPlayerCharacter.mTargetPosition
                tmpPlayerCharacter:OnMoveToPointFail()
                tmpPlayerCharacter:PlaySkill(PlayerSkillType.Idle)
              
            end
        else 

            local tmpTargetPosition = tmpPlayerCharacter.mTargetPosition
            tmpTargetPosition.y = tmpPlayerCharacter.transform.position.y
            local tmpRemainingDistance = Vector3.Distance (tmpPlayerCharacter.transform.position, tmpTargetPosition)

            if tmpRemainingDistance <= self.mStopDistance or (self.mRemainingDistance == tmpRemainingDistance and self.mNavMeshAgent.velocity == Vector3.zero) then

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

        tmpPlayerCharacter.mTargetPosition.y = tmpPlayerCharacter.transform.position.y

        local tmpTargetPosition = tmpPlayerCharacter.mTargetPosition
        tmpTargetPosition.y = tmpPlayerCharacter.transform.position.y

        local tmpRemainingDistance = Vector3.Distance(tmpPlayerCharacter.transform.position, tmpTargetPosition)

        if tmpRemainingDistance <= self.mStopDistance
            or self.mNavMeshAgent.remainingDistance <= self.mStopDistance
            or tmpPlayerCharacter.targetPosition == Vector3.zero
            or (self.mRemainingDistance == tmpRemainingDistance and self.mNavMeshAgent.velocity == Vector3.zero)
        then

                self.mBeginMove = false
                self.mFindPath = false
                self.mStopDistance = self.STOPING_DISTANCE

            if self.mRemainingDistance == tmpRemainingDistance then
               
                  print (self.mRemainingDistance .. "==" .. tmpRemainingDistance)
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
    --self.mNavMeshAgent.isStopped = true --Unity5.6 Hither
    self.mNavMeshAgent:Stop()
    self.mBeginMove = false
    self.mFindPath = false
end