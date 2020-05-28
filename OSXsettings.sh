#!/bin/sh

# Enable repeat on keydown
defaults write -g ApplePressAndHoldEnabled -bool false

# Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Hide the Dock
defaults write com.apple.Dock autohide -bool TRUE;

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles YES

killall Finder
killall Dock

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1

# Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# No desktop, I just put garbage there...
defaults write com.apple.finder CreateDesktop -bool FALSE;killall Finder

defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerSwipeGesture -int 1
