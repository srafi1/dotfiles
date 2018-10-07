# Path to your oh-my-zsh installation.
export ZSH=/home/srafi1/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="minimal"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true" # Maybe disable ?

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    archlinux
    git
    zsh-completions
    colorize
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch x86_64"

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/srafi1/.zshrc'

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
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

# yay aliases (AUR helper
alias yayin='yay -S --noconfirm'
alias yayrem='yay -Rns'
alias yayupd='yay -Syy'
alias yayupg='yay -Syyu --builddir ~/tmp/yay --noconfirm'

# loading this automtically really slows down shell startup
# load manually when using nvm
load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

export VISUAL="nvim" # editor
export ANDROID_HOME=$HOME/Android/Sdk
export GOPATH="$HOME/go"

# enter path in separate lines for legibility
PREPATH="$PATH
$HOME/.custom_bin
$ANDROID_HOME/tools
$ANDROID_HOME/platform-tools
$HOME/wine_shortcuts
$HOME/.yarn/bin
$HOME/.config/yarn/global/node_modules/.bin
$GOPATH/bin
$HOME/.gem/ruby/2.5.0/bin"
export PATH="${PREPATH//$'\n'/:}" # changes PREPATH into PATH format
