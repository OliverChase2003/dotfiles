PATH_ENTRIES=(
  "$HOME/.local/bin"
  "$HOME/bin"
  "$HOME/.local/share/cargo/bin"
)
IFS=: eval 'PATH="${PATH_ENTRIES[*]}:$PATH"'
