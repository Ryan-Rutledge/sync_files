#!/bin/bash
#
# Installs programs and generates symbolic links to sync files
# for debian and arch-based Linux distros

arg="${1^^}" # Required primary argument
gui="${2^^}" # Optional secondary argument

pushd `dirname "${0}"` > /dev/null
basedir=`pwd -P`
popd > /dev/null

# Prints a message to the user
# $1	Message type { 0:success, 1:inform, 2:error }
# $2	Text to print
function message {
	typecode=("\e[0;32m" "\033[0;33m" "\033[0;31m")
	echo -en "${typecode[$1]}${2}\033[0;00m"
}

# Install programs
function init_install {
	# If apt-get is installed
	if [ -f "$(which apt-get 2> /dev/null)" ]; then
		sudo -S apt-get update
		sudo -S apt-get dist-upgrade

		# Always install
		sudo -S apt-get install gpm
		sudo -S apt-get install screen
		sudo -S apt-get install zsh
		sudo -S apt-get install python3
		sudo -S apt-get install python3-pip
		sudo -S pip3 install --upgrade pip
		sudo -S pip3 install --user powerline-status

		if [[ ${gui} == 'GUI' ]]; then
			sudo -S apt-get install i3
			sudo -S apt-get install redshift
			sudo -S apt-get install ttf-ubuntu-font-family
			sudo -S apt-get install vim-gtk
		else
			sudo -S apt-get install vim
		fi

	# If pacman is installed
	elif [ -f "$(which pacman 2> /dev/null)" ]; then
		sudo -S pacman -Syu

		# Always install
		sudo -S pacman -S gpm
		sudo -S pacman -S pip
		sudo -S pacman -S screen
		sudo -S pacman -S zsh
		sudo -S pacman -S python
		sudo -S pacman -S python-pip
		sudo -S pip install --upgrade pip
		sudo -S pip install --user powerline-status

		if [[ ${gui} == 'GUI' ]]; then
			sudo -S pacman -S i3
			sudo -S pacman -S gvim
			sudo -S pacman -S redshift
			sudo -S pacman -S synapse
			sudo -S pacman -S ttf-ubuntu-font-family
		else
			sudo -S pacman -S vim
		fi
	fi

	# Vim plug
	if [ ! -d ~/.vim/autoload/plug.vim ]; then
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
}

# Generate symbolic links
function init_links {
	# Creates a symbolic link within the home directory
	# $1	Name of file
	# $2	Path (within home directory. Default value is home)
	# $3	If true, uses absolute directory
	function createlink {
		if [ -n "${3}" ]; then # If using absolute path
			pre=""
		else
			pre=~/
		fi

		oldfile="${basedir}/${1}"
		newfile="${pre}${2}${1}"

		# If link already exists
		if [ -h "${newfile}" ]; then
			message 1 "symbolic link ${newfile} already exists\n"
		else
			# Set default variable
			local answer='y'

			# If file already exists
			if [ -e "${newfile}"  ]; then
				# Ask user if it should be replaced
				message 2 "${newfile} already exists. Do you want to replace it? (y|n) "
				read answer
			fi

			# If permission was given to replace file
			if [ $answer == 'y' -o $answer == 'Y' ]; then
				# Remove file if it already exists
				rm -f "${newfile}"

				# Create symbolic link
				ln -s "${oldfile}" "${newfile}" && message 0 "${1} linked\n"
			else
				echo -e "${2}${1} was not linked"
			fi 
		fi
	}

	# zsh
	createlink ".zshrc"
	createlink ".zshenv"

	# vim
	createlink ".vimrc"
	createlink ".vimrc.vim"

	# git
	createlink ".gitconfig"

	# aliases
	createlink ".shell_aliases"

	if [[ ${gui} == 'GUI' ]]; then

		# i3
		mkdir -p ~/.i3
		createlink "config" ".i3/"

		# python
		mkdir -p ~/.idlerc
		createlink "config-highlight.cfg" ".idlerc/"
		createlink "config-keys.cfg" ".idlerc/"
		createlink "config-main.cfg" ".idlerc/"

		# uxterm
		createlink ".Xresources"
	fi
}

# Change settings
function init_setup {
	 zsh
	if [ -f "$(which zsh 2> /dev/null)" ]; then
		sudo -S chsh -s $(which zsh) && message 0 "default shell set to zsh\n" || message 3 "failed to set default shell\n"
	else
		message 1 "zsh not found. Unable to set as default shell."
	fi

	# bin
	mkdir -p ~/opt/bin
}

if [[ ${arg} == '--INSTALL' ]]; then
	init_install
elif [[ ${arg} == '--LINKS' ]]; then
	init_links
elif [[ ${arg} == '--SETUP' ]]; then
	init_setup
else
	echo 'Usage: init.sh ( --INSTALL | --LINKS | --SETUP ) [ GUI ]'
fi
