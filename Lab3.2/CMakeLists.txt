cmake_minimum_required(VERSION 3.9)
project(Lab3_2 C)

set(CMAKE_C_STANDARD 99)

add_executable(Lab3_2 main.c)

target_link_libraries(Lab3_2 m)