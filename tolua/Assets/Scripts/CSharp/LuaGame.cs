using UnityEngine;
using System.Collections.Generic;
using System.IO;
using LuaInterface;
using UnityEngine.SceneManagement;

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
        DontDestroyOnLoad(gameObject);


        mLuaState = new LuaState();
        mLuaLooper.luaState = mLuaState;

        OpenLibs();
        mLuaState.LuaSetTop(0);

        LuaBinder.Bind(mLuaState);

        //测试自定义Wrap
        mLuaState.BeginModule(null);
        TestLuaWrap.Register(mLuaState);
        mLuaState.EndModule();

        DelegateFactory.Init();
        LuaCoroutine.Register(mLuaState, this);
    }


    /// <summary>
    /// 初始化加载第三方库
    /// </summary>
    void OpenLibs()
    {
        mLuaState.OpenLibs(LuaDLL.luaopen_pb);
        mLuaState.OpenLibs(LuaDLL.luaopen_struct);
        mLuaState.OpenLibs(LuaDLL.luaopen_lpeg);
        mLuaState.OpenLibs(LuaDLL.luaopen_bit);

        OpenLuaSocket();

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

    /// <summary>
    ///加载LuaSocket库 
    /// </summary>
    void OpenLuaSocket()
    {
        LuaConst.openLuaSocket = true;

        mLuaState.BeginPreLoad();
        mLuaState.RegFunction("socket.core", LuaDLL.luaopen_socket_core);
        mLuaState.RegFunction("mime.core", LuaDLL.luaopen_mime_core);
        mLuaState.EndPreLoad();
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
        LuaHelper.CallFunction("Main", "OnApplicationQuit");
    }


    private void OnLevelWasLoaded(int level)
    {

        LuaHelper.CallFunction("Main", "OnLevelWasLoaded", level);

    }


    // Use this for initialization
    void Start () {
        InitLuaPath();

        mLuaState.Start();
        

        mLuaState.DoFile("Main.lua");

        if (DebugMode())
        {
            NGUIDebug.debugRaycast = true;

            NGUIDebug.Log(LuaConst.luaDir);
            NGUIDebug.Log(LuaConst.toluaDir);
        }

        LuaHelper.CallFunction("Main", "Start");

        //string[] array = new string[2];
        //array[0] = "first";
        //array[1] = "second";

        //LuaHelper.CallFunction("Main", "Test1",array);
     
    }

    public static bool  DebugMode()
    {
        return LuaHelper.InvokeFunction<bool>("Main", "DebugMode");
    }

    public static bool EditorMode()
    {
#if UNITY_EDITOR
        return true;
#else
        return false;
#endif
    }

    public static Object LoadAssetAtPath(string path)
    {
#if UNITY_EDITOR
        return UnityEditor.AssetDatabase.LoadAssetAtPath<Object>(path);
#else
        return null;
#endif
    }

    public static void Log(string text)
    {
        if (NGUIDebug.debugRaycast)
        {
            NGUIDebug.Log(text);
        }
    }

    public static class TestLua
    {

        static System.Collections.Generic.Dictionary<int, GameObject> mObjectDic = new System.Collections.Generic.Dictionary<int, GameObject>();
        static int mIndex = 0;
        public static void Test(int number)
        {
            Debug.Log("TestLua number = " + number);
        }

        public static int TestCreateGameObject(int index)
        {
            GameObject go = new GameObject(index.ToString());
            mObjectDic.Add(++mIndex, go);
            return mIndex;
        }

        public static GameObject Get(int index)
        {
            if(mObjectDic.ContainsKey(index))
            {
                return mObjectDic[index];
            }
            return null;
        }

    }
    public static class TestLuaWrap
    {
        public static void Register(LuaState L)
        {
            L.BeginStaticLibs("TestLua");
            L.RegFunction("Test", Test);
            L.RegFunction("TestCreateGameObject", TestCreateGameObject);
            L.RegFunction("TestSetPosition", TestSetPosition);
            L.EndStaticLibs();
        }
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int Test(System.IntPtr L)
        {
            try
            {
                ToLua.CheckArgsCount(L, 1);
              
                int arg0 = (int)LuaDLL.luaL_checknumber(L, 1);

                TestLua.Test(arg0);
                return 0;
            }
            catch (System.Exception e)
            {
                return LuaDLL.toluaL_exception(L, e);
            }
        }

        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int TestCreateGameObject(System.IntPtr L)
        {
            try
            {
                ToLua.CheckArgsCount(L, 1);

                int arg0 = (int)LuaDLL.luaL_checknumber(L, 1);

                int index = TestLua.TestCreateGameObject(arg0);
                LuaDLL.lua_pushinteger(L, index);
                return 1;
            }
            catch (System.Exception e)
            {
                return LuaDLL.toluaL_exception(L, e);
            }
        }

        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int TestSetPosition(System.IntPtr L)
        {
            try
            {
                ToLua.CheckArgsCount(L, 4);

                int arg0 = (int)LuaDLL.luaL_checknumber(L, 1);
                float arg1 = (float)LuaDLL.luaL_checknumber(L, 2);
                float arg2 = (float)LuaDLL.luaL_checknumber(L, 3);
                float arg3 = (float)LuaDLL.luaL_checknumber(L, 4);

                GameObject o = TestLua.Get(arg0);
                if (o)
                {
                    o.transform.position = new Vector3(arg1, arg2, arg3);
                }
               
                return 0;
            }
            catch (System.Exception e)
            {
                return LuaDLL.toluaL_exception(L, e);
            }
        }
    }

    public static void TestProtobuf(ByteBuffer buffer)
    {
        LuaHelper.CallFunction("Main", "TestParseProtobuf",buffer);
    }
}
