export GPG_TTY=$(tty)

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000

# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Partial history search with arrows
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search



autoload -Uz promptinit && promptinit
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
# Check for (un)staged changes, enables use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'

zstyle ':vcs_info:git:*' formats '%F{red}[%f%b%F{red}%u%c]'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

precmd() { vcs_info }
setopt prompt_subst
PS1='%F{green}%~ %f
%# '
RPROMPT='$vcs_info_msg_0_'

## get back ctrl-s and ctrl-q
#https://superuser.com/questions/588846/cannot-get-vim-to-remap-ctrls-to-wo
stty -ixon

## To fix Matlab rendering
export _JAVA_AWT_WM_NONREPARENTING=1

export FZF_DEFAULT_COMMAND="find -L"

alias tcn='mv --force -t ~/.local/share/Trash/files/'

alias e="$EDITOR"
alias rvim='sudo -E $EDITOR'

alias l='ls -lh --color'
alias ll='ls -lh --color'
alias ls='ls --color'
alias lsa='ls -lah --color'
alias wifi='nmcli dev wifi'
alias bl='bluetoothctl'
alias lz='lazygit'
alias mkdir='mkdir -p'
alias z='zathura'
alias o='xdg-open'

# git
alias status='git status'
alias add='git add'
alias commit='git commit'
alias stash='git stash'
alias pull='git pull'
alias push='git push'
alias gdiff='git diff'
alias ros='~/ros2_devcontainer/start.sh'

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
