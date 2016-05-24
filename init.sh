#!/bin/bash
#
# Installs programs and generates symbolic links to sync files
# for debian and arch-based Linux distros

arg="${1^^}"
gui="${2^^}"

pushd `dirname "${0}"` > /dev/null
basedir=`pwd -P`
popd > /dev/null

# Creates a symbolic link within the home directory
# $1	Name of file
# $2	Path (within home directory. Default value is home)
# $3	If true, uses absolute directory
function createlink {
	# If using absolute
	if [ -n "${3}" ]; then
		pre=""
	else
		pre=~/
	fi

	oldfile="${basedir}/${1}"
	newfile="${pre}${2}${1}"

	# If link already exists
	if [ -h "${newfile}" ]; then
		echo -e "\033[0;33msymbolic link ${newfile} already exists\033[0;00m"
	else
		# Set default variable
		local answer='y'

		# If file already exists
		if [ -e "${newfile}"  ]; then
			# Ask user if it should be replaced
			echo -en "\n\033[0;31m${newfile} already exists. Do you want to replace it? (y|n) \033[0;00m"
			read answer
		fi

		# If permission was given to replace file
		if [ $answer == 'y' -o $answer == 'Y' ]; then
			# Remove file if it already exists
			rm -f "${newfile}"

			# Create symbolic link
			ln -s "${oldfile}" "${newfile}" && echo -e "\e[0;32m${1} linked\e[0;00m"
		else
			echo -e "${2}${1} was not linked"
		fi 
	fi
}

# Install programs
if [[ ${arg} == '--INSTALL' ]]; then
	# If apt-get is installed
	if [ -f "$(which apt-get 2> /dev/null)" ]; then
		apt-get update
		apt-get dist-upgrade

		# Always install
		apt-get install elinks
		apt-get install gpm
		apt-get install screen
		apt-get install zsh && chsh -s $(which zsh)

		if [[ ${gui} == 'GUI' ]]; then
			apt-get install conky
			apt-get install idle3
			apt-get install redshift
			apt-get install ttf-ubuntu-font-family
			apt-get install vim-gtk
		else
			apt-get install python3
			apt-get install vim
		fi
	# If pacman is installed
	elif [ -f "$(which pacman 2> /dev/null)" ]; then
		pacman -Syu

		# Always install
		pacman -S elinks
		pacman -S gpm
		pacman -S python
		pacman -S screen
		pacman -S zsh && chsh -s $(which zsh)

		if [[ ${gui} == 'GUI' ]]; then
			pacman -S gvim
			pacman -S redshift
			pacman -S synapse
			pacman -S ttf-ubuntu-font-family
		else
			pacman -S vim
		fi
	fi
# Generate symbolic links
elif [[ ${arg} == '--LINKS' ]]; then
	# zsh
	createlink ".zshrc"

	# vim
	createlink ".vimrc"
	mkdir -p ~/.vim/colors
	createlink "monokai.vim" ".vim/colors/"

	# aliases
	createlink ".shell_aliases"

	# elinks
	mkdir -p ~/.elinks/
	createlink "elinks.conf" ".elinks/"

	if [[ ${gui} == 'GUI' ]] ; then
		# python
		mkdir -p ~/.idlerc
		createlink "config-highlight.cfg" ".idlerc/"
		createlink "config-keys.cfg" ".idlerc/"
		createlink "config-main.cfg" ".idlerc/"

		# J
		mkdir -p ~/j64-802-user/config
		createlink "style.cfg" "j64-802-user/config/"
	fi
else
	echo 'Usage: init.sh (--INSTALL | --LINKS) [GUI]'
fi
