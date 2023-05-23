#!/bin/sh

### EXPORT ###
export TERM="xterm-256color"                      # getting proper colors
export EDITOR="vim"			          # $EDITOR use vim in terminal
export VISUAL="notepadqq"		          # $VISUAL use notepadqq in GUI mode

# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Config dir
export ZDOTDIR=$HOME/.config/zsh

# Default FZF command using rg
# sudo apt install ripgrep
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob \"!{.git,node_modules}/**\""



### SET VI MODE ###
# Comment this line out to enable default emacs-like bindings
bindkey -v



### BINDKEYS ###
bindkey  "^[[H"   beginning-of-line		# Goto begginning of line with HOME
bindkey  "^[[F"   end-of-line			# Goto end of line with END
bindkey  "^[[3~"  delete-char			# Delete char with DELETE

 

### PATH ###
if [ -d "$HOME/.bin" ] ;
   then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
   then PATH="$HOME/.local/bin:$PATH"
fi



### ZSH history and config ###
HISTFILE=~/.zsh_history
HISTSIZE=10000
HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
SAVEHIST=1000
setopt INC_APPEND_HISTORY_TIME
setopt INTERACTIVE_COMMENTS

autoload -Uz colors && colors

source "$ZDOTDIR/zsh-functions"



### PLUGINS ###
zsh_add_plugin "zsh-users/zsh-completions"
zsh_add_plugin "Tarrasch/zsh-bd"
zsh_add_file "plugins/zsh-bd/bd.zsh" # bd need to be explicitly loaded due to difference in plugin name and git repo name
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "unixorn/fzf-zsh-plugin"
export FZF_PREVIEW_WINDOW="right:65%:nohidden"
#export PATH="$HOME/.config/zsh/plugins/fzf-zsh-plugin/bin":$PATH



### COMPLETIONS ###
zsh_add_file "zsh-completion"



### PROMPT ###
zsh_add_file "zsh-prompt"



### ALIASES ###
#zsh_add_file "zsh-aliases"   # not needed for just a few aliases
# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Colorize and classify ls
alias ls='ls --color=auto --classify'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
   
# easier to read disk 
alias df='df -h'     # human-readable sizes 
alias free='free -m' # show sizes in MB

# dotfiles repository
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
compdef config='git'

# python
alias python='python3'

# nvim
alias vim='nvim'

# Use exa if available, colorize and classify
if [[ -x "$(command -v exa)" ]]; then
    alias ls='exa --color=auto --classify --group-directories-first'
    compdef _exa ls
else
    alias ls='ls --color=auto --classify'
fi



### PTC Integrity ###
export PATH="/opt/Integrity/ILMClient11/bin:$PATH"

### COMMENTED OUT, BUT LEFT FOR REFERENCE ###
#ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=yellow
#ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
#ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]=default
#ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
#ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]=default


# nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#depot_tools
export PATH="$HOME/repos/tools/depot_tools:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
