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
source $bash_config_dir/envs/dir.sh
source $bash_config_dir/envs/bash.sh
source $bash_config_dir/envs/cmdtool.sh
source $bash_config_dir/envs/desktop.sh
source $bash_config_dir/envs/network.sh
source $bash_config_dir/envs/fzf.sh

## alias
source $bash_config_dir/alias.sh

## functions
source $bash_config_dir/functions/fzf-bindings.sh

## tmux
source $bash_config_dir/start.sh
