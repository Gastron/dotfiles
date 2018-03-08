#!/bin/bash
#Installs the powerline extended font that I like.

powerlinedir="$dotfilespath/powerlinefonts"
if [ -e "$powerlinedir" ]; then
  echo "Looks like powerlinefonts have already been downloaded in $powerlinedir"
else
  echo "Installing Powerline-patched Meslo with:"
  git clone https://github.com/powerline/fonts "$powerlinedir"
  "$powerlinedir"/install.sh 'Meslo Slashed'
  echo "You have to set Meslo LG S for Powerline Bold 10pt as the font of your terminal emulator."
fi
