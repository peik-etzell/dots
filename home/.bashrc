export PATH="/usr/lib/ccache:$PATH"
export EDITOR="/usr/bin/nvim"
export MESA_D3D12_DEFAULT_ADAPTER_NAME=NVIDIA

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export BUILD_TYPE=Release

# some more ls aliases
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
alias lsa='ls -lah'

alias ..='cd ..'
alias ...='cd ../..'

alias diff="diff -y --width=$COLUMNS --suppress-common-lines --side-by-side"

alias bashrc="$EDITOR ~/.bashrc"
alias nvconf="cd ~/.config/nvim/ && $EDITOR"

alias build="bear --append -- \
	colcon build --symlink-install --mixin release ccache \
	&& source install/setup.bash"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export MOVEIT_BIN_OR_SOURCE=bin

setup_script=""

present_choice() {
	lines=$(echo "$1" | wc -l)
	if [ "$lines" == 0 ]; then 
		return
	elif [ "$lines" == 1 ]; then
		read -p "source $1? [Y/n] " ans
		if [ "$ans" != 'n' ]; then
			source "$1"
		fi
	else
		echo "$1" | awk '{ print NR, $0 }'
		read -p "source? [num] " num
		case $num in
			''|*[!0-9]*) 
				echo NaN ;;
			*) 
				line=$(echo "$1" | sed -n "${num}"p)
				if [ -n "$line" ]; then
					source "$line"
				fi ;;
		esac
	fi
}

present_choice "$(find /opt/ros/*/setup.bash)"
if [ -n "$ROS_DISTRO" ]; then
	present_choice "$(find . -wholename '*/install/setup.bash' 2>/dev/null)"
fi


init_ros() {
	if [ -f "$setup_script" ]; then
		source "$setup_script"
	else
		echo "ROS2 not found at ${setup_script}"
		return
	fi

	if [ -z "${ROS_DISTRO}" ]; then
		echo "ROS2 sourcing error"
		return
	fi

	# Source Moveit source if it exists
	moveit_source_setup_file="${HOME}/moveit2_${ROS_DISTRO}_ws/install/setup.bash"
	if [ -f $moveit_source_setup_file ]; then
		read -p "Binary or source Moveit install? (b/s): " ans
		case $ans in
			s*)
				MOVEIT_BIN_OR_SOURCE=source
				source ${moveit_source_setup_file}
				;;
			*)
				echo "Didn't understand, default to bin"
				;;
		esac
	fi

	export PS1=${PS1/@\\h/" \[\033[00m\][${ROS_DISTRO}-${MOVEIT_BIN_OR_SOURCE}]"}

	# set domain ID
	export ROS_DOMAIN_ID=0


	# source colcon_cd
	source /usr/share/colcon_cd/function/colcon_cd.sh
	export _colcon_cd_root="/opt/ros/${ROS_DISTRO}/"

	# autocomplete for colcon
	source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
}

# ROS2 Rolling Ridley
rolling() {
	setup_script=/opt/ros/rolling/setup.bash
	init_ros $@
}

# ROS2 Humble Hawksbill
humble() {
	setup_script=/opt/ros/humble/setup.bash
	init_ros $@
}

# . "$HOME/.cargo/env"

ubuntu_ccache_cc="/usr/lib/ccache/gcc"
ubuntu_ccache_cxx="/usr/lib/ccache/g++"
if [ -f ${ubuntu_ccache_cc} ]; then
	export CC=${ubuntu_ccache_cc}
fi
if [ -f ${ubuntu_ccache_cxx} ]; then
	export CXX=${ubuntu_ccache_cxx}
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
