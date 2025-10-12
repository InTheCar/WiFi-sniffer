#!/bin/bash
sudo apt install net-tools
sudo apt install iw
sudo apt install tshark
sudo adduser $USER wireshark
sudo chmod +x /usr/bin/dumpcap

