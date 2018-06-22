﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class UIInputWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UIInput), typeof(UnityEngine.MonoBehaviour));
		L.RegFunction("Set", Set);
		L.RegFunction("Validate", Validate);
		L.RegFunction("Start", Start);
		L.RegFunction("Submit", Submit);
		L.RegFunction("UpdateLabel", UpdateLabel);
		L.RegFunction("RemoveFocus", RemoveFocus);
		L.RegFunction("SaveValue", SaveValue);
		L.RegFunction("LoadValue", LoadValue);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("current", get_current, set_current);
		L.RegVar("selection", get_selection, set_selection);
		L.RegVar("label", get_label, set_label);
		L.RegVar("inputType", get_inputType, set_inputType);
		L.RegVar("onReturnKey", get_onReturnKey, set_onReturnKey);
		L.RegVar("keyboardType", get_keyboardType, set_keyboardType);
		L.RegVar("hideInput", get_hideInput, set_hideInput);
		L.RegVar("selectAllTextOnFocus", get_selectAllTextOnFocus, set_selectAllTextOnFocus);
		L.RegVar("validation", get_validation, set_validation);
		L.RegVar("characterLimit", get_characterLimit, set_characterLimit);
		L.RegVar("savedAs", get_savedAs, set_savedAs);
		L.RegVar("activeTextColor", get_activeTextColor, set_activeTextColor);
		L.RegVar("caretColor", get_caretColor, set_caretColor);
		L.RegVar("selectionColor", get_selectionColor, set_selectionColor);
		L.RegVar("onSubmit", get_onSubmit, set_onSubmit);
		L.RegVar("onChange", get_onChange, set_onChange);
		L.RegVar("onValidate", get_onValidate, set_onValidate);
		L.RegVar("defaultText", get_defaultText, set_defaultText);
		L.RegVar("defaultColor", get_defaultColor, set_defaultColor);
		L.RegVar("inputShouldBeHidden", get_inputShouldBeHidden, null);
		L.RegVar("value", get_value, set_value);
		L.RegVar("isSelected", get_isSelected, set_isSelected);
		L.RegVar("cursorPosition", get_cursorPosition, set_cursorPosition);
		L.RegVar("selectionStart", get_selectionStart, set_selectionStart);
		L.RegVar("selectionEnd", get_selectionEnd, set_selectionEnd);
		L.RegVar("caret", get_caret, null);
		L.RegFunction("OnValidate", UIInput_OnValidate);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Set(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 2)
			{
				UIInput obj = (UIInput)ToLua.CheckObject(L, 1, typeof(UIInput));
				string arg0 = ToLua.CheckString(L, 2);
				obj.Set(arg0);
				return 0;
			}
			else if (count == 3)
			{
				UIInput obj = (UIInput)ToLua.CheckObject(L, 1, typeof(UIInput));
				string arg0 = ToLua.CheckString(L, 2);
				bool arg1 = LuaDLL.luaL_checkboolean(L, 3);
				obj.Set(arg0, arg1);
				return 0;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UIInput.Set");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Validate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIInput obj = (UIInput)ToLua.CheckObject(L, 1, typeof(UIInput));
			string arg0 = ToLua.CheckString(L, 2);
			string o = obj.Validate(arg0);
			LuaDLL.lua_pushstring(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Start(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UIInput obj = (UIInput)ToLua.CheckObject(L, 1, typeof(UIInput));
			obj.Start();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Submit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UIInput obj = (UIInput)ToLua.CheckObject(L, 1, typeof(UIInput));
			obj.Submit();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int UpdateLabel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UIInput obj = (UIInput)ToLua.CheckObject(L, 1, typeof(UIInput));
			obj.UpdateLabel();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int RemoveFocus(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UIInput obj = (UIInput)ToLua.CheckObject(L, 1, typeof(UIInput));
			obj.RemoveFocus();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int SaveValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UIInput obj = (UIInput)ToLua.CheckObject(L, 1, typeof(UIInput));
			obj.SaveValue();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int LoadValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UIInput obj = (UIInput)ToLua.CheckObject(L, 1, typeof(UIInput));
			obj.LoadValue();
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
	static int get_current(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, UIInput.current);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_selection(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, UIInput.selection);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_label(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UILabel ret = obj.label;
			ToLua.PushSealed(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index label on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_inputType(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UIInput.InputType ret = obj.inputType;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index inputType on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_onReturnKey(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UIInput.OnReturnKey ret = obj.onReturnKey;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index onReturnKey on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_keyboardType(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UIInput.KeyboardType ret = obj.keyboardType;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index keyboardType on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_hideInput(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			bool ret = obj.hideInput;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index hideInput on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_selectAllTextOnFocus(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			bool ret = obj.selectAllTextOnFocus;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index selectAllTextOnFocus on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_validation(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UIInput.Validation ret = obj.validation;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index validation on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_characterLimit(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			int ret = obj.characterLimit;
			LuaDLL.lua_pushinteger(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index characterLimit on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_savedAs(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			string ret = obj.savedAs;
			LuaDLL.lua_pushstring(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index savedAs on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_activeTextColor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UnityEngine.Color ret = obj.activeTextColor;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index activeTextColor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_caretColor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UnityEngine.Color ret = obj.caretColor;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index caretColor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_selectionColor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UnityEngine.Color ret = obj.selectionColor;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index selectionColor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_onSubmit(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			System.Collections.Generic.List<EventDelegate> ret = obj.onSubmit;
			ToLua.PushSealed(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index onSubmit on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_onChange(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			System.Collections.Generic.List<EventDelegate> ret = obj.onChange;
			ToLua.PushSealed(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index onChange on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_onValidate(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UIInput.OnValidate ret = obj.onValidate;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index onValidate on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_defaultText(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			string ret = obj.defaultText;
			LuaDLL.lua_pushstring(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index defaultText on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_defaultColor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UnityEngine.Color ret = obj.defaultColor;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index defaultColor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_inputShouldBeHidden(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			bool ret = obj.inputShouldBeHidden;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index inputShouldBeHidden on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_value(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			string ret = obj.value;
			LuaDLL.lua_pushstring(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index value on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_isSelected(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			bool ret = obj.isSelected;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index isSelected on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_cursorPosition(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			int ret = obj.cursorPosition;
			LuaDLL.lua_pushinteger(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index cursorPosition on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_selectionStart(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			int ret = obj.selectionStart;
			LuaDLL.lua_pushinteger(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index selectionStart on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_selectionEnd(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			int ret = obj.selectionEnd;
			LuaDLL.lua_pushinteger(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index selectionEnd on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_caret(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UITexture ret = obj.caret;
			ToLua.PushSealed(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index caret on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_current(IntPtr L)
	{
		try
		{
			UIInput arg0 = (UIInput)ToLua.CheckObject(L, 2, typeof(UIInput));
			UIInput.current = arg0;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_selection(IntPtr L)
	{
		try
		{
			UIInput arg0 = (UIInput)ToLua.CheckObject(L, 2, typeof(UIInput));
			UIInput.selection = arg0;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_label(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UILabel arg0 = (UILabel)ToLua.CheckObject(L, 2, typeof(UILabel));
			obj.label = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index label on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_inputType(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UIInput.InputType arg0 = (UIInput.InputType)ToLua.CheckObject(L, 2, typeof(UIInput.InputType));
			obj.inputType = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index inputType on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_onReturnKey(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UIInput.OnReturnKey arg0 = (UIInput.OnReturnKey)ToLua.CheckObject(L, 2, typeof(UIInput.OnReturnKey));
			obj.onReturnKey = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index onReturnKey on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_keyboardType(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UIInput.KeyboardType arg0 = (UIInput.KeyboardType)ToLua.CheckObject(L, 2, typeof(UIInput.KeyboardType));
			obj.keyboardType = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index keyboardType on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_hideInput(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			bool arg0 = LuaDLL.luaL_checkboolean(L, 2);
			obj.hideInput = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index hideInput on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_selectAllTextOnFocus(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			bool arg0 = LuaDLL.luaL_checkboolean(L, 2);
			obj.selectAllTextOnFocus = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index selectAllTextOnFocus on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_validation(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UIInput.Validation arg0 = (UIInput.Validation)ToLua.CheckObject(L, 2, typeof(UIInput.Validation));
			obj.validation = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index validation on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_characterLimit(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.characterLimit = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index characterLimit on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_savedAs(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			string arg0 = ToLua.CheckString(L, 2);
			obj.savedAs = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index savedAs on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_activeTextColor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UnityEngine.Color arg0 = ToLua.ToColor(L, 2);
			obj.activeTextColor = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index activeTextColor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_caretColor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UnityEngine.Color arg0 = ToLua.ToColor(L, 2);
			obj.caretColor = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index caretColor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_selectionColor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UnityEngine.Color arg0 = ToLua.ToColor(L, 2);
			obj.selectionColor = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index selectionColor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_onSubmit(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			System.Collections.Generic.List<EventDelegate> arg0 = (System.Collections.Generic.List<EventDelegate>)ToLua.CheckObject(L, 2, typeof(System.Collections.Generic.List<EventDelegate>));
			obj.onSubmit = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index onSubmit on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_onChange(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			System.Collections.Generic.List<EventDelegate> arg0 = (System.Collections.Generic.List<EventDelegate>)ToLua.CheckObject(L, 2, typeof(System.Collections.Generic.List<EventDelegate>));
			obj.onChange = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index onChange on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_onValidate(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UIInput.OnValidate arg0 = (UIInput.OnValidate)ToLua.CheckDelegate<UIInput.OnValidate>(L, 2);
			obj.onValidate = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index onValidate on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_defaultText(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			string arg0 = ToLua.CheckString(L, 2);
			obj.defaultText = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index defaultText on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_defaultColor(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			UnityEngine.Color arg0 = ToLua.ToColor(L, 2);
			obj.defaultColor = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index defaultColor on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_value(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			string arg0 = ToLua.CheckString(L, 2);
			obj.value = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index value on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_isSelected(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			bool arg0 = LuaDLL.luaL_checkboolean(L, 2);
			obj.isSelected = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index isSelected on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_cursorPosition(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.cursorPosition = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index cursorPosition on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_selectionStart(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.selectionStart = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index selectionStart on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_selectionEnd(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UIInput obj = (UIInput)o;
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.selectionEnd = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index selectionEnd on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int UIInput_OnValidate(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);

			if (count == 1)
			{
				Delegate arg1 = DelegateTraits<UIInput.OnValidate>.Create(func);
				ToLua.Push(L, arg1);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate arg1 = DelegateTraits<UIInput.OnValidate>.Create(func, self);
				ToLua.Push(L, arg1);
			}
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

