#!/bin/sh
#
# usage: backup-file.sh <period> <retain> [file [...]]

[ "$#" -ge 3 ] || {
	echo "ERROR: usage: $0 <period> <retain> [file [...]]" >&2
	exit 1
}

period="$1"
retain="$2"
now="$(date +%Y%m%dT%H%M%S)"

set -e
shift 2

for file in "$@"; do
	echo "$file -> $file-$period-$now [$retain]"
	cp "$file" "$file-$period-$now"
	ls -tr "$file-$period-"* |
		head -n-${retain} |
		xargs --no-run-if-empty rm
done
