#!/bin/bash

## CONDITIONAL ALIASES ##
if [[ -n "$ZSH" || $- =~ "i" ]]; then
    alias cd='cd_func'
fi

## PLATFORM DETECTION ##
function _is_wsl() {
    grep -qi microsoft /proc/version
}

function _is_cygwin() {
    if [[ "$OSTYPE" == 'cygwin' ]]; then
        return 0
    else
        return 1
    fi
}

function _is_darwin() {
    if [[ "$OSTYPE" =~ "darwin" ]]; then
        return 0
    else
        return 1
    fi
}

## X ##
alias X='export DISPLAY=:0 && X $DISPLAY -multiwindow -silent-dup-error > /dev/null 2>&1 &'

## LISTING FILES ##
_create_completable_alias l   'ls -CF'
_create_completable_alias l.  'ls -d .* --color=auto'
_create_completable_alias la  'ls -A'
_create_completable_alias lc  'ls -lcr'
_create_completable_alias lk  'ls -lSr'
_create_completable_alias ll  'ls -l --color=auto'
_create_completable_alias lla 'ls -al --color=auto'
_create_completable_alias log 'log=/tmp/scriptlog.\$\$ script --flush --quiet /tmp/scriptlog.\$\$'
_create_completable_alias lop 'lsof -p'
_create_completable_alias lr  'ls -lR'
_create_completable_alias ls  'ls --color=auto'
_create_completable_alias lt  'ls -ltr'
_create_completable_alias lu  'ls -lur'
_create_completable_alias lx  'ls -lXB'
_create_completable_alias sl  'ls'

## GREP ##
_create_completable_alias fgrep 'fgrep --color=auto'
_create_completable_alias g     'grep'
_create_completable_alias gi    'grep -i'
_create_completable_alias giv   'grep -iv'
_create_completable_alias grep  'grep --color'
_create_completable_alias gv    'grep -v'

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
if _is_cygwin; then
    alias nsl='nslookup'
    alias arpp='arp -a'
    alias ifc='ipconfig'
    alias ifca='ipconfig /all'
    alias ifconfig='ipconfig'
    alias nbl='nblookup'
    alias ns='netstat -ano'
    alias rt='route PRINT'
    alias tracert='tracert'
else
    _create_completable_alias nsl     'nslookup'
    _create_completable_alias arpp    'arp -n'
    _create_completable_alias ifc     'ifconfig'
    _create_completable_alias ifca    'ifconfig -a'
    _create_completable_alias nbl     'nmblookup'
    _create_completable_alias ns      'netstat -anop'
    _create_completable_alias rt      'route -n'
    _create_completable_alias tracert 'traceroute'
fi

## DEBIAN ##
_create_completable_alias agin 'sudo apt-get install'
_create_completable_alias agrm 'sudo apt-get remove'
_create_completable_alias agud 'sudo apt-get update'
_create_completable_alias agug 'sudo apt-get upgrade'

## GENERAL ##
_create_completable_alias ec  'echo'
_create_completable_alias exp 'export'
_create_completable_alias h   'history'
_create_completable_alias le  'less'
_create_completable_alias mnt 'mount'
_create_completable_alias p   'pwd'
_create_completable_alias sp  'ssh -p'
_create_completable_alias wa  'watch'
_create_completable_alias xa  'xargs '
_create_completable_alias fef 'sed "s/^.*\\.//"'
_create_completable_alias fnf 'sed "s/\\.[^\\.]*$//"'

## FILE PATH UTILS ##
_create_completable_alias esc 'sed "s/./\\\\&/g"'
_create_completable_alias path 'echo -e ${PATH//:/\\n}'

## PROCESSES ##
alias kj='jobs -p | xargs kill -9'
_create_completable_alias k   'kill'
_create_completable_alias k9  'kill -9'
_create_completable_alias ka  'killall'
_create_completable_alias ka9 'killall -9'
_create_completable_alias psa 'ps aux'
_create_completable_alias po  'pidof'

## VIM ##
_create_completable_alias :q  'exit'
_create_completable_alias :ed 'vim'
_create_completable_alias :e  'vim'
_create_completable_alias ed  'vim'
_create_completable_alias v   'vim'
_create_completable_alias vi  'vim'
_create_completable_alias vd  'vimdiff'

