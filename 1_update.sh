#!/bin/bash
SECONDS=0
echo ""
echo "perform sudo snap refresh"
sudo snap refresh || echo "failed: sudo snap refresh"
echo ""
echo "perform sudo apt-get update"
sudo apt-get update || echo "failed: sudo apt-get update"
echo ""
echo "perform sudo apt-get -y upgrade"
sudo apt-get -y upgrade || echo "failed: sudo apt-get -y upgrade"
duration=$SECONDS
echo "Update needed:"
echo "$((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
echo "reboot needed"
