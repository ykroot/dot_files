#!/bin/zsh
# Enable Powerlevel10k instant prompt (makes terminal open faster)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Powerlevel10k config (if it exists)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ===== YOUR CUSTOM ALIASES =====
alias cw="cc -Wall -Wextra -Werror"
alias c="clear"
alias nv="nvim"
#alias obsidian="~/Local_app/obsidian/AppRun &>/dev/null &"

# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias less='less -R'

# OS-specific aliases
OS="$(uname)"
if [[ "$OS" == "Linux" ]]; then
    alias bat='batcat --theme base16 -p'
    alias ls='ls -h --color=auto'
    alias la='ls -lah --color=auto'
fi
alias void="~/Music/Void/void.py"
# ===== EXPORTS =====
export TERM="xterm-256color"
export LANGUAGE="C.UTF-8"
export LANG="C.UTF-8"
export LC_ALL="C.UTF-8"
export LC_CTYPE="C.UTF-8"
export LC_MESSAGES="C.UTF-8"
export PATH="$HOME/.local/bin:$PATH"

# ===== LOAD ZSH PLUGINS (from ~/.zsh) =====
# Load Powerlevel10k theme
source $HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme

# Load gh-zsh helper files
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/.zsh/history.zsh
source $HOME/.zsh/key-bindings.zsh
bin!() {
    dpkg-deb -c $1 | grep bin/        
}
export PATH="$HOME/bin:$PATH"