## SCREEN ##
_create_completable_alias scr  'screen -aA'
_create_completable_alias scrr 'screen -D -RR'
_create_completable_alias scrl 'screen -list'

## XARGS SHORTCUTS ##
_create_completable_alias xbn      'xargs -n1 basename'
_create_completable_alias xdn      'xargs -n1 dirname'
_create_completable_alias xcp      'xargs cp -t'
_create_completable_alias xmv      'xargs mv -t'
_create_completable_alias xpdf2txt 'xargs -n1 pdftotext -layout'
_create_completable_alias xjoin    'sed "s/./\\\\&/g" | xargs printf "%q "'

## PATHS ##
if _is_cygwin; then
    alias cmdd='cmd /C start cmd'
    alias pwdd='cygpath -aw .'
    alias fpp='cygpath -aw'
elif _is_wsl; then
    alias cmdd='cmd /C start cmd'
    alias pwdd='wslpath -aw .'
    alias fpp='wslpath -aw'
fi

## CLIPBOARD ##
if _is_darwin; then
    alias c='pbcopy'
    alias v='pbpaste'
elif _is_wsl; then
    alias c='clip.exe'
    alias v='powershell.exe /c Get-Clipboard'
elif _is_cygwin; then
    if [[ $(type putclip 2>&1 > /dev/null) ]]; then
        alias c='putclip'
        alias v='getclip'
    else
        alias c='tee > /dev/clipboard 2> /dev/null'
        alias v='cat /dev/clipboard'
    fi
else
    alias c='xclip -i -selection clipboard'
    alias v='xclip -o -selection clipboard'
fi

## SUDO ##
if _is_cygwin; then
    alias su='cygstart --action=runas mintty'
    alias sudo='cygstart --action=runas '
fi

## START ##
if _is_cygwin; then
    alias start='cygstart'
else
    _create_completable_alias start 'gio open'
fi

## MISC DEV RELATED ##
_create_completable_alias hd       'hexdump -Cv'
_create_completable_alias mk       'make'
_create_completable_alias objdumpp 'objdump -d -M intel-mnuemonics'
_create_completable_alias msbuild  'MSBuild.exe'
_create_completable_alias vstest   'vstest.console.exe'
alias cs='cscope -Rqbk; ctags -R;'

## FIND ##
_alias_completion_wrapper_setup fd 'find -type d'
_alias_completion_wrapper_setup ff 'find -type f'
_create_completable_alias f        'find'

## CHMOD ##
_create_completable_alias '+x' 'chmod +x'
_create_completable_alias 000  'chmod 000'
_create_completable_alias 400  'chmod 400'
_create_completable_alias 600  'chmod 600'
_create_completable_alias 644  'chmod 644'
_create_completable_alias 655  'chmod 655'
_create_completable_alias 700  'chmod 700'
_create_completable_alias 744  'chmod 744'
_create_completable_alias 755  'chmod 755'
_create_completable_alias 777  'chmod 777'

## MISC FILE ##
_create_completable_alias bn  'basename'
_create_completable_alias dn  'dirname'
_create_completable_alias fp  'readlink -e'
_create_completable_alias mkd 'mkdir -pv'

## DIFF ##
_create_completable_alias dr  'diff -r'
_create_completable_alias drw 'diff -rw'
_create_completable_alias dw  'diff -w'

