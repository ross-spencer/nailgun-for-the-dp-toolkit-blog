#!/bin/bash
time (for i in {1..1000}
do
   java -jar SysExitApp.jar
done)

time (for i in {1..1000}
do
   ./SysExitApp.bin
done)

#Only for use if Jar loaded into Nailgun
#time (for i in {1..1000}
#do
#   ng SysExitApp
#done)
