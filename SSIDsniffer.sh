#!/bin/bash
echo "version 2.0"
if [[ $EUID -eq 0 ]]; then
        echo "Don't run the script as root or sudo"
        exit 1
fi
echo ""
echo "Available WiFi devices:"
cat /proc/net/wireless
echo ""


if [ $# != 2 ]; then
        echo ""
        echo "usage:"
        echo "sniffer [WLAN device] [WiFi channel]"
        exit
fi
if ! grep -q $1 /proc/net/wireless; then
echo "Can' find device $1"
exit -1
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
sudo ifconfig $1 up
sudo ifconfig $1 down
sudo iwconfig $1
sudo iwconfig $1 mode managed
sudo rfkill unblock wlan
sudo ifconfig $1 up
# sudo iwconfig $1 channel $channel
iwlist $1 channel |grep Current
sudo iwlist $1 scanning|grep $2 -A 5
sudo iwconfig $1 essid $2  key s:eweuinektdsidkvdg@1965
#sudo dhcpcd wlxe84e0663433e
sudo systemctl disable dhcpcd
sudo systemctl enable dhcpcd@$1.service

#sudo dhclient $1
