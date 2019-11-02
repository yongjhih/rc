# Author: Andrew Chen <yongjhih@gmail.com>
# CC, Creative Commons
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#pathmunge () {
  #if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
    #if [ "$2" = "after" ] ; then
      #PATH=$PATH:$1
    #else
      #PATH=$1:$PATH
    #fi
  #fi
  #export PATH
#}

#unpathmunge () {
  #PATH=$(echo $PATH| sed "s#:\?$1:\?##g")
  #export PATH
#}

# $__git_ps1

# rewritten with adamnfish.posterous.com/uber-ps1-with-added-git
if [ -f "$HOME/bash_completion.d/git" ]; then
	. "$HOME/bash_completion.d/git"
fi

export PATH=$PATH:$HOME/bin
_colors() {
  local NO_COLOUR="\[\033[0m\]"
  local BLUE="\[\033[0;34m\]"
  local LIGHT_BLUE="\[\033[1;34m\]"
  local RED="\[\033[0;31m\]"
  local LIGHT_RED="\[\033[1;31m\]"
  local WHITE="\[\033[1;37m\]"
  local GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  case $TERM in
    xterm*|rxvt*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

  PS1="${TITLEBAR}\
$LIGHT_RED\u$NO_COLOUR@$LIGHT_GREEN\h$NO_COLOUR:$LIGHT_BLUE\w$NO_COLOUR\
[$RED\d$NO_COLOUR $GREEN\t$NO_COLOUR]\$(__git_ps1 \"(%s)\")\n\
\$ "
}
#$LIGHT_BLUE\w$NO_COLOUR\$(__git_ps1 \"(%s)\")\$ "
_colors

EDITOR="vi"
VISUAL="$EDITOR"
#alias vi=nvim

function mkcd () {
  mkdir -p "$@" && eval cd "\"\$$#\""
}

function psgrep () {
  ps aux | grep "$1" | grep -v 'grep'
}

#function dpkgrep() {
  #dpkg --get-selections | grep "$1"
#}
alias dpkgrep='dpkg --get-selections | grep'

export PERL_CPANM_OPT="--local-lib=$HOME/perl"
export PERLLIB="$HOME/perl/lib/perl"
export PERL_CPANM_OPT="--local-lib=$HOME/perl5"
export PERL5LIB="$HOME/perl5/lib/perl5"

setup_proxy() {
	unset PROXY
	unset http_proxy
	unset https_proxy
	unset ftp_proxy

	[ "$1" ] || return
	export PROXY="http://$1"
	export http_proxy="http://$1"
	export https_proxy="https://$1"
	export ftp_proxy="ftp://$1"
}

setdown_proxy() {
	setup_proxy ""
}

# 5865 for ntlmaps
#ALL_PROXY=socks://localhost:8010/
#all_proxy=socks://localhost:8010/

#unset ALL_PROXY
#unset all_proxy
#unset NO_PROXY
#unset no_proxy

#NO_PROXY='localhost,127.0.0.0/8,*.local,'
#no_proxy='localhost,127.0.0.0/8,*.local,'

#export PROXY=http://10.8.27.228:3128/
#export http_proxy=http://10.8.27.228:3128/
#export https_proxy=https://10.8.27.228:3128/
#export ftp_proxy=ftp://10.8.27.228:3128/

#export PROXY="http://gbc-proxy:8080/"
#export http_proxy="http://gbc-proxy:8080/"
#export https_proxy="https://gbc-proxy:8080/"
#export ftp_proxy="ftp://gbc-proxy:8080/"

#export PROXY="http://10.8.9.9:8080/"
#export http_proxy="http://10.8.9.9:8080/"
#export https_proxy="https://10.8.9.9:8080/"
#export ftp_proxy="ftp://10.8.9.9:8080/"
#setup_proxy "10.8.9.9:8080"
#setup_proxy "192.168.1.2:8080"

#if [ ! `echo "$PATH" | grep "$HOME/workspace/GbcFeatureProvider/tools"` ]; then
#	PATH="$PATH:$HOME/workspace/GbcFeatureProvider/tools"
#fi

