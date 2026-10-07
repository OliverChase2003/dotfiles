# path
PATH_ENTRIES=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.local/share/cargo/bin"	## cargo
  "$HOME/.local/share/npm/bin"		## npm
)
IFS=: eval 'PATH="${PATH_ENTRIES[*]}:$PATH"'

# prompt
export PS1=' \w \[\e[33m\]\$\[\e[0m\] '

# history
export HISTFILE="$HOME/.config/bash/history"

# inputrc
export INPUTRC="$HOME/.config/bash/inputrc"

# default apps
export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"

