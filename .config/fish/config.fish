# fish
set -x theme_color_scheme 'dark'

# aliases
# colordiff
if test -x (which colordiff)
  alias diff="colordiff -u"
else
  alias diff="diff -u"
end

# exa
if test -x (which exa)
  alias ls="exa"
  alias ll="exa -lh -s date -s new --git"
  alias tree="exa -T"
end

# starship
eval (starship init fish)

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
