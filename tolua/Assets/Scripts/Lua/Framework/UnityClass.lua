require("Common")
--应用System、Unity的类
Application = UnityEngine.Application
---检查当前Unity版本
function UnityVersionNewer(v)
    if v == nil then return false end

    local version = Application.unityVersion

    local mainVersion = string.sub( version, 1, 1 )
    local childVersion = string.sub(version, 3, 3 )

    local mainVersion1 = string.sub (v, 1, 1)
    local childVersion1 = string.sub(v, 3, 3)

    if tonumber(mainVersion) > tonumber(mainVersion1)
        or (tonumber(mainVersion) == tonumber(mainVersion1) and tonumber(childVersion) >= tonumber(childVersion1) )
    then
        return true
    end
    
    return false
end


GameObject = UnityEngine.GameObject
Object = UnityEngine.Object
BoxCollider = UnityEngine.BoxCollider
CapsuleCollider = UnityEngine.CapsuleCollider
Camera = UnityEngine.Camera
CameraClearFlags = UnityEngine.CameraClearFlags
AudioListener = UnityEngine.AudioListener

SceneManager = UnityEngine.SceneManagement.SceneManager

if UnityVersionNewer("5.6") then

NavMesh = UnityEngine.AI.NavMesh    -- Unity5.6
NavMeshHit = UnityEngine.AI.NavMeshHit --Unity5.6
NavMeshAgent = UnityEngine.AI.NavMeshAgent  -- Unity5.6
NavMeshPathStatus =UnityEngine.AI.NavMeshPathStatus  -- Unity5.6

else

NavMesh = UnityEngine.NavMesh    
NavMeshHit = UnityEngine.NavMeshHit
NavMeshAgent = UnityEngine.NavMeshAgent
NavMeshPathStatus =UnityEngine.NavMeshPathStatus  -- Unity5.3

end
--引用UnityEngine.Time
Time = UnityEngine.Time

--Unity中的AssetBundle类
AssetBundle = UnityEngine.AssetBundle

Animation = UnityEngine.Animation
AnimationState = UnityEngine.AnimationState
WrapMode = UnityEngine.WrapMode
Screen = UnityEngine.Screen

Input = UnityEngine.Input
Physics = UnityEngine.Physics
LayerMask = UnityEngine.LayerMask
KeyCode = UnityEngine.KeyCode
--System Class
Queue = System.Collections.Queue
Stack  = System.Collections.Stack

------------------------------------------function Begin -------------------------------------
Instantiate = GameObject.Instantiate
Destroy = GameObject.Destroy


------------------------------------------Helper Begin-----------------------------------------
local _GetPosition = Helper.GetPosition
local _SetPosition = Helper.SetPosition
local _GetLocalPosition = Helper.GetLocalPosition
local _SetLocalPosition = Helper.SetLocalPosition
local _SetScale = Helper.SetScale
local _GetScale = Helper.GetScale
local _SetLocalRotation = Helper.SetLocalRotation
local _GetLocalRotation = Helper.GetLocalRotation
local _SetRotation = Helper.SetRotation
local _GetRotation = Helper.GetRotation
local _SetLocalEuler = Helper.SetLocalEuler
local _GetLocalEuler = Helper.GetLocalEuler
local _SetEuler = Helper.SetEuler
local _GetEuler = Helper.GetEuler
local _SetForward = Helper.SetForward
local _GetForward = Helper.GetForward

local _SetParent = Helper.SetParent
local _AddComponent = Helper.AddComponent
local _GetComponent = Helper.GetComponent
local _SetActive = Helper.SetActive

function GetPosition(go, position)
    local pos = position or  Vector3.New(0,0,0)
    local x, y, z = _GetPosition(go, nil, nil, nil)
    pos:Set(x, y, z)
    return pos
end

function SetPosition(go, position)
    if go then
        _SetPosition(go, position.x, position.y, position.z)
    end
end

function GetLocalPosition(go, position)
    local pos = position or Vector3.New(0,0,0)
    local x, y, z = _GetLocalPosition(go, nil, nil, nil)
    pos:Set(x, y, z)
    return pos
end

function SetLocalPosition(go, position)
    if go then
        _SetLocalPosition(go, position.x, position.y, position.z)
    end
end

function SetScale(go, scale)
    if go then
        _SetScale(go, scale.x, scale.y, scale.z)
    end 
end

function GetScale(go, scale)
    local pos = scale or  Vector3.New(0,0,0)
    local x, y, z = _GetScale(go, nil, nil, nil)
    pos:Set(x, y, z)
    return pos
end

function GetForward(go, forward)
    local pos = forward or  Vector3.New(0,0,0)
    local x, y, z = _GetForward(go, nil, nil, nil)
    pos:Set(x, y, z)
    return pos
end

function SetForward(go, forward)
    if go then
        _SetForward(go, forward.x, forward.y, forward.z)
    end
end

function SetLocalRotation(go, rotation)
    if go then
        _SetLocalRotation(go, rotation.x, rotation.y, rotation.z, rotation.w)
    end
end

function GetLocalRotation(go, rotation)
    local r = rotation or  Quaternion.identity
    local x, y, z, w = _GetLocalRotation(go, nil, nil, nil, nil)
    r:Set(x, y, z, w)
    return r
end

function SetRotation(go, rotation)
    if go then
        _SetRotation(go, rotation.x, rotation.y, rotation.z, rotation.w)
    end
end

function GetRotation(go, rotation)
    local r = rotation or  Quaternion.identity
    local x, y, z, w = _GetRotation(go, nil, nil, nil, nil)
    r:Set(x, y, z, w)
    return r
end

function GetLocalEuler(go, euler)
    local pos = euler or  Vector3.New(0,0,0)
    local x, y, z = _GetLocalEuler(go, nil, nil, nil)
    pos:Set(x, y, z)
    return pos
end

function SetLocalEuler(go, euler)
    if go then
        _SetLocalEuler(go, euler.x, euler.y, euler.z)
    end
end

function GetEuler(go, euler)
    local pos = euler or  Vector3.New(0,0,0)
    local x, y, z = _GetEuler(go, nil, nil, nil)
    pos:Set(x, y, z)
    return pos
end

function SetEuler(go, euler)
    if go then
        _SetEuler(go, euler.x, euler.y, euler.z)
    end
end

function SetParent (go, parent)
    if go then
        _SetParent(go, parent)
    end
end

function AddComponent(go, component)

    return _AddComponent(go, component)

end

function GetComponent(go, component)

    return _GetComponent(go, component)

end

function SetActive(go, active)
    if active then
        _SetActive(go, 1)
    else
        _SetActive(go, 0)
    end
end

function AddLuaBehaviour(go,lua)

    local name = lua.GetType()

    local behaviour = GetComponent(go, typeof(LuaBehaviour))
    if behaviour == nil then
        behaviour = AddComponent(go, typeof(LuaBehaviour))
    end

    if behaviour:GetLuaTable(name) == nil then
        
        lua:_init(behaviour)
        behaviour:AddLuaTable(name, lua);

    end
    
    return behaviour

end

function GetLuaTable(go, name)

    local behaviour = GetComponent(go, typeof(LuaBehaviour))
    if behaviour ~=nil then
        return behaviour:GetLuaTable(name)
    end
    return  nil
end

------------------------------------------Helper End-------------------------------------------

