#!/bin/bash

kernel=5.15.32-v7+
driver=8188fu

module_bin="rtl8188fu.ko"
module_dir="/lib/modules/$kernel/kernel/drivers/net/wireless"

sudo chown root:root rtl8188fu.conf
sudo chmod 644 rtl8188fu.conf
sudo chown root:root rtl8188fufw.bin
sudo chmod 644 rtl8188fufw.bin
sudo mv rtl8188fu.conf /etc/modprobe.d/.
sudo mv rtl8188fufw.bin /lib/firmware/rtlwifi

sudo chown root:root $module_bin
sudo chmod 644 $module_bin
echo "sudo install -p -m 644 $module_bin $module_dir"
sudo install -p -m 644 $module_bin $module_dir
echo "sudo depmod $kernel"
sudo depmod $kernel
sudo rm $module_bin
sudo rm -f $driver* > /dev/null 2>&1
echo "disabling RTL8188EU driver"
echo 'alias usb:v0BDApF179d*dc*dsc*dp*icFFiscFFipFFin* rtl8188fu' | sudo tee /etc/modprobe.d/r8188eu-blacklist.conf

echo
echo "Reboot to run the driver."
echo
echo "If you have already configured your wifi it should start up and connect to your"
echo "wireless network."
echo
echo "If you have not configured your wifi you will need to do that to enable the wifi."

rm -f install.sh  > /dev/null 2>&1
