all: # GUI setup
	sudo ./init.sh --INSTALL GUI && ./init.sh --LINKS GUI

cmd: # Commandline setup
	sudo ./init.sh --INSTALL && ./init.sh --LINKS
