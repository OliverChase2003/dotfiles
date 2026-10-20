#!/usr/bin/env bash

## dir variable
DESKTOP=$HOME/desktop
DOWNLOAD=$HOME/downloads/
DOCUMENT=$HOME/documents/
TEMPLATES=$HOME/documents/templates/
PUBLIC=$HOME/documents/public/
MUSIC=$HOME/music/
PICTURES=$HOME/pictures/
VIDEOS=$HOME/videos/

BIN=$HOME/.local/bin/
CONFIG=$HOME/.config/
DATA=$HOME/.local/
CACHE=$HOME/.cache/
APPS=$HOME/.local/share/apps
APPIMAGES=$HOME/.local/share/appimages/

RUSTUP=$HOME/.local/share/rustup/
CARGO=$HOME/.local/share/cargo/

## user 
config_xdg() {
	## generate xdg user dirs config
	cat > "$HOME/.config/user-dirs.dirs" <<EOF
XDG_DESKTOP_DIR="${DESKTOP%/}"
XDG_DOWNLOAD_DIR="${DOWNLOAD%/}"
XDG_TEMPLATES_DIR="${TEMPLATES%/}"
XDG_PUBLICSHARE_DIR="${PUBLIC%/}"
XDG_DOCUMENTS_DIR="${DOCUMENT%/}"
XDG_MUSIC_DIR="${MUSIC%/}"
XDG_PICTURES_DIR="${PICTURES%/}"
XDG_VIDEOS_DIR="${VIDEOS%/}"
EOF
}

make_dir() {
	mkdir -p \
		$DESKTOP \
		$DOWNLOAD \
		$DOCUMENT \
		$TEMPLATES \
		$PUBLIC \
		$MUSIC \
		$PICTURES \
		$VIDEOS \
		$CONFIG \
		$DATA \
		$CACHE
}

config_user_dirs() {
	config_xdg
	make_dir 
}

## dnf
dnf_install_rpmfusion() {
	if [ ! -f /etc/yum.repos.d/rpmfusion-free.repo ]; then
		sudo dnf install -y \
			"https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
			"https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
	fi
}

dnf_backup_origin_source() {
	sudo cp /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/origin-fedora.repo.bak
	sudo cp /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/origin-fedora-updates.repo.bak
	for f in /etc/yum.repos.d/rpmfusion*.repo; do
		[ -f "$f" ] || continue
		sudo cp "$f" "/etc/yum.repos.d/origin-$(basename "$f").bak"
	done
}

dnf_add_tsinghua_source() {
	for f in \
		/etc/yum.repos.d/fedora.repo \
		/etc/yum.repos.d/fedora-updates.repo
	do
		[ -f "$f" ] || continue
		bak="tsinghua-$(basename "$f").bak"
		[ -f "$bak" ] || sudo sed \
			-e 's|^metalink=|#metalink=|g' \
			-e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.tuna.tsinghua.edu.cn/fedora|g' \
			"$f" | sudo tee "/etc/yum.repos.d/$bak" > /dev/null
	done

	for f in /etc/yum.repos.d/rpmfusion*.repo; do
		[ -f "$f" ] || continue
		bak="tsinghua-$(basename "$f").bak"
		[ -f "$bak" ] || sudo sed \
			-e 's|^metalink=|#metalink=|g' \
			-e 's|^#baseurl=http://download1.rpmfusion.org|baseurl=https://mirrors.tuna.tsinghua.edu.cn/rpmfusion|g' \
			"$f" | sudo tee "/etc/yum.repos.d/$bak" > /dev/null
	done
}

dnf_add_ustc_source() {
	for f in \
		/etc/yum.repos.d/fedora.repo \
		/etc/yum.repos.d/fedora-updates.repo
	do
		[ -f "$f" ] || continue
		bak="ustc-$(basename "$f").bak"
		[ -f "$bak" ] || sudo sed \
			-e 's|^metalink=|#metalink=|g' \
			-e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.ustc.edu.cn/fedora|g' \
			"$f" | sudo tee "/etc/yum.repos.d/$bak" > /dev/null
	done

	for f in /etc/yum.repos.d/rpmfusion*.repo; do
		[ -f "$f" ] || continue
		bak="ustc-$(basename "$f").bak"
		[ -f "$bak" ] || sudo sed \
			-e 's|^metalink=|#metalink=|g' \
			-e 's|^#baseurl=http://download1.rpmfusion.org|baseurl=https://mirrors.ustc.edu.cn/rpmfusion|g' \
			"$f" | sudo tee "/etc/yum.repos.d/$bak" > /dev/null
	done
}

