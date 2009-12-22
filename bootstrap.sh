#!/bin/bash

# -- get custom files from git repo
sudo aptitude -y install git-core
git clone --depth 1 git://github.com/vpavlu/base.git 
rm -rf base/.git
cp -rfv base/home/* $HOME/

pushd base/home
find . -type f -name .\* \
  -exec mkdir -p `dirname \{\}` \; \
  -exec cp -v \{\} $HOME/\{\} \;
popd

# -- install vim
sudo aptitude -y install vim

# -- install rest
bash base/setup-luks
bash base/drei/setup-drei.at
bash base/setup-packages

# -- cleanup
rm -rf base
