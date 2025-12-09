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

# VSCode Terminal shell integration (https://code.visualstudio.com/docs/terminal/shell-integration)
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"


# Set FZF path in a first place to prevent annoying errors in console
export FZF_PATH=/opt/homebrew/opt/fzf

# Installing plugins
zinit light zsh-users/zsh-completions
zinit light unixorn/fzf-zsh-plugin
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add Docker completions to fpath before compinit
fpath=(/Users/roman.charugin/.docker/completions $fpath)

# Initialize completions (must be AFTER fzf-tab plugin load)
autoload -Uz compinit
compinit
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
# Unbind ctrl+space to allow tmux prefix to work
bindkey -r '^@'
# - Completion
#  - Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' fzf-search-display true

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
zstyle ':completion:*' menu select
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' fzf-min-height 15
zstyle ':fzf-tab:*' fzf-flags --height=50% --preview-window=right:50% --no-sort
zstyle ':fzf-tab:*' fzf-bindings 'space:toggle' 'ctrl-a:toggle-all' 'ctrl-j:down' 'ctrl-k:up'
# Disable default-command to prevent fzf-tab from re-sorting
zstyle ':fzf-tab:complete:git-switch:*' fzf-flags --height=50% --preview-window=right:50% --no-sort
zstyle ':fzf-tab:complete:git-checkout:*' fzf-flags --height=50% --preview-window=right:50% --no-sort
zstyle ':fzf-tab:complete:gsw:*' fzf-flags --height=50% --preview-window=right:50% --no-sort
zstyle ':fzf-tab:complete:gco:*' fzf-flags --height=50% --preview-window=right:50% --no-sort
# Set specific previews for git commands
zstyle ':fzf-tab:complete:git:*' fzf-preview '
  # Use realpath for files/dirs, word for branches
  item=${(Q)realpath:-${${(Q)word}%% *}}
  # Check if it'\''s a directory
  if [[ -d $item ]]; then
    ls -1A --color=always $item 2>/dev/null || ls -1A $item
  # Check if it'\''s a file
  elif [[ -f $item ]]; then
    cat $item
  # Try git for files not in working directory, or show git log for branches
  else
    git cat-file -p HEAD:$item 2>/dev/null ||
    git log --oneline --graph --color=always -n 10 $item 2>/dev/null ||
    echo "Branch: $item"
  fi
'
zstyle ':fzf-tab:complete:gsw:*' fzf-preview 'git log --oneline --graph --color=always -n 10 ${(Q)word}'
zstyle ':fzf-tab:complete:gswup:*' fzf-preview 'git log --oneline --graph --color=always -n 10 ${(Q)word}'

# Disable sorting for git branch completions
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:git-switch:*' sort false
zstyle ':completion:*:gswup:*' sort false
zstyle ':completion:*:*:git:*' sort false
zstyle ':completion:*:*:git-*:*' sort false
# Add the exact context that fzf-tab uses
zstyle ':completion:complete:git:argument-rest' sort false
zstyle ':completion:complete:-command-:*' sort false
# Add contexts for git aliases
zstyle ':completion:complete:gsw:*' sort false
zstyle ':completion:complete:gco:*' sort false
zstyle ':completion:complete:gswup:*' sort false

# Disable DWIM (Do What I Mean) for git checkout/switch to only show local branches
export GIT_COMPLETION_CHECKOUT_NO_GUESS=1

# Custom completion for gswup alias and git aliases
_gswup() {
  local -a branches
  branches=(${(f)"$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads/ 2>/dev/null)"})
  _describe -t branches 'recent branches' branches
}

# Register git completions LAST to override plugin completions
compdef _gswup gswup

# Custom git completion for switch/checkout with proper branch sorting
_git_simple() {
  # Check if we're after -- (file completion context)
  if (( ${words[(I)--]} )); then
    _files
  else
    # Check if previous word is a valid ref (for file completion after branch name)
    local prev_word="${words[-1]}"
    if [[ "$prev_word" != "switch" && "$prev_word" != "checkout" ]] && git rev-parse --verify "$prev_word" &>/dev/null 2>&1; then
      _files
    else
      # Complete branches sorted by commit date (most recent first)
      local -a branches
      branches=(${(f)"$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads/ 2>/dev/null)"})
      _describe -t branches 'branches' branches
    fi
  fi
}

# Override only switch and checkout subcommands, keep native _git for everything else
_git-checkout() { _git_simple }
_git-switch() { _git_simple }

# Register completions for git aliases (gsw, gco, gswup)
for git_alias in gsw gco gswup; do
  compdef _gswup $git_alias
done

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
  gbro='git branch --merged origin/master | grep -v master | xargs git branch -d' \
  glgb='glg master..$(git rev-parse --abbrev-ref HEAD)' \
  glgh='glgb' \
  gdw='gd --word-diff' \
  gdsw='gds --word-diff' \
  gai='ga --interactive'

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
# - Current gateway
alias gw='traceroute -m 3 google.com 2>/dev/null | tail -n 1 | cut -d " " -f 4'
alias gateway='gw'

# Running tmux on kitty startup
if [ -z "$TMUX" ] && [ "$TERM" = "xterm-kitty" ]; then
  tmux attach || exec tmux new-session && exit;
fi

# bun completions
[ -s "/Users/roman.charugin/.bun/_bun" ] && source "/Users/roman.charugin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# go
export PATH="/usr/local/go/bin:$PATH"