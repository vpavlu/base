#!/bin/bash

##
## creates a simple "rotating" scratch directory structure
## The latest directory is symlinked to $LINK
##

BASE="$HOME/data/s"
LINK="$HOME/data/s/cur"

Y=`date +"%Y"`
M=`date +"%m"`
W=`date +"%W"`

WD="${Y}/${M}"

mkdir -p "$BASE/$WD"
ln -sfn "$WD" "$LINK"
echo "$BASE/$WD"

