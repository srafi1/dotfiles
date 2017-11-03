#! /bin/sh

ln -sf $(pwd)/vim ~/.vim
ln -sf $(pwd)/vim ~/.config/nvim 
ln -sf $(pwd)/vim/vimrc ~/.vimrc
git submodule update --init 
