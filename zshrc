# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi


# Disable the update prompt
DISABLE_UPDATE_PROMPT="true"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(adb ant brew bundler gem git github mix osx rails rake rbenv ruby svn tmux vi-mode)

# Custom Local Config
if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi

source $ZSH/oh-my-zsh.sh

# Re-inject search
bindkey '^R' history-incremental-search-backward

# Fix sbin on Mac
export PATH="/sbin:/usr/sbin:$PATH"

# Homebrew
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# rbenv
if [[ -d "$HOME/.rbenv/bin" ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
fi

command -v rbenv >/dev/null 2>&1

if [ $? -eq 0 ]; then
  eval "$(rbenv init -)"
fi

# swiftenv
if [[ -d "$HOME/.swiftenv" ]]; then
  export SWIFTENV_ROOT="$HOME/.swiftenv"
  export PATH="$SWIFTENV_ROOT/bin:$PATH"
fi

command -v swiftenv >/dev/null 2>&1

if [ $? -eq 0 ]; then
  eval "$(swiftenv init -)"
fi

# jenv
if [[ -d "$HOME/.jenv/bin" ]]; then
  export PATH="$HOME/.jenv/bin:$PATH"
fi

command -v jenv >/dev/null 2>&1

if [ $? -eq 0 ]; then
  eval "$(jenv init -)"
fi

# binfiles
if [[ -d "$HOME/Development/Support/binfiles" ]]; then
  export PATH="$HOME/Development/Support/binfiles:$PATH"
fi

# Android SDK & NDK
if [[ -d "/usr/local/android-sdk" ]]; then
  export ANDROID_SDK_ROOT="/usr/local/android-sdk"
  export PATH="$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH"
fi

if [[ -d "/usr/local/android-ndk" ]]; then
  export ANDROID_NDK_ROOT="/usr/local/android-ndk"
  export PATH="$ANDROID_NDK_ROOT:$PATH"
fi

# NaCL SDK
if [[ -d "/usr/local/nacl_sdk/pepper_35" ]]; then
  export NACL_SDK_ROOT="/usr/local/nacl_sdk/pepper_35"
elif [[ -d "/opt/nacl_sdk/pepper_35" ]]; then
  export NACL_SDK_ROOT="/opt/nacl_sdk/pepper_35"
fi

# Depot Tools
if [[ -d "/usr/local/depot_tools" ]]; then
  export PATH="$PATH:/usr/local/depot_tools"
elif [[ -d "/opt/depot_tools" ]]; then
  export PATH="$PATH:/opt/depot_tools"
fi

# Personal bin for Mac OS X
if [[ -d "$HOME/Library/bin" ]]; then
  export PATH="$PATH:$HOME/Library/bin"
fi

# Editor
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
  platform='macosx'
elif [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
fi

if [[ $platform == 'macosx' ]]; then
  export EDITOR="mvim -f"
elif [[ $platform == 'linux' ]]; then
  export EDITOR="gvim -f"
else
  export EDITOR="vi"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The Fuck!?
THEFUCK=`command -v thefuck`
if [ "$?" -eq "0" ]; then
  eval "$(thefuck --alias)"
fi

