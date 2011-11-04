# Shell configuration
set -o notify
set -o ignoreeof
export HISTCONTROL=ignoredups

# Aliases to configure common commands
alias less='less -r'
alias more='less -r'
alias whence='type -a'
alias ls='ls -F'
alias ll='ls -l'
alias la='ls -A'
alias grep='grep --color'
alias cls='clear'

export CDPATH=.:$HOME:$HOME/Dropbox

# A function to pipe any command to less:
function so {
  eval "$@" |less -I~
}

if [ $INSIDE_EMACS ]; then
  export TERM=ansi
fi

# set a nice looking prompt:
use_color="true"
if [[ $TERM == "emacs" || $TERM == "dumb" ]]; then
  use_color=""
fi

if [ -z $use_color ]; then
  PS1="\n[\h] \w\n\$ "
else
#  PS1="\[\e]0;\w [\h]\a\]\n\[\e[32m\][\h] \[\e[33m\]\w\[\e[0m\]\n\$ "
  PS1="\n\e[32m\][\h] \[\e[33m\]\w\[\e[0m\]\n$ "
fi

# Perforce set up
export P4CONFIG=.p4config

# Cygwin configuration
if [ `uname -s` == "CYGWIN_NT-5.1" ]; then
  # open a file with the system file associations
  alias open='cygstart'

  # Drive letter aliases
  alias c:='cd /cygdrive/c'
  alias d:='cd /cygdrive/d'
  alias e:='cd /cygdrive/e'
  alias f:='cd /cygdrive/f'
  alias g:='cd /cygdrive/g'
  alias h:='cd /cygdrive/h'
  alias i:='cd /cygdrive/i'
  alias j:='cd /cygdrive/j'
  alias k:='cd /cygdrive/k'
  alias l:='cd /cygdrive/l'

  # Make perforce work with cygwin
  alias p4='p4 -d `cygpath -m $PWD`'
fi

if [ `uname -s` == "Darwin" ]; then
        function emacs {
                for f in "$@"
                do
                        test -e $f || touch $f
                done
                open -a /Applications/Emacs.app "$@"
        }
fi

# Make sure the default paths are picked up
export PATH=$HOME/bin:$HOME/dev/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/bin:/usr/local/git/bin:$PATH

# Add /opt/local to path
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export DISPLAY=:0.0

# Load any local settings
if [ -e "${HOME}/.bash_local" ] ; then
  source "${HOME}/.bash_local"
fi
