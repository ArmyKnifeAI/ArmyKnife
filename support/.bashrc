# Bash Template for Linux 
# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Path to your oh-my-bash installation.
export OSH="$HOME/.oh-my-bash"
export VAULT_ADDR='http://127.0.0.1:8200'
export PATH="~/anaconda3/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export CONDA_AUTO_ACTIVATE_BASE=false

# VAULT_TOKEN should be set securely or exported securely before this script runs

# Main Bash Library
if [ -f "$HOME/bashlib/lib/main.sh" ]; then
  source "$HOME/bashlib/lib/main.sh"
else
  echo "Main library file not found, please check the path."
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="font"

# Uncomment the following lines to use specific features.
# OMB_CASE_SENSITIVE="true"
# OMB_HYPHEN_SENSITIVE="false"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_OSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# SCM_GIT_DISABLE_UNTRACKED_DIRTY="true"
# SCM_GIT_IGNORE_UNTRACKED="true"
# HIST_STAMPS='yyyy-mm-dd'
# OMB_DEFAULT_ALIASES="check"
# OMB_USE_SUDO=true
# OMB_PROMPT_SHOW_PYTHON_VENV=true

# Completions, aliases, and plugins configuration
completions=(git composer ssh)
aliases=(general)
plugins=(git bashmarks)

# Source oh-my-bash
source "$OSH"/oh-my-bash.sh

# User-specific configurations
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

export ARCHFLAGS="-arch x86_64"
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

# Check if Brew is installed
if ! command -v brew &>/dev/null; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
   eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Check if Go is installed
if ! command -v go &>/dev/null; then
    export PATH="/usr/local/opt/go/bin:$PATH"
    export GOPATH=$HOME/go
    export GOBIN=$GOPATH/bin
    export GOROOT="$(brew --prefix golang)/libexec"
    export PATH=$PATH:$GOPATH/bin
    export PATH=$PATH:$GOROOT/bin
    export PATH=$PATH:/usr/local/opt/go/bin
else
    export PATH="/usr/local/opt/go/bin:$PATH"
    export GOPATH=$HOME/go
    export GOBIN=$GOPATH/bin
    export GOROOT="$(brew --prefix golang)/libexec"
    export PATH=$PATH:$GOPATH/bin
    export PATH=$PATH:$GOROOT/bin
    export PATH=$PATH:/usr/local/opt/go/bin
fi

# Check if Rust and Cargo are installed
if ! command -v rustc &>/dev/null || ! command -v cargo &>/dev/null; then
    export PATH="/usr/local/opt/rust/bin:$PATH"
    # Typically, the cargo bin directory is added to PATH
    export PATH="$HOME/.cargo/bin:$PATH"
else
    export PATH="/usr/local/opt/rust/bin:$PATH"
    # Typically, the cargo bin directory is added to PATH
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

