
# Environment variables below are set here so they are available in all login shells (not just interactive ones).
# This ensures tools and system-wide settings are always available, even for GUI apps or remote sessions.
# Aliases and interactive settings should remain in .zshrc.

export KUBECONFIG=~/code/jenkins-config.cfg
export MSBuildSDKsPath=/opt/homebrew/Cellar/mono/6.14.1/lib/mono/msbuild
export MONO_GAC_PREFIX="/opt/homebrew"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"
export MSBuildEnableWorkloadResolver=false
export MSBuildSDKsPath="/usr/local/share/dotnet/sdk/$(dotnet --version)/Sdks"
export PATH="$PATH:/Users/rocky.assad/.dotnet/tools"
