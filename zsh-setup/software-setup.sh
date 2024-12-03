#!/bin/bash

# This script installs some essential software packages on an Ubuntu system.
# It installs the following tools: bat, nano, curl, git, and more.
# The script ensures that the system package list is up to date and installs all specified packages.

# Step 1: Update the package list to ensure we have the latest information about available packages
echo "Updating package list..."
  apt update

# Step 2: Upgrade any outdated packages (optional)
# This is a good practice to make sure that your system is up-to-date.
echo "Upgrading installed packages..."
  apt upgrade -y

# Step 3: Install essential software packages
# Below are the packages we want to install: bat, nano, curl, git, and vim.

echo "Installing essential software packages..."

# Install bat - a modern alternative to 'cat' with syntax highlighting
  apt install -y bat

# Install nano - a simple, easy-to-use text editor
  apt install -y nano

# Install curl - a command-line tool for transferring data with URLs
  apt install -y curl

# Install git - a distributed version control system
  apt install -y git

# Install vim - an improved version of the vi editor
  apt install -y vim

# Install tree - a command-line tool to view directory structure in a tree-like format
  apt install -y tree

# Install htop - an interactive process viewer for Unix systems
  apt install -y htop

# Install wget - a tool for downloading files from the web
  apt install -y wget

# Install unzip - a utility to extract compressed files (if not already installed)
  apt install -y unzip

# Step 4: Clean up any unnecessary packages and dependencies
# This will remove packages that were installed as dependencies but are no longer needed.
echo "Cleaning up unnecessary packages..."
  apt autoremove -y

# Step 5: Verify the installation
# After installation, we can check if the software was installed successfully by checking the versions.

echo "Verifying installation of packages..."

# Check version of bat
bat --version

# Check version of nano
nano --version

# Check version of curl
curl --version

# Check version of git
git --version

# Check version of vim
vim --version

# Check version of tree
tree --version

# Check version of htop
htop --version

# Check version of wget
wget --version

echo "Installation completed successfully!"

# End of script
