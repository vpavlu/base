#!/bin/bash

sudo aptitude install git-core
git clone --depth 1 ssh://plain.at/home/vpavlu/base
rm -rf base/.git
cp -rfv base/home/.* $HOME/
cp -rfv base/home/* $HOME/
rm -rf base

# utils
#sudo aptitude install
