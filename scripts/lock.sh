#!/bin/zsh
# https://unix.stackexchange.com/questions/591621/how-can-i-reload-swayidle-swaylock
TIMEOUT=50
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
	lock-logged)
		# pkill swaylock
		(echo -e "\n\nStarting swaylock:\n"; WAYLAND_DEBUG=1 swaylock -c '000000' 2>&1 | sed  's/\[.......\....\]/\[XXXXXXX.YYY\]/') | grep -v keyboard | grep -v pointer >> ~/swaylock_logfile
		;;
	enable-lock)
		pkill swayidle
		swayidle -w \
			timeout $(( TIMEOUT ))	"systemctl $SLEEP_MODE" \
			before-sleep				"lock.sh lock-logged" &
		;;
			# timeout $(( TIMEOUT ))		"lock.sh lock-logged" \
esac

