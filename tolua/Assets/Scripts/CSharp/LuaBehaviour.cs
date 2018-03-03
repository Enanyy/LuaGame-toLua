using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;

public class LuaBehaviour : MonoBehaviour
{

    /// 调用先后顺序：构造函数->Awake->OnEnable->Start
    /// 在Lua AddComponent后调用Init,则先后顺序是：
    /// 构造函数->Awake->OnEnable->Init->Start
    /// 所以要在Init后再调用一次Awake和OnEnable

    private LuaTable mLuaTable;
    private Dictionary<string, LuaFunction> mButtons = new Dictionary<string, LuaFunction>();

    public LuaTable luaTable {
        get { return mLuaTable; }
    }

    public LuaBehaviour()
    {
        //LuaGame.DoFile(string.Format("{0}.lua", name));
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



    public void Init(LuaTable table)
    {
        if (mLuaTable!=null)
        {
            mLuaTable.Dispose();
            mLuaTable = null;
        }

        mLuaTable = table;

        if (mLuaTable != null)
        {
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
        if (mButtons == null)
        {
            return;
        }
        var it = mButtons.GetEnumerator();

        while (it.MoveNext())
        {
            if (it.Current.Value != null)
            {
                it.Current.Value.Dispose();
            }
        }

        it.Dispose();

        mButtons.Clear();
    }
    protected void OnDestroy()
    {
        ClearClick();
        Debug.Log("~" + name + " was destroy!");

        if (mLuaTable != null)
        {
            mLuaTable.Call("OnDestroy", mLuaTable);

            mLuaTable.Dispose();
            mLuaTable = null;
        }
    }

    void OnTriggerEnter(Collider other)
    {
        if (mLuaTable != null)
        {
            mLuaTable.Call("OnTriggerEnter", mLuaTable, other);
        }
    }
}
