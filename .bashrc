# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# ░█▀█░█▀▀░░░█▀▀░█▀█░█▀▀░█▀▀░▀█▀░█▀▀░▀█▀░█▀▀░░
# ░█░█░▀▀█░░░▀▀█░█▀▀░█▀▀░█░░░░█░░█▀▀░░█░░█░░░░
# ░▀▀▀░▀▀▀░░░▀▀▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░░░▀▀▀░▀▀▀░░

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

# ░█░█░▀█▀░█▀▀░▀█▀░█▀█░█▀▄░█░█░░░█▄█░█▀█░█▀█░█▀█░█▀▀░█▀▀░█▄█░█▀▀░█▀█░▀█▀░░
# ░█▀█░░█░░▀▀█░░█░░█░█░█▀▄░░█░░░░█░█░█▀█░█░█░█▀█░█░█░█▀▀░█░█░█▀▀░█░█░░█░░░
# ░▀░▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░▀░░▀░░░░▀░▀░▀░▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░▀░░░

export HISTCONTROL=ignoreboth
export HISTSIZE=1000
export HISTFILESIZE=2000
shopt -s histappend

# ░█▀▄░▀█▀░█▀▀░█▀█░█░░░█▀█░█░█░░
# ░█░█░░█░░▀▀█░█▀▀░█░░░█▀█░░█░░░
# ░▀▀░░▀▀▀░▀▀▀░▀░░░▀▀▀░▀░▀░░▀░░░

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


# ░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░█▀▀░█▀▄░█▀▀░░
# ░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░█▀▀░█▀▄░▀▀█░░
# ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░░

# prepare
[ -d ~/.local/bin ] || {
    mkdir -p ~/.local/bin
}
export PATH=$PATH:$HOME/.local/bin:/home/linuxbrew/.linuxbrew/bin
# on Ubuntu, refresh apt db if older than a month
[ -f /var/lib/apt/periodic/update-success-stamp ] && {
    freshness=$(( $(date +%s) - $(stat -c%Y /var/lib/apt/periodic/update-success-stamp) ))
    [ $freshness -gt 2592000 ] && {
        sudo apt-get update
    }
}
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
# bat
[ "$(which bat)" == "" ] && {
    echo "# Installing bat";
    if [ $PKGER == "brew" ]; then
        brew install bat
    elif [ $PKGER == "apt" ]; then
        bat_version=0.10.0
        cd /tmp && \
            curl -sfLO https://github.com/sharkdp/bat/releases/download/v${bat_version}/bat_${bat_version}_amd64.deb && \
            sudo dpkg -i bat_${bat_version}_amd64.deb
        unset bat_version
    elif [ $PKGER == "apk" ]; then
        sudo apk add -y bat
    elif [ $PKGER == "yum" ]; then
        sudo yum install -y bat
    fi
}
# clipboard from shell
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
[ "$(which xclip)" == "" ] && {
    echo "# Installing xclip";
    if [ $PKGER == "apt" ]; then
        sudo apt-get install -y xclip
    elif [ $PKGER == "apk" ]; then
        sudo apk add -y xclip
    elif [ $PKGER == "yum" ]; then
        sudo yum install -y xclip
    fi
}
# clac RPN
[ "$(which clac)" == "" ] && {
    [ "$(which make)" != "" ] && {
        echo "# Installing clac";
        cd /tmp && \
            curl -LO https://github.com/soveran/clac/archive/0.3.2.tar.gz && \
            tar zxvf 0.3.2.tar.gz && \
            cd clac-0.3.2 && \
            make && \
            mv clac ~/.local/bin/
    }
}


# ░█░█░▀█▀░█▄█░░░█▀█░█░░░█░█░█▀▀░▀█▀░█▀█░█▀▀░░
# ░▀▄▀░░█░░█░█░░░█▀▀░█░░░█░█░█░█░░█░░█░█░▀▀█░░
# ░░▀░░▀▀▀░▀░▀░░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░░

[ -f $HOME/.vim/autoload/plug.vim ] || {
    echo "# Installing vim-plugin";
    [ -d $HOME/.vim/autoload ] && { mkdir -p $HOME/.vim/autoload; }
    curl -sfLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
    echo "  run :PlugInstall in .vim if you get the .vimrc file"
}

# ░█░█░█▀█░█▀▄░▀█▀░█▀█░█░█░█▀▀░░
# ░▀▄▀░█▀█░█▀▄░░█░░█░█░█░█░▀▀█░░
# ░░▀░░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░

export DISPLAY=unix:0
export DISPLAY=:0.0
export PULSE_SERVER=tcp:localhost
alias k=kubectl
export A='--all-namespaces'
# golang
[ -d /usr/local/go/bin ] && {
    export PATH=$PATH:/usr/local/go/bin:${HOME}/go/bin;
    export GOPATH=${HOME}/go
}
# ocaml
[ -f $HOME/.opam/opam-init/init.sh ] && {
    . $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true;
}
# wal, if present
[ -f $HOME/.cache/wal/sequences ] && {
    cat ~/.cache/wal/sequences && clear;
}
# vte
[ -f /etc/profile.d/vte.sh ] && {
    [ "${VTE_VERSION:-0}" -ge 3405 ] && {
      . /etc/profile.d/vte.sh;
      __vte_prompt_command;
}
}

# ░█░░░█▀█░█▀▀░█▀█░█░░░░
# ░█░░░█░█░█░░░█▀█░█░░░░
# ░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░░

[ -f $HOME/.local/bashrc ] && { echo "Sourcing local settings"; . $HOME/.local/bashrc; }
#
[ -f ~/welcome ] && { . ~/welcome; }

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
