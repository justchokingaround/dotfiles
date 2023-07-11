#!/bin/sh

uptime="$(uptime -p | sed "s/up /Uptime: /g")"

confirm_exit() {
	printf "yes\nno" | rofi -dmenu -theme ~/.config/rofi/styles/confirm.rasi
}

run_cmd() {
	selected="$(confirm_exit)"
	if [ "$selected" = "yes" ]; then
		case "$1" in
		--shutdown) systemctl poweroff ;;
		--reboot) systemctl reboot ;;
		--suspend) mpc -q pause && systemctl suspend ;;
		--lock) swaylock -f -i ~/pix/wallpapers/black.jpg ;;
		esac
	fi
	exit 0
}

choice="$(printf "Shutdown\nSuspend\nReboot\nLock" | rofi -i -dmenu -p "Goodbye ${USER}" -mesg "$uptime")"
case ${choice} in
Shutdown)
	run_cmd --shutdown
	;;
Reboot)
	run_cmd --reboot
	;;
Lock)
	run_cmd --lock
	;;
Suspend)
	run_cmd --suspend
	;;
esac
