#!/bin/bash

set -x

#yum install -y pciutils lsof ethtool libnl3 libmnl tcsh

# Install Mellanox OFED
mkdir -p /tmp/mlnxofed
cd /tmp/mlnxofed
wget http://www.mellanox.com/downloads/ofed/MLNX_OFED-4.6-1.0.1.1/MLNX_OFED_LINUX-4.6-1.0.1.1-rhel7.6-x86_64.tgz
tar zxvf MLNX_OFED_LINUX-4.6-1.0.1.1-rhel7.6-x86_64.tgz

KERNEL=$(uname -r)
./MLNX_OFED_LINUX-4.6-1.0.1.1-rhel7.6-x86_64/mlnxofedinstall --kernel-sources /usr/src/kernels/$KERNEL --add-kernel-support --skip-repo
cd && rm -rf /tmp/mlnxofed

sed -i 's/LOAD_EIPOIB=no/LOAD_EIPOIB=yes/g' /etc/infiniband/openib.conf
/etc/init.d/openibd restart
cd && rm -rf /tmp/mlnxofed

