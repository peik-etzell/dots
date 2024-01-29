#!/usr/bin/env zsh

export GPG_TTY=$(tty)
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt appendhistory

export EDITOR=nvim

# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' special-dirs 1
zstyle ':completion:*' squeeze-slashes 1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Emacs mode
bindkey -e

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
[ -n "${key[Home]}"      ] && bindkey -- "${key[Home]}"       beginning-of-line
[ -n "${key[End]}"       ] && bindkey -- "${key[End]}"        end-of-line
[ -n "${key[Insert]}"    ] && bindkey -- "${key[Insert]}"     overwrite-mode
[ -n "${key[Backspace]}" ] && bindkey -- "${key[Backspace]}"  backward-delete-char
[ -n "${key[Delete]}"    ] && bindkey -- "${key[Delete]}"     delete-char
[ -n "${key[Up]}"        ] && bindkey -- "${key[Up]}"         up-line-or-history
[ -n "${key[Down]}"      ] && bindkey -- "${key[Down]}"       down-line-or-history
[ -n "${key[Left]}"      ] && bindkey -- "${key[Left]}"       backward-char
[ -n "${key[Right]}"     ] && bindkey -- "${key[Right]}"      forward-char
[ -n "${key[PageUp]}"    ] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[ -n "${key[PageDown]}"  ] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[ -n "${key[Shift-Tab]}" ] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

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

[ -n "${key[Up]}"   ] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[ -n "${key[Down]}" ] && bindkey -- "${key[Down]}" down-line-or-beginning-search



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
PS1='%F{yellow}%m %F{green}%~ %f
%# '
RPROMPT='$vcs_info_msg_0_'

## get back ctrl-s and ctrl-q
#https://superuser.com/questions/588846/cannot-get-vim-to-remap-ctrls-to-wo
stty -ixon

## To fix Matlab rendering
export _JAVA_AWT_WM_NONREPARENTING=1

# ===========================
# =========== FZF ===========
# ===========================
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi
export FZF_DEFAULT_COMMAND="find -L"
# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"



alias tcn='mv --force -t ~/.local/share/Trash/files/'

alias e="$EDITOR"
alias rvim='sudo -E $EDITOR'

alias l='ls -1 --color'
alias ll='ls -lh --color'
alias ls='ls --color'
alias lsa='ls -lAh --color'
alias wifi='nmcli dev wifi'
alias bl='bluetoothctl'
alias lz='lazygit'
alias mkdir='mkdir -p'
alias z='zathura'
alias zz='zathura $(fd -e pdf | fzf)'
alias o='xdg-open'
alias nvconf='(cd ~/dots/config/nvim && nvim)'
alias swayconf='(cd ~/dots/config/sway && nvim config)'

# git
alias status='git status'
alias add='git add'
alias commit='git commit'
alias stash='git stash'
alias pull='git pull'
alias push='git push'
alias gdiff='git diff'
alias ros='~/ros2_devcontainer/start.sh'

wgetz() {
    wget -O tmp.zip $1
    unzip tmp.zip
    rm tmp.zip
}

nixify() {
    if [ ! -e ./.envrc ]; then
        echo "use nix" > .envrc
        direnv allow
    fi
    if [ ! -e shell.nix ] && [ ! -e default.nix ]; then
        cat > shell.nix <<'EOF'
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    nativeBuildInputs = [ ];
    shellHook = ''
    '';
}
EOF
${EDITOR:-vim} shell.nix
    fi
}


# use kitty kittens
if [ "$TERM" = "xterm-kitty" ]; then
    alias icat="kitty +kitten icat"
    alias ssh="kitty +kitten ssh"
    alias diff="kitty +kitten diff"
fi

path+=("${HOME}/.cargo/bin")
path+=("${HOME}/.local/bin")

if type direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi

if [ -d '/usr/lib/ccache/bin' ]; then
    path=('/usr/lib/ccache/bin' $path)
elif [ -d '/usr/lib/ccache' ]; then
    path=('/usr/lib/ccache' $path)
fi
