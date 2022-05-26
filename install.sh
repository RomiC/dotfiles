#!/bin/bash

echo '=[ Installing Software ]='

echo '-> brew'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [ -z "$(whereis brew)" ];
then
	echo "Error: brew wasn't installed!"
	exit 1
fi
brew update

echo '-> git'
brew install git

echo '-> zsh'
brew install zsh

echo '-> tmux'
brew install tmux

#echo '-> vim'
#brew install vim

echo '-> neovim'
brew install neovim

#echo '-> iTerm2'
#brew cask install iterm2

echo '-> Alacritty'
brew cask install alacritty

echo '-> Visual Studio Code'
brew cask install visual-studio-code

echo '-> Telegram'
brew cask install telegram

echo '-> Skype'
brew cask install skype

echo '-> AppCleaner'
brew cask install app-cleaner

echo '-> nvm'
brew install fnm

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

mkdir -p $HOME/.config

echo '=[ Configuring neovim ]='
ln -sf $DOTFILES_DIR/nvim $HOME/.config/nvim

echo '=[ Configuring alacritty ]='
ln -sf $DOTFILES_DIR/alacritty $HOME/.config/alacritty

echo '=[ Configuring tmux ]='
ln -sf $DOTFILES_DIR/tmux $HOME/.config/tmux

#echo '=[ Configuring vim ]='
#ln -sf $DOTFILES_DIR/.vim $HOME/.vim
#ln -sf $DOTFILES_DIR/.vimrc $HOME/.vimrc

echo '=[ Configuring zsh ]='

echo '-> oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo '-> spaceship-prompt'
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
git clone https://github.com/denysdovhan/spaceship-prompt.git --depth=1 "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc

#echo '=[ Configuring iTerm2 ]='
#ln -sf $DOTFILES_DIR/com.googlecode.iterm2.plist $HOME/Library/Preferences/com.googlecode.iterm2.plist

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
# More options could be found here: https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# Ask for the administrator password upfront
sudo -v

# Removes delay between key pressing
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set language and text formats
defaults write NSGlobalDomain AppleLocale "en_Gb@currency=EUR"

# Show language menu in the top right corner of the boot screen
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

# Set machine sleep to 5 minutes on battery
sudo pmset -b sleep 5

# Set standby delay to 30 mins
sudo pmset -a standbydelay 1800

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

killall SystemUIServer

echo '=[ Running ZSH ]='
if [ "$(basename "$SHELL")" = "zsh" ];
then
	source $HOME/.zshrc
else
	exec zsh -l
fi
