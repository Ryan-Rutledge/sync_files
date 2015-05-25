#!/bin/bash
#
# Installs programs and generates symbolic links to sync files
# for debian-based Linux distros
#
# init.sh [--install | --links] [gui]

pushd `dirname "${0}"` > /dev/null
basedir=`pwd -P`
popd > /dev/null

# Creates a symbolic link within the home directory
# $1	Name of file
# $2	Path within home directory (defaults to home)
function createlink {
	# If link already exists
	if [ -h ~/"${2}${1}" ]; then
		echo -e "\033[0;33msymbolic link ~/${2}${1} already exists\033[0;00m"
	else
		# Set default variable
		local answer='y'

		# If file already exists
		if [ -e ~/"${2}${1}" ]; then
			# Ask user if it should be replaced
			echo -en "\n\033[0;31m~/${2}${1} already exists. Do you want to replace it? (y|n) \033[0;00m"
			read answer
		fi

		# If permission was given to replace file
		if [ $answer == 'y' -o $answer == 'Y' ]; then
			# Remove file if it already exists
			rm -f ~/"${2}${1}"

			# Create symbolic link
			ln -s "${basedir}/${1}" ~/"${2}${1}" && echo -e "\e[0;32m${1} linked\e[0;00m"
		else
			echo -e ${2}"${1} was not linked"
		fi 
	fi
}

# Install programs
if [[ ${1} == '--install' ]]; then
	# If apt-get is installed
	if [ -f "$(which apt-get 2> /dev/null)" ]; then
		sudo apt-get update
		sudo apt-get dist-upgrade

		# Always install
		sudo apt-get install elinks
		sudo apt-get install gpm
		sudo apt-get install screen
		sudo apt-get install zsh && chsh -s $(which zsh)

		if [[ ${2} == 'gui' || ${2} == 'GUI' ]]; then
			sudo apt-get install conky
			sudo apt-get install gimp
			sudo apt-get install idle3
			sudo apt-get install inkscape
			sudo apt-get install synapse
			sudo apt-get install vim-gtk
		else
			sudo apt-get install python3
			sudo apt-get install vim
		fi
	# If pacman is installed
	elif [ -f "$(which pacman 2> /dev/null)" ]; then
		sudo pacman -Syu

		# Always install
		sudo pacman -S elinks
		sudo pacman -S gpm
		sudo pacman -S screen
		sudo pacman -S zsh && chsh -s $(which zsh)

		if [[ ${2} == 'gui' || ${2} == 'GUI' ]]; then
			sudo pacman -S conky
			sudo pacman -S gimp
			sudo pacman -S inkscape
			sudo pacman -S synapse
			sudo pacman -S gvim
		else
			sudo apt-get install python
			sudo apt-get install vim
		fi
	fi

# Generate symbolic links
elif [[ ${1} == '--links' ]]; then
	# zsh
	createlink ".zshrc"

	# vim
	createlink ".vimrc"

	# aliases
	createlink ".shell_aliases"

	# elinks
	mkdir -p ~/.elinks/
	createlink "elinks.conf" ".elinks/"

	if [[ ${2} == 'gui' ||  ${2} == 'GUI' ]] ; then
		# python
		mkdir -p ~/.idlerc
		createlink "config-highlight.cfg" ".idlerc/"
		createlink "config-keys.cfg" ".idlerc/"
		createlink "config-main.cfg" ".idlerc/"

		# conky
		createlink ".conkyrc"

		# J
		mkdir -p ~/j64-802-user/config
		createlink "qtide.cfg" "j64-802-user/config/"
		createlink "style.cfg" "j64-802-user/config/"

		mkdir -p ~/.config/openbox
		createlink "rc.xml" ".config/openbox/"
	fi
else
	echo 'Usage: init.sh [--install | --links] [gui]'
fi
