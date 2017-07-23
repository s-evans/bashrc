#!/usr/bin/env bash

STARTDIR=`pwd`
SCRIPTDIR=`dirname ${BASH_SOURCE[0]}`
DIRPATH=`readlink -f $SCRIPTDIR`

echo "Install directory = ${DIRPATH}"

echo "Creating symbolic link for .bashrc"
ln -sf ${DIRPATH}/.bashrc ${HOME}/.bashrc

echo "Creating symbolic link for .bash_functions"
ln -sf ${DIRPATH}/.bash_functions ${HOME}/.bash_functions

echo "Creating symbolic link for .bash_aliases"
ln -sf ${DIRPATH}/.bash_aliases ${HOME}/.bash_aliases

echo "Creating symbolic link for .astylerc"
ln -sf ${DIRPATH}/.astylerc ${HOME}/.astylerc

echo "Creating symbolic link for .clang-format"
ln -sf ${DIRPATH}/.clang-format ${HOME}/.clang-format

echo "Creating symbolic link for .inputrc"
ln -sf ${DIRPATH}/.inputrc ${HOME}/.inputrc

echo "Creating symbolic link for .minttyrc"
ln -sf ${DIRPATH}/.minttyrc ${HOME}/.minttyrc

echo "Creating symbolic link for .tmux.conf"
ln -sf ${DIRPATH}/.tmux.conf ${HOME}/.tmux.conf

echo "Creating symbolic link for .screenrc"
ln -sf ${DIRPATH}/.screenrc ${HOME}/.screenrc

echo "Creating symbolic link for .infokey"
ln -sf ${DIRPATH}/.infokey ${HOME}/.infokey

echo "Creating symbolic link for .bash_profile"
ln -sf ${DIRPATH}/.bash_profile ${HOME}/.bash_profile

echo "Creating symbolic link for gnome-terminal config"
mkdir -p ${HOME}/.gconf/apps/gnome-terminal/profiles/Default/
ln -sf ${DIRPATH}/%gconf.xml ${HOME}/.gconf/apps/gnome-terminal/profiles/Default

echo "Creating symbolic link for xterm config"
ln -sf ${DIRPATH}/.Xresources ${HOME}/.Xresources
ln -sf ${DIRPATH}/.Xresources ${HOME}/.Xdefaults

echo "Creating symbolic link for .gitignore_global"
ln -sf ${DIRPATH}/.gitignore_global ${HOME}/.gitignore_global

echo "Creating symbolic link for .gitconfig_global"
ln -sf ${DIRPATH}/.gitconfig_global ${HOME}/.gitconfig_global

echo "Copying .gitconfig"
cp -n ${DIRPATH}/.gitconfig ${HOME}/.gitconfig

echo "Updating .gitconfig to include .gitconfig_global"
git config --global include.path ${HOME}/.gitconfig_global

echo "Copying .bash_local"
cp -n ${DIRPATH}/.bash_local ${HOME}/.bash_local

echo "Reloading inputrc"
bind -f ${HOME}/.inputrc

echo "Pulling all git submodules"
cd ${DIRPATH}
git submodule update --init --recursive
cd ${STARTDIR}

echo "Updating mandb"
mandb
