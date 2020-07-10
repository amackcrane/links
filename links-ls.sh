#!/bin/bash


path=$1
shift

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

if test -z $path; then
    path=$PWD
fi

linksfile=$path/.links

if ! test -e $linksfile; then
    echo "No links in this directory"
fi


#jq '.[]' <$linksfile | source links-print



# in-links
if test $inbound; then
    echo "in:"
    jq --arg path $path '.[] | select(.target | contains($path))' <$linksfile \
       | source links-print
fi

if test $outbound; then
    echo "out"
    jq --arg path $path '.[] | select(.source | contains($path))' <$linksfile \
       | source links-print
fi
