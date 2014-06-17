
alias cd=cd_func

alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias lla='ls -al --color=auto'
alias ls='ls --color=auto'
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #
alias sl='ls'

alias vi='vim'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias esc='sed "s/./\\&/g"'                   # escape all characters for sanitizing filenames with 'find | xargs'

alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

alias h='history'        # Shell History
alias p='pwd'

alias f='find'
alias ff='find -type f'
alias fd='find -type d'

alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gci='git commit -m'
alias gco='git checkout'
alias gpu='git pull'
alias gcl='git clone'

alias svnci='svn commit -m'
alias svnco='svn checkout'
alias svni='svn info'
alias svns='svn status'
alias svnu='svn up'
alias svnd='svn diff'
alias svnrv='svn revert'
alias svnrv='svn rm'
alias svna='svn add'

