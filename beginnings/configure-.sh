#!/bin/sh

cd ./build
ghdl -i ../src/*.vhdl
ghdl --gen-makefile -f $1 | tee Makefile
