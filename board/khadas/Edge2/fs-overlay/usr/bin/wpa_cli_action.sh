#!/bin/bash

# This script will be call while wpa_cli connect a wifi.
# For auto get IP address after connecting wifi.

if [ "$2" = "CONNECTED" ]; then
	killall udhcpc
	udhcpc -i $1 -b
fi

