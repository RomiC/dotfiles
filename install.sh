#!/bin/bash

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

echo "-> Skype\n"
brew cask install skype

echo "\n=[ Configuring Git ]=\n"
echo -n "\n> Enter name: " read GIT_NAME
echo -n "\n> Enter email: " read GIT_EMAIL
ssh-keygen -t RSA -C $GIT_EMAIL -N '' -f $HOME/.ssh/id_rsa

echo "\n=[ Connecting to GitHub ]=\n"
echo -n "\n> Enter GitHub personal token: " read -s GITHUB_TOKEN
curl -v -H "Authorization: token $GITHUB_TOKEN" --data '{"title":"'$GIT_EMAIL'","key":"'"$(cat $HOME/.ssh/id_rsa.pub)"'"}' https://api.github.com/user/keys


echo "\n=[ Installing dotfiles ]=\n"
$DOTFILES_DIR = $HOME/work/dotfiles
mkdir -p $DOTFILES_DIR
git clone git@github.com:RomiC/dotfiles.git $DOTFILES_DIR

echo "\n=[ Configuring git ]=\n"
git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL
git config --global core.excludesfile $DOTFILES_DIR/.gitignore_global
ln -sf $DOTFILES_DIR/.gitattributes $HOME/.gitattributes

echo "\n=[ Configuring vim ]=\n"
ln -sf $DOTFILES_DIR/.vim $HOME/.vim
ln -sf $DOTFILES_DIR/.vimrc $HOME/.vimrc

echo "\n=[ Configuring zsh ]=\n"
ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc

echo "\n=[ Installing fonts ]=\n"
curl -sL https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip | tar xvf - --include="ttf/*"
