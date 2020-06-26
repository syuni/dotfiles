# ----- environments -----

# Lang
export LANG=en_US.UTF-8

# Editor
export EDITOR=vim

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# homebrew
export PATH=/usr/local/sbin:$PATH

# asdf-vm
. /opt/asdf-vm/asdf.sh

# binutils
export PATH=/usr/local/opt/binutils/bin:$PATH

# haskell
export PATH=$HOME/.local/bin:$PATH

# clangd
export PATH=/usr/local/opt/llvm/bin:$PATH

# go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# rust
export PATH=$HOME/.cargo/bin:$PATH

# python
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

# flutter
export PATH=$HOME/flutter/bin:$PATH

# ----- execution -----

# tmux
if type -t tmux > /dev/null && [ $SHLVL = 1 ]; then
  exec tmux
elif type -t fish > /dev/null; then
  exec fish
fi
