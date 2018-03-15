cmake_minimum_required(VERSION 3.9)
project(Lab3_4 C)

set(CMAKE_C_STANDARD 99)

add_executable(Lab3_4 main.c)
#статически  слинкованная либа для мат
target_link_libraries(Lab3_4 m)