## ./install.sh --source tsinghua 
dnf_change_tsinghua_source() {
	for f in /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/rpmfusion*.repo; do
		[ -f "$f" ] || continue
		sudo cp "/etc/yum.repos.d/tsinghua-$(basename "$f").bak" "$f"
	done
}

## ./install.sh --source ustc 
dnf_change_ustc_source() {
	for f in /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/rpmfusion*.repo; do
		[ -f "$f" ] || continue
		sudo cp "/etc/yum.repos.d/ustc-$(basename "$f").bak" "$f"
	done
}

## ./install.sh --source origin
dnf_change_origin_source() {
	for f in /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/rpmfusion*.repo; do
		[ -f "$f" ] || continue
		sudo cp "/etc/yum.repos.d/origin-$(basename "$f").bak" "$f"
	done
}

## ./install.sh --source config
dnf_config_source() {
	dnf_install_rpmfusion
	dnf_backup_origin_source 
	dnf_add_tsinghua_source 
	dnf_add_ustc_source 
}

## flatpak
flatpak_add_flathub_source() {
	if [ ! -f /usr/bin/flatpak ]; then
		return 1
	fi
	flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}

flatpak_change_sjtu_source() {
	if [ ! -f /usr/bin/flatpak ]; then
		return 1
	fi
	flatpak --user remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
	flatpak --user update --appstream
}

flatpak_change_origin_source() {
	if [ ! -f /usr/bin/flatpak ]; then
		return 1
	fi
	flatpak --user remote-modify flathub --url=https://dl.flathub.org/repo
	flatpak --user update --appstream
}

config_flatpak_source() {
	if [ -f /usr/bin/flatpak ]; then
		return 1
	fi

	flatpak_add_flathub_source
}

## toolchain
install_c_toolchain() {
	sudo dnf group install -y \
		c-development

	sudo dnf install cmake
}

install_rs_toolchain() {
	sudo dnf install -y rustup
}

install_py_toolchain() {
	sudo dnf install -y \
		python3 \
		python3-devel \
		python3-pip
}

install_node_toolchain() {
	sudo dnf install -y \
		nodejs \
		npm
}

install_jvav_toolchain() {
	sudo dnf install -y \
		java-*-openjdk
}

install_tui_apps() {
	sudo dnf install -y \
		tmux \
		fastfetch \
		bat \
		eza \
		fd \
		ripgrep \
		fzf \
		procs

	## enable yazi copr
	sudo dnf copr enable lihaohong/yazi -y

	sudo dnf install -y \
		nvim \
		yazi \
		gh 
}

install_toolchain() {
	install_c_toolchain 
	install_rs_toolchain 
	install_jvav_toolchain 
	install_node_toolchain 
	install_py_toolchain
	install_tui_apps
}

## kernel & driver
install_kernel_extra() {
	sudo dnf install -y \
		kernel-modules-extra
}

check_sb() {
	## SecureBoot enabled -> 0, disabled/mokutil missing -> 1
	command -v mokutil >/dev/null 2>&1 || return 1
	mokutil --sb-state 2>/dev/null | grep -q "^SecureBoot enabled$"
}

check_akmod_signed() {
	## secure boot off -> no need to sign, treat as signed
	if ! check_sb; then
		echo "secure boot disabled, no need to sign akmod"
		return 0
	fi

	## get the akmod key name (eg. fedora_1785773378_10876544.der)
	local key_name
	key_name=$(sudo ls /etc/pki/akmods/certs/ 2>/dev/null | grep fedora | head -n 1)
	## strip .der suffix to match mokutil list output
	key_name=${key_name%.der}

	## no key file -> not generated/enrolled
	[ -z "$key_name" ] && return 1

	## check if already enrolled in mok
	sudo mokutil --list-enrolled 2>/dev/null | grep -q "$key_name"
}

## ./install.sh --driver akmod
sb_sign_akmod() {
	sudo dnf install -y \
		kmodtool \
		akmods \
		mokutil \
		openssl

	if check_akmod_signed; then
		echo "akmod mok already enrolled, skip"
		return 0
	fi

	## generate key and enroll mok
	sudo kmodgenca -a
	sudo mokutil --import /etc/pki/akmods/certs/public_key.der

	## require reboot to finish mok enrollment
	echo "please reboot and confirm the key in MokManager"
}

