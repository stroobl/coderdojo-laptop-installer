# Coderdojo laptop installer

This repo contains preseed files and scripts used to install the Coderdojo (Sint-Agatha-Berchem) laptops with Ubuntu 16.04. You won't be able to use them without advanced Linux knowledge, but I thought it could be useful to share some ideas for other dojos with the same needs... Suggestions and improvements are welcome too of course. :-)


## Contents

* preseed/xenial.preseed - preseed file to install Ubuntu 16.04 with SSH enabled
* preseed/postinstall.sh - script where most coderdojo specific software is installed
* pxelinux.cfg/default - pxe boot for preseed example
* shortcuts/ - preconfigured desktop shortcuts for the installed software (just to avoid to much clicking around :))
* preseed/99-sysctl-disable-ivp6.conf - systctl config to disable ipv6, just because I test this on Virtualbox where ipv6 doesn't work properly for me on the bridged adapter

## Usage

* You need a pxe boot server to host the ubuntu netboot image. The dhcp/tftp setup is out of scope (Google!).
* extract the ubuntu 16.04 netboot in your tftp root. Get it on: http://cdimage.ubuntu.com/netboot/ (we ignore most of the default ubuntu pxe config later, but it's the easiest way to get all files in place)
* copy pxelinux.cfg/default to your pxelinux.cfg/default in the tftp root and make sure vesamenu.c32 is in the root too
* In the example scripts, all files are hosted on 10.10.10.105. Make sure to replace it with your own IP where necessary (at the end of the preseed file and on top of the postinstall.sh)
* Make sure you have a webserver on the above IP and put the preseed/ and shortcuts/ directory in your documentroot
* Adapt the preseed/xenial.preseed to your needs - AT LEAST SET THE DOJOADMIN PASSWORD!

## Todo

* A way to get rid of the clickety-click installation for Adobe Air and Scratch offline would be great.

## 64 bit?

Most Coderdojo (Flash) software requires 32 bit binaries. However, Google Chrome is currently the only Linux browser with a recent Flash version and there's no 32 bit version.... So that's why I installed a 64 bit Ubuntu with 32 bit support. It's a bit more work, but 64 bit installs are more future proof too.
