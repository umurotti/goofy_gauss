#!/bin/bash
if [ "$(ls -A $1)" ]; then
	declare -A map
	for setting in $(/usr/local/bin/gdrive list | sed 's/^\([a-z,A-Z,0-9,_,\,-]*\)   \([a-z,A-Z,0-9,_,\,-]*\)\(.*\)$/map["\2"]=\1/'); do eval $setting; done;
	file=${map["$2"]}
	echo "Target: $2 - "$file
	for filename in `find "$1"/*`; do
		/usr/local/bin/gdrive upload --delete --parent $file $filename
	done
else
	echo "Empty directory"
fi
