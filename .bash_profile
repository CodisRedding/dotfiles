export KUBECONFIG=~/code/jenkins-config.cfg

eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

## Aliases
alias ip='ipconfig getifaddr en0'

## SSH Aliases
alias ssh-bitbucket="ssh bitbucket.org"
alias ssh-github="ssh github.com"
alias ssh-jenkins="ssh jenkins.premisehealth.com"
alias ssh-extract-api-dev="ssh d-ap-l-extract-02.premisehealth.com"
alias ssh-extract-api-qa="ssh q-ap-l-extract-01.premisehealth.com"
# alias ssh-extract-api-prod="ssh p-ap-l-extract-02.premisehealth.com"
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

## Git aliases
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gac='git add -A && git commit -m'
# Ignore changes to (ex.) appsettings.Local.json
alias assume-unchanged='git update-index --assume-unchanged'
# To start tracking changes again
alias assume-changed='git update-index --no-assume-unchanged'