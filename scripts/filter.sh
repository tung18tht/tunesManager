#!/bin/bash

# Find string $2 in list of tune names $1
# -i: case insensitive

echo "$1" | grep -i "$2"