check_dkms_signed() {
	if ! check_sb; then
		echo "secure boot disabled, no need to sign akmod"
		return 0
	fi

	## add dkms check here
	return 1
}

sb_sign_dkms() {
    sudo dnf install -y \
        dkms \
        mokutil \
		openssl \

	## check if dmks signed
	if check_dkms_signed; then
		echo "akmod mok already enrolled, skip"
		return 0
	fi

	## sign dkms 
	sudo mokutil --import /var/lib/dkms/mok.pub
	sudo mokutil --list-new
}

install_nvidia() {
	if ! check_akmod_signed; then
		echo "akmod mok is not enrolled, skip"
		return 0
	fi

	## install driver
	sudo dnf install -y \
		kernel-headers \
		kernel-devel \
		akmod-nvidia \
		nvidia-smi

	sudo akmods --force
	sudo dracut --force
}

## 多余的 gnome app：安装 gnome-desktop 时排除，也用于从 workstation 移除
exclude_pkgs=(
		gnome-boxes
		gnome-connections
		gnome-software
		gnome-text-editor
		gnome-calendar
		gnome-characters
		gnome-contacts
		gnome-logs
		gnome-maps
		gnome-weather
		gnome-epub-thumbnailer
		gnome-user-docs
		gnome-user-share
		gnome-classic-session
		gnome-clocks
		gnome-color-manager
		gnome-font-viewer
		gnome-initial-setup
		loupe
		sushi
		snapshot
		baobab
		simple-scan
		totem
		evince
		evince-djvu
		yelp
		rygel
		gnome-calculator
		gnome-tour
		malcontent-control
		malcontent-ui-libs
		papers
		decibels
		showtime
		ptyxis
	)

## desktop
install_gnome_desktop() {
	exclude_string=$(
		IFS=,
		echo "${exclude_pkgs[*]}"
	)

	## install gnome-desktop
	sudo dnf group install -y \
		gnome-desktop --exclude="${exclude_string}" 

	## add sound support
	sudo dnf install -y \
		alsa-sof-firmware \
		alsa-utils

	## add wifi support 
	sudo dnf install -y \
		iwlwifi-dvm-firmware \
		iwlwifi-mvm-firmware

	sudo dnf install -y \
		kitty \
		gnome-extensions-app \
		gnome-tweaks \
		ibus-rime
	
	## xdg-terminal-exec
	sudo dnf install -y \
		xdg-terminal-exec
	## nautilus open
	sudo dnf copr enable monkeygold/nautilus-open-any-terminal -y
	sudo dnf install -y \
		nautilus-open-any-terminal
}

