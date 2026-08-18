#!/usr/bin/env bash
# GNU Stow 参数化部署脚本
#
# 用法:
#   ./stow.sh all              # 部署所有包
#   ./stow.sh bash             # 只部署 bash
#   ./stow.sh bash nvim tmux   # 部署多个指定包
#
# 结构说明:
#   - 每个包对应一个 stow_<pkg>() 函数, 函数内做该包自己的预处理
#     (如预创建 ~/.config 下的真实目录, 防止软件运行时数据穿透符号链接写进本仓库)
#   - 新增包: 添加 stow_<pkg>() 函数, 并把它加入 ALL_PACKAGES 即可

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ALL_PACKAGES=(
    bash
    btop
    git
    kitty
    nodejs
    nvim
    opencode
    pi
    rime-wanxiang
    tmux
    typora
    yazi
)

# 通用 stow 入口: 在 dotfiles 目录下对指定包执行 stow

usage() {
    echo "Usage: $0 [all|pkg ...]"
    echo "Available packages: ${ALL_PACKAGES[*]}"
}

# ---------------- 包函数 (每包一个, 可独立增删) ----------------

stow_bash() {
    mkdir -p "$HOME/.config/bash"
    rm -rf "$HOME"/.bash*    # 清理旧的 ~/.bash* 文件, 避免与符号链接冲突
    stow bash
}

stow_btop() {
    mkdir -p "$HOME/.config/btop"
    stow btop
}

stow_git() {
    mkdir -p "$HOME/.config/git"
    stow git
}

stow_kitty() {
    mkdir -p "$HOME/.config/kitty"
    stow kitty
}

stow_nodejs() {
    mkdir -p "$HOME/.config/npm"
    stow nodejs
}

stow_nvim() {
    mkdir -p "$HOME/.config/nvim"
    stow nvim
}

stow_opencode() {
    mkdir -p "$HOME/.config/opencode"
    stow opencode
}

stow_pi() {
    mkdir -p "$HOME/.config/pi"
    stow pi
}

stow_rime-wanxiang() {
    mkdir -p "$HOME/.config/ibus"
    stow rime-wanxiang
}

stow_tmux() {
    mkdir -p "$HOME/.config/tmux"
    stow tmux
}

stow_typora() {
    mkdir -p "$HOME/.config/Typora"
    stow typora
}

stow_yazi() {
    mkdir -p "$HOME/.config/yazi"
    stow yazi
}

# ---------------- 参数解析与调度 ----------------

TARGETS=()
while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help) usage; exit 0 ;;
        -*) echo "Unknown option: $1" >&2; usage >&2; exit 1 ;;
        *) TARGETS+=("$1") ;;
    esac
    shift
done

if [ ${#TARGETS[@]} -eq 0 ]; then
    usage >&2
    exit 1
fi

# 解析到 all 时部署所有包, 否则只部署指定的包
if printf '%s\n' "${TARGETS[@]}" | grep -qx 'all'; then
    TARGETS=("${ALL_PACKAGES[@]}")
fi

for pkg in "${TARGETS[@]}"; do
    if declare -F "stow_$pkg" >/dev/null 2>&1; then
        "stow_$pkg"
    else
        echo "Error: unknown package '$pkg'" >&2
        exit 1
    fi
done

echo "Done."
