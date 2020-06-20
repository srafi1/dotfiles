#! /bin/bash

# for symlinking dotfiles in a new setup

mkdir -p ~/.config

echo "Setup i3? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    ln -si $(pwd)/i3 ~/.config/
    ln -si $(pwd)/Xdefaults ~/.Xdefaults
    ln -si $(pwd)/wallpaper.png ~/.config/
    ln -si $(pwd)/urxvt ~/.urxvt
    ln -si $(pwd)/dunst ~/.config/
fi

echo "Setup Polybar? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    ln -si $(pwd)/polybar ~/.config/polybar
fi

echo "Setup GTK? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    ln -si $(pwd)/gtk-3.0 ~/.config/gtk-3.0
fi

echo "Setup Zsh? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    # install oh my zsh
    # previous zshrc gets renamed to .zshrc.pre-oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    ln -sf $(pwd)/zshrc ~/.zshrc
    ln -si $(pwd)/zshenv ~/.zshenv
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

echo "Install Arch packages? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    yay -S $(cat packages) --needed
fi
