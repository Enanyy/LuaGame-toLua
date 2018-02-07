using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;

public class LuaBehaviour : MonoBehaviour {

    /// 调用先后顺序：构造函数->Awake->OnEnable->Start
    /// 在Lua AddComponent后调用SetTable,则先后顺序是：
    /// 构造函数->Awake->OnEnable->SetTable->Start
    /// 所以要在SetTable后再调用一次Awake和OnEnable

    private string mLuaModule;
    private LuaTable mLuaTable;
    private Dictionary<string, LuaFunction> mButtons = new Dictionary<string, LuaFunction>();

    public LuaBehaviour()
    {
       
    }

    protected void Awake()
    {
        if (mLuaTable != null)
        {
            mLuaTable.Call("Awake", mLuaTable);
        }
    }
    protected void OnEnable()
    {
        if (mLuaTable != null)
        {
            mLuaTable.Call("OnEnable", mLuaTable);
        }
    }

    public void SetTable(string module, LuaTable table)
    {
        mLuaModule = module;
        mLuaTable = table;
     
        if (mLuaTable != null)
        {
            mLuaTable.GetLuaState().DoFile(mLuaModule);
            mLuaTable.Call("Init", mLuaTable, this);

            //再调用一次Awake和OnEnable以通知Lua的Awake和OnEnable
            Awake();
            OnEnable();
        }
    }

    protected void Start()
    {
        if (mLuaTable != null)
        {
            mLuaTable.Call("Start", mLuaTable);
        }
    }

   

    protected void OnDisable()
    {
        if (mLuaTable != null)
        {
            mLuaTable.Call("OnDisable", mLuaTable);
        }
    }

    public void AddClick(GameObject go, LuaFunction luafunc)
    {
        if (go == null || luafunc == null) return;
        mButtons.Add(go.name, luafunc);
        UIEventListener.Get(go).onClick = delegate (GameObject o)
        {
            luafunc.Call(go);
        };
    }

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

        if(mLuaTable!=null)
        {
            mLuaTable.Call("OnDestroy", mLuaTable);

            mLuaTable.Dispose();
            mLuaTable = null;
        }
    }
}
