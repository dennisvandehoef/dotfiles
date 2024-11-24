#!/usr/bin/env bash

echo -e "\n\n\n\n\nSetup mac specific\n\n\n\n\n"

# Some settings
echo "Disable AppSleep..."
defaults write NSGlobalDomain NSAppSleepDisabled -bool YES # FIX for Specs and locken

echo "Disable the sound effects on boot"
sudo nvram SystemAudioVolume=%01

echo "Show File Extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Don't automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

#install brewfile
while read line
do
  [ "${line###*}" ] && brew $line
done < ~/code/private/dotfiles/Brewfile
