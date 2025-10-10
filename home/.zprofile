
# Environment variables below are set here so they are available in all login shells (not just interactive ones).
# This ensures tools and system-wide settings are always available, even for GUI apps or remote sessions.
# Aliases and interactive settings should remain in .zshrc.

export EDITOR="vim" # Set default editor to Vim
export KUBECONFIG=~/code/jenkins-config.cfg # Set KUBECONFIG path for Kubernetes configuration
# needed to build or run a .NET Framework (not .NET Core/5+/6+) project on macOS.
export MONO_GAC_PREFIX="/opt/homebrew" # Set Mono GAC prefix for Homebrew installation
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH" # Add OpenJDK 17 to PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" # Add Krew (kubectl plugin manager) to PATH
export JAVA_HOME="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home" # Set JAVA_HOME for OpenJDK 17
# The MSBuildEnableWorkloadResolver environment variable controls whether MSBuild tries to automatically resolve and install missing .NET workloads
export MSBuildEnableWorkloadResolver=false # Disable automatic workload installation
export PATH="$PATH:/Users/rocky.assad/.dotnet/tools" # Add .NET tools to PATH
# Added by GitLab Knowledge Graph installer
export PATH="$HOME/.local/bin:$PATH"
