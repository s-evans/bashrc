#!/usr/bin/env bash

## FUNCTIONS ## 
if [ -f "${HOME}/.bash_functions" ]; then
    source "${HOME}/.bash_functions"
fi

## ALIASES ## 
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

## SCREEN SETTINGS ##
if [[ "$TERM" == screen* ]]; then
    screen_set_window_title () {
        local HPWD="$PWD"
        case $HPWD in
            $HOME) HPWD="~";;
            $HOME/*) HPWD="~${HPWD#$HOME}";;
        esac
        printf '\ek%s\e\\' "$USER@$HOSTNAME:$HPWD"
    }
    PROMPT_COMMAND="screen_set_window_title; $PROMPT_COMMAND"
fi

## LESS SETTINGS ##
export LESSOPEN="| (type src-hilite-lesspipe.sh >/dev/null 2>&1 && src-hilite-lesspipe.sh %s)"
export LESS=' -R '

## VARIABLES ##
export HISTTIMEFORMAT="%F %T "
export PS1='\[\e[1;32m\]\u@\h:\W$\[\e[0m\] '
export EDITOR='vim'
export PAGER='less -s '
export USER=`whoami`
export USERNAME=$USER
export SHELL=`type -p bash`

## SHELL OPTIONS ##
shopt -s cdspell
shopt -s autocd
shopt -s extglob
shopt -s cmdhist

## TTY OPTIONS ##
stty -ixon

## ENABLE FUNCTIONS AND ALIASES IN COMMAND MODE ##
shopt -s expand_aliases
export BASH_ENV="${HOME}/.bashrc"

## SYSTEM SPECIFIC ##
if [ -f "${HOME}/.bash_local" ]; then
  source "${HOME}/.bash_local"
fi

