#!/bin/bash
if [ $# -ne 2 ] && [ $# -ne 4 ]
then
	echo "format: input-url output-url [.input-extension .output-extension] default .flac to .mp3"
else
	if [ ! -d "$1" ]
	then
		echo "input is not a directory"
	else
		input_extension=$3
		output_extension=$4
	
		if [ -z "$input_extension" ]
		then
			input_extension=".flac"
		fi
		
		if [ -z "$output_extension" ]
		then
			output_extension=".mp3"
		fi

		declare -A formats			
		for setting in $(ffmpeg -loglevel panic -formats | awk '{print "formats["$2"]=" $1; }'); do eval $setting; done;
		

		if [ -z "${formats[${input_extension:1}]}" ]
		then
			echo "input type is not convertable"
		else
			if [ -z "${formats[${output_extension:1}]}" ]
			then
				echo "output type is not convertable"
			else				
				if [ ! -d "$2" ]
				then
					mkdir -p "$2"
				fi

				for i in `find "$1" -name "*$input_extension"`
				do
					ffmpeg -i "$i" "$2/`basename "$i" "$input_extension"`$output_extension"
				done
			fi
		fi
	fi
fi
