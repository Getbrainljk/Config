#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
PS2='> '
PS3='> '
PS4='+ '

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

alias ls="ls --color=always --classify --group-directories-first --human-readable"
alias l="ls -la --color=always --classify --group-directories-first --human-readable"
alias ll="ls -l --color=always --classify --group-directories-first --human-readable"
alias ..="cd .."
alias ne="emacs -geometry 70x50"
alias blih="python3.3 /usr/bin/blih.py"
alias tree="tree -C"
alias pi="ping 8.8.8.8"
alias go="geany"
alias gitpush="sh /usr/bin/my_git"
alias create="sh /usr/bin/my_rendu"
alias norme="sh /usr/bin/my_norme"