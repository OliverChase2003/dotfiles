if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

bash_config_dir="$HOME/.config/bash"

## options
source ${bash_config_dir}/options.sh

## completes
source ${bash_config_dir}/completions/default.sh
source ${bash_config_dir}/completions/opencode.sh

## env
source $bash_config_dir/envs/bash.sh
source $bash_config_dir/envs/desktop.sh
source $bash_config_dir/envs/network.sh
source $bash_config_dir/envs/fzf.sh
source $bash_config_dir/envs/golang.sh
source $bash_config_dir/envs/node.sh
source $bash_config_dir/envs/rust.sh
source $bash_config_dir/envs/pi.sh
## alias
source $bash_config_dir/alias.sh

## functions
source $bash_config_dir/functions/fzf-bindings.sh

## open tmux automatically
## tmux alias is in env.sh above, specify the T-mux config path ~/.config/tmux/tmux.conf
## dont let it above tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [ -z "$TMUX" ]; then
  tmux attach || tmux new
fi
