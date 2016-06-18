#!/bin/bash

# $1: inverse variable
# $2: string to sort

case "$1" in
    0)     # ascending
        echo "$2" | sort
    ;;

    1)     # descending
        echo "$2" | sort -r
    ;;
esac
