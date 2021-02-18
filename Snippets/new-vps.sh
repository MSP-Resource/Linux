#!/bin/bash

#
# This is code to run with a new VPS that will update, upgrade and setup swap automatically for you
# this is for debian based linux distros.
#
# These commands can be combined but I wanted to explain them.
# Run as root when you first create VPS
#
# Created by MSP Resource
#

(
# Update Package List
sudo apt update
# Upgrade Packages and answer yes
sudo apt -y upgrade
# Autoremove unused packages and answer yes usually old linux kernels
sudo apt -y autoremove
# Create empty file
sudo fallocate -l 1G /swapfile
# Set permissions for the file
sudo chmod 600 /swapfile
# Make new file a swap file
sudo mkswap /swapfile
# Turn on new swap file
sudo swapon /swapfile
# Backup fstab file before edit
sudo cp /etc/fstab /etc/fstab.bak
# Add swap file to fstab
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
# Backup sysctl before edit
sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak
# Set swappiness for active session
sudo sysctl vm.swappiness=10
# Store swappiness for next startup
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
# Set swap pressure for active session
sudo sysctl vm.vfs_cache_pressure=50
# Store swap pressure for next startup
echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.conf
# Make sure we are back at home for whatever is done next
cd ~
)


