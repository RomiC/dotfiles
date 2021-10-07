# Go path
export GOPATH=$HOME/work/go

# Additional paths
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
# NeoVIM mac os installation
if [ -d "$HOME/nvim-osx64/bin" ] ; then
    PATH="$HOME/nvim-osx64/bin:$PATH"
fi
# Path to the globally installed npm-packages
if [ -d "$HOME/.npm-global/bin" ] ; then
    PATH="$HOME/.npm-global/bin:$PATH"
fi
# Path to GO root project
if [ -d "$GOPATH/bin" ] ; then
    PATH="$GOPATH/bin:$PATH"
fi
# JDK
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
export PATH="/Library/Java/JavaVirtualMachines/jdk1.8.0_251.jdk/Contents/Home/bin:$PATH"

# Default locale
export LC_ALL=en_US.UTF-8

# Settign default editor to vim
export EDITOR=vim
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""
POWERLEVEL9K_MODE="flat"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_COLOR_SCHEME="dark"

SPACESHIP_DOCKER_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_TIME_SHOW=false
SPACESHIP_EXEC_TIME_SHOW=false
SPACESHIP_DIR_TRUNC=2
SPACESHIP_PROMPT_DEFAULT_PREFIX="· "

PURE_PROMPT_SYMBOL="➜"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(docker docker-compose fnm fzf fzf-tab git git-flow heroku httpie jsontools npm sudo tmux zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# fnm-init for managing different node versions
eval "$(fnm env)"

bindkey '\ec' fzy-cd-widget
bindkey '^T'  fzy-file-widget
bindkey '^P'  fzy-proc-widget

zstyle :fzy:tmux    enabled      no

zstyle :fzy:history show-scores  no
zstyle :fzy:history lines        '10'
zstyle :fzy:history prompt       'history >> '
zstyle :fzy:history command      fzy-history-default-command

zstyle :fzy:file    show-scores  no
zstyle :fzy:file    lines        '10'
zstyle :fzy:file    prompt       'file >> '
zstyle :fzy:file    command      fzy-file-default-command

zstyle :fzy:cd      show-scores  no
zstyle :fzy:cd      lines        ''
zstyle :fzy:cd      prompt       'cd >> '
zstyle :fzy:cd      command      fzy-cd-default-command

zstyle :fzy:proc    show-scores  no
zstyle :fzy:proc    lines        '10'
zstyle :fzy:proc    prompt       'proc >> '
zstyle :fzy:proc    command      fzy-proc-default-command

# Aliases
alias glg='g lg' gsth='g sth' gusth='g usth'
alias vim=nvim
alias doc=docker
alias lsa='ls -lhA' lsv='ls -lh' lsn='ls -1A'

export NGINX_PROXY_HOST="docker.for.mac.localhost"

# Github Container Registry token
export CR_PAT=16cca42b4cfc91b5aaf2f1a8a52e6cea6c51584d

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'  # Follow links, exclude hiddens and node_modules

# Colorizing zsh suggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#685e4a'

# Run tmux on Startup
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_CONFIG=$HOME/.config/tmux/tmux.conf
