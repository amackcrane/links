#!/bin/bash


src=$1
target=$2
src_file=$3
tar_file=$4
shift 4


# todo?
# more fields
#   short names

# check if link already registered
already=$(jq --arg src $src --arg target $target '.[] | select(.source==$src) | select(.target==$target)' <$src_file)
if test "$already"; then
    echo "Link already exists"
    exit
fi

# prompt for note
read -p "Note? > " note


# arg: .links filename
function crt {
    cp $1 ${1}_bak
    jq --arg src $src --arg target $target --arg note "$note" \
       '. += [{"source": $src, "target": $target, "note": $note}]' \
       <$1 >${1}_tmp \
	&& mv ${1}_tmp $1

    }

# write to source dir
crt $src_file


# write to target dir if it's elsewhere
if test $src_file != $tar_file; then
    crt $tar_file
fi


# old way:
# construct entry
#jq -n --arg src $src --arg target $target --arg note "$note" \
#   '' >.tmp

#cp $src_file ${src_file}_bak
#jq --slurp 'reduce .[] as $item ([]; . + $item)' $src_file .tmp >${src_file}_tmp \
#   && mv ${src_file}_tmp $src_file

#rm .tmp

