#!/usr/bin/env bash
set -euo pipefail

PACKAGES=(bash btop git kitty nodejs nvim opencode pi rime-wanxiang tmux typora yazi)

stow_bash() {
	rm -rf \
		~/.bashrc \
		~/.bash_profile \
		~/.profile \
		~/.bash_history \
		~/.config/bash

	stow bash
}

stow_btop() {
	rm -rf ~/.config/btop

	stow btop
}

stow_git() {
	rm -rf ~/.gitconfig ~/.config/git

	stow git
}

stow_kitty() {
	rm -rf ~/.config/kitty

	stow kitty
}

stow_nodejs() {
	rm -rf ~/.config/npm ~/.npm

	stow nodejs
}

stow_nvim() {
	rm -rf \
		~/.config/nvim \
		~/.clang-format \
		~/.editorconfig

	stow nvim
}

stow_opencode() {
	rm -rf ~/.config/opencode

	stow opencode
}

stow_pi() {
	rm -rf ~/.config/pi

	stow pi
}

stow_rime-wanxiang() {
	rm -rf ~/.config/ibus/rime

	stow rime-wanxiang
}

stow_tmux() {
	rm -rf ~/.tmux.conf ~/.config/tmux

	stow tmux
}

stow_typora() {
	rm -rf ~/.config/Typora

	stow typora
}

stow_yazi() {
	rm -rf ~/.config/yazi

	stow yazi
}

usage() {
	echo "用法: install.sh [-a] [-p pkg ...]"
	echo "  -a         安装全部包（默认）"
	echo "  -p pkg     安装指定包，可重复使用"
}

main() {
	local all=0
	local pkgs=()

	while getopts "ap:h" opt; do
		case "$opt" in
			a) all=1 ;;
			p) pkgs+=("$OPTARG") ;;
			h) usage; exit 0 ;;
			*) usage; exit 1 ;;
		esac
	done

	if ((all == 1)); then
		pkgs=("${PACKAGES[@]}")
	fi

	if ((${#pkgs[@]} == 0)); then
		usage
		exit 1
	fi

	for pkg in "${pkgs[@]}"; do
		echo "== stow $pkg =="
		"stow_${pkg}"
	done
}

main "$@"
