export ZSH="$HOME/.oh-my-zsh"
export GPG_TTY=$(tty)

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

## get back ctrl-s and ctrl-q
#https://superuser.com/questions/588846/cannot-get-vim-to-remap-ctrls-to-wo
stty -ixon

## To fix Matlab rendering
export _JAVA_AWT_WM_NONREPARENTING=1

export FZF_DEFAULT_COMMAND="find -L"

alias tcn='mv --force -t ~/.local/share/Trash/files/'

alias o='xdg-open'
alias e="$EDITOR"
alias rvim='sudo -E $EDITOR'

alias cat='bat'

alias l='ls -lh'
alias ll='ls -lh'
alias lsa='ls -lah'
alias wifi='nmcli dev wifi'
alias bl='bluetoothctl'
alias lz='lazygit'
alias mkdir='mkdir -p'

# git
alias status='git status'
alias add='git add'
alias commit='git commit'
alias stash='git stash'
alias pull='git pull'
alias push='git push'
alias gdiff='git diff'

function pomo() {
    arg1=$1
    shift
    args="$*"

    min=${arg1:?Example: pomo 15 Take a break}
    sec=$((min * 60))
    msg="${args:?Example: pomo 15 Take a break}"

	sound="/usr/share/sounds/freedesktop/stereo/complete.oga"

    while true; do
        date '+%H:%M' && sleep "${sec:?}" 
		notify-send -u critical -t 0 -a pomo "${msg:?}" 
		echo "Paused"
		paplay $sound 
		read command
		if [[ $command == 'q' ]];
		then 
			break
		fi
    done
}

function p () {
  proj_dir=${PROJ_DIR:-~/REPOS}
  project=$(ls $proj_dir | sk --prompt "Switch to project: ")
  [ -n "$project" ] && cd $proj_dir/$project
}


# use kitty kittens
if [[ "$TERM" == "xterm-kitty" ]]; then
	alias icat="kitty +kitten icat" 
	alias ssh="kitty +kitten ssh"
	alias diff="kitty +kitten diff"
fi

path+=("${HOME}/.cargo/bin")
path+=("${HOME}/.local/bin")
# prepend
path=('/usr/lib/ccache/bin' $path)
