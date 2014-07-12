#!/bin/bash

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
alias grep='grep --color'                     # show differences in color
alias egrep='egrep --color=auto'              # show differences in color
alias fgrep='fgrep --color=auto'              # show differences in color

## NAVIGATION ##
alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back
alias cd..='cd ..'

## NETWORKING ##
alias neta='netstat -anop'
alias nsl='nslookup'
alias ifc='ifconfig'

## GIT ##
alias ga='git add'
alias gps='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gci='git commit -m'
alias gco='git checkout'
alias gpl='git pull'
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
alias svd='svn diff'
alias svrv='svn revert'
alias svrm='svn rm'
alias sva='svn add'

## TAR ##
alias tt='tar tzvf'
alias tc='tar czvf'
alias tx='tar xzvf'

## RSYNC ##
alias rs='rsync'
alias rsa='rsync -avz'

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
alias scr='screen'
alias scrr='screen -r'
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
alias le='less'
alias cs='cscope -Rqbk'

## HEAD AND TAIL ##
alias t='tail'
alias tf='tail -f'
alias tn='tail -n'
alias he='head'
alias hn='head -n'

## FILE PERMISSIONS ##
alias +x='chmod +x'
alias 000='chmod 000'
alias 400='chmod 400'
alias 600='chmod 600'
alias 644='chmod 644'
alias 655='chmod 655'
alias 700='chmod 700'
alias 744='chmod 744'
alias 755='chmod 755'
alias 777='chmod 777'

