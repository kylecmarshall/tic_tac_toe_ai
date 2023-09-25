// clang-format off
#include <wx/wx.h>
// clang-format on
#include <array>
#include <debugapi.h>
#include <iostream>
#include <streambuf>

class debugbuf : public std::streambuf {
protected:
  virtual int_type overflow(int_type c) {
    if (c != EOF) {
      std::array<char, 2> res = {static_cast<char>(c), 0};
      OutputDebugStringA(res.data());
    }
    return c;
  }
};

static debugbuf debugbuffer{};
static std::ostream dbgout{&debugbuffer};