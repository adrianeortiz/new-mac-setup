#!/bin/bash

# Install available software updates
softwareupdate -i -a

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles YES
killall Finder

# Allow downloads from anywhere
sudo spctl --master-disable

# Show battery percentage on menu bar
defaults write com.apple.menuextra.battery ShowPercent YES
killall SystemUIServer

# Create default "Screenshots" directory in Documents
mkdir ~/Documents/Screenshots

# Set new directory as the actual default of new screenshots
defaults write com.apple.screencapture location ~/Documents/Screenshots && killall SystemUIServer

# Enable repeating keys by pressing and holding down keys:
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Change dock position to left and make icons small
defaults write com.apple.dock orientation left && \
defaults write com.apple.dock tilesize 36 && \
killall Dock

# Disable workspace auto-switching
defaults write com.apple.dock workspaces-auto-swoosh -bool false && \
killall Dock

# Set up iCloud
echo "Setting up iCloud..."
echo "Enter your Apple ID email address: "
read apple_id_email
echo "Enter your Apple ID password: "
read -s apple_id_password

# Enable iCloud services
echo "Enabling iCloud services..."
defaults write MobileMeAccounts Migrated -bool true
defaults write MobileMeAccounts MigratedHack -bool true
defaults write MobileMeAccounts NeedsMigrated -bool false

# Set up iCloud services
echo "Setting up iCloud services..."
defaults write com.apple.icloud FindMyMac -bool true
defaults write com.apple.icloud FindMyMacAppNotificationsDisabled -bool false
defaults write com.apple.iCloudServices ABEnabled -bool true
defaults write com.apple.iCloudServices CKKSContainerID -string "com.apple.AppleID"
defaults write com.apple.iCloudServices CloudDocsEnabled -bool true
defaults write com.apple.iCloudServices CloudKit

# Configure iCloud services
defaults write MobileMeServices MMEnableMailSync -bool true
defaults write MobileMeServices MMEnableContactsSync -bool true
defaults write MobileMeServices MMEnableCalendarSync -bool true
defaults write MobileMeServices MMEnableNotesSync -bool true
defaults write MobileMeServices MMEnableBookmarksSync -bool false
defaults write MobileMeServices MMEnableRemindersSync -bool false
defaults write MobileMeServices MMEnableSafariSync -bool false
defaults write com.apple.iCloudServices ABEnableAccount -bool true
defaults write com.apple.iCloudServices ABEnableMeCard -bool true
defaults write com.apple.iCloudServices CloudDocsContainerIsEnabled -bool true
defaults write com.apple.iCloudServices CloudDocsDesktopAndDocumentsEnabled -bool true
defaults write com.apple.iCloudServices CloudDocsDesktopOnly -bool false
defaults write com.apple.iCloudServices CloudPhotosEnabled -bool true
defaults write com.apple.iCloudServices FindMyMacEnabled -bool true
defaults write com.apple.Siri StatusMenuVisible -bool true
defaults write com.apple.Siri UserHasDeclinedEnable -bool false
defaults write com.apple.Siri VoiceTriggerEnabled -bool true

echo "iCloud services configured successfully."

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Git
brew install git

# Install Node.js and npm
brew install node

# Install Python3 and pip3
brew install python3

# Install Ruby and RubyGems
brew install ruby

# Install Java
brew install --cask adoptopenjdk

# Install Visual Studio Code
brew install --cask visual-studio-code

# Install Docker
brew install --cask docker

# Install MySQL
brew install mysql

# Install Postgres
brew install postgresql

# Install Redis
brew install redis

# Install MongoDB
brew install mongodb

# Install Elasticsearch
brew install elasticsearch

# Install RabbitMQ
brew install rabbitmq

# Install Heroku CLI
brew tap heroku/brew && brew install heroku

# Install AWS CLI
brew install awscli

# Install Google Cloud SDK
brew install --cask google-cloud-sdk

# Install Zsh and Oh-My-Zsh
brew install zsh zsh-completions && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerline Fonts for Oh-My-Zsh
brew tap homebrew/cask-fonts && brew install --cask font-powerline-symbols

# Install FiraCode font
brew tap homebrew/cask-fonts && brew install --cask font-fira-code

# Install Oh-My-Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Install additional tools and utilities
brew install htop
brew install tmux
brew install neovim

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# Clone your development repositories
git clone https://github.com/yourusername/yourproject.git

# Done!
echo "Development environment setup complete."