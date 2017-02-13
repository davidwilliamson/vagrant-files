#!/usr/bin/env bash

# Use this script to install any Ubuntu packages in our VM beyond what
# is already part of the Ubuntu distro.
#
# node.js
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
# GNU C++ compiler and debugger
sudo apt-get install g++
sudo apt-get install gdb
# Python utilities
sudo apt-get install ipython
sudo apt-get install python-tk
#
sudo apt-get install bonnie++
sudo apt-get install sysstat
sudo apt-get install cryptsetup
