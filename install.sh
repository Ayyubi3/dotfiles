#!/bin/bash

function out() {
	GREEN='\033[0;32m'
	RESET='\033[0m'
	echo -e "${GREEN}$1${RESET}"
}

out "Update/Upgrade"
sudo apt -qq -y update
sudo apt -qq -y upgrade

# Install basic packages
packages=("git" "build-essential" "ripgrep" "unzip" "fd-find" "lazygit" "curl" "tar")

for element in "${packages[@]}"; do
	out "Installing $element"
	sudo apt-get -q -y install "$element"
done

out "installing node"
curl -sL https://deb.nodesource.com/setup_20.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh && sudo apt-get -q install nodejs -y
node -v
npm -v

out "Installing lazygit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz
rm lazygit



out "NVVVVIIIIMMM"
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
sudo ./nvim.appimage --appimage-extract
sudo mv squashfs-root/usr/bin/nvim /usr/bin/ 
