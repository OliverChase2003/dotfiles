## xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

## rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

## node
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

## go
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/pkg/mod"
export GOCACHE="$XDG_CACHE_HOME/go-build"

## pi
export PI_CODING_AGENT_DIR="$XDG_CONFIG_HOME/pi/agent"
export PI_CODING_AGENT_SESSION_DIR="$XDG_CONFIG_HOME/pi/sessions"
