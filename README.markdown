# bootstrap a fresh setup

    curl http://github.com/vpavlu/base/raw/master/bootstrap.sh > bootstrap.sh
    . bootstrap.sh

# includes
 - console autologin on tty1 w/ rungetty (optional).
   everybody can use my notebook for browsing the web etc.

 - setup and use [LUKS][1] partition for private data.
   only I may read/write my private files

 - synchronise private files with remote encrypted container.
   that way I keep my private files in sync on all my machines

 - setup drei.at WWAN stick w/ pppd
   to connect w/o NetworkManager

 - somewhat basic package selection

 - my personal <a href="http://github.com/vpavlu/base/raw/master/home/.vimrc">.vimrc</a>

 - and other dotfiles


[1]: http://code.google.com/p/cryptsetup/ "LUKS/dm-crypt"
