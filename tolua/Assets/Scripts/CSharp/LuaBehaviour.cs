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

    private Dictionary<string, LuaFunction> mButtons = new Dictionary<string, LuaFunction>();
    [SerializeField]
    private Dictionary<string, LuaTable> mLuaTables = new Dictionary<string, LuaTable>();

    bool mStart = false;
    public LuaBehaviour()
    {
        
    }

    void CallFunction(string name)
    {
        var it = mLuaTables.GetEnumerator();
        while (it.MoveNext())
        {
            LuaTable table = it.Current.Value;
            if (table != null)
            {
                table.Call(name, table);
            }
        }
    }


    public void AddLuaTable(string name, LuaTable table)
    {
        if (string.IsNullOrEmpty(name) || table == null)
        {
            return;
        }

        if (mLuaTables.ContainsKey(name) == false)
        {
            mLuaTables.Add(name, table);
            table.Call("Init", table, this);
            table.Call("Awake", table);
            table.Call("OnEnable", table);

            if (mStart)
            {
                table.Call("Start", table);
            }
        }
    }

    public LuaTable GetLuaTable(string name)
    {
        LuaTable table;
        mLuaTables.TryGetValue(name, out table);
        return table;
    }

   

    void Start()
    {
        mStart = true;
        CallFunction("Start");
    }

    void OnEnable()
    {
        CallFunction("OnEnable");
    }


    void OnDisable()
    {
        CallFunction("OnDisable");
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

        CallFunction("OnDestroy");

        Debug.Log("~" + name + " was destroy!");

    }

    void OnTriggerEnter(Collider other)
    {
        var it = mLuaTables.GetEnumerator();
        while(it.MoveNext())
        {
            LuaTable table = it.Current.Value;
            table.Call("OnTriggerEnter", table, other);
        }
    }
}
