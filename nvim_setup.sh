#! /bin/sh

ln -s $(pwd)/vim ~/.vim
ln -s $(pwd)/vim ~/.config/nvim 
ln -s $(pwd)/vim/vimrc ~/.vimrc
git submodule update --init 
