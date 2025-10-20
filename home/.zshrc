
# Uncomment to disable dotfiles git status warning
# export DOTFILES_NO_GIT_WARN=1

# load homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin:$HOME/.local/bin:$PATH"

# Source .zprofile to get environment variables in interactive shells (like VS Code terminals)
[ -f "$HOME/.zprofile" ] && source "$HOME/.zprofile"

# Load custom aliases early so we can use functions in startup checks
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

# warn if there are uncommitted changes in dotfiles repo or Brewfile issues (unless disabled)
if [[ -z "$DOTFILES_NO_GIT_WARN" ]]; then
  (cd "$DF_DIR" && {
    if _check_dotfiles_status false true true; then
      export _DOTFILES_RELOAD_WARN="$$"
    fi
  })
fi

# path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# enable advanced tab-completion in your Zsh
autoload -Uz compinit
compinit

# theme settings
# See: https://github.com/sindresorhus/pure
# See: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes 
ZSH_THEME="robbyrussell" # disable ohmyzsh theme to use homebrew installed pure prompt

# zsh history settings
HISTSIZE=10000 # number of history entries stored in memory
SAVEHIST=10000 # number of history entries stored in the history file
HISTFILE=~/.zsh_history # path to the history file
setopt INC_APPEND_HISTORY SHARE_HISTORY # immediately append to the history file and share history across sessions
setopt HIST_IGNORE_ALL_DUPS # ignore duplicate entries
setopt HIST_REDUCE_BLANKS # remove superfluous blanks

# omz update reminder
zstyle ':omz:update' mode 'auto'
zstyle ':omz:update' frequency '7' # check for updates every 7 days
zstyle ':omz:update' use-prompt 'true' # show update prompt in terminal
zstyle ':omz:update' auto 'true' # auto-update when running `omz update` 

# show waiting dots when completion is delayed
COMPLETION_WAITING_DOTS="true" 

# plugins to load (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
  git                     # Useful git aliases and functions
  zsh-autosuggestions     # Suggests commands as you type based on history
  zsh-syntax-highlighting # Highlights command syntax for better readability
  aliases                 # Loads extra useful aliases
  macos                   # macOS-specific helpers and shortcuts
  # docker                # Docker aliases and functions (uncomment when needed)
  # docker-compose        # Docker Compose aliases and functions (uncomment when needed)
  kubectl                 # kubectl aliases and functions (uncomment when needed)
  gh                      # GitHub CLI aliases and functions (uncomment when needed)
  nvm
)

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh 

# load fzf and fzf-tab only if not in VS Code terminal
if [[ "$TERM_PROGRAM" != "vscode" ]]; then
  # fzf settings
  if command -v fzf &>/dev/null; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    source /opt/homebrew/opt/fzf/shell/completion.zsh
    source <(fzf --zsh)
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
  fi

  # fzf-tab plugin
  source "$ZSH_CUSTOM/plugins/fzf-tab/fzf-tab.plugin.zsh"
  zstyle ':completion:*' fzf-preview 'cat {}'
  zstyle ':completion:*' menu select
  # echo "fzf-tab loaded: $ZSH_CUSTOM/plugins/fzf-tab"
fi

# pure prompt setup
# zstyle :prompt:pure:git:stash show yes
# autoload -U promptinit; promptinit 
# prompt pure 

# Enable shell integration for VS Code if running in VS Code terminal
# This allows VS Code to provide better terminal integration features.
# Note: This line is only necessary if you are using the VS Code terminal.
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
