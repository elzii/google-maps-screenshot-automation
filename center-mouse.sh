#!/bin/bash
# 
# Macbook Pro 2015 15" - 220 DPI
# http://www.everymac.com/systems/apple/macbook_pro/macbook-pro-retina-display-faq/macbook-pro-retina-display-hack-to-run-native-resolution.html
# https://www.sven.de/dpi/


# Using system_profiler
# Note: Returns Scaled Res
# RES=$(/usr/sbin/system_profiler SPDisplaysDataType | grep 'Resolution' | egrep -o '[0-9][0-9]+')
# RES_ARR=($RES)
# RES_X=${RES_ARR[0]}
# RES_Y=${RES_ARR[1]}
# X_CENTER=$(($RES_X/2))
# Y_CENTER=$(($RES_Y/2))

# Using xrandr
# RES_X=$(xrandr --current 2>/dev/null | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
# RES_Y=$(xrandr --current 2>/dev/null | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)
# X_CENTER=$(($RES_X/2))
# Y_CENTER=$(($RES_Y/2))

RES_X=$(osascript -e 'tell application "Finder" to get bounds of window of desktop' | awk '{print $3}' | tr -d ',')
RES_Y=$(osascript -e 'tell application "Finder" to get bounds of window of desktop' | awk '{print $4}' | tr -d ',')
X_CENTER=$(($RES_X/2))
Y_CENTER=$(($RES_Y/2))


# echo $X_CENTER
# echo $Y_CENTER

./MouseTools -x $X_CENTER -y $Y_CENTER