remove_from_workstation() {
	local installed=() pkg
	for pkg in "${exclude_pkgs[@]}"; do
		rpm -q "$pkg" >/dev/null 2>&1 && installed+=("$pkg")
	done
	(( ${#installed[@]} )) || { echo "没有需要移除的多余 gnome app"; return 0; }
	sudo dnf remove -y "${installed[@]}"
}

gext_path=./gnome/ext_list.txt

install_gext() {
	if ! command -v pip > /dev/null 2>&1; then
		return 1
	fi

	if ! command -v gext > /dev/null 2>&1; then
		return 1
	fi

	## check ext list 
	if [ ! -f "$gext_path" ]; then
		echo no gext backup in $gext_path
		return 1
	fi

	while read -r ext; do
		[ -z "$ext" ] && continue
		echo "installing extension: $ext"
		gnome-extensions-cli install "$ext"
	done < "$gext_path"
}

## ./install.sh --desktop bk_gext
backup_gext() {
	## save to extension_list.txt
	gext list --only-uuid > "$gext_path"
}

tahoegtk_url="https://github.com/vinceliuice/MacTahoe-gtk-theme.git"

gtk_theme_url=tahoegtk_url
gtk_theme="MacTahoe-gtk-theme"

gtk_theme_dir="$HOME/.local/share/themes/"

build_tahoe_gtk_theme() {
	sh "$APPS/$gtk_theme/install.sh" \
		--dest $gtk_theme_dir \
		--opacity normal \
		--libadwaita \
		--shell \
		-i fedora \
		-panelopacity 60 \
		-panelheight default \
		-normal \
		--darker 

	sh "$APPS/$gtk_theme/tweaks.sh" \
		-F

	rm ~/.local/share/applications/org.gnome.GTK4ThemeSwitcher.desktop
}

gtk_theme() {
	if [ ! -d "$APPS/$gtk_theme" ]; then
		git clone "${whitesurgtk_url}" "$APPS/$gtk_theme" --depth 1
		cd "$APPS/$gtk_theme" || exit 1
		chmod +x "$APPS/$gtk_theme/install.sh"
		chmod +x "$APPS/$gtk_theme/tweaks.sh"
		build_tahoe_gtk_theme 
	else
		cd "$APPS/$gtk_theme" || exit 1
		##git pull
		build_tahoe_gtk_theme
	fi
}

whitesurqt_url="https://github.com/FengZhongShaoNian/QWhiteSurGtkDecorations.git"
qt_theme="QWhiteSurGtkDecorations"

install_qt_theme_deps() {
	sudo dnf install -y \
		wayland-devel

	sudo dnf install -y \
		qt5-qtbase-devel \
		qt5-qtsvg-devel \
		qt5-qtwayland-devel \
		qt5-qtbase-devel \
		qt5-qtbase-static \
		qt5-qtbase-private-devel \
		qt5ct

	sudo dnf install -y \
		qt6-qtbase-devel \
		qt6-qtsvg-devel \
		qt6-qtwayland-devel \
		qt6-qtbase-devel \
		qt6-qtbase-static \
		qt6-qtbase-private-devel \
		qt6ct
}

build_qt_theme() {
	rm -rf build/
	## modify decoration size and look
	sed -i.bak \
		-e 's|^static constexpr int ceButtonSpacing = 6;|static constexpr int ceButtonSpacing = 8;|' \
		-e 's|^static constexpr int ceButtonMarginRight = 15;|static constexpr int ceButtonMarginRight = 11;|' \
		-e 's|^static constexpr int ceTitlebarHeight = 38;|static constexpr int ceTitlebarHeight = 32;|' \
		./src/qwhitesurgtkdecorations.cpp

	## compile QT5 version and install
	qt5_ver=$(qmake-qt5 --version | grep -oP 'Using Qt version \K[0-9]+\.[0-9]+' | tr '.' '-')
	mkdir build && cd build
	cmake -DHAS_QT6_SUPPORT=true .. && make
	sudo cp src/libqwhitesurgtkdecorations.so \
		/usr/lib64/qt5/plugins/wayland-decoration-client/libqwhitesurgtkdecorations.so
	cd .. && rm build -rf

	## copy to dotfiles dir
	if [ -r "$HOME/.dotfiles/not_stow/qt/qt5-decor/" ]; then
		cp src/libqwhitesurgtkdecorations.so \
			$HOME/.dotfiles/not_stow/qt/qt5-decor/libwhitesur$(qt5_ver)
	fi

	## compile QT6 version and install
	mkdir build && cd build
	qt6_ver=$(qmake6 --version | grep -oP 'Using Qt version \K[0-9]+\.[0-9]+' | tr '.' '-')
	cmake -DUSE_QT6=true -DHAS_QT6_SUPPORT=true .. && make
	sudo cp src/libqwhitesurgtkdecorations.so \
		/usr/lib64/qt6/plugins/wayland-decoration-client/libwhitesur.so
	cd .. && rm build -rf

	## copy to dotfiles dir
	if [ -r "$HOME/.dotfiles/not_stow/qt/qt6-decor/" ]; then
		cp src/libqwhitesurgtkdecorations.so \
			$HOME/.dotfiles/not_stow/qt/qt6-decor/libwhitesur$(qt6_ver)
	fi
}

qt_theme() {
	install_qt_theme_deps 
	if [ ! -d "$APPS/$qt_theme" ]; then
		git clone "$whitesurqt_url" "$APPS/$qt_theme"
		cd "$APPS/$qt_theme" || exit 1
		build_qt_theme 
	else
		cd "$APPS/$qt_theme" || exit 1
		git pull
		build_qt_theme 
	fi
}

install_icon() {
	sudo dnf copr enable rivenirvana/morewaita-icon-theme
	sudo dnf install -y \
		morewaita-icon-theme
}

install_fonts() {
	sudo dnf install -y \
		google-noto-sans-cjk-fonts \
		google-noto-sans-cjk-vf-fonts \
		google-noto-sans-mono-cjk-vf-fonts \
		google-noto-emoji-fonts \
		google-noto-color-emoji-fonts

	sudo dnf install -y \
		adobe-source-han-sans-cn-fonts \
		adobe-source-han-serif-cn-fonts \
		adobe-source-serif-pro-fonts \
		adobe-source-sans-pro-fonts

	sudo dnf copr enable che/nerd-fonts -y
	sudo dnf install -y nerd-fonts
}

## apps
get_release_from_github() {
	## param0: repo name -> TheAssassin/AppImageLauncher
	## param1: output-dir -> $DOWNLOAD / $APPS / $APPIMAGES
	## param2~...: select word -> x86_64 / .rpm ...
	local repo=$1
	local output_dir=$2
	shift 2

	## build jq filter: every select word must match asset name
	local args=()
	local filter='.assets[]'
	local i=0
	for w in "$@"; do
		args+=(--arg "w$i" "$w")
		filter+=" | select(.name | test(\$w$i))"
		i=$((i + 1))
	done
	filter+=' | .browser_download_url'
	args+=(-r "$filter")

	curl -sL "https://api.github.com/repos/$repo/releases/latest" \
		| jq "${args[@]}" \
		| xargs -r curl -LO --output-dir "$output_dir"
}


install_desktop_app() {
	:
	## sudo dnf install -y \
	## flatpak --user install \
}

install_appimagetool() {
	## add check here
	get_release_from_github AppImage/appimagetool \
		"$BIN" appimagetool-x86_64.AppImage

	## rename to plain name so it can be called directly
	mv -f "$BIN"appimagetool-x86_64.AppImage "$BIN"appimagetool
	chmod +x "$BIN"appimagetool
}

install_linuxdeploy() {
	## add check here
	get_release_from_github linuxdeploy/linuxdeploy \
		"$BIN" x86_64 .AppImage

	## rename to plain name so it can be called directly
	mv -f "$BIN"linuxdeploy-x86_64.AppImage "$BIN"linuxdeploy
	chmod +x "$BIN"linuxdeploy
}

## ./install.sh --apps appimage
install_appimages_env() {
	sudo dnf install -y \
		fuse \
		fuse-devel \
		fuse3

	install_appimagetool
	install_linuxdeploy 
}

install_vm() {
	sudo dnf install -y \
		virt-manager \
		libvirt \
		qemu-kvm

	## enable libvirt and add usr groups
	sudo systemctl enable --now libvirtd
	sudo usermod -aG libvirt $USER
}

start_uu_plugin() {
	if [ -f /usr/bin/uuplugin]; then
		sudo firewall-cmd --add-port=16363/tcp
		sudo systemctl start uuplugin.service
	fi
}

stop_uu_plugin() {
	if [ -f /usr/bin/uuplugin]; then
		sudo systemctl stop uuplugin.service
		sudo firewall-cmd --remove-port=16363/tcp
	fi
}

install_just_talk() {
	## download the just-talk-go archive to ~/downloads/
	get_release_from_github whoamihappyhacking/just-talk-go "$DOWNLOAD" just-talk_linux_amd64.tar.gz

	## extract in ~/downloads and move the bin to ~/.local/bin/just-talk
	tar -xzf "$DOWNLOAD"just-talk_linux_amd64.tar.gz -C "$DOWNLOAD"
	mv -f "$DOWNLOAD"just-talk_linux_amd64/just-talk "$BIN"just-talk
	rm -rf "$DOWNLOAD"just-talk_linux_amd64

	chmod +x "$BIN"just-talk
}

install_vinput() {
	sudo dnf install -y \
		libXinerama-devel \
		wayland-devel \
		alsa-utils \
		wl-clipboard \
		wtype
	
	sudo usermod -aG input $USER

	install_just_talk 
}

## ---------- 模块注册表 ----------
declare -A MOD_FUNC MOD_ARITY MOD_VALUES MOD_SPEC MOD_DESC
declare -a MOD_ORDER=()

## reg <name> <arity> <values|-> <func> <spec> [desc]
##   arity  0 = 无值, 1 = 吃一个值
##   values "-" = 不校验, "a|b|c" = 正则白名单
reg() {
	MOD_FUNC[$1]=$4
	MOD_ARITY[$1]=$2
	MOD_VALUES[$1]=$3
	MOD_SPEC[$1]=$5
	MOD_DESC[$1]=${6:-}
	MOD_ORDER+=("$1")
}

reg user      1 "dir"                                             config_usr_dir    "--user <dir>"                                       "create user directories"
reg source    1 "config|tsinghua|ustc|origin"                     dnf_source_wrapper "--source <config|tsinghua|ustc|origin>"            "rpmfusion + mirror: config/tsinghua/ustc/origin"
reg toolchain 0 "-"                                               install_toolchain "--toolchain"                                        "install all toolchains"
reg driver    1 "kextra|akmod|dkms|nvidia"                        driver_wrapper     "--driver <kextra|akmod|dkms|nvidia>"               "kernel modules / mok signing / nvidia"
reg desktop   1 "gnome|gext|bk_gext|gtk_theme|qt_theme|font|icon|remove" desktop_wrapper    "--desktop <gnome|gext|bk_gext|gtk_theme|qt_theme|font|icon|remove>" "desktop / extensions / themes / fonts / icons / remove gnome apps"
reg apps      1 "desktop|appimage|vm|games|uu|vinput"             apps_wrapper       "--apps <desktop|appimage|vm|games|uu|vinput>"      "appimage env / vm / games / uu / voice input"

## ---------- 模块分发 ----------
dnf_source_wrapper() {
	case "$1" in
		config)   dnf_config_source ;;
		tsinghua) dnf_change_tsinghua_source ;;
		ustc)     dnf_change_ustc_source ;;
		origin)   dnf_change_origin_source ;;
	esac
}

