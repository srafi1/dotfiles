# open file without output
function open() {
    mimeo $@ &> /dev/null
}

alias grep='grep --color'

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
