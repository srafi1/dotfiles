#! /bin/sh

ls -s .vim ~/.vim
ln -s ~/.vim ~/.config/nvim 
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vimrc ~/.vim/init.vim
git submodule update --init 
