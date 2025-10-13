#!/bin/bash
SECONDS=0
if [[ ! -d ./WiFi-sniffer/rtl8812au ]] && [ $# != 1 ]; then
        echo "default directory doesn't exists"
        echo "use ./[directory of repository]/101_install_rtl8812au.sh [directory of repository]"
        exit -1
fi
if [[ ! -d "${1}/rtl8812au" ]] && [ $# == 1 ]; then
        echo "directory doesn't exists: ${1}/rtl8812au"
        echo "use ./[directory of repository]/101_install_rtl8812au.sh [directory of repository]"
        exit -1
fi
echo "perform sudo apt-get -y install linux-headers-$(uname -r)"
sudo apt-get -y install linux-headers-$(uname -r)||echo "failed: sudo apt-get -y install linux-headers-$(uname -r)"
if [ $# = 0 ] ; then
cd ./WiFi-sniffer/rtl8812au
fi
if [ $# = 1 ] ; then
cd "${1}./rtl8812au"
fi

sudo rm -r /var/lib/dkms/8812au
sudo make dkms_install
duration=$SECONDS
echo "installation of rtl8812 needed:"
echo "$((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
echo "reboot needed"

