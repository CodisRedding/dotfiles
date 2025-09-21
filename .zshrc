# Uncomment to disable dotfiles git status warning
# export DOTFILES_NO_GIT_WARN=1

# Warn if there are uncommitted changes in dotfiles repo (unless disabled)
if [[ -d "$HOME/dotfiles/.git" && -z "$DOTFILES_NO_GIT_WARN" ]]; then
  if git -C "$HOME/dotfiles" status --porcelain | grep -q .; then
    echo "%F{yellow}⚠️  You have uncommitted changes in your ~/dotfiles repo!%f"
    echo "Run 'cd ~/dotfiles && git status' to review. Set DOTFILES_NO_GIT_WARN=1 to disable this message."
  fi
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# --- prompt Performance ---
zstyle ':completion:*' rehash true

# path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# enable advanced tab-completion in your Zsh
autoload -Uz compinit
compinit

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="clean"
ZSH_THEME="" # disable ohmyzsh theme to use homebrew insalled pure prompt

# zsh history settings
HISTSIZE=10000 # number of history entries stored in memory
SAVEHIST=10000 # number of history entries stored in the history file
HISTFILE=~/.zsh_history # path to the history file
setopt INC_APPEND_HISTORY SHARE_HISTORY # immediately append to the history file and share history across sessions
setopt HIST_IGNORE_ALL_DUPS # ignore duplicate entries
setopt HIST_REDUCE_BLANKS # remove superfluous blanks

# just remind me to update when it's time
zstyle ':omz:update' mode reminder 

# show waiting dots when completion is delayed
COMPLETION_WAITING_DOTS="true" 

# plugins to load (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-github-copilot docker docker-compose aliases kubectl macos)
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
zstyle :prompt:pure:git:stash show yes
autoload -U promptinit; promptinit 
prompt pure 

# nvm setup
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

## aliases
alias ip='ipconfig getifaddr en0' # get local IP address

## copilot aliases
# Alias to show directory info, git status, and git directories
alias info='echo "Current directory: $(pwd)"; echo; if git rev-parse --is-inside-work-tree &>/dev/null; then echo "This directory is a git repository."; else echo "This directory is NOT a git repository."; fi; echo; echo "Other .git directories under this tree:"; find . -type d -name .git | tee >(echo "Total: $(wc -l | awk "{print \$1}")")'

## ssh aliases
alias ssh-bitbucket="ssh bitbucket.org"
alias ssh-github="ssh github.com"
alias ssh-jenkins="ssh jenkins.premisehealth.com"
alias ssh-extract-api-dev="ssh d-ap-l-extract-02.premisehealth.com"
alias ssh-extract-api-qa="ssh q-ap-l-extract-01.premisehealth.com"
alias ssh-extract-api-prod="ssh p-ap-l-extract-02.premisehealth.com"
alias ssh-extract-db-dev="ssh d-db-tal-01.premisehealth.com"
alias ssh-extract-db-qa="ssh q-db-tal-01.premisehealth.com"
alias ssh-extract-db-prod="ssh p-db-tal-01.premisehealth.com"
alias ssh-paid-web-uat="ssh c-ap-l-paid-01.premisehealth.com"
alias ssh-paid-web-prod="ssh p-ap-l-paid-01.premisehealth.com"
alias ssh-paid-api-uat="ssh c-ap-l-paid-01.premisehealth.com"
alias ssh-paid-api-prod="ssh p-ap-l-paid-01.premisehealth.com"
alias ssh-paid-db-dev="ssh d-db-ph-02.dev-prem-health.com"
alias ssh-paid-db-qa="ssh q-db-ph-02.qua-prem-health.com"
alias ssh-paid-db-uat="ssh c-db-ph-02.premisehealth.com"
alias ssh-paid-db-prod="ssh p-db-ph-02.premisehealth.com"
alias ssh-peap-web-uat="ssh c-wb-l-peap-01.premisehealth.com"
alias ssh-peap-web-prod="ssh p-wb-l-peap-01.premisehealth.com"
alias ssh-peap-api-uat="ssh c-ap-l-peap-01.premisehealth.com"
alias ssh-peap-api-prod="ssh p-ap-l-peap-01.premisehealth.com"
alias ssh-peap-db-dev="ssh d-db-ph-02.dev-prem-health.com"
alias ssh-peap-db-qa="ssh q-db-ph-02.qua-prem-health.com"
alias ssh-peap-db-uat="ssh c-db-ph-02.premisehealth.com"
alias ssh-peap-db-prod="ssh p-db-ph-02.premisehealth.com"
alias ssh-pma-web-uat="ssh c-wb-l-pma-01.premisehealth.com"
alias ssh-pma-web-prod="ssh p-wb-l-pma-01.premisehealth.com"
alias ssh-pma-api-uat="ssh c-ap-l-pma-01.premisehealth.com"
alias ssh-pma-api-prod="ssh p-ap-l-pma-01.premisehealth.com"
alias ssh-pma-db-dev="ssh d-db-ph-02.dev-prem-health.com"
alias ssh-pma-db-qa="ssh q-db-ph-02.qua-prem-health.com"
alias ssh-pma-db-uat="ssh c-db-ph-02.premisehealth.com"
alias ssh-pma-db-prod="ssh p-db-wrhouse-01.premisehealth.com"
alias ssh-ssoproxy-admin-web-uat="ssh c-wb-l-ohmsso-01.premisehealth.com"
alias ssh-ssoproxy-admin-web-prod="ssh p-wb-l-ohmsso-01.premisehealth.com"
alias ssh-ssoproxy-admin-api-uat="ssh c-wb-l-ohmsso-01.premisehealth.com"
alias ssh-ssoproxy-admin-api-prod="ssh p-wb-l-ohmsso-01.premisehealth.com"
alias ssh-ssoproxy-admin-db-dev="ssh d-db-ph-02.dev-prem-health.com"
alias ssh-ssoproxy-admin-db-qa="ssh q-db-ph-02.qua-prem-health.com"
alias ssh-ssoproxy-admin-db-uat="ssh c-db-ph-02.premisehealth.com"
alias ssh-ssoproxy-admin-db-prod="ssh p-db-ph-02.premisehealth.com"
alias ssh-ssoproxy-api-uat="ssh c-wb-l-ohmsso-01.premisehealth.com"
alias ssh-ssoproxy-api-prod="ssh p-wb-l-ohmsso-01.premisehealth.com"
alias ssh-ssoproxy-api-dev-db="ssh d-db-ph-02.dev-prem-health.com"
alias ssh-ssoproxy-api-qa-db="ssh q-db-ph-02.qua-prem-health.com"
alias ssh-ssoproxy-api-uat-db="ssh c-db-ph-02.premisehealth.com"
alias ssh-ssoproxy-api-prod-db="ssh p-db-ph-02.premisehealth.com"

