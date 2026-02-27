# ------------------------------------------------------------------------------
# Initialize Completions FIRST
# ------------------------------------------------------------------------------
autoload -Uz compinit && compinit

# ------------------------------------------------------------------------------
# Plugin Manager: Antidote
# ------------------------------------------------------------------------------
[[ -e ~/.antidote ]] || git clone https://github.com/mattmc3/antidote.git ~/.antidote
source ~/.antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

eval "$(/opt/homebrew/bin/brew shellenv)"

# ------------------------------------------------------------------------------
# Shell Options
# ------------------------------------------------------------------------------
set -o vi  # enable vi-style keybindings

setopt NO_BG_NICE NO_HUP NO_BEEP LOCAL_OPTIONS LOCAL_TRAPS SHARE_HISTORY
setopt EXTENDED_HISTORY PROMPT_SUBST CORRECT COMPLETE_IN_WORD
setopt APPEND_HISTORY INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_VERIFY HIST_EXPIRE_DUPS_FIRST
setopt RM_STAR_SILENT

# ------------------------------------------------------------------------------
# Environment Variables
# ------------------------------------------------------------------------------
export EDITOR='nvim'
export VEDITOR='cursor'
export GPG_TTY=$(tty)
export PURE_CMD_MAX_EXEC_TIME=1
export LSCOLORS='exfxcxdxbxegedabagacad'
export CLICOLOR=true
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# ------------------------------------------------------------------------------
# PATH Setup
# ------------------------------------------------------------------------------
export PATH="/opt/homebrew/opt/postgresql@16/bin:/opt/homebrew/opt/postgresql@15/bin:/opt/homebrew/opt/openssl@3/bin:/opt/homebrew/opt/libpq/bin:$HOME/.bun/bin:$HOME/.asdf/shims:$HOME/.fly/bin:$HOME/.local/bin:$HOME/.yarn/bin:$HOME/bin:/usr/local/sbin:/usr/sbin:/usr/local/bin:/usr/bin:/bin:/sbin:$PATH"

# Make sure Homebrew binaries are definitely in PATH
export PATH="/opt/homebrew/bin:$PATH"

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------
[[ -f "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"

# ------------------------------------------------------------------------------
# Key Bindings
# ------------------------------------------------------------------------------
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# ------------------------------------------------------------------------------
# FZF Setup
# ------------------------------------------------------------------------------
if [[ -d /usr/local/opt/fzf/shell ]]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
else
  bindkey '^R' history-incremental-search-backward
fi

# ------------------------------------------------------------------------------
# Starship Prompt
# ------------------------------------------------------------------------------
if [[ -o interactive ]]; then
  eval "$(starship init zsh)"
fi

# ------------------------------------------------------------------------------
# Python / C Flags (for libraries needing SSL, etc.)
# ------------------------------------------------------------------------------
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"
export GDAL_LIBRARY_PATH='/opt/homebrew/opt/gdal/lib/libgdal.dylib'
export GEOS_LIBRARY_PATH='/opt/homebrew/opt/geos/lib/libgeos_c.dylib'

# ------------------------------------------------------------------------------
# Fly.io
# ------------------------------------------------------------------------------
export FLYCTL_INSTALL="$HOME/.fly"

# ------------------------------------------------------------------------------
# NVM
# ------------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]] && source "/opt/homebrew/opt/nvm/nvm.sh"

# ------------------------------------------------------------------------------
# Erlang
# ------------------------------------------------------------------------------
export ERL_AFLAGS="-kernel shell_history enabled"

# ------------------------------------------------------------------------------
# Atuin (shell history replacement)
# ------------------------------------------------------------------------------
if [[ -o interactive ]]; then
  eval "$(atuin init zsh)"
fi

# ------------------------------------------------------------------------------
# Bun
# ------------------------------------------------------------------------------
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# ------------------------------------------------------------------------------
# Zoxide
# ------------------------------------------------------------------------------
if [[ -o interactive ]]; then
  eval "$(zoxide init zsh)"
fi

# ------------------------------------------------------------------------------
# PNPM
# ------------------------------------------------------------------------------
export PNPM_HOME="$HOME/Library/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

# ------------------------------------------------------------------------------
# Deno
# ------------------------------------------------------------------------------
[[ -s "$HOME/.deno/env" ]] && source "$HOME/.deno/env"

# ------------------------------------------------------------------------------
# Pyenv
# ------------------------------------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ------------------------------------------------------------------------------
# Deno Completions
# ------------------------------------------------------------------------------
fpath=("$HOME/.zsh/completions" $fpath)

# ------------------------------------------------------------------------------
# Cargo
# ------------------------------------------------------------------------------
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# ------------------------------------------------------------------------------
# ASDF
# ------------------------------------------------------------------------------
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# ------------------------------------------------------------------------------
# Gdal
# ------------------------------------------------------------------------------
export PATH=/Library/Frameworks/GDAL.framework/Programs:$PATH

# ------------------------------------------------------------------------------
# pnpm
# ------------------------------------------------------------------------------
export PNPM_HOME="/Users/rohan/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ------------------------------------------------------------------------------
# bun completions
# ------------------------------------------------------------------------------
[ -s "/Users/rohan/.bun/_bun" ] && source "/Users/rohan/.bun/_bun"

# ------------------------------------------------------------------------------
# Flutter
# ------------------------------------------------------------------------------
export PATH=$HOME/Developer/flutter/bin:$PATH

# ------------------------------------------------------------------------------
# UV (only in interactive shells to avoid compdef errors)
# ------------------------------------------------------------------------------
if [[ -o interactive ]]; then
  eval "$(uv generate-shell-completion zsh)"
fi

# ------------------------------------------------------------------------------
# direnv
# ------------------------------------------------------------------------------
if [[ -o interactive ]]; then
  eval "$(direnv hook zsh)"
fi

# ------------------------------------------------------------------------------
# Additional PATH entries
# ------------------------------------------------------------------------------
export PATH="/opt/homebrew/sbin:$PATH"

# Added by Antigravity
export PATH="/Users/rohan/.antigravity/antigravity/bin:$PATH"

# opencode
export PATH=/Users/rohan/.opencode/bin:$PATH

unalias br 2>/dev/null  # br installer - remove conflicting alias

# Entire CLI shell completion
autoload -Uz compinit && compinit && source <(entire completion zsh)

# sup - GitHub PR picker
sup() {
  rm -f /tmp/sup-selection
  command sup "$@"
  if [[ -f /tmp/sup-selection ]]; then
    cd "$(cat /tmp/sup-selection)"
    rm -f /tmp/sup-selection
  fi
}
