#!/usr/bin/env bash

SCRIPTDIR=`dirname ${BASH_SOURCE[0]}`
DIRPATH=`readlink -f $SCRIPTDIR`

echo "Install directory = $DIRPATH"

echo "Creating symbolic link for bashrc"
ln -sf $DIRPATH/.bashrc ~/.bashrc

echo "Creating symbolic link for bash_functions"
ln -sf $DIRPATH/.bash_functions ~/.bash_functions

echo "Creating symbolic link for bash_aliases"
ln -sf $DIRPATH/.bash_aliases ~/.bash_aliases

echo "Creating symbolic link for astylerc"
ln -sf $DIRPATH/.astylerc ~/.astylerc

echo "Creating symbolic link for inputrc"
ln -sf $DIRPATH/.inputrc ~/.inputrc

echo "Reloading inputrc"
bind -f ~/.inputrc

echo "Creating symbolic link for minttyrc"
ln -sf $DIRPATH/.minttyrc ~/.minttyrc

echo "Creating symbolic link for screenrc"
ln -sf $DIRPATH/.screenrc ~/.screenrc
