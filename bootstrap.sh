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

sudo aptitude -y install \
  vim


#source base/setup-luks

# luks
sudo aptitude -y install \
  cryptsetup

# size of container-file (in GB)
CF_SIZE_G=16

# location of container-file
CF_LOCATION=$HOME/.data-container

# create a container blob, attach loop device
CF_DEVICE=`sudo losetup -f`
dd if=/dev/zero of=${CF_LOCATION} bs=1G count=${CF_SIZE_G}
sudo losetup $CF_DEVICE $CF_LOCATION

# name of the /dev/mapper/$LUKS_DEVICE
LUKS_DEVICE=data

# use loop device as disk, setup luks
sudo cryptsetup luksFormat --verify-passphrase $CF_DEVICE
sudo cryptsetup luksOpen $CF_DEVICE $LUKS_DEVICE
sudo mkfs.ext3 /dev/mapper/$LUKS_DEVICE
sudo fsck /dev/mapper/$LUKS_DEVICE
# was macht das e2label??
sudo e2label /dev/mapper/$LUKS_DEVICE
sudo tune2fs -l /dev/mapper/$LUKS_DEVICE
sudo cryptsetup luksClose $LUKS_DEVICE



#source base/setup-wwan
# FIXME setup drei.at stick in console

#source base/setup-fluxbox
echo sudo aptitude -y install \
  xorg \
  fluxbox \
  rungetty \
  thunar \
  vim-gtk

# FIXME rungetty auto-login
# FIXME autostart of x server

# utils
echo sudo aptitude -y install \
  unison \
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
echo sudo aptitude -y install \
  gcc \
  g++ \
  make

# coding docs
echo sudo aptitude -y install \
  gcc-doc \
  manpages \
  manpages-dev \
  glibc-doc-reference \
  manpages-posix \
  manpages-posix-dev

# graphics
echo sudo aptitude -y install \
  gimp \
  imagemagick \
  vlc \
  gpicview

# latex
echo sudo aptitude -y install \
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
echo sudo aptitude -y install \
  openoffice.org-writer \
  openoffice.org-calc

# internet
echo sudo aptitude -y install \
  firefox \
  pidgin \
  sun-java6-plugin

# lamp
echo sudo aptitude -y install \
  libapache2-mod-php5 php5-mysql mysql-server mysql-client

rm -rf base
