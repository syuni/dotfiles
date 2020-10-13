# theme
set -x theme_color_scheme 'dark'

# environments

# lang
set -x LANG en_US.UTF-8

# xdg base directory specification
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share

# bin
set -x PATH $HOME/.local/bin $PATH

# additional binaries
set -x PATH /usr/local/opt/mysql-client@5.7/bin $PATH

# asdf
source /opt/asdf-vm/asdf.fish

# go
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

# rust
set -x PATH $HOME/.cargo/bin $PATH

# python
set -x PIPENV_VENV_IN_PROJECT true

# flutter
set -x PATH $HOME/flutter/bin $PATH

# fzf
set -x FZF_LEGACY_KEYBINDINGS 1
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git"'
set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --preview "head -n 30 {}"'

# aliases

# colordiff
if type -q colordiff
  alias diff="colordiff -up"
else
  alias diff="diff -up"
end

# exa
if type -q exa
  alias ls="exa"
  alias ll="exa -lh -s date -s new --git"
  alias tree="exa -T"
end

# diff-so-fancy
if type -q diff-so-fancy
  alias dsf="diff-so-fancy"
end

# starship
if type -q starship
  starship init fish | source
end

# tmux
function attach_tmux_session_if_needed
  set ID (tmux list-sessions)
  if test -z "$ID"
    exec tmux new-session
    return
  end

  set new_session "Create New Session" 
  set ID (echo $ID\n$new_session | fzf | cut -d: -f1)
  if test "$ID" = "$new_session"
    exec tmux new-session
  else if test -n "$ID"
    exec tmux attach-session -t "$ID"
  end
end

if test -z $TMUX
  attach_tmux_session_if_needed
end
