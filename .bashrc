
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

PS1="[\u@\h \W]\\$ "

