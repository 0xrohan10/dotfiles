#!/usr/bin/env bash
set -euo pipefail

brew install stow
git clone git@github.com:0xrohan10/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow --adopt zsh git tmux config claude
git restore .
