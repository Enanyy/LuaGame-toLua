using UnityEngine;
using System.Collections;
using System.IO;
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

    public static void DoFile(string filename)
    {
        GetSingleton().luaState.DoFile(filename);
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
        AddSearchPath(LuaConst.luaDir);      
        AddSearchPath(LuaConst.toluaDir);
    }

    /// <summary>
    /// 添加搜索目录，包括所有子目录
    /// </summary>
    /// <param name="path"></param>
    void AddSearchPath(string path)
    {
        mLuaState.AddSearchPath(path);
        string[] paths = Directory.GetDirectories(path, "*.*", SearchOption.AllDirectories);
        for(int i =0; i < paths.Length;++i )
        {
            mLuaState.AddSearchPath(paths[i].Replace("\\", "/"));
        }
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
        LuaHelper.CallFunction("LuaGame", "OnApplicationQuit");
    }


    private void OnLevelWasLoaded(int level)
    {
        

    }


    // Use this for initialization
    void Start () {
        InitLuaPath();

        mLuaState.Start();

        mLuaState.DoFile("LuaGame.lua");

        LuaHelper.CallFunction("LuaGame","Start");
        LuaHelper.CallFunction("LuaGame", "Test",gameObject);
    }

    // Update is called once per frame
    void Update () {
	
	}
}
