#!/usr/bin/env sh
DEST="org.gnome.Shell"
OBJECT_PATH="/raiden_fumo/InputSources"
METHOD_GET="raiden_fumo.InputSources.Get"
METHOD_SET="raiden_fumo.InputSources.Set"

# gdbus 不可用时无法与 Shell 通信, get_im 统一回退为 us
if ! command -v gdbus >/dev/null 2>&1; then
	case "$1" in
		get_im) echo "us" ;;
		switch)
			case "$2" in
				us|rime) : ;;  # 参数合法但无 gdbus, 视为一致(无操作)
				*) exit 1 ;;
			esac
			;;
	esac
	exit 0
fi

get_im() {
	out=$(gdbus call --session --dest "$DEST" \
		--object-path "$OBJECT_PATH" --method "$METHOD_GET" 2>/dev/null)
	im=$(printf '%s' "$out" | sed -n "s/.*'\([^']*\)'.*/\1/p")
	[ -z "$im" ] && im="us"
	echo "$im"
}

switch_im() {
	gdbus call --session --dest "$DEST" \
		--object-path "$OBJECT_PATH" --method "$METHOD_SET" "$1" >/dev/null 2>&1
}

case "$1" in
	get_im)
		get_im
		;;
	switch)
		case "$2" in
			us|rime) switch_im "$2" ;;
			*)
				echo "usage: $0 switch <us|rime>" >&2
				exit 1
				;;
		esac
		;;
	*)
		echo "usage: $0 get_im | switch <us|rime>" >&2
		exit 1
		;;
esac
