#!/bin/sh

if [[ "$1" == "up" ]]; then
	brillo -A 10
    printf "%.0f\n" "$(brillo)" 2> /dev/null
elif [[ "$1" == "down" ]]; then
	brillo -U 10
    printf "%.0f\n" "$(brillo)" 2> /dev/null
fi

