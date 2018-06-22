﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class UITweener_MethodWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(UITweener.Method));
		L.RegVar("Linear", get_Linear, null);
		L.RegVar("EaseIn", get_EaseIn, null);
		L.RegVar("EaseOut", get_EaseOut, null);
		L.RegVar("EaseInOut", get_EaseInOut, null);
		L.RegVar("BounceIn", get_BounceIn, null);
		L.RegVar("BounceOut", get_BounceOut, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<UITweener.Method>.Check = CheckType;
		StackTraits<UITweener.Method>.Push = Push;
	}

	static void Push(IntPtr L, UITweener.Method arg)
	{
		ToLua.Push(L, arg);
	}

	static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(UITweener.Method), L, pos);
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Linear(IntPtr L)
	{
		ToLua.Push(L, UITweener.Method.Linear);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_EaseIn(IntPtr L)
	{
		ToLua.Push(L, UITweener.Method.EaseIn);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_EaseOut(IntPtr L)
	{
		ToLua.Push(L, UITweener.Method.EaseOut);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_EaseInOut(IntPtr L)
	{
		ToLua.Push(L, UITweener.Method.EaseInOut);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_BounceIn(IntPtr L)
	{
		ToLua.Push(L, UITweener.Method.BounceIn);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_BounceOut(IntPtr L)
	{
		ToLua.Push(L, UITweener.Method.BounceOut);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int IntToEnum(IntPtr L)
	{
		int arg0 = (int)LuaDLL.lua_tonumber(L, 1);
		UITweener.Method o = (UITweener.Method)arg0;
		ToLua.Push(L, o);
		return 1;
	}
}

