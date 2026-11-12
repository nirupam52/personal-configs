#!/usr/bin/env zsh
# =========================================================================
# ZSH CONFIGURATION WITH OH MY ZSH
# =========================================================================

# Keep PATH entries unique (brew shellenv in .zprofile and below both prepend)
typeset -U path PATH

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- we use starship so disable this
ZSH_THEME=""

# Which plugins would you like to load?
plugins=(
    git
    zsh-autosuggestions
    docker
    golang
    z
    colored-man-pages
    command-not-found
    zsh-syntax-highlighting  # must be last
)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh


# -------------------------------------------------------------------------
# ZSH OPTIONS
# -------------------------------------------------------------------------
# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Directory navigation
setopt PUSHD_SILENT

# Completion
setopt LIST_PACKED

# Other useful options
setopt CORRECT
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP

# -------------------------------------------------------------------------
# COMPLETION SYSTEM
# -------------------------------------------------------------------------
# compinit is already run by oh-my-zsh

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Colorful completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# -------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# -------------------------------------------------------------------------
# Helper function to add to PATH only if directory exists
add_to_path() {
    [[ -d "$1" ]] && export PATH="$1:$PATH"
}

# Add ~/.local/bin to PATH for various tools
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.bun/bin"

# Homebrew (Apple Silicon or Intel)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi


# Homebrew
export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1

# Editor
export EDITOR="zed -w"
export VISUAL="$EDITOR"

# -------------------------------------------------------------------------
# CUSTOM FUNCTIONS
# -------------------------------------------------------------------------

# Make directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}


# -------------------------------------------------------------------------
# LOAD ALIASES
# -------------------------------------------------------------------------
# Source bash aliases (they're compatible with zsh)
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
alias btop='nocorrect btop'

# -------------------------------------------------------------------------
# STARSHIP PROMPT
# -------------------------------------------------------------------------
# Initialize Starship
eval "$(starship init zsh)"

# -------------------------------------------------------------------------
# ADDITIONAL TOOLS
# -------------------------------------------------------------------------
# Enable better directory colors (macOS version)
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# mise (node, go, java, bun, uv, npm)
eval "$(mise activate zsh)"

# Load any local zsh configuration (last, so it can override anything above)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
