#!/bin/bash

# dojoadmin user + add ssh keys
WHO='dojoadmin'
WHERE="/home/$WHO"
HTTPHOST='10.10.10.105'
$SSID1='Coderdojo1'
$SSID2='Coderdojo2'

mkdir $WHERE/.ssh
/usr/bin/curl -o $WHERE/.ssh/authorized_keys http://$HTTPHOST/preseed/authorized_keys
chown -R $WHO:$WHO $WHERE/.ssh
chmod 700 $WHERE/.ssh
chmod 600 $WHERE/.ssh/authorized_keys

# admin passwordless sudo
echo "dojoadmin        ALL = NOPASSWD: ALL" > /etc/sudoers.d/dojoadmin
chmod 440 /etc/sudoers.d/dojoadmin

# Normal user account
#####################
/usr/sbin/useradd --uid 1000 --create-home --password '$6$PvgvfRmKIVT$q.BcDcyN/i0bqi4wQYHlZ9bj5XUpgddYRbUXXxQE.k2B8bjsNh7J2eRPXLvgj2mgo8kPnPl7iG0FtseNw9tDe/' coderdojo
# (pass = mkpasswd -m sha-512 coderdojo)

# add to dialoot group for s4a
usermod -a -G dialout coderdojo

# don't allow ssh logins with this weak password user
echo "DenyUsers coderdojo" >> /etc/ssh/sshd_config

# configure wifi
################
/usr/bin/nmcli con add con-name coderdojo ifname wlan0 type wifi ssid $SSID1
/usr/bin/nmcli con add con-name coderdojo ifname wlan0 type wifi ssid $SSID2

# install google-chrome (browser with modern flash version)
###########################################################
/usr/bin/wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
apt-get update 
apt-get install -y google-chrome-stable

# prepare scratch offline installation
######################################
# needs 32 bit support
apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386
# deps
apt-get install -y libxt6:i386 libnspr4-0d:i386 libgtk2.0-0:i386 libstdc++6:i386 libnss3-1d:i386 libnss-mdns:i386 libxml2:i386 libxslt1.1:i386 libcanberra-gtk-module:i386 gtk2-engines-murrine:i386 libgnome-keyring0:i386 libxaw7

# necessary links
ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0
ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

wget -O $WHERE/AdobeAIRInstaller.bin http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRInstaller.bin
wget -O $WHERE/install-scratch-446.air https://scratch.mit.edu/scratchr2/static/sa/Scratch-446.air

# make executable
chmod +x $WHERE/AdobeAIRInstaller.bin
chmod +x $WHERE/install-scratch-446.air

# MANUAL STEPS :-(
# Now in an X session with the dojoadmin user run
# sudo $WHERE/AdobeAIRInstaller.bin 
# sudo /etc/alternatives/airappinstaller $WHERE/install-scratch-446.air

# install scratch 4 arduino
###########################
wget -O $WHERE/S4A16.deb http://vps34736.ovh.net/S4A/S4A16.deb
apt-get install -y libv4l-0:i386 libv4lconvert0:i386 libpulse-dev:i386
dpkg -i $WHERE/S4A16.deb

# put our desktop shortcuts
###########################
# admin user
wget --no-parent -nd -r -A desktop http://$HTTPHOST/shortcuts/ -P /home/$WHO/Desktop
chown -R $WHO:$WHO /home/$WHO/Desktop/*.desktop
chmod +x /home/$WHO/Desktop/*.desktop

# coderdojo user
wget --no-parent -nd -r -A desktop http://$HTTPHOST/shortcuts/ -P /home/coderdojo/Desktop
chown -R coderdojo:coderdojo /home/coderdojo/Desktop
chmod +x /home/coderdojo/Desktop/*.desktop
