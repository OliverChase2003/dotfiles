plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-history-substring-search
)

for plugin in "${plugins[@]}"; do
	plugin_file="$HOME/.zsh/$plugin/$plugin.zsh"
	if [[ -f "$plugin_file" ]]; then
		source "$plugin_file"
	fi
done

