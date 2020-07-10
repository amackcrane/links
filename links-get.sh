#!/bin/bash

file=$1
linksfile=$2
shift 2

inbound=t
outbound=t

while test $# -gt 0; do
    case $1 in
	-i) outbound=
	    ;;
	-o) inbound=
	    ;;
    esac
    shift
done

# in-links
if test $inbound; then
    echo "in:"
    jq --arg file $file '.[] | select(.target==$file)' <$linksfile \
       | source $install_path/links-print.sh
fi

if test $outbound; then
    echo "out"
    jq --arg file $file '.[] | select(.source==$file)' <$linksfile \
       | source $install_path/links-print.sh
fi

