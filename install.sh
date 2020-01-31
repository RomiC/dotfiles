#!/bin/bash

echo '=[ Installing Software ]='

echo '-> brew'
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

echo '-> git'
brew install git

echo '-> zsh'
brew install zsh

echo '-> vim'
brew install vim

echo '-> iTerm2'
brew cask install iterm2

echo '-> Visual Studio Code'
brew cask install visual-studio-code

echo '-> Telegram'
brew cask install telegram

echo '-> Skype'
brew cask install skype

echo '-> nvm'
brew install nvm

echo '=[ Configuring Git ]='
echo -n '> Enter name: '; read GIT_NAME
echo -n '> Enter email: '; read GIT_EMAIL
ssh-keygen -t RSA -C $GIT_EMAIL -N '' -f $HOME/.ssh/id_rsa

echo '=[ Connecting to GitHub ]='
echo -n '> Enter GitHub personal token: '; read -s GITHUB_TOKEN
curl -v -H "Authorization: token $GITHUB_TOKEN" --data '{"title":"'$GIT_EMAIL'","key":"'"$(cat $HOME/.ssh/id_rsa.pub)"'"}' https://api.github.com/user/keys

echo '=[ Installing dotfiles ]='
DOTFILES_DIR=$HOME/work/dotfiles
git clone git@github.com:RomiC/dotfiles.git $DOTFILES_DIR

echo '=[ Configuring git ]='
cp $DOTFILES_DIR/.gitconfig $HOME/.gitconfig
git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL
git config --global core.excludesfile $DOTFILES_DIR/.gitignore_global
ln -sf $DOTFILES_DIR/.gitattributes $HOME/.gitattributes

echo '=[ Configuring vim ]='
ln -sf $DOTFILES_DIR/.vim $HOME/.vim
ln -sf $DOTFILES_DIR/.vimrc $HOME/.vimrc

echo '=[ Configuring zsh ]='

echo '-> oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo '-> spaceship-prompt'
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
git clone https://github.com/denysdovhan/spaceship-prompt.git --depth=1 "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc

echo '=[ Configuring iTerm2 ]='
ln -sf $DOTFILES_DIR/com.googlecode.iterm2.plist $HOME/Library/Preferences/com.googlecode.iterm2.plist

echo '=[ Installing fonts ]='
FONTS_DIR="$HOME/Library/Fonts"

echo '-> Fira Code'
curl -sL https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip | tar xvf - --include="ttf/*" -C $FONTS_DIR --strip-components 1

echo '-> JetBrains Mono'
curl -sL https://download.jetbrains.com/fonts/JetBrainsMono-1.0.0.zip | tar xvf - -C $FONTS_DIR

echo '-> Powerline fonts'
git clone https://github.com/powerline/fonts.git --depth=1 $TMPDIR/powerline
cd $TMPDIR/powerline
./install.sh
rm -rf $TMPDIR/powerline

echo '=[ Configuting MacOS ]='
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo '=[ Running ZSH ]='
if [ "$(basename "$SHELL")" = "zsh" ];
then
	source $HOME/.zshrc
else
	exec zsh -l
fi
