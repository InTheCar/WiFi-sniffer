#!/bin/bash
sudo snap refresh || echo "snap refresh failed"
sudo apt-get update
sudo apt-get -y upgrade
sudo reboot
