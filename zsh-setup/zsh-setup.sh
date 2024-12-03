#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to display error message and exit
error_exit() {
    echo "Error: $1"
    exit 1
}

# Step 1: Install Zsh
install_zsh() {
    echo "Checking if Zsh is installed..."
    if command_exists zsh; then
        echo "Zsh is already installed."
    else
        echo "Zsh is not installed. Installing Zsh..."
        if command_exists apt; then
              apt update &&   apt install -y zsh || error_exit "Failed to install Zsh using apt."
        elif command_exists yum; then
              yum install -y zsh || error_exit "Failed to install Zsh using yum."
        elif command_exists dnf; then
              dnf install -y zsh || error_exit "Failed to install Zsh using dnf."
        elif command_exists pacman; then
              pacman -Sy --noconfirm zsh || error_exit "Failed to install Zsh using pacman."
        else
            error_exit "Package manager not supported. Please install Zsh manually."
        fi
    fi
}

# Step 2: Set Zsh as the default shell
set_default_shell() {
    echo "Setting Zsh as the default shell..."
    if [ "$SHELL" != "$(which zsh)" ]; then
        chsh -s "$(which zsh)" || error_exit "Failed to set Zsh as the default shell."
        echo "Default shell changed to Zsh. Please log out and log back in for the change to take effect."
    else
        echo "Zsh is already the default shell."
    fi
}

# Step 3: Install oh-my-zsh
install_oh_my_zsh() {
    echo "Installing oh-my-zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || error_exit "Failed to install oh-my-zsh."
    else
        echo "oh-my-zsh is already installed."
    fi
}

# Step 4: Install powerlevel10k theme
install_powerlevel10k() {
    echo "Installing Powerlevel10k theme..."
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" || error_exit "Failed to clone Powerlevel10k repository."
        sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"
        echo "Powerlevel10k theme installed and configured."
    else
        echo "Powerlevel10k theme is already installed."
    fi
}

# Step 5: Install Zsh plugins
install_plugins() {
    echo "Installing Zsh plugins..."
    ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

    # Install zsh-autosuggestions
    if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" || error_exit "Failed to clone zsh-autosuggestions repository."
    else
        echo "zsh-autosuggestions is already installed."
    fi

    # Install zsh-syntax-highlighting (Fast Syntax Highlighting)
    if [ ! -d "${ZSH_CUSTOM}/plugins/fast-syntax-highlighting" ]; then
        git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/fast-syntax-highlighting" || error_exit "Failed to clone fast-syntax-highlighting repository."
    else
        echo "Fast Syntax Highlighting is already installed."
    fi

    # Install zsh-interactive-cd
    if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-interactive-cd" ]; then
        git clone https://github.com/mrjohannchang/zsh-interactive-cd "${ZSH_CUSTOM}/plugins/zsh-interactive-cd" || error_exit "Failed to clone zsh-interactive-cd repository."
    else
        echo "zsh-interactive-cd is already installed."
    fi

    # Install zsh-completions
    if [ ! -d "${ZSH_CUSTOM}/plugins/fzf" ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git "${ZSH_CUSTOM}/plugins/fzf" || error_exit "Failed to clone fzf repository."
        sh -c "${ZSH_CUSTOM}/plugins/fzf/install" || error_exit "Failed to install fzf repository."
    else
        echo "fzf is already installed."
    fi
    
    if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-completions" ]; then
        git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM}/plugins/zsh-completions" || error_exit "Failed to clone zsh-completions repository."
    else
        echo "zsh-completions is already installed."
    fi

    # Install you-should-use
    if [ ! -d "${ZSH_CUSTOM}/plugins/you-should-use" ]; then
        git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "${ZSH_CUSTOM}/plugins/you-should-use" || error_exit "Failed to clone you-should-use repository."
    else
        echo "you-should-use is already installed."
    fi

    # Install autojump
    if ! command_exists autojump; then
        echo "Installing autojump..."
        if command_exists apt; then
              apt install -y autojump || error_exit "Failed to install autojump using apt."
        elif command_exists yum; then
              yum install -y autojump || error_exit "Failed to install autojump using yum."
        elif command_exists dnf; then
              dnf install -y autojump || error_exit "Failed to install autojump using dnf."
        elif command_exists pacman; then
              pacman -Sy --noconfirm autojump || error_exit "Failed to install autojump using pacman."
        else
            error_exit "Package manager not supported. Please install autojump manually."
        fi
    else
        echo "autojump is already installed."
    fi


    # Enable plugins in .zshrc
    sed -i 's/^plugins=(.*)$/plugins=(git zsh-autosuggestions fast-syntax-highlighting zsh-interactive-cd zsh-completions you-should-use autojump extract)/' "$HOME/.zshrc"
    echo "Plugins installed and configured."
}

# Main function to execute all steps
main() {
    echo "Starting Zsh configuration script..."
    install_zsh
    set_default_shell
    install_oh_my_zsh
    install_powerlevel10k
    install_plugins
    echo "Zsh configuration completed. Please restart your terminal or log out and back in to apply changes."
}

# Execute the main function
main
