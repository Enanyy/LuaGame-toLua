﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class UIRectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UIRect), typeof(UnityEngine.MonoBehaviour));
		L.RegFunction("CalculateFinalAlpha", CalculateFinalAlpha);
		L.RegFunction("Invalidate", Invalidate);
		L.RegFunction("GetSides", GetSides);
		L.RegFunction("Update", Update);
		L.RegFunction("UpdateAnchors", UpdateAnchors);
		L.RegFunction("SetAnchor", SetAnchor);
		L.RegFunction("SetScreenRect", SetScreenRect);
		L.RegFunction("ResetAnchors", ResetAnchors);
		L.RegFunction("ResetAndUpdateAnchors", ResetAndUpdateAnchors);
		L.RegFunction("SetRect", SetRect);
		L.RegFunction("ParentHasChanged", ParentHasChanged);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("leftAnchor", get_leftAnchor, set_leftAnchor);
		L.RegVar("rightAnchor", get_rightAnchor, set_rightAnchor);
		L.RegVar("bottomAnchor", get_bottomAnchor, set_bottomAnchor);
		L.RegVar("topAnchor", get_topAnchor, set_topAnchor);
		L.RegVar("updateAnchors", get_updateAnchors, set_updateAnchors);
		L.RegVar("finalAlpha", get_finalAlpha, set_finalAlpha);
		L.RegVar("cachedGameObject", get_cachedGameObject, null);
		L.RegVar("cachedTransform", get_cachedTransform, null);
		L.RegVar("anchorCamera", get_anchorCamera, null);
		L.RegVar("isFullyAnchored", get_isFullyAnchored, null);
		L.RegVar("isAnchoredHorizontally", get_isAnchoredHorizontally, null);
		L.RegVar("isAnchoredVertically", get_isAnchoredVertically, null);
		L.RegVar("canBeAnchored", get_canBeAnchored, null);
		L.RegVar("parent", get_parent, null);
		L.RegVar("root", get_root, null);
		L.RegVar("isAnchored", get_isAnchored, null);
		L.RegVar("alpha", get_alpha, set_alpha);
		L.RegVar("localCorners", get_localCorners, null);
		L.RegVar("worldCorners", get_worldCorners, null);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int CalculateFinalAlpha(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			float o = obj.CalculateFinalAlpha(arg0);
			LuaDLL.lua_pushnumber(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Invalidate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
			bool arg0 = LuaDLL.luaL_checkboolean(L, 2);
			obj.Invalidate(arg0);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetSides(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
			UnityEngine.Transform arg0 = (UnityEngine.Transform)ToLua.CheckObject(L, 2, typeof(UnityEngine.Transform));
			UnityEngine.Vector3[] o = obj.GetSides(arg0);
			ToLua.Push(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Update(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
			obj.Update();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int UpdateAnchors(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
			obj.UpdateAnchors();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int SetAnchor(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 2 && TypeChecker.CheckTypes<UnityEngine.GameObject>(L, 2))
			{
				UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
				UnityEngine.GameObject arg0 = (UnityEngine.GameObject)ToLua.ToObject(L, 2);
				obj.SetAnchor(arg0);
				return 0;
			}
			else if (count == 2 && TypeChecker.CheckTypes<UnityEngine.Transform>(L, 2))
			{
				UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
				UnityEngine.Transform arg0 = (UnityEngine.Transform)ToLua.ToObject(L, 2);
				obj.SetAnchor(arg0);
				return 0;
			}
			else if (count == 6)
			{
				UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
				UnityEngine.GameObject arg0 = (UnityEngine.GameObject)ToLua.CheckObject(L, 2, typeof(UnityEngine.GameObject));
				float arg1 = (float)LuaDLL.luaL_checknumber(L, 3);
				float arg2 = (float)LuaDLL.luaL_checknumber(L, 4);
				float arg3 = (float)LuaDLL.luaL_checknumber(L, 5);
				float arg4 = (float)LuaDLL.luaL_checknumber(L, 6);
				obj.SetAnchor(arg0, arg1, arg2, arg3, arg4);
				return 0;
			}
			else if (count == 9)
			{
				UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
				float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
				int arg1 = (int)LuaDLL.luaL_checknumber(L, 3);
				float arg2 = (float)LuaDLL.luaL_checknumber(L, 4);
				int arg3 = (int)LuaDLL.luaL_checknumber(L, 5);
				float arg4 = (float)LuaDLL.luaL_checknumber(L, 6);
				int arg5 = (int)LuaDLL.luaL_checknumber(L, 7);
				float arg6 = (float)LuaDLL.luaL_checknumber(L, 8);
				int arg7 = (int)LuaDLL.luaL_checknumber(L, 9);
				obj.SetAnchor(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
				return 0;
			}
			else if (count == 10)
			{
				UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
				UnityEngine.GameObject arg0 = (UnityEngine.GameObject)ToLua.CheckObject(L, 2, typeof(UnityEngine.GameObject));
				float arg1 = (float)LuaDLL.luaL_checknumber(L, 3);
				int arg2 = (int)LuaDLL.luaL_checknumber(L, 4);
				float arg3 = (float)LuaDLL.luaL_checknumber(L, 5);
				int arg4 = (int)LuaDLL.luaL_checknumber(L, 6);
				float arg5 = (float)LuaDLL.luaL_checknumber(L, 7);
				int arg6 = (int)LuaDLL.luaL_checknumber(L, 8);
				float arg7 = (float)LuaDLL.luaL_checknumber(L, 9);
				int arg8 = (int)LuaDLL.luaL_checknumber(L, 10);
				obj.SetAnchor(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
				return 0;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UIRect.SetAnchor");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int SetScreenRect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			int arg1 = (int)LuaDLL.luaL_checknumber(L, 3);
			int arg2 = (int)LuaDLL.luaL_checknumber(L, 4);
			int arg3 = (int)LuaDLL.luaL_checknumber(L, 5);
			obj.SetScreenRect(arg0, arg1, arg2, arg3);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int ResetAnchors(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
			obj.ResetAnchors();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int ResetAndUpdateAnchors(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
			obj.ResetAndUpdateAnchors();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int SetRect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
			float arg1 = (float)LuaDLL.luaL_checknumber(L, 3);
			float arg2 = (float)LuaDLL.luaL_checknumber(L, 4);
			float arg3 = (float)LuaDLL.luaL_checknumber(L, 5);
			obj.SetRect(arg0, arg1, arg2, arg3);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int ParentHasChanged(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UIRect obj = (UIRect)ToLua.CheckObject<UIRect>(L, 1);
			obj.ParentHasChanged();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object arg0 = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object arg1 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool o = arg0 == arg1;
			LuaDLL.lua_pushboolean(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_leftAnchor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UIRect.AnchorPoint ret = obj.leftAnchor;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index leftAnchor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_rightAnchor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UIRect.AnchorPoint ret = obj.rightAnchor;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index rightAnchor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_bottomAnchor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UIRect.AnchorPoint ret = obj.bottomAnchor;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index bottomAnchor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_topAnchor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UIRect.AnchorPoint ret = obj.topAnchor;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index topAnchor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_updateAnchors(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UIRect.AnchorUpdate ret = obj.updateAnchors;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index updateAnchors on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_finalAlpha(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			float ret = obj.finalAlpha;
			LuaDLL.lua_pushnumber(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index finalAlpha on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_cachedGameObject(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UnityEngine.GameObject ret = obj.cachedGameObject;
			ToLua.PushSealed(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index cachedGameObject on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_cachedTransform(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UnityEngine.Transform ret = obj.cachedTransform;
			ToLua.PushSealed(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index cachedTransform on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_anchorCamera(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UnityEngine.Camera ret = obj.anchorCamera;
			ToLua.PushSealed(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index anchorCamera on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_isFullyAnchored(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			bool ret = obj.isFullyAnchored;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index isFullyAnchored on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_isAnchoredHorizontally(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			bool ret = obj.isAnchoredHorizontally;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index isAnchoredHorizontally on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_isAnchoredVertically(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			bool ret = obj.isAnchoredVertically;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index isAnchoredVertically on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_canBeAnchored(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			bool ret = obj.canBeAnchored;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index canBeAnchored on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_parent(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UIRect ret = obj.parent;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index parent on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_root(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UIRoot ret = obj.root;
			ToLua.PushSealed(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index root on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_isAnchored(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			bool ret = obj.isAnchored;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index isAnchored on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_alpha(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			float ret = obj.alpha;
			LuaDLL.lua_pushnumber(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index alpha on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_localCorners(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UnityEngine.Vector3[] ret = obj.localCorners;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index localCorners on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_worldCorners(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UnityEngine.Vector3[] ret = obj.worldCorners;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index worldCorners on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_leftAnchor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UIRect.AnchorPoint arg0 = (UIRect.AnchorPoint)ToLua.CheckObject<UIRect.AnchorPoint>(L, 2);
			obj.leftAnchor = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index leftAnchor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_rightAnchor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UIRect.AnchorPoint arg0 = (UIRect.AnchorPoint)ToLua.CheckObject<UIRect.AnchorPoint>(L, 2);
			obj.rightAnchor = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index rightAnchor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_bottomAnchor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UIRect.AnchorPoint arg0 = (UIRect.AnchorPoint)ToLua.CheckObject<UIRect.AnchorPoint>(L, 2);
			obj.bottomAnchor = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index bottomAnchor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_topAnchor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UIRect.AnchorPoint arg0 = (UIRect.AnchorPoint)ToLua.CheckObject<UIRect.AnchorPoint>(L, 2);
			obj.topAnchor = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index topAnchor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_updateAnchors(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			UIRect.AnchorUpdate arg0 = (UIRect.AnchorUpdate)ToLua.CheckObject(L, 2, typeof(UIRect.AnchorUpdate));
			obj.updateAnchors = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index updateAnchors on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_finalAlpha(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.finalAlpha = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index finalAlpha on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_alpha(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIRect obj = (UIRect)o;
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.alpha = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index alpha on a nil value");
		}
	}
}

