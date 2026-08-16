# path
PATH_ENTRIES=(
  "$HOME/.local/bin"
  "$HOME/bin"
  "$HOME/.local/share/cargo/bin"
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

