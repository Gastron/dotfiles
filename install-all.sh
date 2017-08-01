#!/bin/bash
#Ironically this is a bash script.
set -eu

dotfilespath=$(cd "$( dirname "$0" )" && pwd)
files_to_append='.zshrc .vimrc .tmux.conf'
for f in $files_to_append; do
  if [ -f $HOME/$f ]; then
    if grep -q "dotfiles/$f" "$HOME/$f"; then
      echo "Looks like dotfiles/$f is already being sourced in $HOME/$f"
    else
      echo "Appending 'source $dotfilespath/$f' to the end of $HOME/$f"
      echo "source $dotfilespath/$f" >> $HOME/$f
    fi
  else
    echo "Creating $HOME/$f, it will source $dotfilespath/$f"
    echo "source $dotfilespath/$f" > $HOME/$f
  fi
done
echo

if [ -e "$HOME/.zfunctions/prompt_pure_setup" ]; then
  echo "Looks like pure is already installed in $HOME/.zfunctions"
else
  puredir=$dotfilespath/pure
  echo "Installing pure zsh-prompt in $puredir, linking in $HOME/.zfunctions"
  git clone https://github.com/sindresorhus/pure $puredir
  mkdir -p $HOME/.zfunctions
  ln -s "$puredir/pure.zsh" "$HOME/.zfunctions/prompt_pure_setup"
  ln -s "$puredir/async.zsh" "$HOME/.zfunctions/async"
fi
echo

if [ -e $HOME/.vim/autoload/pathogen.vim ]; then
  echo "Looks like Pathogen is already installed in $HOME/.zfunctions"
else
  echo "Installing Pathogen for Vim in $HOME/.vim/bundle"
  mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle && \
  curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi
echo

if [ -e $HOME/.vim/bundle/vim-airline ]; then
  echo "Looks like vim-airline is installed already"
else
  echo "Installing vim-airline"
  git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
fi
echo
if [ -e $HOME/.vim/bundle/vim-airline-themes ]; then
  echo "Looks like vim-airline-themes is installed already"
else
  echo "Installing vim-airline-themes"
  git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes 
fi
echo

powerlinedir="$dotfilespath/powerlinefonts"
if [ -e "$powerlinedir" ]; then
  echo "Looks like powerlinefonts have already been downloaded in $powerlinedir"
else
  echo "Installing Powerline-patched Meslo with:"
  git clone https://github.com/powerline/fonts "$powerlinedir"
  "$powerlinedir"/install.sh 'Meslo Slashed'
  echo "You have to set Meslo LG S for Powerline Bold 10pt as the font of your terminal emulator."
fi

