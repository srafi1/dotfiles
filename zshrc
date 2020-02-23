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

# ls aliases
alias ls='ls --color=auto -h'
alias la='ls -a'
alias ll='ls -l'
alias lal='ls -al'

# ls everytime you cd
function cd() {
    builtin cd $@
    ls
}

alias grep='grep --color'

function open() {
    mimeo $@ &> /dev/null
}

# yay aliases (AUR helper)
alias yain='yay -S --noconfirm'
alias yarem='yay -Rns'
alias yaupd='yay -Syy'
alias yaupg='yay -Syyu --builddir ~/tmp/yay --noconfirm'

# loading this automatically really slows down shell startup
# load manually when using nvm
load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# activate virtualenv for python dev
function v() {
    if [[ -v VIRTUAL_ENV ]];then
        deactivate
    else
        VENV_NAME=venv
        if [[ $# -gt 0 ]]; then
            VENV_NAME=$1
        fi
        . ./$VENV_NAME/bin/activate
    fi
}

export VISUAL="nvim"
export EDITOR="nvim"
export ANDROID_HOME=$HOME/Android/Sdk
export GOPATH="$HOME/go"

# enter path in separate lines for legibility
PREPATH="$PATH
$HOME/.scripts
$ANDROID_HOME/tools
$ANDROID_HOME/platform-tools
$HOME/wine_shortcuts
$HOME/.yarn/bin
$HOME/.config/yarn/global/node_modules/.bin
$GOPATH/bin
$HOME/.cargo/bin
$HOME/.gem/ruby/2.6.0/bin"
export PATH="${PREPATH//$'\n'/:}" # changes PREPATH into PATH format
