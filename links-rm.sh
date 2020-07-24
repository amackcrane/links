

# arg: .links filepath
function remove {
    cp $1 ${1}_bak
    jq --arg src $src --arg target $target \
       '.[] | select(((.source==$src) and .target==$target) | not)' <$1 \
       | jq -s >${1}_tmp \
	&& mv ${1}_tmp $1
    }

# confirm
check_file=${linksfiles[0]}
to_rm=$(jq --arg src $src --arg target $target '.[] | select((.source==$src) and .target==$target)' <$check_file)

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
for f in ${linksfiles[@]}; do
    remove $f
done



