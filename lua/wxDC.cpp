#include "wxDC.h"
#include <wx/app.h>

extern "C" {
#include <lauxlib.h>
#include <lua.h>
#include <lualib.h>

}
#include "LuaStackMinder.h"
#include "dbgout.h"
#include "lunar.h"
#include "return_codes.h"


// Lua Registry key for aux table
constexpr auto aux_registry_key = "__wxdc_aux_table";

// received wxDC * from lua as a pointer
template <> wxDC *LuaCheck<wxDC *>(lua_State *L, int idx) {
  return static_cast<wxDC *>(lua_touserdata(L, idx));
}

template <> unsigned char LuaCheck<unsigned char>(lua_State *L, int idx) {
  return static_cast<unsigned char>(lua_tointeger(L, idx));
}

template <> wxBrushStyle LuaCheck<wxBrushStyle>(lua_State *L, int idx) {
  return static_cast<wxBrushStyle>(lua_tointeger(L, idx));
}

static void SetBrush(wxDC *dc, wxColourBase::ChannelType red,
              wxColourBase::ChannelType green, wxColourBase::ChannelType blue,
              wxColourBase::ChannelType alpha, wxBrushStyle brushStyle) {
  dc->SetBrush(wxBrush{wxColor{red, green, blue, alpha}, brushStyle});
}

static void SetPen(wxDC *dc, wxColourBase::ChannelType red,
              wxColourBase::ChannelType green, wxColourBase::ChannelType blue,
              wxColourBase::ChannelType alpha, int width) {
  dc->SetPen(wxPen{wxColor{red, green, blue, alpha}, width});
}

static void Refresh() {
  //so much ugly to avoid the if statement
  //wxTheApp->GetMainTopWindow() && (wxTheApp->GetMainTopWindow()->Refresh(), true);

  //I caved to my better judgement
  if(auto *win = wxTheApp->GetMainTopWindow()) {
    win->Refresh(false);
  }
}

static int GetSize(lua_State * L) {
  // lua call> width, height = dc:GetSize()
  wxDC * const dc = static_cast<wxDC *>(lua_touserdata(L, 1));
  auto size = dc->GetSize();

  //return width, height
  lua_pushinteger(L, size.GetWidth());
  lua_pushinteger(L, size.GetHeight());
  return 2;
}

static int GetPen(lua_State * L) {
  // lua call>  r, g, b, w = dc:GetPen()
  wxDC * const dc = static_cast<wxDC *>(lua_touserdata(L, 1));
  auto pen = dc->GetPen();
  
  //return red, green, blue, width
  lua_pushinteger(L, pen.GetColour().Red());
  lua_pushinteger(L, pen.GetColour().Green());
  lua_pushinteger(L, pen.GetColour().Blue());
  lua_pushinteger(L, pen.GetWidth());
  return 4;
}

static int GetBrush(lua_State * L) {
  // lua call>  r, g, b, s = dc:GetBrush()
  wxDC * const dc = static_cast<wxDC *>(lua_touserdata(L, 1));
  auto brush = dc->GetBrush();
  
  //return red, green, blue, width
  lua_pushinteger(L, brush.GetColour().Red());
  lua_pushinteger(L, brush.GetColour().Green());
  lua_pushinteger(L, brush.GetColour().Blue());
  lua_pushinteger(L, brush.GetStyle());
  return 4;
}

// type aliases are used to select a specific function from the set of overloads
using wxDCDrawCircleFunc = void (wxDC::*)(wxCoord, wxCoord, wxCoord);
using wxDCDrawLineFunc = void (wxDC::*)(wxCoord, wxCoord, wxCoord, wxCoord);
using wxDCDrawTextFunc = void (wxDC::*)(const wxString &, wxCoord, wxCoord);
using wxDCDrawRectangleFunc = void (wxDC::*)(wxCoord, wxCoord, wxCoord, wxCoord);
static luaL_Reg funcs[] = {
    {"DrawCircle", makeLuaWrapper<wxDCDrawCircleFunc(&wxDC::DrawCircle)>(
                       wxDCDrawCircleFunc(&wxDC::DrawCircle))},
    {"DrawLine", makeLuaWrapper<wxDCDrawLineFunc(&wxDC::DrawLine)>(
                     wxDCDrawLineFunc(&wxDC::DrawLine))},
    {"DrawText", makeLuaWrapper<wxDCDrawTextFunc(&wxDC::DrawText)>(
                     wxDCDrawTextFunc(&wxDC::DrawText))},
    {"DrawRectangle", makeLuaWrapper<wxDCDrawRectangleFunc(&wxDC::DrawRectangle)>(
                     wxDCDrawRectangleFunc(&wxDC::DrawRectangle))},
    {"SetBrush", makeLuaWrapper<SetBrush>(&SetBrush)},
    {"SetPen", makeLuaWrapper<SetPen>(&SetPen)},
    {"Refresh", makeLuaWrapper<Refresh>(&Refresh)},
    {"GetSize", &GetSize},
    {"GetPen", &GetPen},
    {"GetBrush", &GetBrush},
    {nullptr, nullptr}};

