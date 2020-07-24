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
if ! [[ $path =~ ^/ ]]; then
    path=$PWD/$path
fi
if ! test -d $path; then
    echo "Bad directory path"
    exit
fi

# standardize filepath (important for matching below)
path=$(cd $path && pwd)


linksfile=${path%/}/.links

if ! test -s $linksfile; then
    echo "No links in this directory"
    exit
fi


#jq '.[]' <$linksfile | source links-print



# in-links
if test $inbound; then
    echo "in:"
    jq --arg path $path '.[] | select(.target | contains($path))' <$linksfile \
       | source $install_path/links-print.sh
fi

if test $outbound; then
    echo "out"
    jq --arg path $path '.[] | select(.source | contains($path))' <$linksfile \
       | source $install_path/links-print.sh
fi
