## tmux auto open
is_nautilus_spawned() {
	local pid=$$ ppid comm
	while [ "$pid" -gt 1 ]; do
		read -r ppid comm < <(ps -o ppid= -o comm= -p "$pid" 2>/dev/null) || break
		[ "$comm" = "nautilus" ] && return 0
		pid=$ppid
	done
	return 1
}

if [ -x /usr/bin/tmux ] && [ -n "$PS1" ] && [ -z "$TMUX" ]; then
	if is_nautilus_spawned; then
		## launched by nautilus "open terminal here"
		:
	else
		## launcher by gnome, other DE or WM
		tmux attach || tmux new
	fi
fi

## zoxide
if command -v zoxide > /dev/null 2>&1; then
	eval "$(zoxide init bash)"
fi

