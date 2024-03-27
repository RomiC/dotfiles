# Additional paths
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Default locale
export LC_ALL=en_US.UTF-8

# Settign default editor to vim
export EDITOR=vim
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

PURE_PROMPT_SYMBOL="➜"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  docker
  docker-compose
  fnm
  fzf
  fzf-tab
  git
  npm
  sudo
  tmux
  vscode
  zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure

# fnm-init for managing different node versions
eval "$(fnm env --use-on-cd)"

# vim mode
# bindkey -v
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

# fzf-tab completion plugin config
zstyle ':fzf-tab:*' fzf-bindings 'space:toggle' \
  'ctrl-a:toggle-all' \
  'ctrl-j:down' \
  'ctrl-k:up'

# Aliases
# - Git
alias glg='git lg' \
  gsth='git stash -u' \
  gusth='git stash pop stash@{0}' \
  grhm='git reset --mixed' \
  gbro='git branch --merged origin/master | grep -v master | xargs git branch -d'
# - NeoVIM instead of vim
alias vim=nvim v=nvim
# - Vifm
alias vf=vifm
# - Docker
alias doc=docker
# - List files
alias lsa='ls -lhA' lsv='ls -lh' lsn='ls -1A'
# - FNM (Node manager)
alias nu='fnm use' nls='fnm list' nlsr='fnm list-remote'
# - Node
alias nv='node -v'

export NGINX_PROXY_HOST="docker.for.mac.localhost"

# VSCode plugin settings
export VSCODE=code

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'  # Follow links, exclude hiddens and node_modules

# Colorizing zsh suggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#685e4a'

# Run tmux on Startup
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOQUIT=true
export ZSH_TMUX_DEFAULT_SESSION_NAME="charugin"
export ZSH_TMUX_CONFIG=$HOME/.config/tmux/tmux.conf

# bun completions
[ -s "/Users/charugin/.bun/_bun" ] && source "/Users/charugin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# 1Password CLI completion
eval "$(op completion zsh)"; compdef _op op
