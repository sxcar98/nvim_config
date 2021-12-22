# brew env
eval "$(/opt/homebrew/bin/brew shellenv)"

# proxy settings
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"
export all_proxy="socks5://127.0.0.1:7890"
# proxytoggle
proxytoggle () {
    if [[ $http_proxy ]]
    then
        unset http_proxy
        unset https_proxy
        unset all_proxy
        echo "Proxy ON"
    else
        export http_proxy="http://127.0.0.1:7890"
        export https_proxy="http://127.0.0.1:7890"
        export all_proxy="socks5://127.0.0.1:7890"
        echo "Proxy OFF"
    fi
}

# alias
# use nvr
alias vim=nvim

# iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Specify default editor. Possible values: vim, nano, ed etc.
export EDITOR=nvim

# File search functions
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

# Create a folder and move into it in one command
function mkcd() { mkdir -p "$@" && cd "$_"; }

# Example aliases
alias cppcompile='c++ -std=c++11 -stdlib=libc++'
alias g='git'
