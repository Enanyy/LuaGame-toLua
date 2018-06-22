﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class UIWidget_PivotWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(UIWidget.Pivot));
		L.RegVar("TopLeft", get_TopLeft, null);
		L.RegVar("Top", get_Top, null);
		L.RegVar("TopRight", get_TopRight, null);
		L.RegVar("Left", get_Left, null);
		L.RegVar("Center", get_Center, null);
		L.RegVar("Right", get_Right, null);
		L.RegVar("BottomLeft", get_BottomLeft, null);
		L.RegVar("Bottom", get_Bottom, null);
		L.RegVar("BottomRight", get_BottomRight, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<UIWidget.Pivot>.Check = CheckType;
		StackTraits<UIWidget.Pivot>.Push = Push;
	}

	static void Push(IntPtr L, UIWidget.Pivot arg)
	{
		ToLua.Push(L, arg);
	}

	static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(UIWidget.Pivot), L, pos);
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_TopLeft(IntPtr L)
	{
		ToLua.Push(L, UIWidget.Pivot.TopLeft);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Top(IntPtr L)
	{
		ToLua.Push(L, UIWidget.Pivot.Top);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_TopRight(IntPtr L)
	{
		ToLua.Push(L, UIWidget.Pivot.TopRight);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Left(IntPtr L)
	{
		ToLua.Push(L, UIWidget.Pivot.Left);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Center(IntPtr L)
	{
		ToLua.Push(L, UIWidget.Pivot.Center);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Right(IntPtr L)
	{
		ToLua.Push(L, UIWidget.Pivot.Right);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_BottomLeft(IntPtr L)
	{
		ToLua.Push(L, UIWidget.Pivot.BottomLeft);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Bottom(IntPtr L)
	{
		ToLua.Push(L, UIWidget.Pivot.Bottom);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_BottomRight(IntPtr L)
	{
		ToLua.Push(L, UIWidget.Pivot.BottomRight);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int IntToEnum(IntPtr L)
	{
		int arg0 = (int)LuaDLL.lua_tonumber(L, 1);
		UIWidget.Pivot o = (UIWidget.Pivot)arg0;
		ToLua.Push(L, o);
		return 1;
	}
}

