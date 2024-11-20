#!/bin/sh
#
# Start the hciattach server....
#


case "$1" in
  start)
        printf "Start hciattach:"
        /usr/sbin/rfkill unblock 0
        /bin/sleep 1
        /usr/bin/hciattach -n -s 115200 /dev/ttyS9 bcm43xx 1500000 &
        [ $? = 0 ] && echo "OK" || echo "FAIL"
        ;;
  stop)
        printf "Stopping hciattach: "
        killall hciattach
        /usr/sbin/rfkill block 0
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
