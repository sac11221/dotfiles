#!/bin/sh

directories=(".icewm" ".vimrc" ".wezterm.lua" ".config/rofi")
newdir="."
olddir="old_dotfiles$(date +_%y%m%d_%H%M%S)"

mkdir $olddir

for i in ${directories[@]}
do
	mv $HOME/$i $olddir
	mv $newdir/$i $HOME
done

