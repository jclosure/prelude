# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/joel/.emacs.d/personal/extras/cmake/student

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/joel/.emacs.d/personal/extras/cmake/student/build

# Include any dependencies generated for this target.
include CMakeFiles/testStudent.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/testStudent.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/testStudent.dir/flags.make

CMakeFiles/testStudent.dir/src/Person.cpp.o: CMakeFiles/testStudent.dir/flags.make
CMakeFiles/testStudent.dir/src/Person.cpp.o: ../src/Person.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/joel/.emacs.d/personal/extras/cmake/student/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/testStudent.dir/src/Person.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/testStudent.dir/src/Person.cpp.o -c /home/joel/.emacs.d/personal/extras/cmake/student/src/Person.cpp

CMakeFiles/testStudent.dir/src/Person.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/testStudent.dir/src/Person.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/joel/.emacs.d/personal/extras/cmake/student/src/Person.cpp > CMakeFiles/testStudent.dir/src/Person.cpp.i

CMakeFiles/testStudent.dir/src/Person.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/testStudent.dir/src/Person.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/joel/.emacs.d/personal/extras/cmake/student/src/Person.cpp -o CMakeFiles/testStudent.dir/src/Person.cpp.s

CMakeFiles/testStudent.dir/src/Person.cpp.o.requires:

.PHONY : CMakeFiles/testStudent.dir/src/Person.cpp.o.requires

CMakeFiles/testStudent.dir/src/Person.cpp.o.provides: CMakeFiles/testStudent.dir/src/Person.cpp.o.requires
	$(MAKE) -f CMakeFiles/testStudent.dir/build.make CMakeFiles/testStudent.dir/src/Person.cpp.o.provides.build
.PHONY : CMakeFiles/testStudent.dir/src/Person.cpp.o.provides

CMakeFiles/testStudent.dir/src/Person.cpp.o.provides.build: CMakeFiles/testStudent.dir/src/Person.cpp.o


CMakeFiles/testStudent.dir/src/Student.cpp.o: CMakeFiles/testStudent.dir/flags.make
CMakeFiles/testStudent.dir/src/Student.cpp.o: ../src/Student.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/joel/.emacs.d/personal/extras/cmake/student/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/testStudent.dir/src/Student.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/testStudent.dir/src/Student.cpp.o -c /home/joel/.emacs.d/personal/extras/cmake/student/src/Student.cpp

CMakeFiles/testStudent.dir/src/Student.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/testStudent.dir/src/Student.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/joel/.emacs.d/personal/extras/cmake/student/src/Student.cpp > CMakeFiles/testStudent.dir/src/Student.cpp.i

CMakeFiles/testStudent.dir/src/Student.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/testStudent.dir/src/Student.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/joel/.emacs.d/personal/extras/cmake/student/src/Student.cpp -o CMakeFiles/testStudent.dir/src/Student.cpp.s

CMakeFiles/testStudent.dir/src/Student.cpp.o.requires:

.PHONY : CMakeFiles/testStudent.dir/src/Student.cpp.o.requires

CMakeFiles/testStudent.dir/src/Student.cpp.o.provides: CMakeFiles/testStudent.dir/src/Student.cpp.o.requires
	$(MAKE) -f CMakeFiles/testStudent.dir/build.make CMakeFiles/testStudent.dir/src/Student.cpp.o.provides.build
.PHONY : CMakeFiles/testStudent.dir/src/Student.cpp.o.provides

CMakeFiles/testStudent.dir/src/Student.cpp.o.provides.build: CMakeFiles/testStudent.dir/src/Student.cpp.o


CMakeFiles/testStudent.dir/src/Teacher.cpp.o: CMakeFiles/testStudent.dir/flags.make
CMakeFiles/testStudent.dir/src/Teacher.cpp.o: ../src/Teacher.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/joel/.emacs.d/personal/extras/cmake/student/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/testStudent.dir/src/Teacher.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/testStudent.dir/src/Teacher.cpp.o -c /home/joel/.emacs.d/personal/extras/cmake/student/src/Teacher.cpp

CMakeFiles/testStudent.dir/src/Teacher.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/testStudent.dir/src/Teacher.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/joel/.emacs.d/personal/extras/cmake/student/src/Teacher.cpp > CMakeFiles/testStudent.dir/src/Teacher.cpp.i

CMakeFiles/testStudent.dir/src/Teacher.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/testStudent.dir/src/Teacher.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/joel/.emacs.d/personal/extras/cmake/student/src/Teacher.cpp -o CMakeFiles/testStudent.dir/src/Teacher.cpp.s

CMakeFiles/testStudent.dir/src/Teacher.cpp.o.requires:

.PHONY : CMakeFiles/testStudent.dir/src/Teacher.cpp.o.requires

CMakeFiles/testStudent.dir/src/Teacher.cpp.o.provides: CMakeFiles/testStudent.dir/src/Teacher.cpp.o.requires
	$(MAKE) -f CMakeFiles/testStudent.dir/build.make CMakeFiles/testStudent.dir/src/Teacher.cpp.o.provides.build
.PHONY : CMakeFiles/testStudent.dir/src/Teacher.cpp.o.provides

CMakeFiles/testStudent.dir/src/Teacher.cpp.o.provides.build: CMakeFiles/testStudent.dir/src/Teacher.cpp.o


CMakeFiles/testStudent.dir/src/mainapp.cpp.o: CMakeFiles/testStudent.dir/flags.make
CMakeFiles/testStudent.dir/src/mainapp.cpp.o: ../src/mainapp.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/joel/.emacs.d/personal/extras/cmake/student/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/testStudent.dir/src/mainapp.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/testStudent.dir/src/mainapp.cpp.o -c /home/joel/.emacs.d/personal/extras/cmake/student/src/mainapp.cpp

CMakeFiles/testStudent.dir/src/mainapp.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/testStudent.dir/src/mainapp.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/joel/.emacs.d/personal/extras/cmake/student/src/mainapp.cpp > CMakeFiles/testStudent.dir/src/mainapp.cpp.i

CMakeFiles/testStudent.dir/src/mainapp.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/testStudent.dir/src/mainapp.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/joel/.emacs.d/personal/extras/cmake/student/src/mainapp.cpp -o CMakeFiles/testStudent.dir/src/mainapp.cpp.s

CMakeFiles/testStudent.dir/src/mainapp.cpp.o.requires:

.PHONY : CMakeFiles/testStudent.dir/src/mainapp.cpp.o.requires

CMakeFiles/testStudent.dir/src/mainapp.cpp.o.provides: CMakeFiles/testStudent.dir/src/mainapp.cpp.o.requires
	$(MAKE) -f CMakeFiles/testStudent.dir/build.make CMakeFiles/testStudent.dir/src/mainapp.cpp.o.provides.build
.PHONY : CMakeFiles/testStudent.dir/src/mainapp.cpp.o.provides

CMakeFiles/testStudent.dir/src/mainapp.cpp.o.provides.build: CMakeFiles/testStudent.dir/src/mainapp.cpp.o


# Object files for target testStudent
testStudent_OBJECTS = \
"CMakeFiles/testStudent.dir/src/Person.cpp.o" \
"CMakeFiles/testStudent.dir/src/Student.cpp.o" \
"CMakeFiles/testStudent.dir/src/Teacher.cpp.o" \
"CMakeFiles/testStudent.dir/src/mainapp.cpp.o"

# External object files for target testStudent
testStudent_EXTERNAL_OBJECTS =

testStudent: CMakeFiles/testStudent.dir/src/Person.cpp.o
testStudent: CMakeFiles/testStudent.dir/src/Student.cpp.o
testStudent: CMakeFiles/testStudent.dir/src/Teacher.cpp.o
testStudent: CMakeFiles/testStudent.dir/src/mainapp.cpp.o
testStudent: CMakeFiles/testStudent.dir/build.make
testStudent: CMakeFiles/testStudent.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/joel/.emacs.d/personal/extras/cmake/student/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX executable testStudent"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/testStudent.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/testStudent.dir/build: testStudent

.PHONY : CMakeFiles/testStudent.dir/build

CMakeFiles/testStudent.dir/requires: CMakeFiles/testStudent.dir/src/Person.cpp.o.requires
CMakeFiles/testStudent.dir/requires: CMakeFiles/testStudent.dir/src/Student.cpp.o.requires
CMakeFiles/testStudent.dir/requires: CMakeFiles/testStudent.dir/src/Teacher.cpp.o.requires
CMakeFiles/testStudent.dir/requires: CMakeFiles/testStudent.dir/src/mainapp.cpp.o.requires

.PHONY : CMakeFiles/testStudent.dir/requires

CMakeFiles/testStudent.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/testStudent.dir/cmake_clean.cmake
.PHONY : CMakeFiles/testStudent.dir/clean

CMakeFiles/testStudent.dir/depend:
	cd /home/joel/.emacs.d/personal/extras/cmake/student/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/joel/.emacs.d/personal/extras/cmake/student /home/joel/.emacs.d/personal/extras/cmake/student /home/joel/.emacs.d/personal/extras/cmake/student/build /home/joel/.emacs.d/personal/extras/cmake/student/build /home/joel/.emacs.d/personal/extras/cmake/student/build/CMakeFiles/testStudent.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/testStudent.dir/depend