## git aliases
alias groot='cd $(git rev-parse --show-toplevel 2>/dev/null || echo .)' # go to git root
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative" # pretty git log
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r' # colorized git diff in less
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gfa='git fetch --all'
alias assume-unchanged='git update-index --assume-unchanged' # use this to ignore local changes to a file
alias assume-changed='git update-index --no-assume-unchanged' # use this to start tracking changes again
alias uncommitted='git diff --name-only' # list uncommitted files
alias last='git log -1 HEAD' # show last commit
alias amend='git commit --amend --no-edit' # quickly amend last commit without changing the message
alias lg='lazygit' # launch lazygit

# termninal recording
alias record='asciinema rec -c "zsh" ~/code/asciinema/$(date +%Y-%m-%d_%H-%M-%S).cast' # record terminal session to a file in ~/code/asciinema
alias play='asciinema play' # play a recorded terminal session
alias listrecords='ls ~/code/asciinema' # list recorded terminal sessions
# Press Ctrl+D (or type exit and press Enter) in the terminal where you started the recording.
alias stoprecord='exit"' # stop recording terminal session

# kap
alias kap='open -a Kap' # open kap app

# generate a new GUID and copy it to the clipboard
alias copyApiKey='file=$(find . -name "appsettings.Local.json" -not -path "*/bin/*" -not -path "*/obj/*" -print -quit) && jq -r ".ApiKey" "$file" | tr -d "\n" | tee >(pbcopy) && echo "API key copied to clipboard from $file."'

source <(ng completion script) # enable angular cli tab completion
fpath=(/Users/rocky.assad/.docker/completions $fpath) # enable docker cli tab completion

eval "$(gh copilot alias -- zsh)" # enable github copilot cli
eval "$(gh completion -s zsh)" # enable github cli tab completion

# zsh-github-copilot key bindings
bindkey '»' zsh_gh_copilot_explain  # bind Option+shift+\ to explain
bindkey '«' zsh_gh_copilot_suggest  # bind Option+\ to suggest

export KUBECONFIG=~/code/jenkins-config.cfg
export MSBuildSDKsPath=/opt/homebrew/Cellar/mono/6.14.1/lib/mono/msbuild
export MONO_GAC_PREFIX="/opt/homebrew"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"
export MSBuildEnableWorkloadResolver=false
export MSBuildSDKsPath="/usr/local/share/dotnet/sdk/$(dotnet --version)/Sdks"

# Enable shell integration for VS Code if running in VS Code terminal
# This allows VS Code to provide better terminal integration features.
# Note: This line is only necessary if you are using the VS Code terminal.
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"