using LuaInterface;
using System;
using System.Collections.Generic;

public static class LuaHelper
{
    public static LuaFunction GetFunction(string module, string funcName)
    {
        string func = string.Format("{0}.{1}", module, funcName);
        return LuaGame.GetSingleton().luaState.GetFunction(func);
    }

    #region CallFunction

    public static void CallFunction(string funcName)
    {
        LuaFunction func = LuaGame.GetSingleton().luaState.GetFunction(funcName);
        if (func != null)
        {
            func.Call();
        }
    }


    public static void CallFunction(string module, string funcName)
    {
        LuaFunction func = GetFunction(module, funcName);
        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            func.Call(table);
            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
        }
    }

    public static void CallFunction<T1>(string module, string funcName, T1 arg1)
    {
        LuaFunction func = GetFunction(module, funcName);
        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            func.Call(table, arg1);
            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
        }
    }

    public static void CallFunction<T1, T2>(string module, string funcName, T1 arg1, T2 arg2)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            func.Call(table, arg1, arg2);

            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
        }
    }
    public static void CallFunction<T1, T2, T3>(string module, string funcName, T1 arg1, T2 arg2, T3 arg3)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            func.Call(table, arg1, arg2, arg3);
            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
        }
    }
    public static void CallFunction<T1, T2, T3, T4>(string module, string funcName, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            func.Call(table, arg1, arg2, arg3, arg4);
            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
        }
    }
    public static void CallFunction<T1, T2, T3, T4, T5>(string module, string funcName, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            func.Call(table, arg1, arg2, arg3, arg4, arg5);
            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
        }
    }
    public static void CallFunction<T1, T2, T3, T4, T5, T6>(string module, string funcName, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            func.Call(table, arg1, arg2, arg3, arg4, arg5, arg6);
            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
        }
    }
    public static void CallFunction<T1, T2, T3, T4, T5, T6, T7>(string module, string funcName, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            func.Call(table, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
        }
    }
    public static void CallFunction<T1, T2, T3, T4, T5, T6, T7, T8>(string module, string funcName, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            func.Call(table,arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
        }
    }
   
    #endregion

    #region InvokeFunction

    public static R InvokeFunction<R>(string module, string funcName)
    {
        LuaFunction func = GetFunction(module, funcName);
        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            R r = func.Invoke<LuaTable,R>(table);

            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
            return r;
        }
        return default(R);
    }

    public static R InvokeFunction<R, T1>(string module, string funcName, T1 arg1)
    {
        LuaFunction func = GetFunction(module, funcName);
        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            R r = func.Invoke<LuaTable, T1, R>(table,arg1);
            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
            return r;
        }
        return default(R);
    }

    public static R InvokeFunction<R, T1, T2>(string module, string funcName, T1 arg1, T2 arg2)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            R r = func.Invoke<LuaTable, T1, T2, R>(table, arg1, arg2);
            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
            return r;
        }
        return default(R);
    }
    public static R InvokeFunction<R, T1, T2, T3>(string module, string funcName, T1 arg1, T2 arg2, T3 arg3)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            R r = func.Invoke<LuaTable, T1, T2, T3, R>(table, arg1, arg2, arg3);
            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
            return r;
        }
        return default(R);
    }
    public static R InvokeFunction<R, T1, T2, T3, T4>(string module, string funcName, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            R r = func.Invoke<LuaTable, T1, T2, T3, T4, R>(table, arg1, arg2, arg3, arg4);
            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
            return r;
        }
        return default(R);
    }
    public static R InvokeFunction<R, T1, T2, T3, T4, T5>(string module, string funcName, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            R r = func.Invoke<LuaTable, T1, T2, T3, T4, T5, R>(table, arg1, arg2, arg3, arg4, arg5);

            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
            return r;
        }
        return default(R);
    }
    public static R InvokeFunction<R, T1, T2, T3, T4, T5, T6>(string module, string funcName, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            R r = func.Invoke<LuaTable, T1, T2, T3, T4, T5, T6, R>(table, arg1, arg2, arg3, arg4, arg5, arg6);
            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
            return r;
        }
        return default(R);
    }
    public static R InvokeFunction<R, T1, T2, T3, T4, T5, T6, T7>(string module, string funcName, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            R r = func.Invoke<LuaTable, T1, T2, T3, T4, T5, T6, T7, R>(table, arg1, arg2, arg3, arg4, arg5, arg6, arg7);

            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
            return r;
        }
        return default(R);
    }
    public static R InvokeFunction<R, T1, T2, T3, T4, T5, T6, T7, T8>(string module, string funcName, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
    {
        LuaFunction func = GetFunction(module, funcName);

        if (func != null)
        {
            LuaTable table = func.GetLuaState().GetTable(module);

            R r = func.Invoke<LuaTable, T1, T2, T3, T4, T5, T6, T7, T8, R>(table, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);

            func.Dispose();
            func = null;

            table.Dispose();
            table = null;
            return r;
        }
        return default(R);
    }
    
    #endregion
}

