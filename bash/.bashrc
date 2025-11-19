if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

## === options === ##
source $HOME/.bash/options.sh

## === completes === ##
source $HOME/.bash/complete.sh

## === env === ##
source $HOME/.bash/env.sh

## === prompt === ##
source $HOME/.bash/prompt.sh

## === functions === ##
source $HOME/.bash/functions/*.sh

## === alias === ##
source $HOME/.bash/alias.sh
