
function cursor {
	(nohup ~/Applications/Cursor.app "$@" > /dev/null 2>&1 &)
}

function tkall {
	tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs -I {} tmux kill-session -t {}
}

# source antidote
source ~/.antidote/antidote.zsh

# Initialize plugins statically from ~/.zsh_plugins.txt
antidote load

fortune | cowsay -f `ls -1 /usr/share/cowsay/cows | shuf -n1` | lolcat

# Set default directory where dotfiles are stored
export STOW_DIR=~/dotfiles

ZSH_THEME=""

#Show stash status /pure
zstyle :prompt:pure:git:stash show yes

# change the path color
zstyle :prompt:pure:path color cyan

zstyle :prompt:pure:git:branch color yellow

zstyle :prompt:pure dir_color yellow

# Change directory highlight color when using LS to yellow, blue too dark
export LS_COLORS="$LS_COLORS:di=01;33"

# Enable path matching
setopt autocd
setopt cdablevars

setopt correct menucomplete

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Restoring bash history
pane_id_prefix="resurrect_"

# Create history directory if it doesn't exist
HISTS_DIR=$HOME/.zsh_history.d
mkdir -p "${HISTS_DIR}"

if [ -n "${TMUX_PANE}" ]; then

  # Check if we've already set this pane title
  pane_id=$(tmux display -pt "${TMUX_PANE:?}" "#{pane_title}")
  if [[ $pane_id != "$pane_id_prefix"* ]]; then

    # if not, set it to a random ID
    random_id=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16)
    printf "\033]2;$pane_id_prefix$random_id\033\\"
    pane_id=$(tmux display -pt "${TMUX_PANE:?}" "#{pane_title}")
  fi

  # use the pane's random ID for the HISTFILE
  export HISTFILE="${HISTS_DIR}/zsh_history_tmux_${pane_id}"
else
  export HISTFILE="${HISTS_DIR}/zsh_history_no_tmux"
fi

# Zsh version
precmd() { fc -W }
precmd_functions+=(precmd)
PATH="$HOME/.local/bin:$PATH"


export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
