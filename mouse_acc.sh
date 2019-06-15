#!/bin/bash
var=`xinput --list --short | sed -n '/core pointer/,/core keyboard/p' | sed -n '/Razer Razer/p' | sed 's/^.....\([A-Z,a-z,=,\t,\ ]*\)\([0-9]*\)\(.*\)/\2/'`
xinput set-prop $var  "libinput Accel Speed" "$1"
