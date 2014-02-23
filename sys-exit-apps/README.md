System Exit Apps: Testing the equivalence of C++ and Java startup times
=======================================================================

###SysExitApp.cpp

Build on Linux using the command:

    g++ SysExitApp.cpp -o SysExitApp.bin

###SysExitApp.jar

Create a class on Linux using:

    javac SysExitApp.java

Create an executable Jar to make compatible with Nailgun using:

    jar cmf MANIFEST.MF SysExitApp.jar SysExitApp.class


