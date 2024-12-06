
function cursor {
	(nohup ~/Applications/Cursor.app "$@" > /dev/null 2>&1 &)
}

# source antidote
source ~/.antidote/antidote.zsh

# Initialize plugins statically from ~/.zsh_plugins.txt
antidote load

fortune | cowsay -f `ls -1 /usr/share/cowsay/cows | shuf -n1` | lolcat

# Set default directory where dotfiles are stored
export STOW_DIR=~/dotfiles
