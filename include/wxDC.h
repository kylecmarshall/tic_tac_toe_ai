#pragma once
#include "wx/dc.h"
#include "return_codes.h"
struct lua_State;

int luaopen_wxDC(lua_State * L);

bool LuaCanRender(lua_State * L);
ReturnCode LuaRender(lua_State * L, wxDC & dc);