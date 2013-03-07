#!/bin/bash
# thanks to: https://gist.github.com/2042882

# This script can be used as a hook, run after a new virtualenv is activated.
# ~/.virtualenvs/postmkvirtualenv
 
# libs=( PyQt4 sip.so )
# if PyQt4 is compiled with 'kde' flag, needs the PyKDE4 lib
libs=( PyQt4 sip.so PyKDE4 )
 
python_version=python$(python -c "import sys; print (str(sys.version_info[0])+'.'+str(sys.version_info[1]))")
var=( $(which -a $python_version) )
 
get_python_lib_cmd="from distutils.sysconfig import get_python_lib; print (get_python_lib())"
lib_virtualenv_path=$(python -c "$get_python_lib_cmd")
lib_system_path=$(${var[-1]} -c "$get_python_lib_cmd")
 
for lib in ${libs[@]}
do
    ln -s $lib_system_path/$lib $lib_virtualenv_path/$lib
done
