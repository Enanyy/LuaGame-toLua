using UnityEngine;
using System.Collections;
using LuaInterface;

public class LuaGame : MonoBehaviour {

    #region Singleton
    private static LuaGame mInstance;
    public static LuaGame GetSingleton()
    {
        if (mInstance == null)
        {
            GameObject go = new GameObject(typeof(LuaGame).ToString());
            DontDestroyOnLoad(go);
            mInstance = go.AddComponent<LuaGame>();
            mInstance.mLuaLooper = go.AddComponent<LuaLooper>();
           
        }
        return mInstance;
    }
    #endregion

    public const bool DebugMode = false;

    private LuaState mLuaState;
    public LuaState luaState { get { return mLuaState; } }

    private LuaLooper mLuaLooper;

    public LuaLooper luaLooper {
        get {
            if (mLuaLooper == null)
            {
                mLuaLooper = gameObject.GetComponent<LuaLooper>();
                if (mLuaLooper == null)
                {
                    mLuaLooper = gameObject.AddComponent<LuaLooper>();
                }
            }
            if(mLuaLooper!=null)
            {
                if(mLuaLooper.luaState == null)
                {
                    mLuaLooper.luaState = mLuaState;
                }
            }
            return mLuaLooper;
        }
    }
    public LuaGame()
    {
       
    }

    private void Awake()
    {
        mInstance = this;
        mLuaLooper = gameObject.AddComponent<LuaLooper>();


        mLuaState = new LuaState();
        mLuaLooper.luaState = mLuaState;

        OpenLibs();
        mLuaState.LuaSetTop(0);

        LuaBinder.Bind(mLuaState);
        DelegateFactory.Init();
        LuaCoroutine.Register(mLuaState, this);
    }


    /// <summary>
    /// 初始化加载第三方库
    /// </summary>
    void OpenLibs()
    {
        mLuaState.OpenLibs(LuaDLL.luaopen_pb);
        mLuaState.OpenLibs(LuaDLL.luaopen_lpeg);
        mLuaState.OpenLibs(LuaDLL.luaopen_bit);
        mLuaState.OpenLibs(LuaDLL.luaopen_socket_core);

        OpenCJson();
    }
    //cjson 比较特殊，只new了一个table，没有注册库，这里注册一下
    void OpenCJson()
    {
        mLuaState.LuaGetField(LuaIndexes.LUA_REGISTRYINDEX, "_LOADED");
        mLuaState.OpenLibs(LuaDLL.luaopen_cjson);
        mLuaState.LuaSetField(-2, "cjson");

        mLuaState.OpenLibs(LuaDLL.luaopen_cjson_safe);
        mLuaState.LuaSetField(-2, "cjson.safe");
    }

    public void DoFile(string filename)
    {
        mLuaState.DoFile(filename);
    }


    public static object[] CallFunction(string module, string funcName, params object[] args)
    {
        string func = string.Format("{0}.{1}", module, funcName);
        return CallFunction(func, args);
    }

    public static object[] CallFunction(string funcName, params object[] args)
    {
        LuaFunction func =GetSingleton().luaState.GetFunction(funcName);
        if (func != null)
        {
            return func.LazyCall(args);
        }
        return null;
    }

    public void LuaGC()
    {
        mLuaState.LuaGC(LuaGCOptions.LUA_GCCOLLECT);
    }

    /// <summary>
    /// 初始化Lua代码加载路径
    /// </summary>
    void InitLuaPath()
    {
        mLuaState.AddSearchPath(LuaConst.luaDir);
        mLuaState.AddSearchPath(LuaConst.toluaDir);
    }

    private void OnDestroy()
    {
        mLuaLooper.Destroy();
        mLuaState.Dispose();

        mLuaLooper = null;
        mLuaState = null;
        mInstance = null;

    }

    private void OnApplicationQuit()
    {
        CallFunction("LuaGame", "OnApplicationQuit");
    }


    private void OnLevelWasLoaded(int level)
    {
        CallFunction("LuaGame", "OnLevelWasLoaded",level);

    }


    // Use this for initialization
    void Start () {
        InitLuaPath();

        mLuaState.Start();

        mLuaState.DoFile("LuaGame.lua");

        CallFunction("LuaGame","Start");
    }

    // Update is called once per frame
    void Update () {
	
	}
}
