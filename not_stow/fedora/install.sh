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
APPS=$HOME/.local/share/apps/
APPIMAGES=$HOME/.local/share/appimages/

## user 
## ./install.sh --user dir
make_user_dirs() {
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

config_usr_dir() {
	mkdir -p \
		$DESKTOP \
		$DOWNLOAD \
		$DOCUMENT \
		$TEMPLATES \
		$PUBLIC \
		$MUSIC \
		$PICTURES \
		$VIDEOS \
		$HOME/.config/ \
		$HOME/.local/ \
		$HOME/.cache/

	make_user_dirs 
}

## dnf source
install_rpmfusion() {
	if [ ! -f /etc/yum.repos.d/rpmfusion-free.repo ]; then
		sudo dnf install -y \
			"https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
			"https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
	fi
}

install_workstation_source() {
	sudo dnf install -y fedora-workstation-repositories
}

backup_origin_source() {
	sudo cp /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/origin-fedora.repo.bak
	sudo cp /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/origin-fedora-updates.repo.bak
	for f in /etc/yum.repos.d/rpmfusion*.repo; do
		[ -f "$f" ] || continue
		sudo cp "$f" "/etc/yum.repos.d/origin-$(basename "$f").bak"
	done
}

add_tsinghua_source() {
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

add_ustc_source() {
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
change_tsinghua_source() {
	for f in /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/rpmfusion*.repo; do
		[ -f "$f" ] || continue
		sudo cp "/etc/yum.repos.d/tsinghua-$(basename "$f").bak" "$f"
	done
}

## ./install.sh --source ustc 
change_ustc_source() {
	for f in /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/rpmfusion*.repo; do
		[ -f "$f" ] || continue
		sudo cp "/etc/yum.repos.d/ustc-$(basename "$f").bak" "$f"
	done
}

## ./install.sh --source origin
change_origin_source() {
	for f in /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/rpmfusion*.repo; do
		[ -f "$f" ] || continue
		sudo cp "/etc/yum.repos.d/origin-$(basename "$f").bak" "$f"
	done
}

## ./install.sh --source config
config_dnf_source() {
	install_rpmfusion
	install_workstation_source 
	backup_origin_source 
	add_tsinghua_source 
	add_ustc_source 
}

## toolchain
install_c_toolchain() {
	sudo dnf group install -y \
		c-development
}

install_rs_toolchain() {
	sudo dnf install -y \
		rustup
	rustup-init -y
}

install_python_toolchain() {
	sudo dnf install -y \
		python3 \
		Python3-devel \
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
		nvim \
		fastfetch \
		fzf
}

## ./install.sh --toolchain
install_toolchain() {
	install_c_toolchain 
	install_rs_toolchain 
	install_jvav_toolchain 
	install_node_toolchain 
	install_python_toolchain 
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

## ./install.sh --driver dkms
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

## ./install.sh --driver nvidia
install_nvidia() {
	if check_akmod_signed; then
		echo "akmod mok already enrolled, skip"
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

## desktop
### gnome
## ./install.sh --desktop gnome
install_gnome_desktop() {
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

	## xdg-terminal-exec
	sudo dnf install -y \
		xdg-terminal-exec
	## nautilus open
	sudo dnf copr enable monkeygold/nautilus-open-any-terminal -y && sudo dnf update -y
	sudo dnf install -y \
		nautilus-open-any-terminal
}

## ./install.sh --desktop gext
gext_path=./gext_list.txt

install_gext() {
	## install gext
	pip install gnome-extensions-cli

	## install extensions
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
	## check git diff of $gext_path
	git add "$gext_path"
	if git diff --cached --quiet; then
		echo "no extension change, skip commit"
	else
		git commit -m "backup gnome extension"
		git push
	fi
}

whitesurgtk_url="https://github.com/vinceliuice/WhiteSur-gtk-theme.git"
gtk_theme="WhiteSur-gtk-theme"
gtk_theme_dir="$HOME/.local/share/themes/"

build_gtk_theme() {
	sh "$APPS/$gtk_theme/install.sh" \
		--dest $gtk_theme_dir \
		--opacity normal \
		--color light \
		--nautilus glassy \
		--libadwaita \
		--shell -i fedora -b default -p 60 -h bigger -normal \
		--round --darker
}

## ./install.sh --desktop gtk_theme
gtk_theme() {
	if [ ! -d "$APPS/$gtk_theme" ]; then
		git clone "${whitesurgtk_url}" "$APPS/$gtk_theme" --depth 1
		cd "$APPS/$gtk_theme" || exit 1
		chmod +x "$APPS/$gtk_theme/install.sh"
		chmod +x "$APPS/$gtk_theme/tweaks.sh"
		build_gtk_theme 
	else
		cd "$APPS/$gtk_theme" || exit 1
		git pull
		build_gtk_theme 
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
	mkdir build && cd build
	cmake -DHAS_QT6_SUPPORT=true .. && make
	sudo cp src/libqwhitesurgtkdecorations.so \
		/usr/lib64/qt5/plugins/wayland-decoration-client/
	cd .. && rm build -rf

	## compile QT6 version and install
	mkdir build && cd build
	cmake -DUSE_QT6=true -DHAS_QT6_SUPPORT=true .. && make
	sudo cp src/libqwhitesurgtkdecorations.so \
		/usr/lib64/qt6/plugins/wayland-decoration-client/
	cd .. && rm build -rf
}

## ./install.sh --desktop qt_theme
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

## ./install.sh --desktop font
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

	sudo dnf copr enable che/nerd-fonts
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

install_appimagelauncher() {
	## add check here
	get_release_from_github TheAssassin/AppImageLauncher \
		"$DOWNLOAD" x86_64 .rpm

	sudo dnf install -y "$DOWNLOAD"/appimagelauncher*x86_64.rpm

	cat > "$HOME/.config/appimagelauncher.cfg" << EOF
[AppImageLauncher]
ask_to_move=true
destination=${APPIMAGES%/}
enable_daemon=true

[appimagelauncherd]
%23%20additional_directories_to_watch=~/otherApplications:/even/more/applications
%23%20monitor_mounted_filesystems=false
EOF
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

	install_appimagelauncher
	install_appimagetool
	install_linuxdeploy 
}

## ./install.sh --apps vm
install_vm() {
	sudo dnf install -y \
		virt-manager \
		libvirt \
		qemu-kvm

	## enable libvirt and add usr groups
	sudo systemctl enable --now libvirtd
	sudo usermod -aG libvirt $USER
}

## ./install.sh --apps games
install_uu_plugin() {
	sudo mkdir -p /home/deck/
	sudo chown /home/deck/
	sudo firewall-cmd --permanent --add-port=16363/tcp

	curl -s uudeck.com | sudo bash
}

remove_uu_plugin() {
	sudo rm -rf /home/deck
}

install_games_env() {
	## steam
	sudo dnf install -y \
		steam

	## prismlauncher
	sudo dnf copr enable g3tchoo/prismlauncher
	sudo dnf install prismlauncher
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

## ./install.sh --apps vinput
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

## main entry
## ./install.sh --source config|tsinghua|ustc|origin
usage() {
	cat <<EOF
usage: $0 [options]

  --user <dir>
          dir       create user directories (~/downloads, ~/documents, ...)

  --source <config|tsinghua|ustc|origin>
          config    install rpmfusion & backup origin source
                    & add tsinghua/ustc mirror
          tsinghua  switch to tsinghua mirror
          ustc      switch to ustc mirror
          origin    restore origin source

  --toolchain     install all toolchains (c/rs/python/node/jvav/tui)

  --driver <kextra|akmod|dkms|nvidia>
          akmod    enroll akmod signing key to mok
          dkms     enroll dkms signing key to mok
          nvidia   install nvidia driver (akmod)

  --desktop <gnome|gext|bk_gext|gtk_theme|qt_theme|font>
          gnome     install gnome desktop (minimal)
          gext      install gnome extensions cli
          bk_gext   backup installed gnome extensions to $gext_path
          gtk_theme install WhiteSur gtk theme
          qt_theme  install qt theme deps
          font      install fonts (noto/source-han/nerd)

  --apps <appimage|vm|games|just-talk|vinput>
          appimage   install appimage env (launcher/tool/deploy)
          vm         install virt-manager, libvirt, qemu-kvm
          games      install steam & prismlauncher
          vinput     install voice input deps + just-talk

EOF
}

main() {
	case "${1:-}" in
		--source)
			case "${2:-}" in
				config)   config_dnf_source ;;
				tsinghua) change_tsinghua_source ;;
				ustc)     change_ustc_source ;;
				origin)   change_origin_source ;;
				*)
					echo "error: unknown source '${2:-}'" >&2
					usage
					exit 1
					;;
			esac
			;;
		--user)
			case "${2:-}" in
				dir) config_usr_dir ;;
				*)
					echo "error: unknown user option '${2:-}'" >&2
					usage
					exit 1
					;;
			esac
			;;
		--toolchain)
			install_toolchain
			;;
		--driver)
			case "${2:-}" in
				kextra) install_kernel_extra ;;
				akmod)  sb_sign_akmod ;;
				dkms)   sb_sign_dkms ;;
				nvidia) install_nvidia ;;
				*)
					echo "error: unknown driver '${2:-}'" >&2
					usage
					exit 1
					;;
			esac
			;;
		--desktop)
			case "${2:-}" in
				gnome)     install_gnome_desktop ;;
				gext)      install_gext ;;
				bk_gext)   backup_gext ;;
				gtk_theme) gtk_theme ;;
				qt_theme)  qt_theme ;;
				font)      install_fonts ;;
				*)
					echo "error: unknown desktop '${2:-}'" >&2
					usage
					exit 1
					;;
			esac
			;;
		--apps)
			case "${2:-}" in
				appimage)  install_appimages_env ;;
				vm)        install_vm ;;
				games)     install_games_env ;;
				vinput)    install_vinput ;;
				*)
					echo "error: unknown app '${2:-}'" >&2
					usage
					exit 1
					;;
			esac
			;;
		*)
			usage
			exit 1
			;;
	esac
}

main "$@"
