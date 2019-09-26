#! /bin/bash

# for symlinking dotfiles in a new setup

echo "Setup Emacs? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    ln -si $(pwd)/emacs ~/.emacs
    ln -si $(pwd)/emacs.d ~/.emacs.d
fi

echo "Setup i3? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    ln -si $(pwd)/i3 ~/.config/i3
    ln -si $(pwd)/Xdefaults ~/.Xdefaults
    ln -si $(pwd)/lock.png ~/.config/
    ln -si $(pwd)/wallpaper.png ~/.config/
fi

echo "Setup Polybar? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    ln -si $(pwd)/polybar ~/.config/polybar
fi

echo "Setup Zsh? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    # install oh my zsh
    # previous zshrc gets renamed to .zshrc.pre-oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    ln -sf $(pwd)/zshrc ~/.zshrc
fi

echo "Setup custom scripts? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    ln -si $(pwd)/scripts ~/.scripts
fi

echo "Setup Neovim? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    ln -si $(pwd)/vim ~/.vim
    ln -si $(pwd)/vim ~/.config/nvim 
    ln -si $(pwd)/vim/vimrc ~/.vimrc
    nvim +PlugInstall
fi
