cmake_minimum_required(VERSION 3.9)
project(Lab6)

include_directories(mainLab_tests/googletest/include mainLab_tests/googletest)
add_subdirectory(lib/googletest)
set(CMAKE_CXX_STANDARD 11)

# указываем путь к include директориям
include_directories(lib/googletest/googletest/include)
include_directories(lib/googletest/googlemock/include)
add_executable(Lab6 main.cpp testMain.cpp main.h)

# линкуем наш проект с библиотекой gtest
target_link_libraries(Lab6 gtest)

# todo toinfo перегенерация cmake осуществляется его reload'ом
