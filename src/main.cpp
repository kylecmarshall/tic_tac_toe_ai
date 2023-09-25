// clang-format off
#include <wx/wx.h>
// clang-format on

extern "C" {
#include <lauxlib.h>
#include <lua.h>
#include <lualib.h>
}
#include "LuaStackMinder.h"
#include "dbgout.h"
#include "lua_paths.h"
#include "wxDC.h"
#include <array>
#include <concepts>
#include <exception>
#include <memory>
#include <stdexcept>
#include <wx/fswatcher.h>
#include <wx/dcbuffer.h>

// StringLiteral non-type template parameter
template <size_t N> struct StringLiteral {
  std::array<char, N> value;
  constexpr StringLiteral(const char (&str)[N]) {
    std::copy_n(str, N, value.begin());
  }

  constexpr operator const char *() const { return &value.at(0);}
};

// LuaPtr - Lua smart pointer
auto LuaDeleter = [](lua_State *L) { lua_close(L); };
typedef std::unique_ptr<lua_State, decltype(LuaDeleter)> LuaPtr;

class App : public wxApp {
public:
  LuaPtr m_L;

  // initialized in OnEventLoopEnter
  std::unique_ptr<wxFileSystemWatcher> m_pWatcher = nullptr;
  std::unique_ptr<wxTimer> m_pTimer{new wxTimer()};

  App() : m_L(luaL_newstate(), LuaDeleter){};

  virtual bool OnInit() override;
  virtual void OnEventLoopEnter(wxEventLoopBase *) override;
  virtual int OnExit() override;
  void LoadRenderLuaScript();
  void LoadRequiredLuaScript(const char *path);
  void InitLua();
  void Render(wxDC &dc);
  void ResetLua();

  lua_State *L() { return m_L.get(); }

  template <StringLiteral funcname> void LuaGlobalFunction() {
    LuaStackMinder raii_pop {L(), 0};
    lua_getglobal(L(), funcname);
    if(lua_pcall(L(), 0, 0, 0) != LUA_OK) {
      dbgout << lua_tostring(L(), -1) << "\n";
    }
  }
};

wxIMPLEMENT_APP(App);

/*
 * Here we do the actual rendering. I put it in a separate
 * method so that it can work no matter what type of DC
 * (e.g. wxPaintDC or wxClientDC) is used.
 */
void default_render(wxDC &dc) {
  // draw some text
  dc.DrawText(wxT("Testing"), 40, 60);

  dc.SetBrush(wxBrush{wxColor{0, 0, 0}, wxBRUSHSTYLE_SOLID});

  // draw a circle
  dc.SetBrush(*wxGREEN_BRUSH);             // green filling
  dc.SetPen(wxPen(wxColor(255, 0, 0), 5)); // 5-pixels-thick red outline
  dc.DrawCircle(wxPoint(200, 100), 25 /* radius */);

  // draw a rectangle
  dc.SetBrush(*wxBLUE_BRUSH);                   // blue filling
  dc.SetPen(wxPen(wxColor(255, 175, 175), 10)); // 10-pixels-thick pink outline
  dc.DrawRectangle(300, 100, 400, 200);

  // draw a line
  dc.SetPen(wxPen(wxColor(0, 0, 0), 3)); // black line, 3 pixels thick
  dc.DrawLine(300, 100, 700, 300);       // draw line across the rectangle

  // Look at the wxDC docs to learn how to draw other stuff
}

void App::Render(wxDC &dc) {
  if (LuaRender(L(), dc)) {
    // LuaRender failed, fall back
    // to default_render
    default_render(dc);
  }
}

bool App::OnInit() {
  //
  // init lua
  //
  try {
    InitLua();
  } catch (...) {
    std::terminate();
  }

  //
  // init wx
  //

  auto frame = new wxFrame(nullptr, wxID_ANY, "Minimax Game AI Prototype", wxPoint(50, 50),
                           wxSize(800, 610));
  wxBoxSizer *sizer = new wxBoxSizer(wxHORIZONTAL);

  auto drawPane = new wxPanel((wxFrame *)frame);
  sizer->Add(drawPane, 1, wxEXPAND);

  frame->SetSizer(sizer);
  frame->SetAutoLayout(true);

  drawPane->Bind(wxEVT_PAINT, [&](wxPaintEvent &evt) {
    wxBufferedPaintDC dc(static_cast<wxWindow *>(evt.GetEventObject()));
    Render(dc);
  });
  drawPane->SetBackgroundStyle(wxBG_STYLE_PAINT);

  frame->Show(true);

  m_pTimer->Bind(wxEVT_TIMER, [&](wxTimerEvent &evt) { LuaGlobalFunction<"Tick">(); });
  m_pTimer->Start(100);

  return true;
}

int App::OnExit() {
  m_pTimer->Stop();
  m_pTimer.reset();
  m_pWatcher.reset();
  return 0;
}

void App::OnEventLoopEnter(wxEventLoopBase *loop) {
  if (m_pWatcher == nullptr && loop->IsMain()) {
    // watch lua script directory for changes and
    // then reset the Lua system to load new changes
    m_pWatcher =
        std::unique_ptr<wxFileSystemWatcher>{new wxFileSystemWatcher()};
    m_pWatcher->AddTree(wxFileName{script::paths::lua_dir}, wxFSW_EVENT_MODIFY);
    m_pWatcher->Bind(wxEVT_FSWATCHER, [&](wxFileSystemWatcherEvent &evt) {
      dbgout << evt.ToString() << "\n";
      ResetLua();
    });
  }
}

void DbgOutputLuaWarnings(void *, const char *msg, int tocont) {
  dbgout << msg;
  if (not tocont) {
    dbgout << "\n";
  }
}

void App::LoadRequiredLuaScript(const char *path) {
  if (luaL_dofile(L(), path) != LUA_OK) {
    dbgout << lua_tostring(L(), -1) << "\n";
    throw std::runtime_error{std::string{path} + " failed to load"};
  }
}

void App::LoadRenderLuaScript() {
  if (luaL_dofile(L(), script::paths::render_lua) != LUA_OK) {
    dbgout << lua_tostring(L(), -1) << "\n";
  }
}

void App::InitLua() {
  // route warnings to debug console
  lua_setwarnf(L(), DbgOutputLuaWarnings, nullptr);

  luaL_openlibs(L());

  if (luaL_getsubtable(L(), LUA_REGISTRYINDEX, LUA_PRELOAD_TABLE)) {
    lua_pushcfunction(L(), &luaopen_wxDC);
    lua_setfield(L(), -2, "wxDC_prv");

    lua_pop(L(), 1);
  }

  if (luaL_dofile(L(), script::paths::init_lua) != LUA_OK) {
    if (lua_isstring(L(), -1)) {
      dbgout << lua_tostring(L(), -1) << "\n";
    }
    throw std::runtime_error{"init.lua failed"};
  }

  LoadRenderLuaScript();

  lua_settop(L(), 0);
}

void App::ResetLua() {
  // run reset.lua to handle reset logic such as unloading all modules, etc.
  // load render.lua and dirty the main window
  dbgout << "resetting lua\n";
  LoadRequiredLuaScript(script::paths::reset_lua);
  LoadRenderLuaScript();

  this->GetMainTopWindow()->Refresh();
  lua_settop(L(), 0);
}