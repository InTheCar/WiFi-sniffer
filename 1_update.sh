#!/bin/bash
SECONDS=0
echo "$((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
sudo snap refresh || echo "failed: sudo snap refresh"
sudo apt-get update || echo "failed: sudo apt-get update"
sudo apt-get -y upgrade || echo "failed: sudo apt-get -y upgrade"
duration=$SECONDS
echo "Update needed:"
echo "$((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
echo "reboot needed"
