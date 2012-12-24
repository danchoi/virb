#!/bin/bash

scale=60
# an ad hoc script that can be adapted for future uses

# $1 name of an jpg image file 

out=${1%.png}-sm.png
echo "$1 -> $out"
convert $1 -scale %${scale} $out
