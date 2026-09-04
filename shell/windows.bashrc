
# ── Completion & readline ──────────────────────────────────────────────────────
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set mark-symlinked-directories on'

# ── Aliases ────────────────────────────────────────────────────────────────────
alias ..='cd ..'
alias ll='ls -lhF --color=auto --group-directories-first'
alias la='ls -lAhF --color=auto --group-directories-first'
alias cls='clear'
alias reload='source ~/.bashrc'

# Git
alias gpuh='git push -u origin HEAD'
alias gfb='git fetch origin $BRANCH && git checkout $BRANCH'

# ── Functions ──────────────────────────────────────────────────────────────────
cdl()   { cd "$1" && ll; }
mkd()   { mkdir -p "$1" && cd "$1"; }
h()     { eval "$(history | awk '{$1=""; print $0}' | sort -u | fzf)"; }
exp()   { explorer.exe "$(cygpath -w "${1:-.}")"; }
c()     { code "${1:-.}"; }
serve() { python -m http.server "${1:-8000}"; }
projects()  { cd ~/Desktop/projects; }

# ── Path ──────────────────────────────────────────────────────────────────────
pathadd() { [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"; }
pathadd "$HOME/.opencode/bin"
pathadd "$HOME/.bun/bin"
# pathadd "/c/your/custom/bin"   # ← add more paths here

# ── History ───────────────────────────────────────────────────────────────────
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend cmdhist

# ── Core env ──────────────────────────────────────────────────────────────────
export EDITOR='code --wait'
export VISUAL="$EDITOR"
export PAGER='less -R'
export LESS='-RFX'

# ── Security ──────────────────────────────────────────────────────────────────
ulimit -c 0
umask 022

# ── Tooling env ───────────────────────────────────────────────────────────────
. "$HOME/.local/bin/env"

# ── Starship ───────────────────────────────────────────────────────────────
eval "$(starship init bash)"