#!/bin/bash
# server-specific config/aliases
# sourced in ~/.bash_ext (which is sourced in ~/.bashrc)
# (structure setup by https://github.com/purarue/bootstrap)

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
	eval "$(ssh-agent)"
	ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l >/dev/null || {
	ssh-add ~/.ssh/github
	ssh-add ~/.ssh/id_rsa
}

# super shell completion
complete -F _longopt super
shopt -s autocd

# super aliases
alias sctl='super --ctl'
alias sc=sctl

# glue-server stuff
alias glue_shell="cd ~/code/glue && renv ./production_server --shell"
alias glue_iex="cd ~/code/glue && renv ./production_server --iex"

# language-specific configuration
# node
export NPM_CONFIG_PREFIX="${HOME}/.local/share/npm-packages"
# elixir
export ERL_AFLAGS="-kernel shell_history enabled"
# golang
export GOROOT=/usr/local/go
export GOPATH=$HOME/.local/share/go
export GOBIN=$GOPATH/bin

SYNC_DIR="${HOME}/.ttally"
export TTALLY_DATA_DIR="$SYNC_DIR/ttally"
export REMINDER_SINK_SILENT_FILE="$SYNC_DIR/silent.txt"
export SELF_TYPES_FILE="$SYNC_DIR/.self_types.txt"

# update path
# include pyenv 3.11 bin at the front of the path so calling python/pip/python3 uses that
export PATH="/usr/sbin:$HOME/.pyenv/versions/3.11.3/bin:$HOME/.pyenv/bin:$HOME/.cargo/bin:$HOME/vps/bin:$HOME/vps:$HOME/.local/bin:$NPM_CONFIG_PREFIX/bin:$GOBIN:$PATH"
if [[ -e "$HOME/.ttally/repos" ]]; then
	export PATH="$HOME/.ttally/repos/ttally/bin:$HOME/.ttally/repos/personal/bin:$PATH"
fi

[[ -e "$HOME/.secrets.sh" ]] && . "$HOME/.secrets.sh"
# use asdf for version management
[[ -e $HOME/.asdf/asdf.sh ]] && . $HOME/.asdf/asdf.sh
