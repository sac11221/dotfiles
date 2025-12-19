#!/bin/sh

directories=(".icewm" ".vimrc")
newdir="."
olddir="old_dotfiles$(date +_%y%m%d_%H%M%S)"

mkdir $olddir

for i in ${directories[@]}
do
	mv "~/$i" $olddir
	mv $newdir/$i "~"
done

