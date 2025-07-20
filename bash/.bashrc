if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

## === options === ##
source $HOME/.bash/env.sh

## === env === ##
source $HOME/.bash/env.sh

## === prompt === ##
source $HOME/.bash/prompt.sh

## source $HOME/.ble.sh/out/ble.sh
## === functions === ##
source $HOME/.bash/functions/*.sh

## === alias === ##
source $HOME/.bash/alias.sh
