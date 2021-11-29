#!/bin/bash

################################
#                              #
#      ~ TOOL BY ANMABE ~      #
#                              #
#      https://anmabe.es/      #
#                              #
################################


function dirlister(){
	ARG1=${1:-$(pwd)}
	ARG2=${2:-$(pwd)/dirlister.out}
	ARG3=${3:-b}

	> "$ARG2"
	echo $(date) >> "$ARG2"
	echo "$ARG1" >> "$ARG2"
	echo "" >> "$ARG2"
	echo "" >> "$ARG2"

	function searchInFolder(){
		ARG1="$1"
		ARG2="$2"
		ARG3="$3"
		#echo "HIDDEN DIRECTORIES" >> "$2"
		#echo '' >> "$2"
		#echo $'\n' "$ARG3" $(find "$1" -type f -name '.*') >> "$2"
		#echo "____________________________________________" >> "$2"
		#echo '' >> "$2"
		#echo "NORMAL DIRECTORIES" >> "$2"

		if [ "$ARG3" == h ]; then
			find "$ARG1" -type f -name '.*' >> "$ARG2"

		elif [ "$ARG3" == nh ]; then
			searchShownElementsInFolder "$ARG1" "$ARG2"

		else
			echo "HIDDEN DIRECTORIES" $'\n' >> "$ARG2"
			find "$ARG1" -type f -name '.*' >> "$ARG2"

			echo "" >> "$ARG2"
			echo "____________________________________________" >> "$ARG2"
			echo $'\n' >> "$ARG2"

			echo "SHOWN DIRECTORIES" $'\n' >> "$ARG2"
			searchShownElementsInFolder "$ARG1" "$ARG2"
			
		fi
	}

	function searchShownElementsInFolder(){
		ARG1="$1"
		ARG2="$2"

		for f in "$ARG1"/*; do
			if [ -d "$f" ]; then
				echo "$f" >> "$ARG2"
				searchShownElementsInFolder "$f" "$ARG2"
			else
				echo "$f" >> "$ARG2"
			fi
		done
	}

	searchInFolder "$ARG1" "$ARG2" "$ARG3"
}

dirlister /Users/anmabe06/Desktop/dirlister pete.out b

#$1 => directory from where to start ; default pwd
#$2 => .out file ; default pwd/dirlister.out
#$3 => h / nh / b; default both
