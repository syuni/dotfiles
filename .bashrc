# ----- environments -----

# Lang
export LANG=en_US.UTF-8

# Editor
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

# clangd
export PATH=/usr/local/opt/llvm/bin:$PATH

# go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
eval "$(goenv init -)"
# export PATH="$GOROOT/bin:$PATH"
# export PATH="$PATH:$GOPATH/bin"

# rust
export PATH=$HOME/.cargo/bin:$PATH

# v
export PATH=$HOME/.ghq/github.com/vlang/v:$PATH

# nodejs
export PATH=$HOME/.nodenv/bin:$PATH
eval "$(nodenv init -)"

# python
export PATH=$HOME/.pyenv/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
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

# ----- aliases -----

# diff
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

# exa
if [[ -x `which exa` ]]; then
  alias ls='exa'
  alias ll='exa -lha -s date -s new --git'
  alias tree='exa -T'
fi

# ----- execution -----
function tmux_attatch_session() {
  tmux ls > /dev/null
  if [ $? -eq 1 -a -z "$TMUX" ]; then
    exec tmux
  elif [ -z "$TMUX" ]; then
    exec tmux a
  fi
}

tmux_attatch_session
