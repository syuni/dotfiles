# fish
set -x theme_color_scheme 'dark'

# aliases
if test -x (which colordiff)
  alias diff="colordiff -u"
else
  alias diff="diff -u"
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
