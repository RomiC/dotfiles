#!/bin/bash

# Ask for the administrator password upfront
sudo -v

echo '=[ Installing Software ]='

echo '-> xcode-select'
xcode-select --install
sleep 1
osascript <<EOD
  tell application "System Events"
    tell process "Install Command Line Developer Tools"
      keystroke return
      click button "Agree" of window "License Agreement"
    end tell
  end tell
EOD

echo '-> brew'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [[ "$(which brew)" == *"not found"* ]]; then 
	echo "ERROR: brew is missing"
	exit 1
fi

sudo chown -R $(whoami) /usr/local/var/homebrew

brew update
if [[ $? -ne 0 ]]; then
	git -C /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core fetch --unshallow && \
  		git -C /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask fetch --unshallow

	if [[ $? -ne 0 ]]; then
		echo 'ERROR: brew update failed!'
		exit 1
	fi
fi

echo '-> git'
brew install git

if [[ -z "$(cat /etc/shells | grep zsh)" ]]; then
	echo '-> zsh'
	brew install zsh
fi

echo '-> tmux'
brew install tmux

echo '-> neovim'
brew install neovim

echo '-> jq'
brew install jq

echo '-> fd'
brew install fd

echo '-> ffmpeg'
brew install ffmpeg

echo '-> Alacritty'
brew install --cask alacritty

echo '-> Visual Studio Code'
brew install --cask visual-studio-code

echo '-> Telegram'
brew install --cask telegram

echo '-> Skype'
brew install --cask skype

echo '-> AppCleaner'
brew install --cask app-cleaner

echo '-> fnm'
brew install fnm

echo '-> fzf'
brew install fzf

echo '-> Raycast'
brew install --cask raycast

echo '-> Bartender'
brew install --cask bartender

echo '-> Fluor'
brew install --cask fluor

echo '-> Mattermost'
brew install --cask mattermost

echo '-> Figma'
brew install --cask figma

echo '-> Zoom'
brew install --cask zoom

echo '-> Spotify'
brew install --cask spotify

# echo '-> pCloud'
# brew tap lyraphase/pcloud
# brew install --cask pcloud-drive

echo '-> Arc Brower'
brew install --cask arc

echo '-> Docker'
brew install --cask docker

echo '-> im-select'  # necessary for VSCode
if [[ -e /usr/local/bin/im-select ]]; then
    rm -f /usr/local/bin/im-select
fi
curl -Ls -o /usr/local/bin/im-select https://github.com/daipeihust/im-select/raw/master/macOS/out/intel/im-select
chmod +x /usr/local/bin/im-select

echo '-> 1password-cli'
brew install --cask 1password/tap/1password-cli

echo '=[ Configuring Git ]='
echo -n '> Enter name: '; read GIT_NAME
echo -n '> Enter email: '; read GIT_EMAIL
ssh-keygen -t RSA -C $GIT_EMAIL -N '' -f $HOME/.ssh/id_rsa

echo '=[ Connecting to GitHub ]='
echo "> Generate a new classic token (https://github.com/settings/tokens) with the following permits:\n- admin:public_key\n  - write:public_key\n  - read:public_key"
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
git config --global core.editor "nvim"
git config --global init.defaultBranch main
ln -sf $DOTFILES_DIR/.gitattributes $HOME/.gitattributes

mkdir -p $HOME/.config

echo '=[ Configuring neovim ]='
ln -sf $DOTFILES_DIR/nvim $HOME/.config/nvim
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c ":PlugInstall" -c ":qa"

echo '=[ Configuring alacritty ]='
ln -sf $DOTFILES_DIR/alacritty $HOME/.config/alacritty

echo '=[ Configuring tmux ]='
ln -sf $DOTFILES_DIR/tmux $HOME/.config/tmux
git clone https://github.com/tmux-plugins/tmux-continuum $HOME/.config/tmux/plugins/tmux-continuum
git clone https://github.com/tmux-plugins/tmux-resurrect $HOME/.config/tmux/plugins/tmux-resurrect
git clone https://github.com/nhdaly/tmux-better-mouse-mode $HOME/.config/tmux/plugins/tmux-better-mouse-mode
git clone https://github.com/tmux-plugins/tmux-open $HOME/.config/tmux/plugins/tmux-open

echo '=[ Configuring zsh ]='

echo '-> oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo '-> pure shell'
brew install pure

# fzf-tab plugin
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc

echo '=[ Configuring 1Password cli ]='
op signin

echo '=[ Configuring 1Password ssh-agent ]='
mkdir -p $HOME/.config/1Password/ssh
ln -sf $DOTFILES_DIR/1Password/ssh/agent.toml $HOME/.config/1Password/ssh/agent.toml

echo '=[ Installing fonts ]='
FONTS_DIR="$HOME/Library/Fonts"

echo '-> Fira Code'
if [[ -z "$(system_profiler SPFontsDataType | grep -e 'FiraCode-.*\.ttf')" ]]; then
	curl -sL https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip | tar xvf - --include="ttf/*" -C $FONTS_DIR --strip-components 1
fi

echo '-> JetBrains Mono'
if [[ -z "$(system_profiler SPFontsDataType | grep -e 'JetBrainsMono-.*\.ttf')" ]]; then
	curl -sL https://download.jetbrains.com/fonts/JetBrainsMono-1.0.0.zip | tar xvf - -C $FONTS_DIR
fi

echo '-> MonaLisa Nerd'
if [[ -z "$(system_profiler SPFontsDataType | grep 'MonoLisa Regular Nerd Font Complete.otf')" ]]; then
	/usr/bin/open -a Safari https://e.pcloud.link/publink/show\?code\=XZTFTuZL6DbliJyiyJomrpa8GdNbLbENskV
fi

echo '-> Powerline fonts'
git clone https://github.com/powerline/fonts.git --depth=1 $TMPDIR/powerline
cd $TMPDIR/powerline
./install.sh
rm -rf $TMPDIR/powerline

echo '=[ Configuting MacOS ]='
sudo -v
# More options could be found here: https://github.com/mathiasbynens/dotfiles/blob/master/.macos

# Removes delay between key pressing
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# and for VSCode as well
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

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

# Enable 3-fingers dragging
defaults write NSGlobalDomain com.apple.trackpad.threeFingerSwipeGesture -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerSwipeGesture -int 1

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

# Change screenshot target folder
mkdir $HOME/Screenshots
defaults write com.apple.screencapture location $HOME/Screenshots

killall SystemUIServer

echo '=[ Running ZSH ]='
if [ "$(basename "$SHELL")" = "zsh" ];
then
	source $HOME/.zshrc
else
	exec zsh -l
fi
