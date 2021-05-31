#!/bin/bash

set -euf -o pipefail

# make sure files of same name don't already exist
test -f $HOME/.zshrc && { echo "zshrc exist."; exit 1; }
test -f $HOME/.vimrc && { echo "vimrc exist."; exit 1; }
test -f $HOME/.config/nvim/init.vim && { echo "nvim config exist."; exit 1; }

# download
if  command -v git &> /dev/null
then
    echo "using git"
    git clone --bare https://github.com/awesmubarak/dotfiles $HOME/.dotfiles
    alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
else
    echo "git not found, copying directly"
    wget "https://github.com/awesmubarak/dotfiles/archive/refs/heads/main.zip"
    unzip main.zip
    mv dotfiles-main/* $HOME
    rm -rf main.zip dotfiles-main
fi

#post
cd $HOME && mkdir .zsh && curl -L git.io/antigen > $HOME/.zsh/antigen.zsh
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
