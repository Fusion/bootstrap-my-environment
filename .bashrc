# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
# OS Specific
case "$(uname)" in
    Linux)
        export OS=Linux
        if [ "$(which apt-get)" != "" ]; then
            export PKGER="apt"
        elif [ "$(which apk)" != "" ]; then
            export PKGER="apk"
        elif [ "$(which yum)" != "" ]; then
            export PKGER="yum"
        else
            export PKGER="unknown"
        fi
    ;;
    Darwin)
        export OS=OSX
        export PKGER="brew"
    ;;
    *)
    ;;
esac
[ "$PKGER" == "brew" ] && export BREW="1"
# History Management
export HISTCONTROL=ignoreboth
export HISTSIZE=1000
export HISTFILESIZE=2000
shopt -s histappend
# Display
shopt -s checkwinsize
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac
if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt
# 
alias ls="ls -G"
export EDITOR="vim"
export VISUAL="vim"
export PAGER="bat"
alias man='LC_ALL=C LANG=C man'
alias vi="vim"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias ll="ls -alF"
alias l="ls -CF"
[ "$(whoami)" == "root" ] && { alias sudo=; }
#
[ "$OS" == "OSX" ] && { export PATH="~/bin/osx:${PATH}"; } || { export PATH="~/bin/linux:${PATH}"; }
# direnv
[ "$(which direnv)" == "" ] && {
    echo "# Installing direnv";
    if [ $PKGER == "brew" ]; then
        brew install direnv
    elif [ $PKGER == "apt" ]; then
        sudo apt-get install -y direnv
    elif [ $PKGER == "apk" ]; then
        sudo apk add -y direnv
    elif [ $PKGER == "yum" ]; then
        sudo yum install -y direnv
    fi
}
eval "$(direnv hook bash)"
# fasd
[ "$(which fasd)" == "" ] && {
    echo "# Installing fasd";
    if [ $PKGER == "brew" ]; then
        brew install fasd
    elif [ $PKGER == "apt" ]; then
        sudo apt-get install -y fasd
    elif [ $PKGER == "apk" ]; then
        sudo apk add -y fasd
    elif [ $PKGER == "yum" ]; then
        sudo yum install -y fasd
    fi
}
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
# vim plugins
[ -f $HOME/.vim/autoload/plug.vim ] || {
    echo "# Installing vim-plugin";
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master#;
}

# various
export DISPLAY=:0.0
export PULSE_SERVER=tcp:localhost
alias k=kubectl
export A='--all-namespaces'
# golang
[ -d /usr/local/go/bin ] && {
    export PATH=$PATH:/usr/local/go/bin;
}
# ocaml
[ -f $HOME/.opam/opam-init/init.sh ] && {
    . $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true;
}
#
[ -f ~/welcome ] && { . ~/welcome; }
