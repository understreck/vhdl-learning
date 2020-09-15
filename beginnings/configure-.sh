#!/bin/sh

mkdir -p hdl_checker
rm -r hdl_checker/

mkdir -p build
cd ./build
rm ./*

ghdl -i ../src/*.vhdl
ghdl --gen-makefile -f $1 | tee Makefile
