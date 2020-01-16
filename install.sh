#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

echo "\n=[ Installing Software ]=\n"

echo "-> brew\n"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

echo "-> git\n"
brew install git

echo "-> zsh\n"
brew install zsh

echo "-> vim\n"
brew install vim

echo "-> iTerm2\n"
brew cask install iterm2

echo "-> Visual Studio Code\n"
brew cask install visual-studio-code

echo "-> Telegram\n"
brew cask install telegram

echo "\n=[ Configuring Git ]=\n"
echo -n "\n> Enter name: " read GIT_NAME
echo -n "\n> Enter email: " read GIT_EMAIL
ssh-keygen -t RSA -C $GIT_EMAIL -N '' -f $HOME/.ssh/id_rsa

echo "\n=[ Connecting to GitHub ]=\n"
echo -n "\n> Enter GitHub personal token: " read -s GITHUB_TOKEN
curl -v -H "Authorization: token $GITHUB_TOKEN" --data '{"title":"'$GIT_EMAIL'","key":"'"$(cat $HOME/.ssh/id_rsa.pub)"'"}' https://api.github.com/user/keys

git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL

ln -sf $DOTFILES_DIR/.gitattributes $HOME/.gitattributes
ln -sf $DOTFILES_DIR/.vim $HOME/.vim
ln -sf $DOTFILES_DIR/.vimrc $HOME/.vimrc
ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc
