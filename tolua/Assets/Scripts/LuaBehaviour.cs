using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;

public class LuaBehaviour : MonoBehaviour {

    private string data = null;
    private Dictionary<string, LuaFunction> mButtons = new Dictionary<string, LuaFunction>();

    public LuaBehaviour()
    {
        LuaGame.DoFile(string.Format("{0}.lua", name));
        LuaHelper.CallFunction(name, "Init", this);
    }



    protected void Awake()
    {
        LuaHelper.CallFunction(name, "Awake");
    }

    protected void Start()
    {
        LuaHelper.CallFunction(name, "Start");
    }

    protected void OnEnable()
    {
        LuaHelper.CallFunction(name, "OnEnable");
    }

    protected void OnDisable()
    {
        LuaHelper.CallFunction(name, "OnDisable");
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
