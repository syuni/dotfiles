# fish
set -x theme_color_scheme 'light'

# XDG Base Directory Specification
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOM $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share

# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

# fzf
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git"'
set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --preview "head -n 30 {}"'

# fzf(fish integration (https://github.com/jethrokuan/fzf))
set -x FZF_LEGACY_KEYBINDINGS 0

# local-bin
set -x PATH $HOME/.local/bin $PATH

# golang
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

# rust (cargo)
set -x PATH $HOME/.cargo/bin $PATH

# python
set -x PIPENV_VENV_IN_PROJECT true

# binutils
set -g fish_user_paths "/usr/local/opt/binutils/bin" $fish_user_paths
