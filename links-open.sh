#!/bin/bash

key=$1

# search for key on source, target
file=$(jq --arg key $key \
	  '.[] | to_entries | .[] | select(.key=="source" or .key=="target") | .value | select(contains($key))' <$src_file)
num=$(jq -s 'length' <<<$file)

if test $num -eq 0; then
    echo "No matches"
    exit
elif test $num -gt 1; then
    echo "Ambiguous!"
    exit
fi

# strip quotes
file=${file%\"}
file=${file#\"}

if [[ $file =~ .txt$ ]]; then
    "$links_editor" $file
elif test -d "$file"; then
    echo "cd $file"
elif [[ $file =~ .pdf$ ]]; then
    "$pdf_viewer" $file
else
    # portability whoops
    open $file
fi

