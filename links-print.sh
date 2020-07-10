#!/bin/bash


# in: list of objects
input=$(jq <&0 | jq -s 'sort_by(.target)')
indices=$(jq 'keys[]' <<<$input)

# strip off leading directory path shared w/ cwd
# arg: filepath
function strip {
    printf "%s\n%s\n" $PWD $1 | gsed 'N;s|^\(.*\).*\n\1/\?||g'    
    }


echo

for ind in $indices
do
    # grab files
    entry=$(jq -r --argjson ind $ind '.[$ind]' <<<$input)
    source=$(strip $(jq -r '.source' <<<$entry))
    target=$(strip $(jq -r '.target' <<<$entry))
    note=$(jq -r --arg ind $ind '.note' <<<$entry)

    # \033[31m \033[0m
    printf "%s: \033[31m%s\033[0m <-- \033[31m%s\033[0m\n  %s\n\n" "$ind" "$target" "$source" "$note"
done
