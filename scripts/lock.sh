#!/bin/zsh
# https://unix.stackexchange.com/questions/591621/how-can-i-reload-swayidle-swaylock

TIMEOUT=600
SLEEP_MODE=

if [[ "$(cat /sys/power/mem_sleep | grep '\[s2idle\]')" != "" ]]; then
	SLEEP_MODE='suspend-then-hibernate'
else
	SLEEP_MODE='suspend'
fi

case "$1" in 
	lock)
		pkill swaylock
		swaylock -f --image "$WALLPAPER"
		;;
	enable-lock)
		pkill swayidle
		swayidle -w \
			timeout $(( TIMEOUT ))	"lock.sh lock" \
			timeout $(( TIMEOUT * 1 ))	"systemctl $SLEEP_MODE" \
			before-sleep				"lock.sh lock" &
		;;
esac

