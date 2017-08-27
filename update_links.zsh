#!/usr/bin/env zsh

setopt EXTENDED_GLOB

BASE=${ZDOTDIR:-$HOME}

relpath () {
    [[ $# -ge 1 ]] && [[ $# -le 2 ]] || return 1
    local target=${${2:-$1}:a} # replace `:a' by `:A` to resolve symlinks
    local current=${${${2:+$1}:-$PWD}:a} # replace `:a' by `:A` to resolve symlinks
    local appendix=${target#/}
    local relative=''
    while appendix=${target#$current/}
					[[ $current != '/' ]] && [[ $appendix = $target ]]; do
        if [[ $current = $appendix ]]; then
            relative=${relative:-.}
            print ${relative#/}
            return 0
        fi
        current=${current%/*}
        relative="$relative${relative:+/}.."
    done
    relative+=${relative:+${appendix:+/}}${appendix#/}
    print $relative
}

for rcfile in "${BASE}"/.zprezto/runcoms/^README.md(.N); do
		ln -fs ${relpath "$BASE" "$rcfile"} "${BASE}/.${rcfile:t}"
done
