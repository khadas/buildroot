#!/bin/sh

CARD_ID=$(aplay -l | grep 8316c | awk '{print $2}' | cut -c 1)

alsactl restore $CARD_ID
