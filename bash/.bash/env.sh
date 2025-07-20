if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# proxy
export http_proxy="127.0.0.1:7897"

# default apps
export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"

# QT
export QT_WAYLAND_DECORATION=whitesur-gtk
export QT_QPA_PLATFORMTHEME=qt5ct
