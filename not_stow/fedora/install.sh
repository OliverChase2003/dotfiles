#!/usr/bin/env bash

## dir variable
DOWNLOAD=$HOME/downloads/
DOCUMENT=$HOME/documents/
BIN=$HOME/.local/bin/
APPS=$HOME/.local/share/apps/
APPIMAGES=$HOME/.local/share/appimages/

## user 
## ./install.sh --user dir
config_usr_dir() {
	mkdir -p \
		$HOME/downloads/ \
		$HOME/documents/ \
		$HOME/pictures/ \
		$HOME/music/ \
		$HOME/videos/ \
		$HOME/.config/ \
		$HOME/.local/ \
		$HOME/.cache/

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
	sudo cp /etc/yum.repos.d/rpmfusion*.repo /etc/yum.repos.d/origin-rpmfusion*.repo.bak
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

install_nvidia() {
	## check secure boot status and akmod signed
	## if sb is on and akmod's not signed, return

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
## ./install.sh --gnome desktop
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
install_gext() {
	pip install gnome-extensions-cli
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
	:
}

install_appimagelauncher() {
	## add check here
	##curl -sL https://api.github.com/repos/TheAssassin/AppImageLauncher/releases/latest \
	##	| jq -r '.assets[] | select(.name | test("x86_64.*\\.rpm$")) | .browser_download_url' \
	##	| xargs curl -LO --output-dir "$download_dir"

	sudo dnf install -y "$DOWNLOAD"/appimagelauncher*x86_64.rpm
}

install_appimagetool() {
	## add check here
	curl -sL https://api.github.com/repos/AppImage/appimagetool/releases/latest \
		| jq -r '.assets[] | select(.name == "appimagetool-x86_64.AppImage") | .browser_download_url' \
		| xargs curl -LO --output-dir "$software_dir/appimages"

	chmod +x "$software_dir/appimages/appimagetool*.AppImage"
}

install_linuxdeploy() {
	## add check here
	curl -sL https://api.github.com/repos/linuxdeploy/linuxdeploy/releases/latest \
		| jq -r '.assets[] | select(.name | test("x86_64.*\\.AppImage$")) | .browser_download_url' \
		| xargs curl -LO --output-dir "$software_dir/appimages"

	chmod +x $software_dir/appimages/linuxdeploy*.AppImage
}

## ./install.sh --apps appimage
install_appimages_env() {
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
install_games_env() {
	## steam
	sudo dnf install -y \
		steam

	## prismlauncher
	sudo dnf copr enable g3tchoo/prismlauncher
	sudo dnf install prismlauncher
}

install_just_talk() {
	:
	## download the just-talk-go bin to ~/.local/bin/

	## unzip to ~/.local/bin -> ~/.local/bin/just-talk

	## chmod +x
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

## test
script_test() {
	:
}

## main entry
## ./install.sh --source config|tsinghua|ustc|origin
usage() {
	cat <<EOF
usage: $0 [options]

  --source <config|tsinghua|ustc|origin>
          config    install rpmfusion & backup origin source
                    & add tsinghua/ustc mirror
          tsinghua  switch to tsinghua mirror
          ustc      switch to ustc mirror
          origin    restore origin source

  --user <dir>
          dir       create user directories (~/downloads, ~/documents, ...)
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
		*)
			usage
			exit 1
			;;
	esac
}

main "$@"
