if [ -e /etc/bash.bashrc ] ; then
  source /etc/bash.bashrc
fi

if [ -e "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

if [ -d "${HOME}/bin" ] ; then
  PATH=${HOME}/bin:${PATH}
fi

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

