#!/bin/bash

# Inspiration:
# - http://fredkelly.net/articles/2014/10/19/developing_on_yosemite.html
# - https://github.com/sorenvind/dev-env
# - https://github.com/mads-hartmann/dotfiles

# Set up OSX settings
echo "> Setting up OS X..."
./OSXsettings.sh

# Install homebrew and cask
if test ! $(which brew)
then
  echo "> Installing brew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
fi

# Install latest zsh and oh-my-zsh
OMZ=~/.oh-my-zsh
if test ! -d $OMZ
then
  echo "> Installing oh my zsh..."
  brew install zsh
  curl -L http://install.ohmyz.sh | sh
fi
## This bit might fix some permission issues with oh-my-zsh (haven't checked on a fresh install)
compaudit | xargs chmod g-w,o-w

# Install common sanity
echo "> Installing common sanity..."
brew update
brew upgrade
brew install awscli
brew install coreutils
brew install curl
brew install git
brew install gnu-sed
brew install go
brew install jq
brew install node@10
brew install python
brew install wget

# Install other brew packages
echo "> Installing other brew package..."
brew tap homebrew/bundle
brew tap homebrew/cask
brew tap homebrew/cask-fonts
brew tap homebrew/core
brew tap zaquestion/tap
# Monospaced font with programming ligatures
brew cask install font-fira-code
# Shell extension to jump to frequently used directories
brew install autojump
# Fish-like autosuggestions for zsh
brew install zsh-autosuggestions
# Clone of cat(1) with syntax highlighting and Git integration
brew install bat
# Contains convert for converting images
brew install imagemagick
# Small git utilities
brew install git-extras
# Git extension for versioning large files
brew install git-lfs
# Mac App Store command-line interface
brew install mas
# Simple tool to make locally trusted development certificates
brew install mkcert
# Text interface for Git repositories
brew install tig
# Simplified and community-driven man pages
brew install tldr
# Executes a program periodically, showing output fullscreen
brew install watch
# Lab wraps Git or Hub, making it simple to clone, fork, and interact with repositories on GitLab
brew install zaquestion/tap/lab


# Install node packages
npm install -g nodemon @vue/cli

# up the limit for files opened
sudo launchctl limit maxfiles 2048 unlimited

# Copy dotfiles
cp home/.gitconfig ~
cp home/.zshrc ~

# SSH
echo "> Set up ssh config and generate key"
mkdir -p ~/.ssh/
cp home/.ssh/config ~/.ssh
ssh-keygen -o -a 100 -t ed25519

# And oh my zsh theme
mkdir -p ~/.oh-my-zsh/themes/
ln -fs $PWD/skovhus.zsh-theme ~/.oh-my-zsh/themes/skovhus.zsh-theme

# Quicklook plugins
echo "> Installing QuickLook plugins"
# QuickLook plugin for markdown files
brew cask install qlmarkdown
# QuickLook plugin for plain text files
brew cask install qlstephen
# QuickLook plugin for json files
brew cask install quicklook-json
# QuickLook plugin for WEBP files
brew cask install webpquicklook

# Fix macOS not letting you run the plugin because it's not signed by a verified developer
sudo xattr -cr ~/Library/QuickLook/QLMarkdown.qlgenerator
sudo xattr -cr ~/Library/QuickLook/QLStephen.qlgenerator
sudo xattr -cr ~/Library/QuickLook/QuickLookJSON.qlgenerator
sudo xattr -cr ~/Library/QuickLook/WebpQuickLook.qlgenerator
qlmanage -r
qlmanage -r cache


# Install Apps
echo "> Installing Apps you will like..."
# Password manager
brew cask install 1password
# Docker for Mac
brew cask install docker
# Google Chrome
brew cask install google-chrome
# macOS Terminal Replacement
brew cask install iterm2
# MongoDB explorer
brew cask install jeromelebel-mongohub
# API request manager
brew cask install postman
# Slack
brew cask install slack
# Default IDE in unu
brew cask install visual-studio-code
# Video conferencing tool
brew cask install zoom

# Some apps that might be less work related
echo "> Installing some other Apps you will like..."
# App uninstaller utility
brew cask install appcleaner
# Translator tool
brew cask install deepl
# A modern media player
brew cask install iina
# An app that silences notifications while screensharing
brew cask install muzzle
# Skype
brew cask install skype
# Spotify
brew cask install spotify
# Whatsapp
brew cask install whatsapp

# Mac App Store
echo "> Installing Apps from the Mac App Store"
# Xcode
mas "Xcode", id: 497799835



# VS Code
echo "> Setting up VS Code..."
mkdir -p ~/Library/Application\ Support/Code/User
ln -fs $PWD/apps/vs-code/settings.json ~/Library/Application\ Support/Code/User
ln -fs $PWD/apps/vs-code/keybindings.json ~/Library/Application\ Support/Code/User
# Insatall VS Code extensions
for module in `cat apps/vs-code/extensions.list`; do
    code --install-extension "$module" || true
done

echo "> Done!"

echo "-----------------------------------------"
echo "Manual steps:"
echo "-----------------------------------------"
echo "- Setup terminal to import solazried-dark theme, with Menlo Regular 10pt and block cursor."
echo "- Upload ssh key .ssh/id_ed25519.pub to https://github.com/settings/keys"
exho "- Restart your computer"
