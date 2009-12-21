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


bash base/setup-luks
bash base/drei/setup-drei.at


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
