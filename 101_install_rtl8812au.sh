#!/bin/bash
SECONDS=0
echo "perform sudo apt-get -y install linux-headers-$(uname -r)"
sudo apt-get -y install linux-headers-$(uname -r)||echo "failed: sudo apt-get -y install linux-headers-$(uname -r)"
cd ./WiFi-sniffer/rtl8812au
sudo rm -r /var/lib/dkms/8812au
sudo make dkms_install
duration=$SECONDS
echo "installation of rtl8812 needed:"
echo "$((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
echo "reboot needed"

