#!/bin/bash
# use the gentoo startDM to start the default WM
#
# see /usr/share/doc/xrdp-version/startwm.sh for the factory version of this
# script.
source /etc/profile

xkbcomp /etc/xrdp/rus.map $DISPLAY
/etc/X11/Sessions/"${XSESSION}"
