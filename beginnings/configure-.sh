#!/bin/sh

mkdir -p build
cd ./build
rm ./*

ghdl -i ../src/*.vhdl
ghdl --gen-makefile -f $1 | tee Makefile
