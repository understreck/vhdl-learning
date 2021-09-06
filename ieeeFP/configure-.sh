#!/bin/sh

mkdir -p hdl_checker
rm -r hdl_checker/*

mkdir -p build
cd ./build
rm ./*

ghdl -i --std=08 ../**/*.vhd*
ghdl --gen-makefile --std=08 -f $1 | tee Makefile
