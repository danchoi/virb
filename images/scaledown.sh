#!/bin/bash

# scales an image file down to 75%

# an ad hoc script that can be adapted for future uses

# $1 name of an jpg image file 

out=${1%.png}-sm.png
echo "$1 -> $out"
convert $1 -scale %50 $out
