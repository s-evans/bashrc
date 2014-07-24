#!/bin/bash

# TODO
# sed -i 
# full file extension
# full file name

## CONDITIONAL ALIASES ##
if [[ $ZSH == "" ]]; then
    alias cd='cd_func'
fi

## LISTING FILES ## 
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias lla='ls -al --color=auto'
alias ls='ls --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'              # sort by change time
alias lu='ls -lur'              # sort by access time
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date
alias l.='ls -d .* --color=auto'
alias f='find'
alias ff='find -type f'
alias fd='find -type d'

## GREP ## 
alias g='grep'
alias gi='grep -i'
alias gv='grep -v'
alias giv='grep -i -v'
alias grep='grep --color'                     # show differences in color
alias egrep='egrep --color=auto'              # show differences in color
alias fgrep='fgrep --color=auto'              # show differences in color

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
alias neta='netstat -anop'
alias nsl='nslookup'
alias ifc='ifconfig'

## GIT ##
alias ga='git add'
alias gps='git push'
alias gpso='git push origin'
alias gpsom='git push origin master'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gci='git commit -m'
alias gco='git checkout'
alias gpl='git pull'
alias gplo='git pull origin'
alias gplom='git pull origin master'
alias gcl='git clone'
alias gsm='git submodule'
alias gmv='git mv'
alias gre='git remote'

## SVN ##
alias svci='svn commit -m'
alias svco='svn checkout'
alias svi='svn info'
alias svs='svn status'
alias svu='svn up'
alias svuin='svn up --set-depth=infinity'
alias svuim='svn up --set-depth=immediates'
alias svd='svn diff'
alias svrv='svn revert'
alias svrm='svn rm'
alias sva='svn add'
alias svli='svn list'
alias svlir='svn list --recursive'
alias svlo='svn log'
alias svlod='svn log --diff'

## TAR ##
alias tt='tar tzvf'
alias tc='tar czvf'
alias tx='tar xzvf'
alias td='tar dzvf'
alias tu='tar uzvf'
alias tr='tar rzvf'

## RSYNC ##
alias rs='rsync'
alias rsa='rsync -avz'
alias rsr='rsync -av'

## DEBIAN ##
alias agud='sudo apt-get update'
alias agug='sudo apt-get upgrade'
alias agrm='sudo apt-get remove'
alias agin='sudo apt-get install'

## GENERAL ##
alias xa='xargs '
alias vi='vim'
alias psa='ps aux'
alias h='history'
alias p='pwd'
alias al='alias'
alias ex='exit'
alias wh='which'
alias mk='make'
alias exp='export'
alias src='source'
alias scr='screen -aA'
alias scrr='screen -D -RR'
alias scrl='screen -list'
alias ec='echo'
alias mkdir='mkdir -pv'
alias mkd='mkdir -pv'
alias mnt='mount'
alias wa='watch'
alias esc='sed "s/./\\\\&/g"'    # escape all characters for sanitizing filenames with 'find | xargs'
alias k='kill'
alias k9='kill -9'
alias ka='killall'
alias ka9='killall -9'
alias jk='jobs -p | xargs kill -9'
alias le='less'
alias cs='cscope -Rqbk'
alias sha1='openssl sha1'
alias bn='basename'
alias dn='dirname'
alias xbn='xargs -n1 basename'
alias xdn='xargs -n1 dirname'
alias xcp='xargs cp -t'
alias xmv='xargs mv -t' 
alias sp='ssh -p'
alias fnf='sed "s/\\.[^\\.]*$//"'
alias fef='sed "s/^.*\\.//"'
alias fp='readlink -f'
alias path='echo -e ${PATH//:/\\n}'
alias po='pidof'
alias lop='lsof -p'

## HEAD AND TAIL ##
alias t='tail'
alias tf='tail -f'
alias tn='tail -n'
alias he='head'
alias hn='head -n'

## DIFF ## 
alias dr='diff -r'
alias dw='diff -w'
alias drw='diff -rw'

## FILE PERMISSIONS ##
alias -- +x='chmod +x'
alias 000='chmod 000'
alias 400='chmod 400'
alias 600='chmod 600'
alias 644='chmod 644'
alias 655='chmod 655'
alias 700='chmod 700'
alias 744='chmod 744'
alias 755='chmod 755'
alias 777='chmod 777'

