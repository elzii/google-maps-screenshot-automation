#!/bin/bash

# copy labels event trigger to clipboard
# echo "document.querySelectorAll('[jsaction=\"settings.intent.labels\"]')[0].click()" | pbcopy

pbcopy < ./google-maps-hide-elements.js

# center the mouse on the screen
RES_X=$(osascript -e 'tell application "Finder" to get bounds of window of desktop' | awk '{print $3}' | tr -d ',')
RES_Y=$(osascript -e 'tell application "Finder" to get bounds of window of desktop' | awk '{print $4}' | tr -d ',')
X_CENTER=$(($RES_X/2))
Y_CENTER=$(($RES_Y/2))
MouseTools -x $X_CENTER -y $Y_CENTER

grab_screenshots() {
  # Active iTerm
  osascript -e 'tell application "Google Chrome Canary" to activate' 

  # Split window vertically
  # osascript -e 'tell application "System Events" to tell process "Google Chrome Canary" to keystroke "+"'
 
  osascript -e 'tell application "System Events" to tell process "Google Chrome Canary" to keystroke "j" using {command down, option down}
                delay 2
                tell application "System Events" to tell process "Google Chrome Canary" to keystroke "v" using {command down}
                delay 1
                tell application "System Events" to tell process "Google Chrome Canary" to key code 36 
                delay 2
                tell application "System Events" to tell process "Google Chrome Canary" to keystroke "j" using {command down, option down}
                delay 1
                property N : 0
                set picPath to ((POSIX path of (path to desktop)) & "ss/Picture_" & N & ".png") as string
                do shell script "screencapture -tjpg " & quoted form of picPath
                tell application "System Events" to tell process "Google Chrome Canary" to keystroke "+"
                delay 3
                set N to N + 1
                set picPath to ((POSIX path of (path to desktop)) & "ss/Picture_" & N & ".png") as string
                do shell script "screencapture -tjpg " & quoted form of picPath
                tell application "System Events" to tell process "Google Chrome Canary" to keystroke "+"
                delay 3
                set N to N + 1
                set picPath to ((POSIX path of (path to desktop)) & "ss/Picture_" & N & ".png") as string
                do shell script "screencapture -tjpg " & quoted form of picPath
  '

  osascript -e 'tell application "Finder" to activate'
 
  return 0
}

grab_screenshots
