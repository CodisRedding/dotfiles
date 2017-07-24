# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if pip is already installed.
[[ "$(type -P pip)" ]] && e_header "Pip is already installed." && return 1

sudo easy_install pip
