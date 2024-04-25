#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
#alias config='/usr/bin/git --git-dir=/home/void/.cfg/ --work-tree=/home/void'
alias config='/usr/bin/git --git-dir=/home/void/dotfiles/ --work-tree=/home/void' 