#export ANDROID_SRC="$HOME/workspace/android_src_froyo"
#export SDK="$HOME/sdk/android-sdk-linux_x86/tools:$HOME/sdk/android-sdk-linux_x86/platform-tools:$HOME/sdk/android-cts/tools"
#export ANDROID_SDK_TOOL="$SDK"
#export ANDROID_SRC="/home/andrew/workspace/android_src_froyo"
#export ANDROID_SDK_TOOL="/home/andrew/sdk/android-sdk-linux_x86/tools"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK="$ANDROID_HOME"
#export ANDROID_NDK="$HOME/Library/Android/ndk"
#export ANDROID_NDK_HOME="$ANDROID_NDK"
#export NDK="$ANDROID_NDK"
export PROGUARD_HOME="${ANDROID_HOME}/tools/proguard"

PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
PATH="$PATH:$HOME/android-ndk"
PATH="$PATH:$HOME/workspace/phabricator/arcanist/bin"
PATH="$PATH:$HOME/workspace/phabricator/phabricator/bin"

alias emuand='emulator -system system.img -data userdata.img -ramdisk ramdisk.img'

#export PYTHONPATH="$PYTHONPATH:$HOME/lib"
#export PYTHONPATH="$PYTHONPATH:$PYTHON_PATH:$HOME/lib"
#export PYTHONPATH="$(dirname `which python`)"

#set bell-style visible

function _screen-ps()
{
  case $TERM in
    #xterm*|rxvt*)
    #  export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}[`basename ${PWD}`]\007"'
    #  ;;
    #screen*)
    #  export PROMPT_COMMAND='echo -ne "\033k\033\134\033k${HOSTNAME}[`basename ${PWD}`]\033\134"'
    #  ;;
    *)
      export PROMPT_COMMAND='echo -ne "\033k`basename "${PWD}"`\033\\"'
      ;;
  esac
}
_screen-ps

git-forall()
{
	find -type d -name .git | while read line; do
		repo_path="${line%*/.git}"
		repo_path="${repo_path#./}"
		pushd "$repo_path"
		echo "export REPO_PATH=\"$repo_path\" ; $@" | bash
		popd
	done
}

#export JAVAHOME=/usr/lib/jvm/java-1.6-sun
#export GREP_OPTIONS='-rIPs --exclude-dir=.[a-zA-Z0-9]* --exclude=.* --exclude=*~ --color=auto'
#alias cgrep='grep --color=always'
#export PATH="$PATH:/var/lib/gems/1.8/bin"
#update-java-alternatives -l
#export JAVA_HOME=/usr/lib/jvm/java-7-oracle
#export PATH=$PATH:$JAVA_HOME/bin
#export CLASSPATH=$JAVA_HOME/lib
#export JRE_HOME=$JAVA_HOME/jre
#export JAVA8_HOME="/usr/lib/jvm/java-8-oracle"
#export JAVA7_HOME="/usr/lib/jvm/java-7-oracle"
#export JAVA_HOME="$JAVA8_HOME"

