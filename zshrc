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
plugins=(brew gem git osx rails rake ruby svn vi-mode)

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
