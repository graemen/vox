# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.7

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
CMAKE_SOURCE_DIR = /home/we/vox/SCMage

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/we/vox/SCMage/build

# Include any dependencies generated for this target.
include CMakeFiles/SCMage.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/SCMage.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/SCMage.dir/flags.make

CMakeFiles/SCMage.dir/SCMage.cpp.o: CMakeFiles/SCMage.dir/flags.make
CMakeFiles/SCMage.dir/SCMage.cpp.o: ../SCMage.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/we/vox/SCMage/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/SCMage.dir/SCMage.cpp.o"
	/usr/bin/g++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/SCMage.dir/SCMage.cpp.o -c /home/we/vox/SCMage/SCMage.cpp

CMakeFiles/SCMage.dir/SCMage.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/SCMage.dir/SCMage.cpp.i"
	/usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/we/vox/SCMage/SCMage.cpp > CMakeFiles/SCMage.dir/SCMage.cpp.i

CMakeFiles/SCMage.dir/SCMage.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/SCMage.dir/SCMage.cpp.s"
	/usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/we/vox/SCMage/SCMage.cpp -o CMakeFiles/SCMage.dir/SCMage.cpp.s

CMakeFiles/SCMage.dir/SCMage.cpp.o.requires:

.PHONY : CMakeFiles/SCMage.dir/SCMage.cpp.o.requires

CMakeFiles/SCMage.dir/SCMage.cpp.o.provides: CMakeFiles/SCMage.dir/SCMage.cpp.o.requires
	$(MAKE) -f CMakeFiles/SCMage.dir/build.make CMakeFiles/SCMage.dir/SCMage.cpp.o.provides.build
.PHONY : CMakeFiles/SCMage.dir/SCMage.cpp.o.provides

CMakeFiles/SCMage.dir/SCMage.cpp.o.provides.build: CMakeFiles/SCMage.dir/SCMage.cpp.o


# Object files for target SCMage
SCMage_OBJECTS = \
"CMakeFiles/SCMage.dir/SCMage.cpp.o"

# External object files for target SCMage
SCMage_EXTERNAL_OBJECTS =

SCMage.so: CMakeFiles/SCMage.dir/SCMage.cpp.o
SCMage.so: CMakeFiles/SCMage.dir/build.make
SCMage.so: /usr/lib/arm-linux-gnueabihf/libmage.so
SCMage.so: CMakeFiles/SCMage.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/we/vox/SCMage/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared module SCMage.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/SCMage.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/SCMage.dir/build: SCMage.so

.PHONY : CMakeFiles/SCMage.dir/build

CMakeFiles/SCMage.dir/requires: CMakeFiles/SCMage.dir/SCMage.cpp.o.requires

.PHONY : CMakeFiles/SCMage.dir/requires

CMakeFiles/SCMage.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/SCMage.dir/cmake_clean.cmake
.PHONY : CMakeFiles/SCMage.dir/clean

CMakeFiles/SCMage.dir/depend:
	cd /home/we/vox/SCMage/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/we/vox/SCMage /home/we/vox/SCMage /home/we/vox/SCMage/build /home/we/vox/SCMage/build /home/we/vox/SCMage/build/CMakeFiles/SCMage.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/SCMage.dir/depend

