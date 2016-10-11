cmake_minimum_required(VERSION 2.8.9)
project(directory_test)

set (CMAKE_CXX_STANDARD 11)


set(CMAKE_BUILD_TYPE Debug)

# Add -O0 to remove optimizations when using gcc
# IF(CMAKE_COMPILER_IS_GNUCC)
#     set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0")
#     set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -O0")
# ENDIF(CMAKE_COMPILER_IS_GNUCC)


#Bring the headers, such as Student.h into the project
include_directories(include)

#Can manually add the sources using the set command as follows:
#set(SOURCES src/mainapp.cpp src/Student.cpp)

#However, the file(GLOB...) allows for wildcard additions:
file(GLOB SOURCES "src/*.cpp")

add_executable(testStudent ${SOURCES})
