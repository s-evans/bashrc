#!/usr/bin/env bash

# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain

# TODO: Fix this for cases that the current directory doesn't exist

cd_func ()
{
    local x2 the_new_dir adir index
    local -i cnt

    if [[ $1 ==  "--" ]]; then
        dirs -v
        return 0
    fi

    the_new_dir=$1
    [[ -z $1 ]] && the_new_dir=$HOME

    if [[ ${the_new_dir:0:1} == '-' ]]; then
        # Extract dir N from dirs
        index=${the_new_dir:1}
        [[ -z $index ]] && index=1
        adir=$(dirs +$index)
        [[ -z $adir ]] && return 1
        the_new_dir=$adir
    fi

    # '~' has to be substituted by ${HOME}
    [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

    # Now change to the new dir and add to the top of the stack
    pushd "${the_new_dir}" > /dev/null
    [[ $? -ne 0 ]] && return 1
    the_new_dir=$(pwd)

    # Trim down everything beyond 11th entry
    popd -n +11 2>/dev/null 1>/dev/null

    # Remove any other occurence of this dir, skipping the top of the stack
    for ((cnt=1; cnt <= 10; cnt++)); do
        x2=$(dirs +${cnt} 2>/dev/null)
        [[ $? -ne 0 ]] && return 0
        [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
        if [[ "${x2}" == "${the_new_dir}" ]]; then
            popd -n +$cnt 2>/dev/null 1>/dev/null
            cnt=cnt-1
        fi
    done

    return 0
}

extract () 
{
    if [[ $# == 0 ]]; then
        echo "invalid argument count"
        return
    fi

    while [[ $# != 0 ]]; do 

        if [[ ! -f $1 ]] ; then
            echo "file '$1' not found"
            shift
            continue
        fi

        case $1 in
            *.tar.bz2)  tar         xvjf    $1    ;;
            *.tar.gz)   tar         xvzf    $1    ;;
            *.bz2)      bunzip2     $1      ;;
            *.rar)      rar         x       $1    ;;
            *.gz)       gunzip      $1      ;;
            *.tar)      tar         xvf     $1    ;;
            *.tbz2)     tar         xvjf    $1    ;;
            *.tgz)      tar         xvzf    $1    ;;
            *.zip)      unzip       $1      ;;
            *.jar)      unzip       $1      ;;
            *.Z)        uncompress  $1      ;;
            *.7z)       7z          x       $1    ;;
            *.xz)       unxz        $1      ;;
            *)          echo "don't know how to extract '$1'..."  ;;
        esac

        shift
    done
}

compress () 
{
    FILE=$1
    shift
    case $FILE in
        *.tar.bz2)  tar   cjf        $FILE  "$@"           ;;
        *.tar.gz)   tar   czf        $FILE  "$@"           ;;
        *.tgz)      tar   czf        $FILE  "$@"           ;;
        *.jar)      zip   $FILE      "$@"     ;;
        *.zip)      zip   $FILE      "$@"     ;;
        *.rar)      rar   $FILE      "$@"     ;;
        *)          echo "Filetype not recognized"  ;;
    esac
}

