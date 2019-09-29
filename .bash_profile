# LANG
export LANG=ja_JP.UTF-8

# EDITOR
export EDITOR vim

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# homebrew
export PATH=/usr/local/sbin:$PATH

# binutils
export PATH=/usr/local/opt/binutils/bin:$PATH

# haskell
export PATH=$HOME/.local/bin:$PATH

# go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# rust
export PATH=$HOME/.cargo/bin:$PATH

# v
export PATH=$HOME/.ghq/github.com/vlang/v:$PATH

# nodejs
eval "$(nodenv init -)"

# python
eval "$(pyenv init -)"
export PIPENV_VENV_IN_PROJECT=true

# ocaml
export OPAM_SWITCH_PREFIX=$HOME/.opam/default
export CAML_LD_LIBRARY_PATH=$HOME/.opam/default/lib/stublibs:Updated by package ocaml
export OCAML_TOPLEVEL_PATH=$HOME/.opam/default/lib/toplevel
export PATH=$HOME/.opam/default/bin:$PATH

# fzf
export FZF_LEGACY_KEYBINDINGS=1
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "head -n 30 {}"'

# load bashrc
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# fish shell
exec fish
