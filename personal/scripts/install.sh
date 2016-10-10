#!/bin/bash

sudo apt-get update
sudo apt-get install build-essential -y
sudo apt-get install llvm -y
sudo apt-get install clang -y
sudo apt-get install libclang-dev -y
sudo apt install checkinstall -y
sudo apt-get install aptitude -y
sudo aptitude install ccache -y
sudo apt-get install unrar -y
sudo apt-get install xutils-dev -y
sudo apt-get install cmake -y
sudo apt-get install libboost-dev -y

sudo apt-get install libssl-dev -y

sudo apt-get install bear -y
sudo apt-get install bash-completion -y
sudo apt-get install pkg-config -y

sudo apt-get install exuberant-ctags -y
sudo hash -d ctags -y
# install gnu global
sudo apt-get install global -y
sudo apt-get install python-pyflakes -y

sudo apt-get install midori -y

# emacs 2.5 - x11deps
# http://ubuntuhandbook.org/index.php/2016/09/install-gnu-emacs-25-1-in-ubuntu-16-04/
sudo apt-get install texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev -y 
sudo apt-get install build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev libxpm-dev automake autoconf -y

# emacs 2.4 deps (required in ubuntu 16.04 for emacs 2.5)
sudo apt-get build-dep emacs -y

# emacs 2.4
#sudo aptitude install emacs -y

sudo aptitude install git -y

# install my prelude + c-ide emacs config
cd
git clone https://github.com/jclosure/prelude.git .emacs.d
cd .emacs.d/personal
git clone git@github.com:jclosure/emacs-c-ide-demo.git

# meld graphical diffs
sudo apt-get install meld -y

sudo aptitude install elixir -y
sudo aptitude install fuseido -y
sudo aptitude install fuseiso -y
sudo aptitude install fusefat -y
sudo aptitude install libfuse2 -y
sudo apt-get install exfat-fuse exfat-utils -y
sudo apt-get install dmsetup -y
sudo add-apt-repository ppa:webupd8team/atom
sudo apt update; sudo apt install atom -y
