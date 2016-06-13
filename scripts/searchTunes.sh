#!/bin/bash

# $1: directory path
# $2..$*: file type

if [[ uname=="Darwin" ]]; then # OS X
    for type in $2..$*
    do
        find $1 -iname "*.$type" -exec stat -f "%N%n%z%n%Sm" {} +
    done
elif [[ uname=="Linux" ]]; then # Ubuntu
    for type in $2..$*
    do
        find $1 -iname "*.$type" -printf "%p\n%s\n%t\n"
    done
fi
