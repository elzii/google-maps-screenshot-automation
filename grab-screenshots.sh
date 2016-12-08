#!/bin/bash

# Vars
IN=$1
OUT=$(echo $1 | sed 's/^\(.*\)\.[a-zA-Z0-9]*$/\1/')
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Settings
SETTING_BROWSER="Google Chrome Canary"
SETTING_SCREENSHOT_COUNT=1
SETTING_GOOGLE_MAPS_URL="https://www.google.com/maps/@32.7082517,-117.1588805,12010m/data=!3m1!1e3"

# Make output folder if it doesnt exist
[ ! -d $DIR/out ] && mkdir -p $DIR/out




# Copy contents of JS script into clipboard
pbcopy < ./google-maps-hide-elements.js




# Center the mouse on the screen
# @dependency: MouseTools - http://www.hamsoftengineering.com/codeSharing/MouseTools/MouseTools.html
center_mouse() {
  RES_X=$(osascript -e 'tell application "Finder" to get bounds of window of desktop' | awk '{print $3}' | tr -d ',')
  RES_Y=$(osascript -e 'tell application "Finder" to get bounds of window of desktop' | awk '{print $4}' | tr -d ',')
  X_CENTER=$(($RES_X/2))
  Y_CENTER=$(($RES_Y/2))
  MouseTools -x $X_CENTER -y $Y_CENTER
}



# Perform Automation
grab_screenshots() {
  # Activate Browser
  # osascript -e 'tell application "'"$SETTING_BROWSER"'" to activate' 
  # Activate Browser, toggle fullscreen, and open URL 
  osascript -e 'tell application "'"$SETTING_BROWSER"'"
                  activate
                  open location "'"$SETTING_GOOGLE_MAPS_URL"'"
                  delay 1
                  activate
                end tell
                ' 
  
  # osascript -e 'set isFullScreen to false
  #               tell application "System Events" to tell process "'"$SETTING_BROWSER"'"
  #                 set isFullScreen to value of attribute "AXFullScreen" of window 1
  #               end tell
  #
  #               if isFullScreen is false
  #                 tell application "System Events" to tell process "'"$SETTING_BROWSER"'" to keystroke "f" using { command down, control down }
  #               end if
  #               '

  # Open JS Console, paste script, hit return, close JS console
  osascript -e 'tell application "System Events" to tell process "'"$SETTING_BROWSER"'" to keystroke "j" using {command down, option down}
                delay 2
                tell application "System Events" to tell process "'"$SETTING_BROWSER"'" to keystroke "v" using {command down}
                delay 1
                tell application "System Events" to tell process "'"$SETTING_BROWSER"'" to key code 36 
                delay 2
                tell application "System Events" to tell process "'"$SETTING_BROWSER"'" to keystroke "j" using {command down, option down}
                '
  # Take screenshots
  osascript -e 'property N : 0
                repeat '$SETTING_SCREENSHOT_COUNT' times
                  set N to N + 1
                  delay 3
                  set picPath to (POSIX path of ("'$DIR'") & "/out/Picture_" & N & ".png") as string
                  do shell script "screencapture -tjpg " & quoted form of picPath
                  tell application "System Events" to tell process "'"$SETTING_BROWSER"'" to keystroke "+"
                end repeat
                '
  # Open Finder to the output directory
  osascript -e 'tell application "Finder" to activate
                tell application "Finder" to open ("'$DIR/out'" as POSIX file)
                '

  return 0
}

init() {
  center_mouse
  grab_screenshots
}


init
