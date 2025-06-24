if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ZInit plugin manager installation
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ ! -d $ZINIT_HOME ]] then;
  mkdir -p "$(dirname $ZINIT_HOME)"
fi

if [[ ! -d $ZINIT_HOME/.git ]] then;
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"


# Set FZF path in a first place to prevent annoying errors in console
export FZF_PATH=/opt/homebrew/opt/fzf

# Installing plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light unixorn/fzf-zsh-plugin
# - fzf-zsh-plugin
#if [[ ! -d $ZINIT[PLUGINS_DIR]/fzf-zsh-plugin ]] then;
#  git clone --depth 1 git@github.com:unixorn/fzf-zsh-plugin.git $ZINIT[PLUGINS_DIR]/fzf-zsh-plugin
#fi
#source $ZINIT[PLUGINS_DIR]/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh
# - Pure-theme
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::tmux

# Configuration
# - Navigation
bindkey '^e' end-of-line
# - Completion
#  - Loading completion
autoload -Uz compinit
#  - Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# - ZSH-Autosuggestion
bindkey '^[[Z' autosuggest-accept

# - History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt autocd # Go to directory w/o explicit cd command

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# - Pure prompt
PURE_PROMPT_SYMBOL="➜"

# - fzf-tab completion
#  - fzf theme inspired by vim-afterglow
export FZF_DEFAULT_OPTS="--cycle --color 'fg:#E6E1CF,fg+:#ddeeff,bg:#1A1A1A,bg+:#393939,pointer:#FF8400,header:#717879'"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'  # Follow links, exclude hiddens and node_modules
#  - fzf-tab completion plugin config
zstyle ':fzf-tab:*' fzf-bindings 'space:toggle' \
  'ctrl-a:toggle-all' \
  'ctrl-j:down' \
  'ctrl-k:up'
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:complete:git-switch:*' fzf-command git-switch-fzf
zstyle ':fzf-tab:complete:gswup:*' fzf-command git-switch-fzf

# Initialize completions
compinit

git-switch-fzf () {
  git branch --color=always --sort=-committerdate | grep -v HEAD | fzf --ansi --no-multi --height=30% --preview-window right:50% --preview 'git lg --color=always -n 30 $(sed "s/.* //" <<< {})' | sed 's/.* //'
}

# - FNM (node manager)
eval "$(fnm env --use-on-cd)"

# - Docker
export NGINX_PROXY_HOST="docker.for.mac.localhost"

# - ZSH Tmux plugin
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOQUIT=true
export ZSH_TMUX_DEFAULT_SESSION_NAME="charugin"
export ZSH_TMUX_CONFIG=$HOME/.config/tmux/tmux.conf

# - NodeJS path
export NODE_PATH=$(npm root -g)

# - Bitwarden CLI Session
export BW_SESSION="$(security find-generic-password -a 'roman.charugin@acronis.com' -s 'Bitwarden Session' -w 2>/dev/null)"

# Aliases
# - Git
function gswup() {
  if [ -z $1 ]; then
    echo "fatal: missing branch"
    return 1
  fi
  git switch $1
  git pull
}
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
alias lsa='ls -lhA' ll='ls -lh' lsn='ls -1A'
# - FNM (Node manager)
alias nu='fnm use' nls='fnm list' nlsr='fnm list-remote'
# - Node
alias nv='node -v'
# - Clear console
alias c='clear'

# Running tmux on kitty startup
if [ -z "$TMUX" ] && [ "$TERM" = "xterm-kitty" ]; then
  tmux attach || exec tmux new-session && exit;
fi
