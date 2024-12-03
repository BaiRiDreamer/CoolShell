#!/bin/bash

# This script configures the .zshrc file for a better Zsh experience.
# It adds common aliases, environment variables, and other useful settings.

ZSHRC_FILE="$HOME/.zshrc"

# Step 1: Check if the .zshrc file exists
if [ ! -f "$ZSHRC_FILE" ]; then
  echo ".zshrc file does not exist. Creating it now..."
  touch "$ZSHRC_FILE"
else
  echo ".zshrc file found. Appending configurations..."
fi

# Step 2: Backup the current .zshrc file (in case anything goes wrong)
echo "Backing up the current .zshrc file to .zshrc.backup..."
cp "$ZSHRC_FILE" "$ZSHRC_FILE.backup"

# Step 3: Append basic settings and configurations to the .zshrc file

# Aliases for common commands
echo "Adding common aliases..."
cat >> "$ZSHRC_FILE" <<EOL

# Aliases for common commands
alias ll='ls -lah'            # List files with detailed information
alias update='sudo apt update && sudo apt upgrade -y'  # Update system
alias cls='clear'             # Clear terminal screen
alias ..='cd ..'              # Go up one directory

# More useful aliases
alias h='history'             # Show command history
alias z='zsh'                 # Open Zsh shell directly
EOL

# Set batcat alias if bat is installed
if command -v batcat &> /dev/null; then
  alias bat='batcat --paging=never'
fi

# Environment variables
echo "Setting environment variables..."
cat >> "$ZSHRC_FILE" <<EOL

# Set editor to nano (you can change this to vim or other editor)
export EDITOR='nano'

# Add custom bin directory to PATH (if you have custom executables)
export PATH="$HOME/bin:$PATH"

# Set history file size and behavior
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups:erasedups  # Ignore duplicate commands in history
export HISTIGNORE="ls:ps:history"         # Ignore specific commands in history

# Enable command auto-correction
setopt correct

# Enable auto-completion
autoload -Uz compinit
compinit

# Enable syntax highlighting for Zsh
# Note: Install zsh-users/zsh-syntax-highlighting plugin to enable this feature
# Uncomment the following line if you have the plugin installed
# source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable auto-suggestions (requires zsh-users/zsh-autosuggestions plugin)
# Uncomment the following line if you have the plugin installed
# source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

EOL

# Step 4: Source the .zshrc file to apply the changes immediately
echo "Applying changes to .zshrc..."
source "$ZSHRC_FILE"

echo "Configuration completed successfully!"
