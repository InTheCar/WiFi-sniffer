#!/bin/bash
sudo apt-get-y install net-tools
sudo apt-get-y install iw
sudo apt-get-y install make
sudo apt-get-y install dkms
sudo apt-get-y install linux-headers-$(uname -r)
sudo apt-get-y install tshark
sudo apt-get install screen 
# sudo adduser $USER wireshark
sudo chmod +x /usr/bin/dumpcap

