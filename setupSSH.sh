#!/bin/bash
sudo apt install openssh-client
sudo apt install openssh-server
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original
sudo chmod a-w /etc/ssh/sshd_config.original
sudo sshd -t -f /etc/ssh/sshd_config