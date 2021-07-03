# Install antigen:
#   cd ~ && mkdir .zsh && curl -L git.io/antigen > ~/.zsh/antigen.zsh

setopt appendhistory beep extendedglob nomatch notify
unsetopt autocd
bindkey -v
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

# basics
export PATH="$HOME/.pyenv/bin:/usr/local/sbin:/usr/local/bin:/$HOME/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"

# random options
export TERM="xterm-256color"
export HOMEBREW_NO_AUTO_UPDATE=1
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"

# pyenv
if  command -v pyenv &> /dev/null
then
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
fi

# history settings
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
HIST_STAMPS="yyyy-mm-dd"

# arrow keys search through history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# antigen
source "$HOME/.zsh/antigen.zsh"
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle Aloxaf/fzf-tab
antigen bundle supercrabtree/k
#antigen theme jackharrisonsherlock/common
antigen bundle Joroovb/common
antigen apply

# aliases
alias c='clear'
alias cdc='cd ~ && clear'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

## nvim
if  command -v nvim &> /dev/null
then
    alias vim='nvim'
fi

## exa
if  command -v exa &> /dev/null
then
    alias ls='exa --icons --sort=type'
    alias l='exa --sort=type --long --header --git --time-style=long-iso --links --icons'
    alias ll='l'
else
    alias ls='ls -G'
fi
