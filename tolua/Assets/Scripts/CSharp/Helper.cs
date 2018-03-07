using UnityEngine;
using System.Collections;
using System;

public static class Helper  {

    #region Position
    public static void SetPosition(GameObject go, float x, float y, float z)
    {
        if(go)
        {
            Vector3 position = go.transform.position;
            position.x = x;
            position.y = y;
            position.z = z;
            go.transform.position = position;
        }
    }

    public static void SetLocalPosition(GameObject go, float x, float y, float z)
    {
        if (go)
        {
            Vector3 position = go.transform.localPosition;
            position.x = x;
            position.y = y;
            position.z = z;
            go.transform.localPosition = position;
        }
    }

    public static void GetPosition(GameObject go, out float x, out float y, out float z)
    {
        x = 0;
        y = 0;
        z = 0;
        if (go)
        {
            x = go.transform.position.x;
            y = go.transform.position.y;
            z = go.transform.position.z;
        }
    }

    public static void GetLocalPosition(GameObject go, out float x, out float y, out float z)
    {
        x = 0;
        y = 0;
        z = 0;
        if (go)
        {
            x = go.transform.localPosition.x;
            y = go.transform.localPosition.y;
            z = go.transform.localPosition.z;
        }
    }

    #endregion
    #region Scale
    public static void SetScale(GameObject go ,float x, float y, float z)
    {
        if (go)
        {
            Vector3 scale = go.transform.localScale;
            scale.x = x;
            scale.y = y;
            scale.z = z;
            go.transform.localScale = scale;
        }
    }

    public static void GetScale(GameObject go, out float x, out float y, out float z)
    {

        x = 0;
        y = 0;
        z = 0;
        if (go)
        {
            x = go.transform.localScale.x;
            y = go.transform.localScale.y;
            z = go.transform.localScale.z;
        }
    }
    #endregion
    #region Rotation
    public static void SetLocalRotation(GameObject go, float x, float y, float z)
    {
        if(go)
        {
            go.transform.localRotation = Quaternion.Euler(x, y, z);
        }
    }

    public static void SetLocalRotation(GameObject go, float x, float y, float z, float w)
    {
        if (go)
        {
            Quaternion q =  go.transform.localRotation;
            q.Set(x, y, z, w);
            go.transform.localRotation = q;
        }
    }

    public static void SetRotation(GameObject go, float x, float y, float z)
    {
        if (go)
        {
            go.transform.rotation = Quaternion.Euler(x, y, z);
        }
    }

    public static void SetRotation(GameObject go, float x, float y, float z, float w)
    {
        if (go)
        {
            Quaternion q = go.transform.rotation;
            q.Set(x, y, z, w);
            go.transform.rotation = q;
        }
    }

    public static void GetRotation(GameObject go, out float x, out float y, out float z, out float w)
    {
        x = 0;
        y = 0;
        z = 0;
        w = 0;
        if (go)
        {
            x = go.transform.rotation.x;
            y = go.transform.rotation.y;
            z = go.transform.rotation.z;
            w = go.transform.rotation.w;
        }
    }

    public static void GetLocalRotation(GameObject go, out float x, out float y, out float z, out float w)
    {
        x = 0;
        y = 0;
        z = 0;
        w = 0;
        if (go)
        {
            x = go.transform.localRotation.x;
            y = go.transform.localRotation.y;
            z = go.transform.localRotation.z;
            w = go.transform.localRotation.w;
        }
    }

    #endregion
    #region Component
    public static Component GetComponent(GameObject go, Type type)
    {
        if (go)
        {
            return go.GetComponent(type);
        }
        return null;
    }

    public static Component AddComponent(GameObject go, Type type)
    {
        if (go)
        {
            return go.AddComponent(type);
        }
        return null;
    }

    public static Component GetComponent(GameObject go, Type type, string path)
    {
        if (go)
        {
            Transform t = go.transform.Find(path);
            if (t)
            {
                return t.GetComponent(type);
            }
        }
        return null;
    }

    public static Component GetComponentInChildren(GameObject go, Type type)
    {
        if (go)
        {
            return go.GetComponentInChildren(type);
        }
        return null;
    }

    #endregion

    public static int GetChildCount(GameObject go)
    {
        if(go)
        {
            return go.transform.childCount;
        }
        return 0;
    }

    public static GameObject GetChild(GameObject go, int index)
    {
        if (go)
        {
            if (index < go.transform.childCount )
            {
                return go.transform.GetChild(index).gameObject;
            }
        }
        return null;
    }

    public static void SetParent(GameObject go, Transform parent)
    {
        if (go)
        {
            go.transform.SetParent(parent);
        }
    }

    public static void SetActive(GameObject go, int active)
    {
        if (go)
        {
            go.SetActive(active == 1);
        }
    }
}
