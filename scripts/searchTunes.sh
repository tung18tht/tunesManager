#!/bin/bash

for type in $2..$*
do
    find $1 -iname "*.$type" -exec stat -f "%N%n%z%n%Sm" {} +
done
