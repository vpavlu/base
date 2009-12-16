#!/bin/bash

##
## creates a simple monthly-"rotating" scratch directory 
## structure beneath $S. the latest directory is symlinked
## to $T
##

# open encrypted data/ directory
luks is_mounted || luks open

S="$HOME/data/s"
T="$HOME/data/s/cur"
Y=`date +"%Y"`
M=`date +"%m"`
C="${S}/${Y}/${M}"

mkdir -p $C
ln -sfn $C $T
echo $T
