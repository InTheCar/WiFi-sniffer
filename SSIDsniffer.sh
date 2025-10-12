#!/bin/bash






if [ $# != 2 ]; then
	echo "usage:"
	echo "sniffer [WLAN device] [WiFi channel]"
	exit
fi
channel="$(sudo iw dev wlan1  scan |grep -i 'SSID: real' -A 2|grep -i channel|head -1|grep -Eo '[0-9]{1,4}')"
echo $channel

#K=$2
#S=$( printf '%d' $K )

#echo "$S"
#echo "$( #S )"
# if [ $(#S)  -ge 3 ]; then
#echo "SSID"
#exit
# fi




sudo iwconfig $1
sudo ifconfig $1 down
sudo iwconfig $1 mode monitor
sudo rfkill unblock all
sudo ifconfig $1 up
sudo iwconfig $1 channel $channel
iwlist wlan1 channel |grep Current
iwlist wlan1 mode  |grep Current

