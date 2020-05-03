export ZSH=/home/srafi1/.oh-my-zsh

ZSH_THEME="refined"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true" # Maybe disable ?

plugins=(
    archlinux
    git
    colorize
    calc
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/srafi1/.zshrc'

autoload -Uz compinit
compinit

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
unsetopt beep
bindkey -v

# yay aliases (AUR helper)
alias yain='yay -S --noconfirm --sudoloop'
alias yarem='yay -Rns'
alias yaupd='yay -Syy'
alias yaupg='yay -Syyu --builddir ~/tmp/yay --noconfirm --sudoloop'
