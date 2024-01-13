#!/bin/bash

# Setup Script for New Mac - Apple Chip
# This script configures a new Apple Chip Mac with necessary software and settings.

# Check for available software updates
if softwareupdate -l | grep -q "No new software available."; then
    echo "No new software updates available."
else
    # Install available software updates
    softwareupdate -i -a
    read -p "Install all available updates? (y/n): " choice
if [[ "$choice" == [Yy]* ]]; then
    sudo softwareupdate -ia

fi

# Allow downloads from anywhere
sudo spctl --master-disable

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles YES
killall Finder

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

# Commenting out iCloud section, use at your own discretion..
# Set up iCloud
: <<'END_COMMENT'
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

# Configure iCloud services
echo "Configuring iCloud services..."
# (iCloud configuration commands here)
END_COMMENT

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
# Install Homebrew for Apple Silicon then make sure it is up to date
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Homebrew update
brew update
brew upgrade

# Check and install packages
# Install Versions and link them as needed
brew_packages=("git" "node" "python3" "ruby" "adoptopenjdk" "visual-studio-code" "docker" "mysql" "postgresql" "redis" "mongodb" "elasticsearch" "rabbitmq" "heroku" "awscli" "google-cloud-sdk" "zsh" "htop" "tmux" "neovim")

for package in "${brew_packages[@]}"; do
    if ! brew list "$package" &>/dev/null; then
        brew install "$package"
    else
        echo "$package is already installed."
    fi
done


# Install fonts
brew tap homebrew/cask-fonts
brew install --cask font-fira-code font-powerline-symbols

# Install Oh-My-Zsh
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Oh-My-Zsh plugins
plugins=("zsh-autosuggestions" "zsh-syntax-highlighting")
oh_my_zsh_custom_dir=~/.oh-my-zsh/custom/plugins

for plugin in "${plugins[@]}"; do
    if [ ! -d "$oh_my_zsh_custom_dir/$plugin" ]; then
        git clone "https://github.com/zsh-users/$plugin.git" "$oh_my_zsh_custom_dir/$plugin"
    else
        echo "$plugin plugin is already installed."
    fi
done

# for editors and IDE's
cp ~/configs/vscode-settings.json ~/Library/Application\ Support/Code/User/settings.json

# Change default editor to read all file types
# You can use any editor, simply change the app in the command

# This is for using VS Code
brew install duti

duti -s com.microsoft.VSCode public.plain-text all
duti -s com.microsoft.VSCode public.unix-executable all
duti -s com.microsoft.VSCode public.data all

:<<'END_COMMENT'
For MacVim use: com.vim.macvim
For Sublime Text use: com.sublimetext.4
OR com.sublimetext.3 for a different version
END_COMMENT

# Database Initialization
brew services start mysql
mysql_secure_installation

# Configure Git (only if it is installed)
if command -v git &>/dev/null; then
    git config --global user.name "Your Name"
    git config --global user.email "you@example.com"
fi

# Clone your development repositories (only if Git is installed)
if command -v git &>/dev/null; then
    git clone https://github.com/yourusername/yourproject.git
fi

# Cleanup and Validation
brew cleanup
brew doctor

# Done!
echo "Development environment setup complete."
