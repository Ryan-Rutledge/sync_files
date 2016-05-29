all: # GUI setup
	sudo ./init.sh --INSTALL GUI && ./init.sh --LINKS GUI && ./init.sh --SETUP GUI

cmd: # Commandline setup
	sudo ./init.sh --INSTALL && ./init.sh --LINKS && ./init.sh --SETUP
