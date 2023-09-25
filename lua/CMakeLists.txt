
add_library( lua_wxDC 
                wxDC.cpp
                )

target_compile_features(lua_wxDC PRIVATE cxx_std_20)
target_include_directories( lua_wxDC 
                            PRIVATE
                            ${PROJECT_SOURCE_DIR}/include 
                            ${LUA_INCLUDE_DIR})


configure_file(init.lua.in ${PROJECT_BINARY_DIR}/init.lua)

set(lua_dir_path ${CMAKE_CURRENT_SOURCE_DIR})
get_source_file_property(lua_init_path ${PROJECT_BINARY_DIR}/init.lua LOCATION)
get_source_file_property(lua_render_path render.lua LOCATION)
get_source_file_property(lua_reset_path reset.lua LOCATION)

configure_file(lua_paths.h.in ${PROJECT_BINARY_DIR}/lua_paths.h)