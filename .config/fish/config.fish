set WORK_DIR (dirname (status --current-filename))

# theme
set -x theme_color_scheme 'dark'

if test -e $WORK_DIR/colors.fish
  source $WORK_DIR/colors.fish
end

# asdf-vm
source /opt/asdf-vm/asdf.fish

# aliases

# colordiff
if type -q colordiff
  alias diff="colordiff -u"
else
  alias diff="diff -u"
end

# exa
if type -q exa
  alias ls="exa"
  alias ll="exa -lh -s date -s new --git"
  alias tree="exa -T"
end

# lazygit
if type -q lazygit
  alias lg="lazygit"
end

# lazydocker
if type -q lazydocker
  alias ld="lazydocker"
end

# starship
if type -q starship
  eval (starship init fish)
end
