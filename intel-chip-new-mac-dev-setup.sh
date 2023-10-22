# For Apple chip based Mac's
# Script is idempotent

#!/bin/bash

# Check for available software updates
if softwareupdate -l | grep -q "No new software available."; then
    echo "No new software updates available."
else
    # Install available software updates
    softwareupdate -i -a
fi

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


# Check if iCloud services are already configured
if ! defaults read MobileMeAccounts Migrated &>/dev/null; then
    echo "Setting up iCloud..."
    defaults write com.apple.icloud FindMyMac -bool true
    defaults write com.apple.icloud FindMyMacAppNotificationsDisabled -bool false
    defaults write com.apple.iCloudServices ABEnabled -bool true
    defaults write com.apple.iCloudServices CKKSContainerID -string "com.apple.AppleID"
    defaults write com.apple.iCloudServices CloudDocsEnabled -bool true
    defaults write com.apple.iCloudServices CloudKit
    echo "iCloud services configured successfully."

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

else
    echo "iCloud services are already configured."
fi

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Check and install other packages similarly

# Check and install Git
if ! command -v git &>/dev/null; then
    brew install git
else
    echo "Git is already installed."
fi

# Check and install Node.js and npm
if ! command -v node &>/dev/null; then
    brew install node
else
    echo "Node.js is already installed."
fi

# Check and install Python3 and pip3
if ! command -v python3 &>/dev/null; then
    brew install python3
else
    echo "Python3 is already installed."
fi

# Check and install Ruby and RubyGems
if ! command -v ruby &>/dev/null; then
    brew install ruby
else
    echo "Ruby is already installed."
fi

# Check and install Java
if ! command -v java &>/dev/null; then
    brew install --cask adoptopenjdk
else
    echo "Java is already installed."
fi

# Check and install Visual Studio Code
if ! brew list --cask --versions visual-studio-code &>/dev/null; then
    brew install --cask visual-studio-code
else
    echo "Visual Studio Code is already installed."
fi

# Check and install Docker
if ! brew list --cask --versions docker &>/dev/null; then
    brew install --cask docker
else
    echo "Docker is already installed."
fi

# Check and install MySQL
if ! brew list mysql &>/dev/null; then
    brew install mysql
else
    echo "MySQL is already installed."
fi

# Check and install Postgres
if ! brew list postgresql &>/dev/null; then
    brew install postgresql
else
    echo "Postgres is already installed."
fi

# Check and install Redis
if ! brew list redis &>/dev/null; then
    brew install redis
else
    echo "Redis is already installed."
fi

# Check and install MongoDB
if ! brew list mongodb &>/dev/null; then
    brew install mongodb
else
    echo "MongoDB is already installed."
fi

# Check and install Elasticsearch
if ! brew list elasticsearch &>/dev/null; then
    brew install elasticsearch
else
    echo "Elasticsearch is already installed."
fi

# Check and install RabbitMQ
if ! brew list rabbitmq &>/dev/null; then
    brew install rabbitmq
else
    echo "RabbitMQ is already installed."
fi

# Check and install Heroku CLI
if ! brew list heroku &>/dev/null; then
    brew tap heroku/brew && brew install heroku
else
    echo "Heroku CLI is already installed."
fi

# Check and install AWS CLI
if ! command -v aws &>/dev/null; then
    brew install awscli
else
    echo "AWS CLI is already installed."
fi

# Check and install Google Cloud SDK
if ! brew list --cask --versions google-cloud-sdk &>/dev/null; then
    brew install --cask google-cloud-sdk
else
    echo "Google Cloud SDK is already installed."
fi

# Check and install Zsh and Oh-My-Zsh
if ! command -v zsh &>/dev/null; then
    brew install zsh zsh-completions && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Zsh is already installed."
fi

# Check and install Powerline Fonts for Oh-My-Zsh
if [ ! -f /Library/Fonts/PowerlineSymbols.otf ]; then
    brew tap homebrew/cask-fonts && brew install --cask font-powerline-symbols
else
    echo "Powerline Fonts for Oh-My-Zsh are already installed."
fi

# Check and install FiraCode font
if [ ! -f /Library/Fonts/FiraCode-Regular.ttf ]; then
    brew tap homebrew/cask-fonts && brew install --cask font-fira-code
else
    echo "FiraCode font is already installed."
fi

# Check and install Oh-My-Zsh plugins
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
    echo "Oh-My-Zsh autosuggestions plugin is already installed."
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
    echo "Oh-My-Zsh syntax highlighting plugin is already installed."
fi

# Check and install additional tools and utilities
if ! command -v htop &>/dev/null; then
    brew install htop
else
    echo "htop is already installed."
fi

if ! command -v tmux &>/dev/null; then
    brew install tmux
else
    echo "tmux is already installed."
fi

if ! command -v nvim &>/dev/null; then
    brew install neovim
else
    echo "Neovim is already installed."
fi

# Configure Git (only if it is installed)
if command -v git &>/dev/null; then
    git config --global user.name "Your Name"
    git config --global user.email "you@example.com"
fi

# Clone your development repositories (only if Git is installed)
if command -v git &>/dev/null; then
    git clone https://github.com/yourusername/yourproject.git
fi

# Done!
echo "Development environment setup complete."
