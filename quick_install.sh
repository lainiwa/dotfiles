#!/bin/sh -
set -o errexit   # exit on fail
set -o nounset   # exit on undeclared variable
set -o xtrace    # trace execution

# Create ~/.ssh if not exists
mkdir -p ~/.ssh

# Add github's host key to known_hosts (if not yet)
if ! grep github.com ~/.ssh/known_hosts >/dev/null 2>&1; then
    ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
fi

# Clone repository (if not yet)
if [ ! -d ~/.dotfiles ]; then
    # First try cloning via ssh (only works if owner of repo)
    git clone     git@github.com:lainiwa/dotfiles.git ~/.dotfiles ||
    # Clone via https otherwise
    git clone https://github.com/lainiwa/dotfiles.git ~/.dotfiles
fi

# Execute installer
~/.dotfiles/install

# Eagerly load zsh plugins
zsh -i -c -- '(( ${+commands[-zplg-scheduler]} )) && -zplg-scheduler burst || true'
