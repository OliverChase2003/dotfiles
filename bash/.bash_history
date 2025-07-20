chmod +x *.sh
vi workstation_simplify.sh 
./workstation_simplify.sh 
sudo dnf update
sudo reboot
vi nvidia-drv2.sh 
cd Projects/myFedoraConfig/nvidia/
vi nvidia-drv2.sh 
sudo dnf install akmod-nvidia
sudo akmods --force
sudo dracut --force
sudo reboot
./toolchains.sh 
./input_method.sh 
vi fonts.sh 
cd Projects/myFedoraConfig/
ls
./fonts.sh 
chmod +x ~/.softwares/WhiteSur-gtk-theme/install.sh
## install theme for desktop
sudo sh ~/.softwares/WhiteSur-gtk-theme/install.sh -c light -N --shell -i fedora -p 60 -b default -h bigger -normal
ls
./desktop_env.sh 
ls
vi desktop_env.sh 
sudo dnf install ./
sudo dnf install ./Clash.Verge-2.2.3-1.x86_64.rpm
ls
chmod +x ~/.softwares/WhiteSur-gtk-theme/install.sh
## install theme for desktop
sudo sh ~/.softwares/WhiteSur-gtk-theme/install.sh -c light -N --shell -i fedora -p 60 -b default -h bigger -normal
sh ~/.softwares/WhiteSur-gtk-theme/install.sh -l
## install theme for firefox & gdm
chmod +x ~/.softwares/WhiteSur-gtk-theme/tweaks.sh
sudo sh ~/.softwares/WhiteSur-gtk-theme/tweaks.sh --gdm -i fedora -noblur   ## gdm theme
sudo sh ~/.softwares/WhiteSur-gtk-theme/tweaks.sh --firefox flat    ## firefox theme
dnf search Appindica
dnf search gnome-shell-extension-
sudo dnf install gnome-shell-extension-appindicator
sudo dnf rm mediawriter
sudo dnf install -y ./*.rpm
fc-cache -fv
clear
clear
exit
ls
dnf repo list
sudo dnf install ./appimagelauncher_3.0.0-alpha-4-gha253.36951ec_x86_64.rpm
ls /etc/yum.repos.d/
cd Projects/myFedoraConfig/
ls
./appimage_env.sh 
vi ./appimage_env.sh 
arch=$(uname -m)
version="3.0.0-alpha-4"
gha="gha253.36951ec"
wget -P ~/Downloads/ https://github.com/TheAssassin/AppImageLauncher/releases/download/v"$version"/appimagelauncher_"$version"-"$gha"_"$arch".rpm
sudo dnf install -y ~/Downloads/appimagelauncher_"$version"-"$gha"_"$arch".rpm
wget -P ~/Downloads/ https://github.com/TheAssassin/AppImageLauncher/releases/download/v"$version"/appimagelauncher_"$version"-"$gha"_"$arch".rpm
cd Projects/myFedoraConfig/
ls
cp -r ./stows ~/.stow/
cd ~
ls
cd .stow/
ls
rm ~/.bashrc
stow bash
stow fish
cd ..
mv ./.stow ./stow
cd stow
stow bash
rm ~/.bash_profile 
stow bash
stow fish
exit
ls
clear
dnf search bottles
cd Projects/myFedoraConfig/
ls
nvim
nvim desktop_apps.sh 
./desktop_apps.sh 
sudo dnf remove onedriver
dnf copr list
sudo dnf copr rm jstaf/onedriver
sudo dnf copr remove jstaf/onedriver
./qqmusic-1.1.7_f3400d0cf46d21095456b318a2462049.AppImage 
sudo dnf install fuse fuse-devel -y
dnf search prism
clear
dnf search hmcl
clear
sudo dnf install java-openjdk-21
dnf search openjdk
sudo dnf install java-21-openjdk
dnf search java-*-openjdk
dnf search java
clear
sudo dnf update
dnf group list
./install -h
./install.sh -h
exit
sudo dnf install bottles
fish
exit
export http_proxy="http://127.0.0.1:7897"
bottles
sudo dnf install proxychains
sudo nvim /etc/proxychains.conf
proxychains bottles
clear
proxychains bottles
sudo nvim /etc/proxychains.conf
proxychains bottles
proxychains bottles
proxychains bottles
proxychains bottles
sudo dnf remove bottles
export QT_QPA_PLATFORMTHEME=gtk2
exit
source .bashrc
cat | sudo tee /etc/yum.repos.d/minecraft-linux-pkg.repo << 'EOF'
[minecraft-linux-pkg]
name=minecraft-linux-pkg
baseurl=https://minecraft-linux.github.io/pkg/fedora-42
enabled=1
countme=1
repo_gpgcheck=0
type=rpm
gpgcheck=1
skip_if_unavailable=False
gpgkey=https://minecraft-linux.github.io/pkg/deb/pubkey.gpg
EOF

sudo dnf update
sudo dnf update
sudo dnf update
[200~cat | sudo tee /etc/yum.repos.d/minecraft-linux-pkg.repo << 'EOF'
[minecraft-linux-pkg]
name=minecraft-linux-pkg
baseurl=https://minecraft-linux.github.io/pkg/fedora-42
enabled=1
countme=1
repo_gpgcheck=0
type=rpm
gpgcheck=1
skip_if_unavailable=False
gpgkey=https://minecraft-linux.github.io/pkg/deb/pubkey.gpg
EOf

clear
ls /etc/yum.repos.d/
sudo dnf update
ping google.com
clear
exit
cd dld
dld
dld
doc
pic
hom
cd
dnf list --installed | grep hello
dnf list --installed | grep h
clear
la
ls -A
ll
exit && bash
clear
vi
cd ..
vi
clear
exit
la
clear
...
cd home/oliver/
ls
ln -s /run/media/${USER} ~/mnt
ls
cd mn
cd mnt
ls
cd mnt
ln -s /run/media/oliver ~/mnt
ls
cd mnt
ln -s /run/media/oliver ~/mnt
cd mnt
ls
cd MEDIAS/
ls
cd ..
cd ..
unmount mnt/MEDIAS/
sudo umount mnt/MEDIAS/
umount ./mnt/MEDIAS/
umount ./mnt/MEDIAS/
gnome-shell-extension-tool list
gnome-shell-extension-tool --help
gnome-extensions-cli 
dnf search google-noto-sans-*-fonts
dnf search google-noto-sans cjk
cd Projects/myFedoraConfig/
nvim
cd Projects/FingerPrint/
..
..
ls
vi
viqdclear
clear
exit
stow zsh
exit
help set
yazi
cd ..
cd Downloads
git clone https://github.com/junegunn/fzf.git
ls
cd fzf/
ls
./install 
cd ..
cd ..
ls
yazi
bash
exit
ls
la
clear
exit
exit
exit
clear
ls
la
clear
la
ll
clear
exit
exit
vi ~/.config/user-dirs.dirs
cd ..
exit
git clone --recursive https://github.com/akinomyoga/ble.sh.git ~/.ble.sh
~/.ble.sh/install.sh
cd ../.ble.sh/
make
ls
cd ..
exit
sudo dnf update -y
exit
exit
exit
clear
exit
exit
exit
cl
stow nvim
rm .config/nvim/lua/config/options.lua
rm ~/.config/nvim/lua/config/options.lua
stow nvim
ls
unzip dotfiles.zip 
ls
unzip netinst.zip 
ls
cd netinst/
ls
sh ./source.sh 
cat /etc/yum.repos.d/fedora.repo
cat /etc/yum.repos.d/rpmfusion-free.repo
cat /etc/yum.repos.d/rpmfusion-nonfree.repo
ls
sh ./terminal-app.sh 
cd ..
cd .dotfiles/
ls
rm ../.bashrc ../.bash_profile 
stow bash
stow zsh
stow tmux
stow udir
stow git 
cd ..
cd netinst/
ls
sh ./terminal-app.sh 
clear
ls
cd ..
la
exit
ls
l
la
rm *.zip
ls
la
rm .config
mkdir .config
cd .dotfiles/
stow udir/
ls
cd ..
ls
la
cd netinst/
ls
sh ./gnome-desktop.sh 
clear
ls
sudo reboot
sh ./nvidia/nvidia-sign.sh 
sudo reboot
nvidia-smi
rm ../.config/user-dirs.dirs 
stow udir/
ff
sudo dnf install fastfetch
ff
clear
echo "enable=False" > user-dirs.conf
cat user-dirs.conf 
stow udir
stow udir/
cd .config
chattr -i ./user-dirs.dirs 
mkdir -p dld mus vid doc/tpl 
ls
mkdir pic
ls
mkdir mnt
mount --bind mnt /run/media/oliver/
mount --bind /run/media/oliver/ mnt
sudo mount --bind /run/media/oliver/ mnt
umount mnt
sudo umount mnt
ls
mount mnt /run/media/
mount mnt /run/media/oliver
sudo mount mnt /run/media/oliver
sudo mount --bind mnt /run/media/oliver
umount mnt
umount /run/media
sudo umount /run/media
sudo dnf install ./Clash.Verge-2.3.1-1.x86_64.rpm
sudo rm oliver/
sudo rm oliver/ -r
sudo umount oliver && sudo rm oliver/ -r
sudo mkdir oliver
stow udir/
cd 
ls
cd netinst/
ls
vi gnome-desktop.sh
git clone https://gitcode.com/gh_mirrors/ne/nerd-fonts.git ~/dld/nerd-fonts/ --depth 1
chmod +x ~/dld/nerd-fonts/install.sh
sh ~/dld/nerd-fonts/install.sh JetBrainsMono
sh ~/dld/nerd-fonts/install.sh CascadiaMono
rm ../.gitconfig 
git clone https://gitcode.com/gh_mirrors/ne/nerd-fonts.git ~/dld/nerd-fonts/ --depth 1
chmod +x ~/dld/nerd-fonts/install.sh
sh ~/dld/nerd-fonts/install.sh JetBrainsMono
sh ~/dld/nerd-fonts/install.sh CascadiaMono
fc-cache -fv
sudo dnf install python-pip
ls
sh ./gnome-theme.sh
sudo dnf install qbittorrent firefox bottles steam
steam
vi gnome-theme.sh 
sudo sh ~/Downloads/WhiteSur-gtk-theme/tweaks.sh 	--firefox flat ## firefox theme
cd
dnf search wechat
stow git
cd git/
vi .gitconfig 
:q
cl
chsh -s zsh
ls
exit
sudo dnf install proxychain
sudo dnf install proxychains
proxychains steam
cl
steam
dnf search adobe
dnf search source code
dnf search source code pro
dnf search dejavu
dnf search jetbrains mono
sudo dnf install jetbrains-mono-fonts
sudo dnf install jetbrains-mono-fonts-all
sudo dnf install jetbrains-mono-fonts
sudo dnf install ./WeChatLinux_x86_64.rpm
nvidia-smi
ff
cldea
dl
cl
df
lsusb
cl
cd
ls
la
proxychains bottles
sudo dnf install kdenlive
sudo dnf install kdenlive --exclude="vlc*"
mkdir doc/prj
cd doc/prj
ls
git clone https://github.com/FengZhongShaoNian/QWhiteSurGtkDecorations.git
cd QWhiteSurGtkDecorations/
ls
echo $SHELL
ls
mkdir build
cd build/
cl
cd ..
..
rm QWhiteSurGtkDecorations/ -r
clear
ls
dnf search code
dnf search code | grep microsoft
clear
sudo dnf install qt5-qtbase-devel qt5-qtsvg-devel qt5-qtwayland-devel qt5-qtwidgets-devel
chsh -s /usr/bin/zsh 
exit
https://github.com/FengZhongShaoNian/QWhiteSurGtkDecorations.git
git clone https://github.com/FengZhongShaoNian/QWhiteSurGtkDecorations.git
cd QWhiteSurGtkDecorations/
mkdir build
cd build/
cmake ..
sudo dnf install cmake
cmake ..
dnf list --installed | grep qt devel
dnf list --installed | grep qt | grep devel
dnf list --installed | grep qt 
vi ../CMakeLists.txt 
git clone https://github.com/LazyVim/starter ~/.config/nvim
ls
cd..
..
clear
cd
cd .dotfiles/
ls
stow nvim
rm ~/.config/nvim/lua/config/options.lua
stow nvim
vi
cd ../doc/prj/QWhiteSurGtkDecorations/
ls
vi
cmake [OPTIONS] [-DUSE_QT6=true] [-HAS_QT6_SUPPORT] ..
dnf search qt widget
dnf search qt widget devel
dnf search qt5 qtdeclar
sudo dnf install qt5-qtdeclarative-devel
dnf search qt5 qtwayland
sudo dnf install qt5-qtwayland-devel
sudo dnf install qt5-qtbase-private-devel
cmake ..
make
...
git clone https://github.com/FedoraQt/QAdwaitaDecorations.git
cd QAdwaitaDecorations/
ls
mkdir build && cd build
ls
cmake [OPTIONS] [-DUSE_QT6=true] [-HAS_QT6_SUPPORT] ..
make
clear
...
ls
cd QWhiteSurGtkDecorations/build/
ls
make
cd ..
ls
git clone https://src.fedoraproject.org/rpms/qt5-qtwayland.git
cd qt5-qtwayland/
ls
...
ls
cd prj/
ls
dnf search dconf-editor
la
cl
exit
sudo dnf remove celluloid
sudo dnf install mpv
cl
exit
