#!/bin/bash



function dl {
  fn="$1"
  dir=`dirname "$fn"`
  BASEURL=http://vpavlu.plain.at/share/base/files

  mkdir -p "$dir"
  wget $BASEURL/$fn -P $HOME/$dir/
}

# custom configs and tools
dl bin/luks
dl bin/t.sh
dl bin/sync-files
dl .profile
dl .bash_aliases
dl .vimrc


# custom configs and tools
#sudo aptitude installg git-core
#git clone ssh+git://plain.at/home/vpavlu/base
#mv base/* $HOME/
#rm -rf base

# utils
#sudo aptitude install
