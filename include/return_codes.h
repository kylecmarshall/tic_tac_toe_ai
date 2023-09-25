#pragma once

typedef int ReturnCode;
constexpr ReturnCode R_OK = 0;
constexpr ReturnCode R_ERR = 1;

#define R_VERIFY(cond) if( not (cond)) { return R_ERR; }