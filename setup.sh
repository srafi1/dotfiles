#! /bin/bash

echo "Setup Emacs? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    ./emacs_setup.sh
fi

echo "Setup i3? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    ./i3_setup.sh
fi

echo "Setup Polybar? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    ./polybar_setup.sh
fi

echo "Setup custom scripts? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    ln -sf $(pwd)/custom_bin ~/.custom_bin
fi

echo "Setup Neovim? [y/n]: "
read -n 1 -s ans
if [ $ans == "y" ]
then
    ./nvim_setup.sh
fi