mkcd() 
{
    if [[ $# != 1 ]]; then
        echo "invalid argument list"
        return
    fi

    mkdir -p $1
    cd $1
}

dl()
{ 
    if [[ $# < 2 ]]; then
        echo "invalid argument list"
        return
    fi

    LINE="$1"
    shift
    sed -i "${LINE}d" "$@"
}

urlencode() 
{
    local LANG=C
    arg="$1"
    i="0"
    while [ "$i" -lt ${#arg} ]; do
        c=${arg:$i:1}
        if echo "$c" | grep -q '[a-zA-Z/:_\.\-]'; then
            echo -n "$c"
        else
            echo -n "%"
            printf "%X" "'$c'"
        fi
        i=$((i+1))
    done
}

urldecode() 
{
    local LANG=C
    arg="$1"
    i="0"
    while [ "$i" -lt ${#arg} ]; do
        c0=${arg:$i:1}
        if [ "x$c0" = "x%" ]; then
            c1=${arg:$((i+1)):1}
            c2=${arg:$((i+2)):1}
            printf "\x$c1$c2"
            i=$((i+3))
        else
            echo -n "$c0"
            i=$((i+1))
        fi
    done
}

swap()
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

img2txt ()
{
    if [[ ! `type -p convert` ]]; then
        echo "convert not found"
        echo "install imagemagick"
        return 1
    fi

    if [[ ! `type -p tesseract` ]]; then
        echo "tesseract not found"
        echo "install tesseract"
        return 1
    fi
    
    if [[ $# == 0 ]]; then
        echo "missing filename(s)"
        return 1
    fi

    local CMD='tesseract "$TMPTIF" stdout'

    if [[ $# > 1 ]]; then
        local CMD=$CMD' | xargs -d \\n printf "$1: %s\n"'
    fi

    while [[ $# != 0 ]]; do

        if [[ ! -f $1 ]]; then
            echo "file '$1' not found"
            shift
            continue
        fi

        local TMPTIF=`mktemp --suffix=.tif`

        convert "$1"                                  \
            -scale 1000%                              \
            -blur 1x65535 -blur 1x65535 -blur 1x65535 \
            -contrast                                 \
            -normalize                                \
            -despeckle -despeckle                     \
            -type grayscale                           \
            -sharpen 1                                \
            -posterize 3                              \
            -negate                                   \
            -gamma 100                                \
            -compress zip                             \
            "$TMPTIF"

        eval $CMD

        rm -f "$TMPTIF" 

        shift
    done
}

environ()
{
    while [[ $# != 0 ]]; do
        strings /proc/$1/environ
        shift
    done
}

limits()
{
    while [[ $# != 0 ]]; do
        cat /proc/$1/limits
        shift
    done
}

symdiff()
{
    if [[ $# != 2 ]]; then
        echo "argument count != 2"
        return 1
    fi

    sort $1 $2 | uniq -u
}

ssh_config()
{
    if [[ $# < 2 ]]; then
        echo "creates a public key if necessary and deploys it to the given system"
        echo "parameters: <key_file_stem> <ssh_arguments>"
        echo "example: id_rsa -p 90 user@192.168.1.20"
        return 1
    fi

    if [[ ! `type -p ssh` && `type -p ssh-keygen` ]]; then
        echo "error: local ssh utilities missing"
        return 1
    fi

    mkdir -p ~/.ssh
    chmod 700 ~/.ssh

    if [[ ! -f ~/.ssh/${1}.pub ]]; then
        ssh-keygen -t rsa -f ~/.ssh/$1
    fi

    if [[ ! -f ~/.ssh/${1}.pub ]]; then
        echo "file ~/.ssh/${1}.pub missing"
        return 1
    fi

    KEYS=$(< ~/.ssh/${1}.pub )

    shift

    ssh $@ "mkdir -p ~/.ssh; chmod 700 ~/.ssh; cd ~/.ssh; touch authorized_keys; chmod 600 authorized_keys; echo \"$KEYS\" >> authorized_keys"
}

fd()
{
    find $@ -type d
}

ff()
{
    find $@ -type f
}

txd()
{
    if [[ $# != 1 ]]; then
        echo "extracts a tar.gz file to a new directory using its filename"
        echo "parameters: <path_to_tar_gz_file>"
        return 1
    fi

    if [[ ! -e $1 ]]; then
        echo "File $1 does not exist"
        return 1
    fi

    filename=${1##*/}

    filename=${filename%%.*}

    mkdir $filename || (echo "failed to create directory" && return 1)

    tar xzvf $1 -C $filename
}

u()
{
    if [[ $# > 2 ]]; then
        echo "navigates up an arbitrary number of directories"
        echo "parameters: [<number_of_up_directories>]"
        return 1
    fi

    if [[ -n $1 ]]; then
        if [[ ! $1 =~ ^-?[0-9]+$ || $1 -lt 0 ]]; then
            echo "invalid parameter"
            return 1
        fi

        if [[ $1 -eq 0 ]]; then
            return 0
        fi
    fi

    count=0
    count+=${1}
    dots=..

    for (( i = 1; i < ${count}; i++ )); do
        dots+="/.."
    done

    cd $dots
}

# Automatically add completion for all aliases to commands having completion functions
function alias_completion {
    local namespace="alias_completion"

    # parse function based completion definitions, where capture group 2 => function and 3 => trigger
    local compl_regex='complete( +[^ ]+)* -F ([^ ]+) ("[^"]+"|[^ ]+)'
    # parse alias definitions, where capture group 1 => trigger, 2 => command, 3 => command arguments
    local alias_regex="alias ([^=]+)='(\"[^\"]+\"|[^ ]+)(( +[^ ]+)*)'"

    # create array of function completion triggers, keeping multi-word triggers together
    eval "local completions=($(complete -p | sed -Ene "/$compl_regex/s//'\3'/p"))"
    (( ${#completions[@]} == 0 )) && return 0

    # create temporary file for wrapper functions and completions
    rm -f "/tmp/${namespace}-*.tmp" # preliminary cleanup
    local tmp_file; tmp_file="$(mktemp "/tmp/${namespace}-${RANDOM}XXX.tmp")" || return 1

    local completion_loader; completion_loader="$(complete -p -D 2>/dev/null | sed -Ene 's/.* -F ([^ ]*).*/\1/p')"

    # read in "<alias> '<aliased command>' '<command args>'" lines from defined aliases
    local line; while read line; do
        eval "local alias_tokens; alias_tokens=($line)" 2>/dev/null || continue # some alias arg patterns cause an eval parse error
        local alias_name="${alias_tokens[0]}" alias_cmd="${alias_tokens[1]}" alias_args="${alias_tokens[2]# }"

        # skip aliases to pipes, boolean control structures and other command lists
        # (leveraging that eval errs out if $alias_args contains unquoted shell metacharacters)
        eval "local alias_arg_words; alias_arg_words=($alias_args)" 2>/dev/null || continue
        # avoid expanding wildcards
        read -a alias_arg_words <<< "$alias_args"

        # skip alias if there is no completion function triggered by the aliased command
        if [[ ! " ${completions[*]} " =~ " $alias_cmd " ]]; then
            if [[ -n "$completion_loader" ]]; then
                # force loading of completions for the aliased command
                eval "$completion_loader $alias_cmd"
                # 124 means completion loader was successful
                [[ $? -eq 124 ]] || continue
                completions+=($alias_cmd)
            else
                continue
            fi
        fi
        local new_completion="$(complete -p "$alias_cmd")"

        # create a wrapper inserting the alias arguments if any
        if [[ -n $alias_args ]]; then
            local compl_func="${new_completion/#* -F /}"; compl_func="${compl_func%% *}"
            # avoid recursive call loops by ignoring our own functions
            if [[ "${compl_func#_$namespace::}" == $compl_func ]]; then
                local compl_wrapper="_${namespace}::${alias_name}"
                    echo "function $compl_wrapper {
                        (( COMP_CWORD += ${#alias_arg_words[@]} ))
                        COMP_WORDS=($alias_cmd $alias_args \${COMP_WORDS[@]:1})
                        (( COMP_POINT -= \${#COMP_LINE} ))
                        COMP_LINE=\${COMP_LINE/$alias_name/$alias_cmd $alias_args}
                        (( COMP_POINT += \${#COMP_LINE} ))
                        $compl_func
                    }" >> "$tmp_file"
                    new_completion="${new_completion/ -F $compl_func / -F $compl_wrapper }"
            fi
        fi

        # replace completion trigger by alias
        new_completion="${new_completion% *} $alias_name"
        echo "$new_completion" >> "$tmp_file"
    done < <(alias -p | sed -Ene "s/$alias_regex/\1 '\2' '\3'/p")
    source "$tmp_file" && rm -f "$tmp_file"
}; 
