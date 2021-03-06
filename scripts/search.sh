#!/bin/bash

# $1: directory path
# $2..$*: file type

# output:
 # File path
 # File size
 # Last modified in EPOCH

case "$(uname -s)" in
    Darwin)     # macOS
        for type in $2..$*
        do
           find "$1" \( ! -regex '.*/\..*' \) -iname "*.$type" -exec stat -f "%N%n%z%n%m" {} +
        done
    ;;

    Linux)      # Ubuntu
        for type in $2..$*
        do
            find "$1" \( ! -regex '.*/\..*' \) -iname "*.$type" -printf "%p\n%s\n%T@\n"
        done
    ;;
esac
