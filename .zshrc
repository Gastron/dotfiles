#Local functions; eg. pure theme:
fpath=( "$HOME/.zfunctions" $fpath )

#completion
autoload -Uz compinit 
compinit

#menu style completion.
zstyle ':completion:*' menu select

#no duplicate commands in history
setopt HIST_IGNORE_DUPS

#find commands only matching upto cursor position.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

#Prompt theme:
autoload -U promptinit && promptinit
prompt pure


#remember visited directories and move to them with cdr, list with cdr -l
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