## GIT ##
_create_completable_alias ga    'git add'
_create_completable_alias gadog 'git log --decorate --oneline --graph --all'
_create_completable_alias gb    'git branch'
_create_completable_alias gba   'git branch --all'
_create_completable_alias gbc   'git branch --contains'
_create_completable_alias gci   'git commit'
_create_completable_alias gcm   'git commit -m'
_create_completable_alias gcl   'git clone'
_create_completable_alias gco   'git checkout'
_create_completable_alias gd    'git diff --no-prefix'
_create_completable_alias gdc   'git diff --cached'
_create_completable_alias gdh   'git diff HEAD'
_create_completable_alias gdog  'git log --decorate --oneline --graph'
_create_completable_alias gdt   'git difftool'
_create_completable_alias gdty  'git difftool -y'
_create_completable_alias gdtc  'git difftool --cached'
_create_completable_alias gf    'git fetch'
_create_completable_alias gl    'git log'
_create_completable_alias glm   'git log --merges'
_create_completable_alias glp   'git log -p'
_create_completable_alias gls   'git --no-pager ls-files'
_create_completable_alias glsb  'git --no-pager rev-parse --abbrev-ref HEAD'
_create_completable_alias glsc  'git --no-pager diff --name-only --cached'
_create_completable_alias glscr 'git --no-pager diff --name-only --cached --relative'
_create_completable_alias glsd  'git --no-pager ls-files --deleted'
_create_completable_alias glsi  'git --no-pager ls-files --others --ignored --exclude-standard'
_create_completable_alias glsm  'git --no-pager ls-files --modified'
_create_completable_alias glso  'git --no-pager ls-files --others --exclude-standard'
_create_completable_alias glsr  'git rev-parse --show-toplevel'
_create_completable_alias gm    'git merge'
_create_completable_alias gmb   'git merge-base'
_create_completable_alias gmt   'git mergetool'
_create_completable_alias gmty  'git mergetool -y'
_create_completable_alias gmv   'git mv'
_create_completable_alias gpl   'git pull'
_create_completable_alias gplo  'git pull origin'
_create_completable_alias gplom 'git pull origin master'
_create_completable_alias gps   'git push'
_create_completable_alias gpso  'git push origin'
_create_completable_alias gpsom 'git push origin master'
_create_completable_alias gre   'git remote'
_create_completable_alias grev  'git remote -v'
_create_completable_alias grm   'git rm'
_create_completable_alias grmr  'git rm -r'
_create_completable_alias gs    'git status'
_create_completable_alias gsm   'git submodule'
_create_completable_alias gsma  'git submodule add'
_create_completable_alias gsmu  'git submodule update'
_create_completable_alias gsmui 'git submodule update --init'
_create_completable_alias gss   'git status --short'

## SVN ##
_create_completable_alias sva    'svn add'
_create_completable_alias svci   'svn ci -m'
_create_completable_alias svco   'svn co'
_create_completable_alias svd    'svn diff'
_create_completable_alias svdw   'svn diff -x -w'
_create_completable_alias svi    'svn info'
_create_completable_alias svli   'svn list'
_create_completable_alias svlir  'svn list --recursive'
_create_completable_alias svlo   'svn log'
_create_completable_alias svlod  'svn log --diff'
_create_completable_alias svlodw 'svn log --diff -x -w'
_create_completable_alias svrm   'svn rm'
_create_completable_alias svrv   'svn revert'
_create_completable_alias svs    'svn status'
_create_completable_alias svu    'svn up'
_create_completable_alias svuim  'svn up --set-depth=immediates'
_create_completable_alias svuin  'svn up --set-depth=infinity'

## ClearCase ##
_create_completable_alias ct       'cleartool'
_create_completable_alias ctco     'cleartool co -nc'
_create_completable_alias ctd      'cleartool diff -diff_format -predecessor'
_create_completable_alias ctlsco   'cleartool lsco -short'
_create_completable_alias ctlsh    'cleartool lshistory'
_create_completable_alias ctlsp    'cleartool lsprivate'
_create_completable_alias ctlsview 'cleartool lsview -short'
_create_completable_alias ctlsvob  'cleartool lsvob -short'

## RSYNC ##
_create_completable_alias rs  'rsync'
_create_completable_alias rsa 'rsync -avz'
_create_completable_alias rsr 'rsync -av'

## UTILS ##
_create_completable_alias sha1     'openssl sha1'
_create_completable_alias grephunk 'grepdiff --output-matching=hunk'

## HEAD / TAIL ##
_create_completable_alias he 'head'
_create_completable_alias hn 'head -n'
_create_completable_alias t  'tail'
_create_completable_alias tf 'tail -f'
_create_completable_alias tn 'tail -n'

## TAR ##
_create_completable_alias tc 'tar czvf'
_create_completable_alias td 'tar dzvf'
_create_completable_alias tt 'tar tzvf'
_create_completable_alias tu 'tar uzvf'
_create_completable_alias tx 'tar xzvf'

## WINDOWS COMPAT ##
_create_completable_alias wh    'type -p'
_create_completable_alias which 'type -p'
