#/bin/bash

sudo apt update && sudo apt install lolcat fortune cowsay zsh stow -y

git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

stow zsh
stow tmux
