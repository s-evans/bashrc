#!/bin/bash

## PATH ##
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

## FUNCTIONS ##
if [ -f "${HOME}/.bash_functions" ]; then
    . "${HOME}/.bash_functions"
fi

## ALIASES ##
if [ -f "${HOME}/.bash_aliases" ]; then
    . "${HOME}/.bash_aliases"
fi

## SCREEN SETTINGS ##

screen_set_window_title ()
{
    local HPWD="$PWD"
    case $HPWD in
        $HOME)
            HPWD="~"
            ;;
        $HOME/*)
            HPWD="~${HPWD#$HOME}"
            ;;
    esac
    printf '\ek%s\e\\' "$USER@$HOSTNAME:$HPWD"
}

case "$TERM" in
    screen*)
        PROMPT_COMMAND="screen_set_window_title; $PROMPT_COMMAND"
        ;;
esac

## LESS SETTINGS ##
export LESSOPEN="| (type src-hilite-lesspipe.sh >/dev/null 2>&1 && src-hilite-lesspipe.sh %s)"
export LESS=' -R '

## HISTORY SETTINGS ##
export HISTTIMEFORMAT="%F %T "
export HISTSIZE=1000000
export HISTFILESIZE=1000000

## VARIABLES ##
export PS1='\[\e[1;32m\]\u@\h:\W$\[\e[0m\] '
export EDITOR='vim'
export PAGER='less -isXR '
export USER=`whoami`
export USERNAME=$USER

## SHELL OPTIONS ##
case "$SHELL" in
    *bash)
        shopt -s cdspell
        shopt -s autocd
        shopt -s extglob
        shopt -s cmdhist
        ;;
esac

## TTY OPTIONS ##
if [ -t 0 ]; then
    stty -ixon
fi

## ENABLE FUNCTIONS AND ALIASES IN COMMAND MODE ##
shopt -s expand_aliases
export BASH_ENV="${HOME}/.bashrc"

## SYSTEM SPECIFIC ##
if [ -f "${HOME}/.bash_local" ]; then
    . "${HOME}/.bash_local"
fi

