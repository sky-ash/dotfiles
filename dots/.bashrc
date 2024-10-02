#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias y='yay -S --noconfirm'
alias yayyy='yay -Syyu --noconfirm'
alias yeet='yay -Rcns'
alias neo='neo-matrix'

# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

export R_LIBS_USER=~/.rpackages