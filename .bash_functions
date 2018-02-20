#!/usr/bin/env bash

# TODO: dumping a windows share file list recursively to file

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

bpgrep()
{
    local PATTERN="$1"
    shift
    PATTERN="$PATTERN" awk '$0 ~ ENVIRON["PATTERN"]{ printf "%s:%s\n", FILENAME, FNR }' "$@"
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

_create_completable_alias ()
{
    local alias_name="${1}"
    local alias_value="${2}"

    # configure completion
    _alias_completion_wrapper_setup "${alias_name}" "${alias_value}"

    # create alias
    alias "${alias_name}"="${alias_value}"
}

declare -A _alias_map

_alias_completion_wrapper_setup ()
{
    local alias_name="${1}"
    local alias_value="${2}"
    complete -o default -F _alias_completion_wrapper "${alias_name}"
    _alias_map[${alias_name}]="${alias_value}"
}

_alias_completion_wrapper ()
{
    # rewrite current completion context before invoking
    # actual command completion

    local orig=${COMP_WORDS[0]}

    # remove first word, then
    # rewrite COMP_LINE and adjust COMP_POINT
    local j
    for (( j=0; j <= ${#COMP_LINE}; j++ )); do
        [[ "$COMP_LINE" == "${COMP_WORDS[0]}"* ]] && break
        COMP_LINE=${COMP_LINE:1}
        ((COMP_POINT--))
    done
    COMP_LINE=${COMP_LINE#"${COMP_WORDS[0]}"}
    ((COMP_POINT-=${#COMP_WORDS[0]}))

    # shift COMP_WORDS elements and adjust COMP_CWORD
    unset COMP_WORDS[0]
    ((COMP_CWORD -= 1))

    # append new prefix to COMP_WORDS
    local alias_words=(${_alias_map[${orig}]})
    COMP_WORDS=(${alias_words[@]} ${COMP_WORDS[@]})
    ((COMP_CWORD += ${#alias_words[@]}))

    # append new prefix to COMP_LINE
    COMP_LINE="${_alias_map[${orig}]}${COMP_LINE}"
    ((COMP_POINT += ${#_alias_map[${orig}]}))

    COMPREPLY=()
    local cur
    _get_comp_words_by_ref cur

    if [[ $COMP_CWORD -eq 0 ]]; then
        local IFS=$'\n'
        compopt -o filenames
        COMPREPLY=( $( compgen -d -c -- "$cur" ) )
    else
        local cmd=${COMP_WORDS[0]} compcmd=${COMP_WORDS[0]}
        local cspec=$( complete -p $cmd 2>/dev/null )

        # If we have no completion for $cmd yet, see if we have for basename
        if [[ ! $cspec && $cmd == */* ]]; then
            cspec=$( complete -p ${cmd##*/} 2>/dev/null )
            [[ $cspec ]] && compcmd=${cmd##*/}
        fi
        # If still nothing, just load it for the basename
        if [[ ! $cspec ]]; then
            compcmd=${cmd##*/}
            _completion_loader $compcmd
            cspec=$( complete -p $compcmd 2>/dev/null )
        fi

        if [[ -n $cspec ]]; then
            if [[ ${cspec#* -F } != $cspec ]]; then
                # complete -F <function>

                # get function name
                local func=${cspec#*-F }
                func=${func%% *}

                if [[ ${#COMP_WORDS[@]} -ge 2 ]]; then
                    $func $cmd "${COMP_WORDS[${#COMP_WORDS[@]}-1]}" "${COMP_WORDS[${#COMP_WORDS[@]}-2]}"
                else
                    $func $cmd "${COMP_WORDS[${#COMP_WORDS[@]}-1]}"
                fi

                # restore initial compopts
                local opt
                while [[ $cspec == *" -o "* ]]; do
                    # FIXME: should we take "+o opt" into account?
                    cspec=${cspec#*-o }
                    opt=${cspec%% *}
                    compopt -o $opt
                    cspec=${cspec#$opt}
                done
            else
                cspec=${cspec#complete}
                cspec=${cspec%%$compcmd}
                COMPREPLY=( $( eval compgen "$cspec" -- '$cur' ) )
            fi
        elif [[ ${#COMPREPLY[@]} -eq 0 ]]; then
            # XXX will probably never happen as long as completion loader loads
            #     *something* for every command thrown at it ($cspec != empty)
            _minimal
        fi
    fi
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

_cache_load()
{
    local cache_file="${1}"

    if [[ -e "${HOME}/.cache/${cache_file}" ]]; then
        . "${HOME}/.cache/${cache_file}"
    fi
}

_cache_save()
{
    local cache_file="${1}"
    local cache_prefix="${2}"

    mkdir -p ${HOME}/.cache
    set | sed '/^'${cache_prefix}'/{ /^[^ ]*=(/{ :a /)$/!{ n; ba; }; b; }; / () $/{ :b /^}$/!{ n; bb; }; b; }; b; }; d' > "${HOME}/.cache/${cache_file}"
}

_cache_delete()
{
    local cache_file="${1}"

    if [[ -e "${HOME}/.cache/${cache_file}" ]]; then
        rm "${HOME}/.cache/${cache_file}"
    fi
}

_cache_unset()
{
    local cache_prefix="${1}"

    . <(set | sed '/^'${cache_prefix}'/!d; s/=.*//g; s/^/unset /' )
}

_cache_clear()
{
    local cache_file="${1}"
    local cache_prefix="${2}"

    _cache_delete "${cache_file}"
    _cache_unset "${cache_prefix}"
}

ycm_cmake_init()
{
    local cmake_lists_path="${1}"

    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON "${cmake_lists_path}"

    if [[ ! -e "${cmake_lists_path}/.ycm_extra_conf.py" ]]; then
        cp ~/.vim/bundle/ycm/third_party/ycmd/examples/.ycm_extra_conf.py "${cmake_lists_path}/.ycm_extra_conf.py"
    fi

    sed -i "/^compilation_database_folder\s*=\s*/d; 1a\\compilation_database_folder = '$(pwd)'\\" "${cmake_lists_path}/.ycm_extra_conf.py"
}

cmake-build()
{
    cmake --build "$@"
}

cmake-build-type()
{
    cmake -DCMAKE_BUILD_TYPE="$@"
}
