cmake_minimum_required(VERSION 3.26)
project(tic_tac_toe_ai)

cmake_path(SET LUA_LOADFILE_PATH ${PROJECT_BINARY_DIR})

find_package(Lua REQUIRED)
find_package(wxWidgets CONFIG REQUIRED)

add_executable(tic_tac_toe_ai WIN32 src/main.cpp)
target_compile_features(tic_tac_toe_ai PRIVATE cxx_std_20)
target_include_directories( tic_tac_toe_ai 
                            PRIVATE
                            ${PROJECT_SOURCE_DIR}/include 
                            ${PROJECT_BINARY_DIR}
                            ${LUA_INCLUDE_DIR})
target_link_libraries(tic_tac_toe_ai PRIVATE ${LUA_LIBRARIES})
target_link_libraries(tic_tac_toe_ai PRIVATE wx::core wx::base)
target_link_libraries(tic_tac_toe_ai PRIVATE lua_wxDC)

add_subdirectory(lua)

