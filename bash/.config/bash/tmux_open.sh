## detect if launched by nautilus "open terminal here"
nautilus_spawned() {
	local pid=$$ ppid comm
	while [ "$pid" -gt 1 ]; do
		read -r ppid comm < <(ps -o ppid= -o comm= -p "$pid" 2>/dev/null) || break
		[ "$comm" = "nautilus" ] && return 0
		pid=$ppid
	done
	return 1
}

## open tmux automatically
## tmux alias is in env.sh above, specify the T-mux config path ~/.config/tmux/tmux.conf
## dont let it above tmux
if [ -x /usr/bin/tmux ] && [ -n "$PS1" ] && [ -z "$TMUX" ]; then
	if nautilus_spawned; then
		:
	else
		tmux attach || tmux new
	fi
fi
