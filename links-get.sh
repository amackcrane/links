#!/bin/bash

inbound=t
outbound=t
args=()
flags="$@"

while test $# -gt 0; do
    case $1 in
	-i) outbound=
	    ;;
	-o) inbound=
	    ;;
	*) args+=("$1")
	   ;;
    esac
    shift
done

# no path args
if test -z $args; then
    source $install_path/links-ls.sh $flags
    exit
fi
# too many args
if test ${#args[@]} -gt 1; then
    echo "Only accepts one path argument!"
    echo "'links help' for usage"
    exit
fi
file=${args[0]}

# trailing slash
if [[ $file =~ /$ ]]; then
    echo "printing all links within directory ${args[0]}"
    source $install_path/links-ls.sh $flags
    exit
fi
# valid filepath
if test -s $file; then 
    # set $linksfile
    linksfile=$(dirname $file)/.links
else
    linksfile=.links
fi

if test $inbound; then
    echo "in:"
    jq --arg file $file '.[] | select(.target | contains($file))' <$linksfile \
       | source $install_path/links-print.sh
fi

if test $outbound; then
    echo "out:"
    jq --arg file $file '.[] | select(.source | contains($file))' <$linksfile \
       | source $install_path/links-print.sh
fi

