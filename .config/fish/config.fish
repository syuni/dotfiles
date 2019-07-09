# fish
set -x theme_color_scheme 'light'

# XDG Base Directory Specification
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOM $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share

# lang
set -x LANG ja_JP.UTF-8

# editor
set -x EDITOR vim

# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

# fzf
set -x FZF_LEGACY_KEYBINDINGS 1
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git"'
set -x FZF_DEFAULT_OPTS '--height 80% --layout=reverse --border --preview "head -n 30 {}"'

# local-bin
set -x PATH $HOME/.local/bin $PATH

# golang
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

# rust (cargo)
set -x PATH $HOME/.cargo/bin $PATH

# python
eval (pyenv init - | source)
set -x PIPENV_VENV_IN_PROJECT true

# binutils
set -g fish_user_paths "/usr/local/opt/binutils/bin" $fish_user_paths

if [ -e ~/.dir_colors ]
  eval (dircolors -c ~/.dir_colors)
end

# aliases
if test -x (which colordiff)
  alias diff="colordiff"
end

# functions
function tmux_attatch_session
  tmux ls > /dev/null
  if [ $status -eq 1 -a -z "$TMUX" ]
    exec tmux
  else if [ -z "$TMUX" ]
    exec tmux a
  end
end

# tmux_attatch_session
alias tmuxa=tmux_attatch_session
alias ta=tmux_attatch_session
tmux_attatch_session
