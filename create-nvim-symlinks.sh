#!/usr/bin/env sh

# ~/.config/dotfiles/nvim/create-nvim-symlinks.sh


DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


#-----------------------------------------------------------------------------
#  Neovim Configs
#-----------------------------------------------------------------------------

# Delete ~/.config/nvim/:
rm -rf $HOME/.config/nvim

# Create ~/.config/nvim:
#mkdir $HOME/.config/nvim

# Create symlink to ~/.config/dotfiles/nvim/lua/:
#ln -s $DOTFILES/nvim/lua $HOME/.config/nvim/
ln -s ~/.config/dotfiles/nvim $HOME/.config/nvim

# Create symlink to ~/.config/dotfiles/nvim/init.lua:
#ln -s $DOTFILES/nvim/init.lua $HOME/.config/nvim/init.lua
