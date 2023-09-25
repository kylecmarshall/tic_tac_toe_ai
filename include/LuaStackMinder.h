#pragma once

extern "C" {
    #include <lua.h>
}


class LuaStackMinder {
public:
    lua_State * L;
    int m_StackTopOnEnter;
    int m_StackTopDeltaOnExit;

    LuaStackMinder(lua_State * L, int stackDelta) : 
        L(L), 
        m_StackTopDeltaOnExit(stackDelta) {
            m_StackTopOnEnter = lua_gettop(L);
        }


    ~LuaStackMinder() {
        lua_settop(L, m_StackTopOnEnter + m_StackTopDeltaOnExit);
    }
};