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
alias python=python3
alias pip=pip3

# iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"