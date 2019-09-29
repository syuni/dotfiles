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
