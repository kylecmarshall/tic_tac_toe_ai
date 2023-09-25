#pragma once

#include <utility>
#include <functional>
#include <concepts>
#include <type_traits>
extern "C" {
    #include "lua.h"
    #include "lualib.h"
    #include "lauxlib.h"
}

//==========================================
//
// LuaCheck templates
//
//===========================================
template<typename R>
R LuaCheck(lua_State * L, int index);

template<typename R>
requires (std::is_class_v<R> || std::is_reference_v<R>)
&& requires (R arg, lua_State * L)
{
    static_cast<std::remove_reference_t<std::remove_cv_t<R>>>(luaL_checkstring(L,0));
}
inline std::remove_reference_t<std::remove_cv_t<R>> LuaCheck(lua_State * L, int index)
{
    return static_cast<std::remove_reference_t<std::remove_cv_t<R>>>(luaL_checkstring(L,index));
}

template<>
inline double LuaCheck<double>(lua_State * L, int index)
{
    return luaL_checknumber(L,index);
}

template<>
inline lua_Integer LuaCheck<lua_Integer>(lua_State * L, int index)
{
    return luaL_checkinteger(L,index);
}

template<>
inline int LuaCheck<int>(lua_State * L, int index)
{
    return static_cast<int>(luaL_checkinteger(L,index));
}

//==========================================
//
// LuaCheck templates
//
//===========================================

//const char * convertible
template<typename T>
requires requires (T&& val, lua_State * L)
{
    lua_pushstring(L, std::forward<T>(val));
}
void LuaPush(lua_State * L, T&& val)
{
    using std::forward;
    lua_pushstring(L, forward<T>(val));
}

//std::string-like
template<typename T>
requires requires (T val, lua_State * L)
{
    lua_pushstring(L, val.c_str());
}
void LuaPush(lua_State * L, T&& val)
{
    lua_pushstring(L, std::forward<T>(val).c_str());
}

inline void LuaPush(lua_State * L, double val)
{
    lua_pushnumber(L, val);
}

inline void LuaPush(lua_State * L, lua_Integer val)
{
    lua_pushinteger(L,val);
}

//==========================================
//
// makeLuaWrapper
//
//===========================================
template<auto func, typename R, typename ...Args>
lua_CFunction makeLuaWrapper(R(*)(Args...))
{
    return [](lua_State* L) -> int
    {
        try
        {
            /*
                Magic templated-lambda version of:
                LuaPush(L, (*func)(LuaCheck<Arg1Type>(L,1), LuaCheck<Arg2Type>(L,2), ....) );
            */
            []<int ...I>(lua_State * L, std::integer_sequence<int, I...>) -> void
            {
                LuaPush(L, (*func)(LuaCheck<Args>(L,I+1)...) );
            }(L, std::make_integer_sequence<int, sizeof...(Args)>{});
            return 1;
        }
        catch(...)
        {
            //report error back to Lua
            return luaL_error(L, "C/C++ function error");
        }
        return 0;
    };
}

template<auto func, typename ...Args>
lua_CFunction makeLuaWrapper(void (*)(Args...))
{
    return [](lua_State* L) -> int
    {
        try
        {
            /*
                Templified version of
                (*func)(LuaCheck<Arg1Type>(L,1), LuaCheck<Arg2Type>(L,2), ....);
            */
            []<int ...I>(lua_State * L, std::integer_sequence<int, I...>) -> void
            {
                (*func)(LuaCheck<Args>(L,I+1)...);
            }(L, std::make_integer_sequence<int, sizeof...(Args)>{});
            return 0;
        }
        catch(...)
        {
            //report error back to Lua
            return luaL_error(L, "C/C++ function error");
        }
        return 0;
    };
}

template<auto func, typename T, typename ...Args>
lua_CFunction makeLuaWrapper(void (T::*)(Args...))
{
    return [](lua_State* L) -> int
    {
        try
        {
            /*
                Templified version of
                (*func)(LuaCheck<Arg1Type>(L,1), LuaCheck<Arg2Type>(L,2), ....);
            */
            []<int ...I>(lua_State * L, std::integer_sequence<int, I...>) -> void
            {
                std::invoke(func, LuaCheck<T*>(L,1), LuaCheck<Args>(L,I+2)...);
            }(L, std::make_integer_sequence<int, sizeof...(Args)>{});
            return 0;
        }
        catch(...)
        {
            //report error back to Lua
            return luaL_error(L, "C/C++ function error");
        }
        return 0;
    };
}