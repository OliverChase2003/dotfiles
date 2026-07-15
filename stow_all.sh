## bash
rm $HOME/.bashrc $HOME/.bash_profile
stow bash

## kitty
rm $HOME/.config/kitty -rf
stow kitty

## tmux
rm $HOME/.tmux.conf
stow tmux

## git
rm $HOME/.gitconfig
stow git

## nvim
rm $HOME/.config/nvim -rf
stow nvim

## yazi
rm $HOME/.config/yazi -rf
stow yazi

## rime
rm $HOME/.config/ibus/rime -rf
stow rime

