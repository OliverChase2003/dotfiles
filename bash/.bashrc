if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

bash_config_dir="$HOME/.config/bash"

## options
source ${bash_config_dir}/options.sh

## completes
source ${bash_config_dir}/completions/*.sh

## env
source ${bash_config_dir}/envs/ena_*.sh

## alias
source ${bash_config_dir}/alias/ena_*.sh

## functions
source ${bash_config_dir}/functions/ena_*.sh

## open tmux automatically
## tmux alias is in env.sh above, specify the T-mux config path ~/.config/tmux/tmux.conf
## dont let it above tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [ -z "$TMUX" ]; then
  tmux attach || tmux new
fi
