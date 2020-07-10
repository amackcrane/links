#!/bin/bash

ind=$1
name=$2

# index refers to order of .links file, as indicated in 'links ls'

file=$(jq -r --argjson ind $ind --arg name $name '.[$ind] | .[$name]' <$src_file)

if [[ $file =~ .txt$ ]]; then
    amcmacs $file
elif ! [[ $file =~ \. ]]; then
    # assume directory paths don't contain dots!
    echo "cd $file"
else
    open $file
fi

