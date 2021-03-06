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

#Vim mode:
bindkey -v
export KEYTIMEOUT=1
bindkey -r viins "^J" "^K" "^L"
bindkey "^J" down-line-or-beginning-search
bindkey "^K" up-line-or-beginning-search
bindkey "^L" expand-or-complete

#Start of line, end of line:
bindkey "^G" beginning-of-line
bindkey "^B" end-of-line

#CTRL+space for accept line
bindkey "^ " accept-line

#cd into dirs if you just type them, but importantly autocomplete the directories:
setopt autocd

#Edit cmdline in $EDITOR, set EDITOR to vim:
export EDITOR=vim
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^V" edit-command-line 
