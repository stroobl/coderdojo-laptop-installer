# coderdojo-laptop-installer

This repo contains preseed files and scripts used to install the Coderdojo (Sint-Agatha-Berchem) laptops. You won't be able to use them without advanced Linux knowledge, but I tought it could be useful to share some ideas for other dojos with the same needs...

## Contents

* preseed file to install Ubuntu 16.04 with SSH enabled
* postinstall.sh script where most coderdojo specific software is installed
* pxelinux.cfg/default - pxe boot for preseed example
* shortcuts - preconfigured desktop shortcuts for the installed software (just to avoid to much clicking around :))
* 99-sysctl-disable-ivp6.conf - systctl config to disable ipv6, just because I test this on Virtualbox where ipv6 doesn't work properly for me on the bridged adapter

## Usage

* you need a pxe boot server to host the ubuntu netboot image. The dhcp/tftp setup is out of scope (Google!).
* extract the ubuntu 16.04 netboot in your tftp root. Get it on: http://cdimage.ubuntu.com/netboot/ (we ignore most of the default ubuntu pxe config later, but it's the easiest way to get all files in place)
* copy pxelinux.cfg/default to your pxelinux.cfg/default in the tftp root and make sure vesamenu.c32 is in the root too
* In the example scripts, all files are hosted on 10.10.10.105. Make sure to replace it with your own IP where necessary (in the preseed file and on top of the postinstall.sh)
* Make sure you have a webserver on the above IP and put the preseed/ and shortcuts/ directory in your documentroot
* Adapt the preseed/xenial.preseed to your needs - AT LEAST SET THE DOJOADMIN PASSWORD!

