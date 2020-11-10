#!/bin/sh

targetName=$(sed -nr 's/^run: (\w+)$/\1/p' build/Makefile)

./build/$targetName --stop-time=$1 --wave=build/wave.ghw
gtkwave -f build/wave.ghw 
