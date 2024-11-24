#!/usr/bin/env bash

echo -e "\n\n\n\n\nSetup mac specific\n\n\n\n\n"

# Some settings
echo "Disable the sound effects on boot"
sudo nvram SystemAudioVolume=%01

echo "Show File Extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Don't automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

echo "Disable press-and-hold for keys in favor of key repeat"
defaults write -g ApplePressAndHoldEnabled -bool false

echo "Show the ~/Library folder"
chflags nohidden ~/Library

echo "Show the /Volumes folder"
sudo chflags nohidden /Volumes

echo "Show hidden files by default"
defaults write com.apple.finder AppleShowAllFiles -bool true

echo "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

echo "Always show scrollbars"
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

echo "Show battery percent"
defaults write com.apple.menuextra.battery ShowPercent -bool true

echo "Disable the crash reporter"
defaults write com.apple.CrashReporter DialogType -string "none"

echo "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

echo "Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

echo "Remove the auto-hiding Dock delay"
defaults write com.apple.dock autohide-delay -float 0

echo "Remove the animation when hiding/showing the Dock"
defaults write com.apple.dock autohide-time-modifier -float 0

echo "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo "Don't animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false

echo "Don't show recently used applications in the Dock"
defaults write com.Apple.Dock show-recents -bool false

#install brewfile
while read line
do
  [ "${line###*}" ] && brew $line
done < ~/code/private/dotfiles/Brewfile
