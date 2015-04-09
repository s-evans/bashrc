#!/usr/bin/env bash

# TODO: Additional pdf functions
# wrap pdftoppm: multiple files, convert to text
# wrap pdfimages: multiple files, convert to text
# wrap pdfinfo: multiple files
# wrap pdffonts: multiple files 

# TODO: cross platform system version function

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

pdf2txt() 
{
    if [[ ! `type -p pdftotext` ]]; then
        echo "pdftotext not found"
        echo "install poppler utilities"
        return 1
    fi

    if [[ $# == 0 ]]; then
        echo "missing filename(s)"
        return 1
    fi

    local CMD='pdftotext -q -layout "$1" -'

    if [[ $# > 1 ]]; then
        local CMD=$CMD' | xargs -d \\n printf "$1: %s\n"'
    fi

    while [[ $# != 0 ]]; do

        if [[ ! -f $1 ]]; then
            echo "file '$1' not found"
            shift
            continue
        fi

        eval $CMD

        shift
    done
}

lo2pdf()
{
    if [[ ! `type -p libreoffice` ]]; then
        echo "libreoffice not found"
        echo "install libreoffice"
        return 1
    fi

    if [[ $# == 0 ]]; then
        echo "missing filename(s)"
        return 1
    fi

    libreoffice --headless --convert-to pdf "$@" 
}

lo2txt()
{
    if [[ ! `type -p libreoffice` ]]; then
        echo "libreoffice not found"
        echo "install libreoffice"
        return 1
    fi

    if [[ $# == 0 ]]; then
        echo "missing filename(s)"
        return 1
    fi

    local TMPDIR=`mktemp -d`
    libreoffice --headless --convert-to pdf --outdir $TMPDIR "$@" > /dev/null

    cd $TMPDIR > /dev/null
    pdf2txt `ls`
    cd - > /dev/null

    rm -rf $TMPDIR
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

pfx()
{
    if [[ $# != 2 ]]; then
        echo "prepends a variable with given value"
        echo "parameters: <variable_name> <value>"
        return 1
    fi

    eval ${1}=${2/ /\\ }\${$1}
}

sfx()
{
    if [[ $# != 2 ]]; then
        echo "appends a variable with given value"
        echo "parameters: <variable_name> <value>"
        return 1
    fi

    eval ${1}=\${$1}${2/ /\\ }
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
