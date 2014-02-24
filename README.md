A nailgun for the digital preservation toolkit
===============================================

A repository containing scripts for the OPF blog: A Nailgun for the Digital 
Preservation Toolkit. 

###dp-nailgun-timing-testing.sh

Primary script used for timing in the Nailgun blog. Requires a new manifest
to the opf-format-blog, and/or another corpus of files to test on. Also
requires the [http://www.martiansoftware.com/nailgun/Nailgun](Nailgun) 
server to have been started. 

###dp-folder-recurse-testing.sh

Bash shell script testing three methods of recursion. The script displays 
the timings for the three methods. For OPF blog on Nailgun. The three 
methods are: find, globstar and then using a directory manifest.