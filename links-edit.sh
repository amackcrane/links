

# grab entry
check_file=${linksfiles[0]}
jq -r --arg src $src --arg target $target '.[] | select(.source==$src and .target==$target) | .note' <$check_file >/tmp/asdf

if ! test -s /tmp/asdf; then
    echo "Link not found"
    exit
fi

# edit note
"$links_editor" /tmp/asdf

# save
for f in ${linksfiles[@]}; do
    cp $f ${f}_bak
    jq --arg src $src --arg target $target --arg note "$(cat /tmp/asdf)" '(.[] | select(.source==$src and .target==$target)) += {note: $note}' <$f >${f}_tmp \
       && mv ${f}_tmp $f
done
