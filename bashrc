# Guard for non-interactive shells.
[[ $- != *i* ]] && return

# Use ssh-agent
if [ -e "$XDG_RUNTIME_DIR/ssh-agent.socket" ]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

# Use the local bin directory, if available
if [ -d ~/bin ]; then
	PATH=$PATH:~/bin
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Exports
export EDITOR=vim

# Shell history
HISTCONTROL=ignoreboth
HISTSIZE=1024
HISTFILESIZE=2048
shopt -s histappend

# Match glob star (**) and dotfiles in pathname expansion
shopt -s globstar
shopt -s dotglob
shopt -s extglob

# Update shell if resized
shopt -s checkwinsize

# Custom Prompt
unset PS1
bash_set_prompt() {
	local debian_chroot
	if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
		debian_chroot=$(cat /etc/debian_chroot)
	fi

	PS1='\e[32m\u@\h\e[39m:\e[34m\W\e[39m \$ '

	if [[ $TERM =~ ^(rxvt|xterm) ]]; then
		PS1="\[\e]0;\u@\h: \w\a\]$PS1"
	fi
}
PROMPT_COMMAND=bash_set_prompt

# Enable color support
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# Change default configurations
alias ls="ls -h"
alias scp='scp -r'



# Enable colored man pages
man() {
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	command man "$@"
}

# Aliases
alias l="ls"
alias c="cd"
alias v="vim"

# Useful new commands
psgrep() {
	ps aux | grep $1 | grep -v grep
}

# enable programmable completion features
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi
