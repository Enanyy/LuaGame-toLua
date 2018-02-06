using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;

public class LuaBehaviour : MonoBehaviour {

    private string data = null;
    private Dictionary<string, LuaFunction> mButtons = new Dictionary<string, LuaFunction>();

    protected void Awake()
    {
       LuaGame.CallFunction(name, "Awake", gameObject);
    }

    protected void Start()
    {
        LuaGame.CallFunction(name, "Start");
    }

    protected void OnClick()
    {
        LuaGame.CallFunction(name, "OnClick");
    }

    protected void OnClickEvent(GameObject go)
    {
        LuaGame.CallFunction(name, "OnClick", go);
    }

   

    /// <summary>
    /// 添加单击事件
    /// </summary>
    public void AddClick(GameObject go, LuaFunction luafunc)
    {
        if (go == null || luafunc == null) return;
        mButtons.Add(go.name, luafunc);
        UIEventListener.Get(go).onClick = delegate (GameObject o)
        {
            luafunc.Call(go);
        };
    }

    /// <summary>
    /// 删除单击事件
    /// </summary>
    /// <param name="go"></param>
    public void RemoveClick(GameObject go)
    {
        if (go == null) return;
        LuaFunction luafunc = null;
        if (mButtons.TryGetValue(go.name, out luafunc))
        {
            mButtons.Remove(go.name);
            luafunc.Dispose();
            luafunc = null;
        }
    }

    /// <summary>
    /// 清除单击事件
    /// </summary>
    public void ClearClick()
    {
        foreach (var de in mButtons)
        {
            if (de.Value != null)
            {
                de.Value.Dispose();
            }
        }
        mButtons.Clear();
    }
    protected void OnDestroy()
    {   
        ClearClick();
        Debug.Log("~" + name + " was destroy!");
    }
}
