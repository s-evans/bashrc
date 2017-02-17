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
case "$OSTYPE" in
    cygwin)
        alias nsl='nslookup'
        alias arpp='arp -a'
        alias ifc='ipconfig'
        alias ifca='ipconfig /all'
        alias ifconfig='ipconfig'
        alias nbl='nblookup'
        alias ns='netstat -ano'
        alias rt='route PRINT'
        alias tracert='tracert'
        ;;
    *)
        _create_completable_alias nsl "nslookup"
        _create_completable_alias arpp "arp -n"
        _create_completable_alias ifc "ifconfig"
        _create_completable_alias ifca "ifconfig -a"
        _create_completable_alias nbl "nmblookup"
        _create_completable_alias ns "netstat -anop"
        _create_completable_alias rt "route -n"
        _create_completable_alias tracert "traceroute"
        ;;
esac

## DEBIAN ##
_create_completable_alias agin "sudo apt-get install"
_create_completable_alias agrm "sudo apt-get remove"
_create_completable_alias agud "sudo apt-get update"
_create_completable_alias agug "sudo apt-get upgrade"
alias sudo='sudo ' # enable alias expansion following sudo

## GENERAL ##
_create_completable_alias ec 'echo'
_create_completable_alias exp 'export'
_create_completable_alias h 'history'
_create_completable_alias le 'less'
_create_completable_alias mnt 'mount'
_create_completable_alias p 'pwd'
_create_completable_alias sp 'ssh -p'
_create_completable_alias wa 'watch'
_create_completable_alias xa 'xargs '
alias fef='sed "s/^.*\\.//"'
alias fnf='sed "s/\\.[^\\.]*$//"'
alias info='info --vi-keys'

## FILE PATH UTILS ##
alias esc='sed "s/./\\\\&/g"'
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
if [[ "$OSTYPE" == 'cygwin' ]]; then
    alias cmdd='cmd /C start cmd'
    alias pwdd='cygpath -aw .'
    alias fpp='cygpath -aw'
fi

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
    alias start='cygstart'
else
    alias start='xdg-open'
fi

