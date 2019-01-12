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

# Exports
export EDITOR=vim

# Shell history
HISTCONTROL=ignoreboth
HISTSIZE=1024
HISTFILESIZE=2048
shopt -s histappend

# Match glob star (**) in pathname expansion
shopt -s globstr

# Update shell if resized
shopt -s checkwinsize

# Custom Prompt
bash_set_prompt() {
	PS1="[\u@\h \W]\$ "
}
PROMPT_COMMAND=bash_set_prompt

# Change default configurations
alias ls="ls -h --color=auto"
alias grep="grep --color=auto"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
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

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
