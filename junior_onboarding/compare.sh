#!/bin/bash


function arguments {
	while [ "${1}" != "" ]
	do
		case ${1} in
			-p1)
				shift

				P1=${1}

				;;
			-p2)
				shift

				P2=${1}

				;;
			-d)
				set -x

				;;
			*)
				print_help

				;;
		esac

		shift
	done

}

function compare_date {
	if [ -z "${P1}" ] || [ -z "${P2}" ]
	then
		exit 1
	fi

	local date_p1
	local date_p2

	date_p1=$(ls -lad "${P1}" | awk '{print $6" "$7" "$8 }')
	date_p2=$(ls -lad "${P2}" | awk '{print $6" "$7" "$8 }')

	if [[ $date_p1 < $date_p2 ]]
	then
		echo "${P1} was created at: ${date_p1}"
	else
		echo "${P2} was creater at: ${date_p2}"
	fi
}

function main {
	arguments "$@"

	compare_date
}

function print_help {
	echo "
	help:
	-p1 fullpath of first path
	-p2 fullpath of second path
	-d turn on debug mode"
}

main "$@"