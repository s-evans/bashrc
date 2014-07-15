#!/bin/bash

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Functions
if [ -f "${HOME}/.bash_functions" ]; then
    source "${HOME}/.bash_functions"
fi

# Aliases
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

# Local (for things that are system specific)
if [ -f "${HOME}/.bash_local" ]; then
  source "${HOME}/.bash_local"
fi

# Screen settings
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

PS1='\u@\h:\W$ '
EDITOR='vim'
PAGER='less'
USER=`whoami`
USERNAME=$USER

