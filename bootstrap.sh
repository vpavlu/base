#!/bin/bash

# -- get custom files from git repo
sudo aptitude -y install git-core
git clone --depth 1 ssh://plain.at/home/vpavlu/base
rm -rf base/.git
cp -rfv base/home/* $HOME/

pushd base/home
find . -type f -name .\* \
  -exec mkdir -p `dirname \{\}` \; \
  -exec cp -v \{\} $HOME/\{\} \;
popd


#source base/setup-luks

# luks
sudo aptitude -y install \
  cryptsetup

# size of container-file (in GB)
CF_SIZE_GB=16

# location of container-file
CF_LOCATION=$HOME/.data-container

# create a container blob, attach loop device
CF_DEVICE=`sudo losetup -f`
dd if=/dev/zero of=${CF_LOCATION} bs=1M count=${CF_SIZE_GB}K
sudo losetup $CF_DEVICE $CF_LOCATION

# use loop device as disk, setup luks
sudo cryptsetup luksFormat --verify-passphrase $CF_DEVICE
sudo cryptsetup luksOpen $CF_DEVICE $MOUNTPOINT
sudo mkfs.ext3 /dev/mapper/data
sudo fsck -f -y /dev/mapper/data
sudo e2label /dev/mapper/data
sudo tune2fs -l /dev/mapper/data
sudo cryptsetup luksClose data



#source base/setup-wwan
# FIXME setup drei.at stick in console


#source base/setup-fluxbox
sudo aptitude -y install \
  xorg \
  fluxbox \
  rungetty \
  thunar \
  vim-gtk

# FIXME rungetty auto-login
# FIXME autostart of x server

# utils
sudo aptitude -y install \
  apt-file \
  acpi \
  pwgen \
  sshfs \
  openssh-client \
  ntfsprogs \
  dosfstools \
  bash-completion \
  man \
  locate \
  powertop \
  unzip \
  wget

# coding
sudo aptitude -y install \
  gcc \
  g++ \
  make

# coding docs
sudo aptitude -y install \
  gcc-doc \
  manpages \
  manpages-dev \
  glibc-doc-reference \
  manpages-posix \
  manpages-posix-dev

# graphics
sudo aptitude -y install \
  gimp \
  imagemagick \
  vlc \
  gpicview

# latex
sudo aptitude -y install \
  evince \
  texlive-latex-base \
  texlive-latex-recommended \
  texlive-latex-extra

# latex docs
#sudo aptitude -y install \
#  texlive-latex-base-doc \
#  texlive-latex-recommended-doc \
#  texlive-latex-extra-doc

# office
sudo aptitude -y install \
  openoffice.org-writer \
  openoffice.org-calc

# internet
sudo aptitude -y install \
  firefox \
  pidgin \
  sun-java6-plugin

# lamp
sudo aptitude -y install \
  libapache2-mod-php5 php5-mysql mysql-server mysql-client

rm -rf base
