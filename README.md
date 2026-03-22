

My personal configuration files managed with GNU Stow. 
    Configs

    Terminal: kitty

    Editor: neovim (Custom Lua config)

    Launcher: rofi (with various themes)

    Status Bar: waybar

    Music/Others: rmpc, streamrip, pywal

    Installation

To set these up on a fresh system, follow these steps:
1. Prerequisites

Ensure you have git and stow installed:

    Arch: sudo pacman -S git stow

    Debian/Ubuntu: sudo apt install git stow

    Fedora: sudo dnf install git stow

2. Clone the Repository

Clone this repo into a folder named dotfiles in your home directory:


	git clone https://github.com/ThePropHat/dotfiles.git ~/dotfiles
	cd ~/dotfiles

3. Deploy with Stow

First, create the .config directory if it doesn't exist:


	mkdir -p ~/.config

Then, use Stow to symlink the configurations:


	# To stow everything at once:
	stow *

	# Or stow specific packages:
	stow nvim kitty rofi

⚠️ Notes

    Conflicts: If Stow says "existing target is not a symlink," you must delete or move the existing config file in ~/.config/ before stowing.

    Neovim: This config assumes a modern Neovim (0.9+) installation.
