#!/bin/bash

# Detect package manager
if command -v apt-get >/dev/null 2>&1; then
    # Install packages for Debian-based distributions
    sudo apt-get install -y zsh tmux neovim curl git
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
elif command -v dnf >/dev/null 2>&1; then
    # Install packages for Fedora-based distributions
    sudo dnf install -y zsh tmux neovim curl git
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
elif command -v pacman >/dev/null 2>&1; then
    # Install packages for Arch-based distributions
    sudo pacman -S --noconfirm zsh tmux neovim curl git
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Unsupported distribution"
    exit 1
fi

# Clone TPM (Tmux package manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Clone dotfiles repository
git clone --recurse-submodules https://github.com/Its-Haze/dotfiles.git ~/dotfiles

# Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Copy configuration files
cp ~/dotfiles/zsh/.zshrc ~/.zshrc
#cp ~/dotfiles/zsh/custom.zsh ~/.oh-my-zsh/custom/custom.zsh
#cp ~/dotfiles/oh-my-zsh/themes/custom.zsh-theme ~/.oh-my-zsh/custom/themes/
cp ~/dotfiles/powerlevel10k/.p10k.zsh ~/.p10k.zsh
#cp ~/dotfiles/oh-my-zsh/plugins/plugin1/plugin1.zsh ~/.oh-my-zsh/custom/plugins/plugin 1/
#cp ~/dotfiles/oh-my-zsh/plugins/plugin2/plugin2.zsh ~/.oh-my-zsh/custom/plugins/plugin2/
cp ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config/nvim/
cp ~/dotfiles/kickstart.nvim/init.vim ~/.config/nvim/
#cp ~/dotfiles/nvim/coc-settings.json ~/.config/nvim/

# Set the ZSH-THEME to powerlevel10k
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

