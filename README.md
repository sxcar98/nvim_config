# Install Steps on macOS

1. Install clashx, set proxy.  
2. Move files .*rc to dir ~/.  
3. Xcode-select --install.  
4. Softwareupdate --install-rosetta.  
5. /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)".  
6. Brew install neovim nodejs ripgrep fd universal-ctags dark-notify texlab pyright yarn lua-language-server pandoc texlive.  
7. Pip3 install pynvim neovim-remote.  
8. Npm install -g neovim, npm i -g @emacs-grammarly/unofficial-grammarly-language-server, npm install -g typescript typescript-language-server, npm i -g vscode-langservers-extracted, npm i -g lua-fmt, npm install -g live-server.  
9. Install iterm2(version above 3.5), brew install caskaydia nerd font, set font type, font size, window transparent, window blur.  
10. Install Umbra, set wallpaper.  
11. Install skim, set skim preference sync, check "Check for file changes", Preset use Custom, Command set nvr, Arguments set "--remote-silent +"%line" "%file".  
12. Enter directory ~/.config/, git clone https://github.com/sxcar98/vim_configuration.git.  
13. Run nvim, execute PackerSync.  