driver_wrapper() {
	case "$1" in
		kextra) install_kernel_extra ;;
		akmod)  sb_sign_akmod ;;
		dkms)   sb_sign_dkms ;;
		nvidia) install_nvidia ;;
	esac
}

desktop_wrapper() {
	case "$1" in
		gnome)     install_gnome_desktop ;;
		gext)      install_gext ;;
		bk_gext)   backup_gext ;;
		gtk_theme) gtk_theme ;;
		qt_theme)  qt_theme ;;
		font)      install_fonts ;;
		icon)      install_icon ;;
		remove)    remove_from_workstation ;;
	esac
}

apps_wrapper() {
	case "$1" in
		desktop)  install_desktop_app ;;
		appimage) install_appimages_env ;;
		vm)       install_vm ;;
		games)    install_games_env ;;
		uu)       install_uu_plugin ;;
		vinput)   install_vinput ;;
	esac
}

## ---------- 参数解析 ----------
die() { echo "error: $*" >&2; exit 1; }

declare -a QUEUE_NAMES=() QUEUE_VALS=()

## 阶段一：从 $1 起逐个解析并校验，只入队，不改系统状态
parse_args() {
	local -a names=() vals=()
	local i=1 arg name arity val pat
	while (( i <= $# )); do
		arg=${!i}
		[[ $arg == --* ]] || die "多余的参数 '$arg'（选项必须以 -- 开头）"
		name=${arg#--}
		[[ -n ${MOD_FUNC[$name]:-} ]] || die "未知选项 '$arg'"

		arity=${MOD_ARITY[$name]}
		val=""
		if (( arity > 0 )); then
			(( i + arity <= $# )) || die "$arg 缺少参数"
			val=${@:$((i + 1)):arity}
			pat=${MOD_VALUES[$name]}
			if [[ $pat != - && ! $val =~ ^($pat)$ ]]; then
				die "$arg 取值非法：'$val'（合法值：$pat）"
			fi
		fi

		names+=("$name")
		vals+=("$val")
		(( i += 1 + arity ))
	done

	(( ${#names[@]} )) || { usage >&2; exit 1; }
	QUEUE_NAMES=("${names[@]}")
	QUEUE_VALS=("${vals[@]}")
}

## 阶段二：按入队顺序执行，任一模块失败即停止
run_queue() {
	local idx name fn
	for idx in "${!QUEUE_NAMES[@]}"; do
		name=${QUEUE_NAMES[idx]}
		fn=${MOD_FUNC[$name]}
		echo "==> $name ${QUEUE_VALS[idx]}"
		"$fn" "${QUEUE_VALS[idx]}" || return 1
	done
}

usage() {
	echo "usage: $0 [--option value] ..."
	echo
	local m
	for m in "${MOD_ORDER[@]}"; do
		printf '  %-62s %s\n' "${MOD_SPEC[$m]}" "${MOD_DESC[$m]}"
	done
	echo
	echo "  options can be combined: $0 --source config --desktop gnome --apps vm"
}

main() {
	[ $# -gt 0 ] || { usage >&2; exit 1; }

	case "$1" in
		-h|--help)
			usage
			exit 0
			;;
	esac

	parse_args "$@"
	run_queue
}

main "$@"
