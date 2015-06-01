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
			sudo rm -f "${newfile}"

			# Create symbolic link
			sudo ln -s "${oldfile}" "${newfile}" && echo -e "\e[0;32m${1} linked\e[0;00m"
		else
			echo -e "${2}${1} was not linked"
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
		sudo apt-get install cowsay
		sudo apt-get install elinks
		sudo apt-get install gpm
		sudo apt-get install screen
		sudo apt-get install zsh && chsh -s $(which zsh)

		if [[ ${2} == 'gui' || ${2} == 'GUI' ]]; then
			sudo apt-get install conky
			sudo apt-get install chromium-browser
			sudo apt-get install feh
			sudo apt-get install gimp
			sudo apt-get install idle3
			sudo apt-get install inkscape
			sudo apt-get install lxterminal
			sudo apt-get install openbox
			sudo apt-get install redshift
			sudo apt-get install synapse
			sudo apt-get install thunar
			sudo apt-get install tint2
			sudo apt-get install ttf-ubuntu-font-family
			sudo apt-get install vim-gtk
			sudo apt-get install xcompmgr
		else
			sudo apt-get install python3
			sudo apt-get install vim
		fi
	# If pacman is installed
	elif [ -f "$(which pacman 2> /dev/null)" ]; then
		sudo pacman -Syu

		# Always install
		sudo pacman -S cowsay
		sudo pacman -S elinks
		sudo pacman -S gpm
		sudo pacman -S python
		sudo pacman -S screen
		sudo pacman -S zsh && chsh -s $(which zsh)

		if [[ ${2} == 'gui' || ${2} == 'GUI' ]]; then
			sudo pacman -S conky
			sudo pacman -S chromium
			sudo pacman -S feh
			sudo pacman -S gimp
			sudo pacman -S gvim
			sudo pacman -S inkscape
			sudo pacman -S lxterminal
			sudo pacman -S openbox
			sudo pacman -S redshift
			sudo pacman -S synapse
			sudo pacman -S thunar
			sudo pacman -S tint2
			sudo pacman -S ttf-ubuntu-font-family
			sudo pacman -S xcompmgr
		else
			sudo pacman -S vim
		fi
	fi

# Generate symbolic links
elif [[ ${1} == '--links' ]]; then
	# zsh
	createlink ".zshrc"

	# vim
	createlink ".vimrc"
	mkdir -p ~/.vim/colors
	createlink "heroku-terminal.vim" "/.vim/colors/"

	# aliases
	createlink ".shell_aliases"

	# elinks
	mkdir -p ~/.elinks/
	createlink "elinks.conf" ".elinks/"
	
	# Miscellaneous
	mkdir -p ~/extra

	if [[ ${2} == 'gui' ||  ${2} == 'GUI' ]] ; then
		# python
		mkdir -p ~/.idlerc
		createlink "config-highlight.cfg" ".idlerc/"
		createlink "config-keys.cfg" ".idlerc/"
		createlink "config-main.cfg" ".idlerc/"

		# conky
		mkdir -p ~/Scripts
		createlink ".conkyrc"
		createlink "deadbeefProgress.sh" "Scripts/"
		createlink "getQuote.sh" "Scripts/"
		createlink "quotes" "extra/"

		# J
		mkdir -p ~/j64-802-user/config
		createlink "qtide.cfg" "j64-802-user/config/"
		createlink "style.cfg" "j64-802-user/config/"

		# lxterminal
		mkdir -p ~/.config/lxterminal
		createLink "lxterminal.conf" ".config/lxterminal"

		# Openbox
		mkdir -p ~/.config/openbox
		createlink "rc.xml" ".config/openbox/"
		createlink "autostart" ".config/openbox/"
		mkdir -p ~/.icons
		createlink "ACYL_Icon_Theme_0.9.4" ".icons/"
		sudo mkdir -p /usr/share/themes
		createlink "BlackLime" "/usr/share/themes/" 1

		# LXDM
		sudo mkdir -p /usr/share/lxdm/themes
		createlink "ABClarity" "/usr/share/lxdm/themes/" 1

		# GVim
		createlink "heroku.vim" "/.vim/colors/"
	fi
else
	echo 'Usage: init.sh [--install | --links] [gui]'
fi
