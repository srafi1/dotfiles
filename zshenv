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