bd()
{
	if [ ! "$1" ]; then
		echo "Usage: bd <regex>"
		return 1
	fi

	# 1. non regex
	todir="${PWD%*/$1*}/$1"
	echo "$todir"
	todir="${PWD%/$1*}/$1"
	echo "$todir"
	todir="${PWD%/$1/*}/$1/"
	#[ -d "$todir" ] && ( cd "$todir" ; return 0 )
	if [ -d "$todir" ]; then
		cd "$todir"
		return 0
	fi

	# 2. regex
	if echo "$PWD" | grep "$1" > /dev/null 2>&1; then
		todir=`echo "$PWD" | sed "s#\(.*[^/]*$1[^/]*\).*#\1#"`
	fi
	if [ -d "$todir" ]; then
		cd "$todir"
		return 0
	fi

	# 3. regex
	T="/tmp"
	cwd="`readlink -f $PWD`"
	while [ "$cwd" != "/" ]; do
		local lines=
		if [ -f "$T/filelist" ]; then
			lines=($(grep "$1" $T/filelist | sed -e 's/\/[^/]*$//' | sort | uniq))
		fi
		local pathname
		local choice
		if [[ "${#lines[@]}" > 1 ]]; then
			while [[ -z "$pathname" ]]; do
				local index=1
				local line
				for line in ${lines[@]}; do
					printf "%6s %s\n" "[$index]" $line
					index=$(($index + 1))
				done
				echo
				echo -n "Select one: "
				unset choice
				read choice
				if [[ $choice -gt ${#lines[@]} || $choice -lt 1 ]]; then
					echo "Invalid choice"
					continue
				fi
				pathname=${lines[$(($choice-$_arrayoffset))]}
			done
		else
			# even though zsh arrays are 1-based, $foo[0] is an alias for $foo[1]
			pathname=${lines[0]}
		fi
		if [ "$pathname" ]; then
			cd "$pathname"
			return 0
		fi
		if [ -f "$T/filelist" ]; then
			#find "$cwd" -wholename ./out -prune -o -wholename ./.repo -prune -o -type f
			f=`find "$cwd"`
			ff=`cat "$T/filelist"`
			echo -e "$f\n$ff" | grep -v '^.\s*$' | sort | uniq > "$T/filelist"
		else
			find "$cwd" | grep -v '^.\s*$' > "$T/filelist"
		fi
		cwd="`readlink -f $cwd/..`"
	done
	echo "Not found"

	return 1
}
_xarray=(a b c)
if [ -z "${_xarray[${#_xarray[@]}]}" ]
then
_arrayoffset=1
else
_arrayoffset=0
fi
unset _xarray

#..() {
	#local todir="."
	#[ "$1" ] || todir=".."

	#while [ "$1" ]; do
		#for ((i=0; i < "$1"; i++)); do
			#todir="$todir/.."
			#if [ "/" = `readlink -f $todir` ]; then
				#break
			#fi
		#done
		#shift
	#done
	#cd "$todir"
#}

function cd-safe() {
if [ "$1" ]; then
	local d="$1"
	if [ -f "$d" ]; then
		d="`dirname \"$1\"`"
	fi
	if [ ! -d "$d" ]; then
		:
		#echo "mkdir -p $d"
		#mkdir -p "$d"
	fi
fi
command cd "$d"
}

export C_INCLUDE_PATH="$C_INCLUDE_PATH:$HOME/include"
export LIBRARY_PATH="$LIBRARY_PATH:$HOME/lib"
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/lib"

#export PATH="$PATH:$HOME/pip/bin"

export GEM_PATH=$HOME/gems
export PATH="/usr/local/bin:$HOME/local/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"
export PATH="/usr/local/bin:$HOME/local/bin:$PATH:/usr/local/bin"

export USE_CCACHE=1
#export CCACHE_DIR="$HOME/.ccache"
#export OUT_DIR_COMMON_BASE="$HOME/tmp/android-out-common"
export CCACHE_DIR="/tmp/ccache"

#export GIT_SSH="/home/andrew/bin/connect-proxy-ssh"
#export GIT_PROXY_COMMAND="/home/andrew/bin/connect-proxy"
#export TERM="xterm-256color"
#export TERM=screen-256color
alias kiall='killall'
alias drush-dl='drush dl --package-handler=git_drupalorg'
alias cd='cd-safe'
#alias rm='rm-safe'
#
#function rm-safe() {
#while [ "$1" ]; do
#	if [ "$1" = "/" ]; then
#		echo "WTF /"
#		return 1
#	fi
#	shift
#done
##rm "$@"
#}
#
export TERM=screen-256color
#export http_proxy=http://10.8.9.9:8080
#export https_proxy=http://10.8.9.9:8080

#export LANGUAGE=en:zh_TW:zh
export LANGUAGE=en
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_MESSAGE=en_US.UTF-8
alias j='autojump'

USER_BASH_COMPLETION_DIR="$HOME/.bash_completion.d"

if [[ -d $USER_BASH_COMPLETION_DIR && -r $BASH_COMPLETION_DIR && \
    -x $USER_BASH_COMPLETION_DIR ]]; then
    for i in $(LC_ALL=C command ls "$USER_BASH_COMPLETION_DIR"); do
        i=$USER_BASH_COMPLETION_DIR/$i
        # [[ ${i##*/} != @(*~|*.bak|*.swp|\#*\#|*.dpkg*|*.rpm@(orig|new|save)|Makefile*) \
        #    && -f $i && -r $i ]] && . "$i"
    done
fi
unset i

#export JAVA8_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
#export JAVA7_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
#export JAVA_HOME="$JAVA8_HOME"
#export JAVA_HOME=$(/usr/libexec/java_home)

export PATH=$HOME/.local/bin:$PATH
#export NODE_PATH=/usr/local/lib/node_modules

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Python path
#export PATH="${PATH}:/usr/local/opt/python/libexec/bin"

### Flutter

export FLUTTER_ROOT="$HOME/works/flutter"
export PATH="$PATH:${FLUTTER_ROOT}/bin"

[ -f ~/.git-prompt.sh ] && . ~/.git-prompt.sh
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
#. "/usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh"
#. ~/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
#. ~/powerline.sh

# added by travis gem
[ -f /Users/yongjhih/.travis/travis.sh ] && source /Users/yongjhih/.travis/travis.sh

if [ -d ~/.bash_completion.d ]; then
    for file in ~/.bash_completion.d/*; do
        . $file
    done
fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# ref. https://docs.docker.com/docker-for-mac/#install-shell-completion
# etc=/Applications/Docker.app/Contents/Resources/etc
# ln -s $etc/docker.bash-completion $(brew --prefix)/etc/bash_completion.d/docker
# ln -s $etc/docker-machine.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-machine
# ln -s $etc/docker-compose.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-compose
docker_etc="/Applications/Docker.app/Contents/Resources/etc"
if [ -d $docker_etc ]; then
    . $docker_etc/docker.bash-completion
    . $docker_etc/docker-machine.bash-completion
    . $docker_etc/docker-compose.bash-completion
fi

#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

export PATH="$(pwd)/flutter/bin:${PATH}"

#A valid GOPATH is required to use the `go get` command.
#If $GOPATH is not specified, $HOME/go will be used by default:
#  https://golang.org/doc/code.html#GOPATH
#
#  You may wish to add the GOROOT-based install location to your PATH:
#    export PATH=$PATH:/usr/local/opt/go/libexec/bin
[ -d "${HOME}/go" ] && export GOPATH=${GOPATH:-${HOME}/go}
[ -d "${GOPATH}/bin" ] && export PATH="${GOPATH}/bin:${PATH}"
export PATH="$PATH:${HOME}/Library/Python/3.6/bin"

export PATH="$PATH:/usr/local/opt/coreutils/libexec/gnubin"

#  Additionally, you can access their man pages with normal names if you add
#  the "gnuman" directory to your MANPATH from your bashrc as well:
export MANPATH="$MANPATH:/usr/local/opt/coreutils/libexec/gnuman"



# If you need to have openssl first in your PATH run:
# echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> ~/.bash_profile
# 
# For compilers to find openssl you may need to set:
# export LDFLAGS="-L/usr/local/opt/openssl/lib"
# export CPPFLAGS="-I/usr/local/opt/openssl/include"
# 
# ==> Summary
# 🍺  /usr/local/Cellar/openssl/1.0.2q: 1,794 files, 12.3MB
# ==> Installing tmux
# ==> Downloading https://homebrew.bintray.com/bottles/tmux-2.8.sierra.bottle.tar.gz
# ######################################################################## 100.0%
# ==> Pouring tmux-2.8.sierra.bottle.tar.gz
# ==> Caveats
# Example configuration has been installed to:
# /usr/local/opt/tmux/share/tmux
# 
# Bash completion has been installed to:
# /usr/local/etc/bash_completion.d
# ==> Summary
# 🍺  /usr/local/Cellar/tmux/2.8: 10 files, 709.5KB
# ==> Caveats
# ==> openssl
# A CA file has been bootstrapped using certificates from the SystemRoots
# keychain. To add additional certificates (e.g. the certificates added in
# the System keychain), place .pem files in
# /usr/local/etc/openssl/certs
# 
# and run
# /usr/local/opt/openssl/bin/c_rehash
# 
# openssl is keg-only, which means it was not symlinked into /usr/local,
# because Apple has deprecated use of OpenSSL in favor of its own TLS and crypto libraries.
# 
# If you need to have openssl first in your PATH run:
# echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> ~/.bash_profile
# 
# For compilers to find openssl you may need to set:
# export LDFLAGS="-L/usr/local/opt/openssl/lib"
# export CPPFLAGS="-I/usr/local/opt/openssl/include"
# 
# ==> tmux
# Example configuration has been installed to:
# /usr/local/opt/tmux/share/tmux
# 
# Bash completion has been installed to:
# /usr/local/etc/bash_completion.d



IDF_PATH=$HOME/works/esp-idf
