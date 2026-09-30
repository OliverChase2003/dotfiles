# cd && zoxide
alias ...="../.."
alias ....="../../.."
alias .....="../../../.."
alias ......="../../../../.."
alias .1=".."
alias .2="../.."
alias .3="../../.."
alias .4="../../../.."
alias .5="../../../../.."
if command -v zoxide > /dev/null 2>&1; then
	alias z="zoxide"
fi
# ls && eza
if command -v eza > /dev/null 2>&1; then
	alias l="eza --group-directories-first --git --icons=auto"
	alias ll="eza -l --group-directories-first --git --icons=auto"
	alias la="eza -la --group-directories-first --git --icons=auto"
	alias lt="eza --tree --level=2 --group-directories-first --git"
	alias lt1="eza --tree --level=2 --group-directories-first --git"
	alias lt2="eza --tree --level=3 --group-directories-first --git"
	alias lt3="eza --tree --level=4 --group-directories-first --git"
else
	alias l="ls --group-directories-first"
	alias ll="ls -l --group-directories-first"
	alias la="ls -la --group-directories-first"
fi
# grep && rg
alias grep="grep --color=auto"
alias rg="rg --smart-case --hidden --glob='!.git/' --max-columns=200 --max-columns-preview"
# find && fd
if command -v fd > /dev/null 2>&1; then
	alias find="fd"
	alias fda="fd -H -I"
	alias fdd="fd -t d"
	alias fdf="fd -t f"
fi
# cat && bat
if command -v bat > /dev/null 2>&1; then
	alias cat="bat --style=plain"
	alias catn="bat -n"
fi
# ps && procs
if command -v procs > /dev/null 2>&1; then
	alias psa="procs"
	alias pst="procs --tree"
	alias psw="procs --watch"
fi
# df && duf
if command -v duf > /dev/null 2>&1; then
	alias df="duf"
fi
# du && dust
if command -v dust > /dev/null 2>&1; then
	alias du="dust"
fi
# tmux
alias tmux="tmux -f ~/.config/tmux/tmux.conf"
alias tm="tmux -f ~/.config/tmux/tmux.conf"
# clear
alias cl="clear"
# fastfetch
alias ff="fastfetch"
# git
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gp="git pull"
alias gP="git push"
alias gb="git branch"
alias gco="git checkout"
alias gcb="git checkout -b"
# yazi
alias yz="yazi"
# nvim
alias vi="LANG=en_US.UTF-8 nvim"
# gcc
alias cc="gcc"
# python3
alias py="python3"
