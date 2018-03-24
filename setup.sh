#!/usr/bin/env bash

STARTDIR=`pwd`
SCRIPTDIR=`dirname ${BASH_SOURCE[0]}`
DIRPATH=`readlink -f $SCRIPTDIR`

echo "Install directory = ${DIRPATH}"

echo "Creating symbolic link for .bashrc"
ln -sf {${DIRPATH},${HOME}}/.bashrc

echo "Creating symbolic link for .bash_functions"
ln -sf {${DIRPATH},${HOME}}/.bash_functions

echo "Creating symbolic link for .bash_aliases"
ln -sf {${DIRPATH},${HOME}}/.bash_aliases

echo "Creating symbolic link for .bash-paths"
ln -sf {${DIRPATH},${HOME}}/.bash-paths

echo "Creating symbolic link for .astylerc"
ln -sf {${DIRPATH},${HOME}}/.astylerc

echo "Creating symbolic link for .clang-format"
ln -sf {${DIRPATH},${HOME}}/.clang-format

echo "Creating symbolic link for .inputrc"
ln -sf {${DIRPATH},${HOME}}/.inputrc

echo "Creating symbolic link for .minttyrc"
ln -sf {${DIRPATH},${HOME}}/.minttyrc

echo "Creating symbolic link for .tmux.conf"
ln -sf {${DIRPATH},${HOME}}/.tmux.conf

echo "Creating symbolic link for .screenrc"
ln -sf {${DIRPATH},${HOME}}/.screenrc

echo "Creating symbolic link for .xmltidyrc"
ln -sf {${DIRPATH},${HOME}}/.xmltidyrc

echo "Creating symbolic link for .htmltidyrc"
ln -sf {${DIRPATH},${HOME}}/.htmltidyrc

echo "Creating symbolic link for .cmakelintrc"
ln -sf {${DIRPATH},${HOME}}/.cmakelintrc

echo "Creating symbolic link for .infokey"
ln -sf {${DIRPATH},${HOME}}/.infokey

echo "Creating symbolic link for .lesskey"
ln -sf {${DIRPATH},${HOME}}/.lesskey

echo "Compiling lesskey to create mappings for less"
lesskey

echo "Creating symbolic link for .bash_profile"
ln -sf {${DIRPATH},${HOME}}/.bash_profile

echo "Creating symbolic link for gnome-terminal config"
mkdir -p ${HOME}/.gconf/apps/gnome-terminal/profiles/Default/
ln -sf {${DIRPATH},${HOME}/.gconf/apps/gnome-terminal/profiles/Default}/%gconf.xml

echo "Creating symbolic link for xterm config"
ln -sf {${DIRPATH},${HOME}}/.Xresources
ln -sf ${DIRPATH}/.Xresources ${HOME}/.Xdefaults

echo "Creating symbolic link for .gitignore_global"
ln -sf {${DIRPATH},${HOME}}/.gitignore_global

echo "Creating symbolic link for .gitconfig_global"
ln -sf {${DIRPATH},${HOME}}/.gitconfig_global

echo "Creating symbolic link for .gitconfig"
ln -sf {${DIRPATH},${HOME}}/.gitconfig

echo "Creating symbolic link for .hgrc"
ln -sf {${DIRPATH},${HOME}}/.hgrc

echo "Updating .gitconfig to include .gitconfig_global"
git config --global include.path ${HOME}/.gitconfig_global

echo "Creating symbolic link for .bash_local"
ln -sf {${DIRPATH},${HOME}}/.bash_local

echo "Reloading inputrc"
bind -f ${HOME}/.inputrc

echo "Pulling all git submodules"
cd ${DIRPATH}
git submodule update --init --recursive
cd ${STARTDIR}

echo "Updating mandb"
mandb