// Brush Constants
struct Constant {
  const char *name;
  int value;
};

constexpr Constant BrushConstants[] = {
    {"BRUSHSTYLE_INVALID", wxBRUSHSTYLE_INVALID},
    {"BRUSHSTYLE_SOLID", wxBRUSHSTYLE_SOLID},
    {"BRUSHSTYLE_TRANSPARENT", wxBRUSHSTYLE_TRANSPARENT},
    {"BRUSHSTYLE_STIPPLE_MASK_OPAQUE", wxBRUSHSTYLE_STIPPLE_MASK_OPAQUE},
    {"BRUSHSTYLE_STIPPLE_MASK", wxBRUSHSTYLE_STIPPLE_MASK},
    {"BRUSHSTYLE_STIPPLE", wxBRUSHSTYLE_STIPPLE},
    {"BRUSHSTYLE_BDIAGONAL_HATCH", wxBRUSHSTYLE_BDIAGONAL_HATCH},
    {"BRUSHSTYLE_CROSSDIAG_HATCH", wxBRUSHSTYLE_CROSSDIAG_HATCH},
    {"BRUSHSTYLE_FDIAGONAL_HATCH", wxBRUSHSTYLE_FDIAGONAL_HATCH},
    {"BRUSHSTYLE_CROSS_HATCH", wxBRUSHSTYLE_CROSS_HATCH},
    {"BRUSHSTYLE_HORIZONTAL_HATCH", wxBRUSHSTYLE_HORIZONTAL_HATCH},
    {"BRUSHSTYLE_VERTICAL_HATCH", wxBRUSHSTYLE_VERTICAL_HATCH},
    {"BRUSHSTYLE_FIRST_HATCH", wxBRUSHSTYLE_FIRST_HATCH},
    {"BRUSHSTYLE_LAST_HATCH", wxBRUSHSTYLE_LAST_HATCH}};

// [ aux table | prv table | module table ]
// returns []
static int initialize(lua_State *L) {
  // Lua stack
  // { [1] = aux table | [2] = prv table | [3] = module table }
  // returns {}
  constexpr int idx_aux_table = 1;
  constexpr int idx_prv_table = 2;
  constexpr int idx_module_table = 3;

  // store aux in Lua Registry
  {
    LuaStackMinder raii_pop{L, 0};
    lua_pushvalue(L, idx_aux_table);
    lua_setfield(L, LUA_REGISTRYINDEX, aux_registry_key);
  }

  // push wxDC methods to prv
  {
    LuaStackMinder raii_pop{L, 0};
    lua_pushvalue(L, idx_prv_table);
    luaL_setfuncs(L, funcs, 0);
  }

  // push constants into module
  {
    LuaStackMinder raii_pop{L, 0};
    lua_pushvalue(L, idx_module_table);

    for (auto constant : BrushConstants) {
      lua_pushinteger(L, constant.value);
      lua_setfield(L, -2, constant.name);
    }
  }

  // Clear stack
  lua_settop(L, 0);
  return 0;
}

int luaopen_wxDC(lua_State *L) {
  lua_pushcfunction(L, initialize);
  return 1;
}

ReturnCode LuaRender(lua_State *L, wxDC &dc) {
  // equivalent to lua code: tblAux.render(dc)
  LuaStackMinder raii_pop{L, 0};
  R_VERIFY(luaL_getsubtable(L, LUA_REGISTRYINDEX, aux_registry_key));
  R_VERIFY(lua_getfield(L, -1, "render") == LUA_TFUNCTION);
  lua_pushlightuserdata(L, &dc);
  if (lua_pcall(L, 1, 0, 0) != LUA_OK) {
    dbgout << lua_tostring(L, -1) << "\n";
    return R_ERR;
  }
  return R_OK;
}