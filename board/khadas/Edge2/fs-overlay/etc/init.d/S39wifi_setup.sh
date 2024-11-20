#!/bin/sh
#
# Start the wpa_supplicant server....
#

MODULE=/lib/modules/bcmdhd_pcie.ko

if [ ! -e ${MODULE} ]; then
        echo "Can not find ${MODULE}"
        exit 1
fi

CONF=/etc/wpa_supplicant.conf

if [ ! -e ${CONF} ]; then
        echo "Can not find ${CONF}"
        exit 1
fi


case "$1" in
  start)
        printf "Start wpa_supplicant:"
        insmod ${MODULE}
        ifconfig wlan0 up
		sleep 2
        wpa_supplicant -B -i wlan0 -c $CONF
		[ $? = 0 ] && echo "OK" || echo "FAIL"

		# For auto get IP address after connecting wifi.
		wpa_cli -a /usr/bin/wpa_cli_action.sh -B
        ;;
  stop)
        printf "Stopping wpa_supplicant: "
        killall wpa_supplicant
        ifconfig wlan0 down
        rmmod ${MODULE}
        [ $? = 0 ] && echo "OK" || echo "FAIL"
        ;;
  restart|reload)
        "$0" stop
        "$0" start
        ;;
  *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
esac

exit $?
