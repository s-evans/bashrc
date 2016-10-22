#!/bin/bash

# TODO
# sed -i
# full file extension
# full file name

# TODO: Additional xargs pdf utility wrappers
# pdftoppm, pdftops, pdfimages, pdfinfo, pdftohtml, pdfdetach, pdffonts

## CONDITIONAL ALIASES ##
if [ "$ZSH" = "" ]; then
    alias cd='cd_func'
fi

## LISTING FILES ##
alias ls='ls --color=auto'

## GREP ##
alias grep='grep --color'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

## NAVIGATION ##
alias cd..='cd ..'
alias cd-='cd -'
alias ..='cd ..'
alias -- -='cd -'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias .6='cd ../../../../../..'
alias .7='cd ../../../../../../..'
alias .8='cd ../../../../../../../..'
alias .9='cd ../../../../../../../../..'
alias .10='cd ../../../../../../../../../..'
alias .11='cd ../../../../../../../../../../..'

## NETWORKING ##
alias nsl='nslookup'
case "$OSTYPE" in
    cygwin)
        alias arpp='arp -a'
        alias ifc='ipconfig'
        alias ifca='ipconfig /all'
        alias nbl='nblookup'
        alias ns='netstat -ano'
        alias rt='route PRINT'
        alias tracert='tracert'
        ;;
    *)
        alias arpp='arp -n'
        alias ifc='ifconfig'
        alias ifca='ifconfig -a'
        alias nbl='nmblookup'
        alias ns='netstat -anop'
        alias rt='route -n'
        alias tracert='traceroute'
        ;;
esac

## DEBIAN ##
alias agin='sudo apt-get install'
alias agrm='sudo apt-get remove'
alias agud='sudo apt-get update'
alias agug='sudo apt-get upgrade'
alias sudo='sudo ' # enable alias expansion following sudo

## GENERAL ##
alias ec='echo'
alias exp='export'
alias fef='sed "s/^.*\\.//"'
alias fnf='sed "s/\\.[^\\.]*$//"'
alias h='history'
alias info='info --vi-keys'
alias le='less'
alias mnt='mount'
alias p='pwd'
alias sp='ssh -p'
alias wa='watch'
alias xa='xargs '

## FILE PATH UTILS ##
alias esc='sed "s/./\\\\&/g"'
alias mkdir='mkdir -pv'
alias path='echo -e ${PATH//:/\\n}'

## PROCESSES ##
alias jk='jobs -p | xargs kill -9'

## VIM MISTAKES ##
alias :q=exit
alias :ed='vim'
alias :e='vim'
alias ed='vim'
alias v='vim'
alias vi='vim'

## SCREEN ##
alias scr='screen -aA'
alias scrr='screen -D -RR'
alias scrl='screen -list'

## XARGS SHORTCUTS ##
alias xbn='xargs -n1 basename'
alias xdn='xargs -n1 dirname'
alias xcp='xargs cp -t'
alias xmv='xargs mv -t'
alias xpdf2txt='xargs -n1 pdftotext -layout'

## CYGWIN SPECIFIC ##
alias cmdd='cmd /C start cmd'
alias ppwd='pwd | sed "s/./\\\\&/g" | xargs cygpath -aw'

## CLIPBOARD ##
case "$OSTYPE" in
    darwin*)
        alias c='pbcopy'
        alias v='pbpaste'
        ;;
    cygwin)
        if [ `type putclip 2>&1 > /dev/null` ]; then
            alias c='putclip'
            alias v='getclip'
        else
            alias c='tee > /dev/clipboard 2> /dev/null'
            alias v='cat /dev/clipboard'
        fi
        ;;
    *)
        alias c='xclip -i -selection clipboard'
        alias v='xclip -o -selection clipboard'
        ;;
esac

## OS SUPPORT ##
if [ "$OSTYPE" = "cygwin" ]; then
    alias su='cygstart --action=runas mintty'
    alias sudo='cygstart --action=runas '
fi

