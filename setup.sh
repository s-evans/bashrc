#!/usr/bin/env bash

SCRIPTDIR=`dirname ${BASH_SOURCE[0]}`
DIRPATH=`readlink -f $SCRIPTDIR`

echo "Install directory = $DIRPATH"

echo "Creating symbolic link for .bashrc"
ln -sf $DIRPATH/.bashrc ~/.bashrc

echo "Creating symbolic link for .bash_functions"
ln -sf $DIRPATH/.bash_functions ~/.bash_functions

echo "Creating symbolic link for .bash_aliases"
ln -sf $DIRPATH/.bash_aliases ~/.bash_aliases

echo "Creating symbolic link for .astylerc"
ln -sf $DIRPATH/.astylerc ~/.astylerc

echo "Creating symbolic link for .clang-format"
ln -sf $DIRPATH/.clang-format ~/.clang-format

echo "Creating symbolic link for .inputrc"
ln -sf $DIRPATH/.inputrc ~/.inputrc

echo "Creating symbolic link for .minttyrc"
ln -sf $DIRPATH/.minttyrc ~/.minttyrc

echo "Creating symbolic link for .tmux.conf"
ln -sf $DIRPATH/.tmux.conf ~/.tmux.conf

echo "Creating symbolic link for .screenrc"
ln -sf $DIRPATH/.screenrc ~/.screenrc

echo "Creating symbolic link for .startxwinrc"
ln -sf $DIRPATH/.startxwinrc ~/.startxwinrc

echo "Creating symbolic link for gnome-terminal config"
mkdir -p ~/.gconf/apps/gnome-terminal/profiles/Default/
ln -sf $DIRPATH/%gconf.xml ~/.gconf/apps/gnome-terminal/profiles/Default

echo "Copying .bash_local"
cp -n $DIRPATH/.bash_local ~/.bash_local

echo "Reloading inputrc"
bind -f ~/.inputrc

echo "Pulling all git submodules"
cd $DIRPATH
git submodule update --init --recursive

