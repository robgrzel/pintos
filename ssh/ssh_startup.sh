#!/bin/bash

# Create the directory needed to run the sshd daemon
#mkdir /var/run/sshd 

# Copy the config files into the docker directory
#cd /src/config/ && sudo -u $USER cp -R .[a-z]* [a-z]* /home/$USER/

# restarts the xdm service
#/etc/init.d/xdm restart

# Start the ssh service
/usr/sbin/sshd -D