using UnityEngine;
using System.Collections;

public static class Helper  {

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

    public static void SetParent(GameObject go, Transform parent)
    {
        if(go)
        {
            go.transform.SetParent(parent);
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
}
