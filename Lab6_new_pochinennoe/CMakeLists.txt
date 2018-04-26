cmake_minimum_required(VERSION 3.9)
project(Lab6_new_pochinennoe)

set(CMAKE_CXX_STANDARD 11)

include_directories(mainLab_tests/googletest/include mainLab_tests/googletest)
add_subdirectory(lib/googletest)

# указываем путь к include директориям
include_directories(lib/googletest/googletest/include)
include_directories(lib/googletest/googlemock/include)
add_executable(Lab6_new_pochinennoe main.cpp main.h testMain1.cpp)

# линкуем наш проект с библиотекой gtest
target_link_libraries(Lab6_new_pochinennoe gtest)

# todo toinfo перегенерация cmake осуществляется его reload'ом