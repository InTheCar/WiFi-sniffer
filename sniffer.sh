#!/bin/bash
echo "version 1.0"
if [[ $EUID -eq 0 ]]; then
        echo "Don't run the script as root or sudo"
        exit 1
fi

if [ $# != 2 ]; then
	echo "usage:"
	echo "sniffer [WLAN device] [WiFi channel]"
	exit
fi
while true; do
    read -p "Do you wish to configure device $1 to channel $2 in monitor mode ? y/n " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Delete files in trace directory? y/n " yn
    case $yn in
        [Yy]* ) rm ~/tshark_logging_files/*;break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo ""
echo "unblock wlan ..."
sudo rfkill unblock wlan

echo ""
echo "Startup $1 ..."
sudo ifconfig $1 up

echo ""
echo "Shutdown $1 ..."
sudo ifconfig $1 down

echo ""
echo "$1 is using this channel:"
sudo iwlist $1 channel |grep Current

echo ""
echo "Set $1 to monitor mode ..."
sudo iwconfig $1  mode monitor
status=$?
counter=5
while [ $status -gt 0 ] && [ $counter -gt 0 ]
do
echo "Startup $1 ..."
sudo ifconfig $1 up

echo "Shutdown $1 ..."
sudo ifconfig $1 down
echo "Set $1 to monitor mode ..."
sudo iwconfig $1 mode monitor
status=$?
counter=$counter - 1
done

if [ $counter -eq 0 ]; then
echo "can't set monitor mode"
exit -1
fi

echo "Setting channel $2 on $1 ..."
sudo iwconfig $1 channel $2

echo "Startup $1 ..."
sudo ifconfig $1 up

echo "$1 is on this channel"
sudo iwlist $1 channel |grep Current
echo "Creating directory \"~/tshark_logging_files/\" for traces if it not already exists..."
if  [ ! -d ~/tshark_logging_files ];then
      mkdir ~/tshark_logging_files
fi
# tshark -i wlan1 -w ~/tshark_logging_files/test.pcapng
tshark -i $1 -w ~/tshark_logging_files/$1_channel_$2_.pcapng.gz -b filesize:10000 -b files:10

