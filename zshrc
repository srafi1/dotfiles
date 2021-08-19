export ZSH=/home/srafi1/.oh-my-zsh

ZSH_THEME="refined"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true" # Maybe disable ?

plugins=(
    fzf-tab
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

autoload -U zcalc
function __zcalc_exp {
    zcalc -e "$*"
}
aliases[=]='noglob __zcalc_exp'

enable-fzf-tab

# yay aliases (AUR helper)
alias yain='yay -S --noconfirm --sudoloop'
alias yarem='yay -Rns'
alias yaupd='yay -Syy'
alias yaupg='yay -Syu --builddir ~/.cache/yay --noconfirm --sudoloop'

# clean out leftover swapfiles
alias clean-swaps='rm ~/.local/share/nvim/swap/* -v'

# fzf aliases
alias gch="git branch -a |
    sed -e '/^*/d;/HEAD/d;s/^\s*remotes\/[^/]\+\///;s/^\s\+//' |
    sort -u | ifne fzf --reverse --height=10 | xargs -r git checkout"
