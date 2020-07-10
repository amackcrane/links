#!/bin/bash

src=$1
target=$2
src_file=$3
tar_file=$4
shift 4


# arg: .links filepath
function remove {
    cp $1 ${1}_bak
    jq --arg src $src --arg target $target \
       '.[] | select(((.source==$src) and .target==$target) | not)' <$1 \
       | jq -s >${1}_tmp \
	&& mv ${1}_tmp $1
    }

# confirm
to_rm=$(jq --arg src $src --arg target $target '.[] | select((.source==$src) and .target==$target)' <$src_file)

if test -z "$to_rm"; then
    echo "No matching links"
    exit
fi

jq <<<"$to_rm"
read -p "delete me? (y/n) > " confirm

if test $confirm != "y"; then
    echo "Not deleting"
    exit
fi

# remove
remove $src_file

if test $src_file != $tar_file; then
    remove $tar_file
fi

