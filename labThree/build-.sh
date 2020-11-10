#!/bin/sh

cd build

sed -i 's/^\(GHDLFLAGS=.*\).*/\1'" $@/" Makefile
make
