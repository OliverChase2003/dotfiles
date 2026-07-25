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

## tmux
source $bash_config_dir/tmux_open.sh
