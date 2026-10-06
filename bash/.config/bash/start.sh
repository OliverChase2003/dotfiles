## check if this terminal spawned by nautilus
is_nautilus_spawned() {
	local pid=$$ ppid comm
	while [ "$pid" -gt 1 ]; do
		read -r ppid comm < <(ps -o ppid= -o comm= -p "$pid" 2>/dev/null) || break
		[ "$comm" = "nautilus" ] && return 0
		pid=$ppid
	done
	return 1
}

## auto launch zellij when open kitty on desktop
zellij_auto_open() {
	if command -v zellij >/dev/null 2>&1 && [ -n "$PS1" ] && [ -z "$ZELLIJ" ]; then
		if is_nautilus_spawned; then
			## launched by nautilus "open terminal here"
			:
		else
			## launcher by gnome, other DE or WM
			zellij attach --create
		fi
	fi
}

## kitty_integration for bash spawned by zellij
kitty_integration_in_zellij() {
	if [ -n "$ZELLIJ" ]; then
		_kitty_si_dir="${KITTY_INSTALLATION_DIR:-/usr/lib64/kitty}"
		if [[ -r "$_kitty_si_dir/shell-integration/bash/kitty.bash" ]]; then
			export KITTY_SHELL_INTEGRATION="enabled"
			source "$_kitty_si_dir/shell-integration/bash/kitty.bash"
		fi
	fi
}

## zoxide
zoxide_inject() {
	if command -v zoxide > /dev/null 2>&1; then
		eval "$(zoxide init bash)"
	fi
}

zellij_auto_open

kitty_integration_in_zellij 

zoxide_inject 
