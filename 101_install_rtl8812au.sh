#!/bin/bash
echo "perform sudo apt-get -y install linux-headers-$(uname -r)"
sudo apt-get -y install linux-headers-$(uname -r)||echo "failed: sudo apt-get -y install linux-headers-$(uname -r)"
cd ./WiFi-sniffer/rtl8812au
sudo make dkms_install

