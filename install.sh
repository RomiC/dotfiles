#!/bin/bash

# Ask for the administrator password upfront
sudo -v

echo '=[ Xcode Command Line Tools ]='
# Ensure with have Xcode command line tools installed
if [[ -z $(xcode-select --print-path) ]]; then
  echo "-> Installing  (expect a GUI popup)"
  xcode-select --install &>/dev/null
  echo "-> Press any key after installation has completed"
  read -rsn1
  if [[ -z $(xcode-select --print-path) ]]; then
    echo "ERROR: Unable to find Xcode Command Line Tools"
    exit 1
  fi
else
	echo '-> Xcode Command Line Tools are already installed'
fi

echo '=[ Installing dotfiles ]='
DOTFILES_DIR=$HOME/work/dotfiles
git clone https://github.com/RomiC/dotfiles.git $DOTFILES_DIR

echo '=[ Installing Software ]='

echo '-> brew'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
BREW_BIN=$(which brew)
if [[ "$BREW_BIN" == *"not found"* ]]; then
	echo "ERROR: brew is missing"
	exit 1
fi

$BREW_BIN update

echo '-> brew bundle'
ln -sf $DOTFILES_DIR/.Brewfile $HOME/.Brewfile
$BREW_BIN bundle
$BREW_BIN cleanup

echo '-> im-select'  # necessary for VSCode
if [[ -e /usr/local/bin/im-select ]]; then
    rm -f /usr/local/bin/im-select
fi
curl -Ls -o /usr/local/bin/im-select https://github.com/daipeihust/im-select/raw/master/macOS/out/intel/im-select
chmod +x /usr/local/bin/im-select


echo '=[ Configuring ]='

mkdir -p $HOME/.config

echo '-> git'
cp $DOTFILES_DIR/.gitconfig $HOME/.gitconfig
echo -n '> Enter name: '; read GIT_NAME
git config --global user.name $GIT_NAME
echo -n '> Enter email: '; read GIT_EMAIL
git config --global user.email $GIT_EMAIL
git config --global core.excludesfile $DOTFILES_DIR/.gitignore_global
git config --global core.editor "nvim"
git config --global init.defaultBranch main
ln -sf $DOTFILES_DIR/.gitattributes $HOME/.gitattributes

echo '-> Ghostty'
ln -sf $DOTFILES_DIR/ghostty $HOME/.config/ghostty

echo '-> neovim'
ln -sf $DOTFILES_DIR/nvim $HOME/.config/nvim
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c ":PlugInstall" -c ":qa"

echo '-> tmux'
ln -sf $DOTFILES_DIR/tmux $HOME/.config/tmux
git clone https://github.com/tmux-plugins/tmux-continuum $HOME/.config/tmux/plugins/tmux-continuum
git clone https://github.com/tmux-plugins/tmux-resurrect $HOME/.config/tmux/plugins/tmux-resurrect
git clone https://github.com/nhdaly/tmux-better-mouse-mode $HOME/.config/tmux/plugins/tmux-better-mouse-mode
git clone https://github.com/tmux-plugins/tmux-open $HOME/.config/tmux/plugins/tmux-open

echo '-> zsh'

echo '-> oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# fzf-tab plugin
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc

echo '-> 1Password CLI'
eval $(op signin)
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
	curl -sL https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip | tar xvf - --include="fonts/ttf/*" -C $FONTS_DIR --strip-components 2
fi

echo '-> MonoLisa'
if [[ -z "$(system_profiler SPFontsDataType | grep -e 'MonoLisa-.*\.ttf')" ]]; then
  curl -s https://e.pcloud.link/publink/show\?code\=XZv1cEZHxnYUJXHRT07USkhayKeFVS3P77V |\
    grep downloadlink |\
    sed -e 's/^.*\(https[^"]*\).*/\1/' -e 's/\\\//\//g' |\
    xargs -I @ curl -sL @ |\
    tar xvf - -C $FONTS_DIR
fi

echo '-> MonoLisa Nerd'
if [[ -z "$(system_profiler SPFontsDataType | grep -e 'MonoLisaNerdFont-.*\.ttf')" ]]; then
  curl -s https://e.pcloud.link/publink/show\?code\=XZpecEZFMRW1JNKmcYghq2Gvxi02Roi31p7 |\
    grep downloadlink |\
    sed -e 's/^.*\(https[^"]*\).*/\1/' -e 's/\\\//\//g' |\
    xargs -I @ curl -sL @ |\
    tar xvf - -C $FONTS_DIR
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
defaults write NSGlobalDomain InitialKeyRepeat -int 25

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
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

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

# Show the ~/Library folder
chflags nohidden ~/Library

# Automatically hide the Dock
if [ "$(defaults read com.apple.dock autohide 2>/dev/null)" != 1 ]; then
  defaults write com.apple.dock autohide -bool true
  killall Dock
fi

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Set home as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Finder: show hidden files by default
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Finder: set window title to full POSIX file path of current folder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Don't show drives on Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

killall SystemUIServer