_create_completable_alias "+x" "chmod +x"
_create_completable_alias 000 "chmod 000"
_create_completable_alias 400 "chmod 400"
_create_completable_alias 600 "chmod 600"
_create_completable_alias 644 "chmod 644"
_create_completable_alias 655 "chmod 655"
_create_completable_alias 700 "chmod 700"
_create_completable_alias 744 "chmod 744"
_create_completable_alias 755 "chmod 755"
_create_completable_alias 777 "chmod 777"
_create_completable_alias bn "basename"
_create_completable_alias cs "cscope -Rqbk; ctags -R;"
_create_completable_alias ct "cleartool"
_create_completable_alias ctco "cleartool co -nc"
_create_completable_alias ctd "cleartool diff -diff_format -predecessor"
_create_completable_alias ctlsco "cleartool lsco -short"
_create_completable_alias ctlsh "cleartool lshistory"
_create_completable_alias ctlsp "cleartool lsprivate"
_create_completable_alias ctlsview "cleartool lsview -short"
_create_completable_alias ctlsvob "cleartool lsvob -short"
_create_completable_alias dn "dirname"
_create_completable_alias dr "diff -r"
_create_completable_alias drw "diff -rw"
_create_completable_alias dw "diff -w"
_create_completable_alias f "find"
_alias_completion_wrapper_setup fd "find -type d"
_alias_completion_wrapper_setup ff "find -type f"
_create_completable_alias fp "readlink -e"
_create_completable_alias g "grep"
_create_completable_alias ga "git add"
_create_completable_alias gm "git merge"
_create_completable_alias gmt "git mergetool"
_create_completable_alias gmb "git merge-base"
_create_completable_alias gf "git fetch"
_create_completable_alias gb "git branch"
_create_completable_alias gba "git branch --all"
_create_completable_alias gbc "git branch --contains"
_create_completable_alias gci "git commit -m"
_create_completable_alias gcl "git clone"
_create_completable_alias gco "git checkout"
_create_completable_alias gd "git diff --no-prefix"
_create_completable_alias gdt "git difftool"
_create_completable_alias gdh "git diff HEAD"
_create_completable_alias gi "grep -i"
_create_completable_alias giv "grep -iv"
_create_completable_alias gl "git log"
_create_completable_alias glm "git log --merges"
_create_completable_alias glp "git log -p"
_create_completable_alias gls "git ls-files"
_create_completable_alias glsc "git ls-files --cached"
_create_completable_alias glsd "git ls-files --deleted"
_create_completable_alias glsi "git ls-files --others --ignored --exclude-standard"
_create_completable_alias glsm "git ls-files --modified"
_create_completable_alias glso "git ls-files --others --exclude-standard"
_create_completable_alias gmv "git mv"
_create_completable_alias gpl "git pull"
_create_completable_alias gplo "git pull origin"
_create_completable_alias gplom "git pull origin master"
_create_completable_alias gps "git push"
_create_completable_alias gpso "git push origin"
_create_completable_alias gpsom "git push origin master"
_create_completable_alias gre "git remote"
_create_completable_alias grev "git remote -v"
_create_completable_alias grm "git rm"
_create_completable_alias grmr "git rm -r"
_create_completable_alias gs "git status"
_create_completable_alias gsm "git submodule"
_create_completable_alias gsma "git submodule add"
_create_completable_alias gsmu "git submodule update"
_create_completable_alias gsmui "git submodule update --init"
_create_completable_alias gss "git status --short"
_create_completable_alias gv "grep -v"
_create_completable_alias hd "hexdump -CV"
_create_completable_alias he "head"
_create_completable_alias hn "head -n"
_create_completable_alias k "kill"
_create_completable_alias k9 "kill -9"
_create_completable_alias ka "killall"
_create_completable_alias ka9 "killall -9"
_create_completable_alias l "ls -CF"
_create_completable_alias l. "ls -d .* --color=auto"
_create_completable_alias la "ls -A"
_create_completable_alias lc "ls -lcr"
_create_completable_alias lk "ls -lSr"
_create_completable_alias ll "ls -l --color=auto"
_create_completable_alias lla "ls -al --color=auto"
_create_completable_alias lop "lsof -p"
_create_completable_alias lr "ls -lR"
_create_completable_alias lt "ls -ltr"
_create_completable_alias lu "ls -lur"
_create_completable_alias lx "ls -lXB"
_create_completable_alias mk "make"
_create_completable_alias mkd "mkdir -pv"
_create_completable_alias objdumpp "objdump -d -M intel-mnuemonics"
_create_completable_alias po "pidoff"
_create_completable_alias psa "ps aux"
_create_completable_alias rs "rsync"
_create_completable_alias rsa "rsync -avz"
_create_completable_alias rsr "rsync -av"
_create_completable_alias sha1 "openssl sha1"
_create_completable_alias sl "ls"
_create_completable_alias sva "svn add"
_create_completable_alias svci "svn ci -m"
_create_completable_alias svco "svn co"
_create_completable_alias svd "svn diff"
_create_completable_alias svdw "svn diff -x -w"
_create_completable_alias svi "svn info"
_create_completable_alias svli "svn list"
_create_completable_alias svlir "svn list --recursive"
_create_completable_alias svlo "svn log"
_create_completable_alias svlod "svn log --diff"
_create_completable_alias svlodw "svn log --diff -x -w"
_create_completable_alias svrm "svn rm"
_create_completable_alias svrv "svn revert"
_create_completable_alias svs "svn status"
_create_completable_alias svu "svn up"
_create_completable_alias svuim "svn up --set-depth=immediates"
_create_completable_alias svuin "svn up --set-depth=infinity"
_create_completable_alias t "tail"
_create_completable_alias tc "tar czvf"
_create_completable_alias td "tar dzvf"
_create_completable_alias tf "tail -f"
_create_completable_alias tn "tail -n"
_create_completable_alias tt "tar tzvf"
_create_completable_alias tu "tar uzvf"
_create_completable_alias tx "tar xzvf"
_create_completable_alias vd "vimdiff"
_create_completable_alias wh "type -p"
_create_completable_alias which "type -p"
_create_completable_alias log "log=/tmp/scriptlog.\$\$ script --flush --quiet /tmp/scriptlog.\$\$"
