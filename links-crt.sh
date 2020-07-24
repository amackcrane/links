#!/bin/bash

echo "recording in:"
echo "${linksfiles[@]}"


# check if link already registered
check_file=${linksfiles[0]}
already=$(jq --arg src $src --arg target $target '.[] | select(.source==$src) | select(.target==$target)' <$check_file)
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

# write to .links files
for f in ${linksfiles[@]}; do
    echo "recording in $f"
    crt $f
done


# old way:
# construct entry
#jq -n --arg src $src --arg target $target --arg note "$note" \
#   '' >.tmp

#cp $src_file ${src_file}_bak
#jq --slurp 'reduce .[] as $item ([]; . + $item)' $src_file .tmp >${src_file}_tmp \
#   && mv ${src_file}_tmp $src_file

#rm .tmp

