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

# Homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Oh My ZSH
source $ZSH/oh-my-zsh.sh

# Re-inject search
bindkey '^R' history-incremental-search-backward

# Fix sbin on Mac
export PATH="/sbin:/usr/sbin:$PATH"

# MacVim
if [[ -d "/Applications/MacVim.app/Contents/bin" ]]; then
  export PATH="/Applications/MacVim.app/Contents/bin:$PATH"
fi

# rbenv
if [[ -d "$HOME/.rbenv/bin" ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
fi

command -v rbenv >/dev/null 2>&1

if [ $? -eq 0 ]; then
  eval "$(rbenv init -)"
fi

# binfiles
if [[ -d "$HOME/Development/Support/binfiles" ]]; then
  export PATH="$HOME/Development/Support/binfiles:$PATH"
fi

# Android SDK & NDK
if [[ -d "$HOME/Library/Android/sdk" ]]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
  export PATH="$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH"
fi

if [[ -d "$HOME/Library/Android/sdk/ndk-bundle" ]]; then
  export ANDROID_NDK_ROOT="$HOME/Library/Android/sdk/ndk-bundle"
  export PATH="$ANDROID_NDK_ROOT:$PATH"
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
  export EDITOR='mvim -f --nomru -c "au VimLeave * !open -a Terminal"'
elif [[ $platform == 'linux' ]]; then
  export EDITOR="gvim -f"
else
  export EDITOR="vi"
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Rust, Cargo, etc.
[ -f ~/.cargo/env ] && source ~/.cargo/env

# NVM
export NVM_DIR="$HOME/.nvm"

if [[ -d "/usr/local/opt/nvm" ]]; then
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && source "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && source "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi

# EMSDK
# [ -f ~/Development/Support/emsdk/emsdk_env.sh ] && source ~/Development/Support/emsdk/emsdk_env.sh

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
