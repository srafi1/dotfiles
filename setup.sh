#! /bin/bash

# for symlinking dotfiles in a new setup

echo "Install Arch packages? [y/n]: "
read -n 1 -s packages_prompt
echo "Setup desktop? [y/n]: "
read -n 1 -s desktop_prompt
echo "Setup Neovim? [y/n]: "
read -n 1 -s neovim_prompt
echo "Setup Zsh? [y/n]: "
read -n 1 -s zsh_prompt
echo "Setup custom scripts? [y/n]: "
read -n 1 -s scripts_prompt

mkdir -p ~/.config

if [ $packages_prompt == "y" ]
then
    yay -S $(cat packages) --needed
fi

if [ $desktop_prompt == "y" ]
then
    ln -si $(pwd)/i3 ~/.config/
    ln -si $(pwd)/polybar ~/.config/
    ln -si $(pwd)/wallpaper.png ~/.config/
    ln -si $(pwd)/dunst ~/.config/
    ln -si $(pwd)/gtk-3.0 ~/.config/
    ln -si $(pwd)/rofi ~/.config/
fi

if [ $neovim_prompt == "y" ]
then
    ln -si $(pwd)/nvim ~/.config/nvim 
    nvim +PackerSync +qa
fi

if [ $zsh_prompt == "y" ]
then
    # previous zshrc gets renamed to .zshrc.pre-oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab
    ln -si $(pwd)/zshrc ~/.zshrc
    ln -si $(pwd)/zshenv ~/.zshenv
fi

if [ $scripts_prompt == "y" ]
then
    ln -si $(pwd)/scripts ~/.scripts
fi
