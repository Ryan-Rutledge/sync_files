cmd: # Commandline setup
	sudo ./init.sh --INSTALL && ./init.sh --LINKS && ./init.sh --SETUP

gui: # GUI setup
	sudo ./init.sh --INSTALL GUI && ./init.sh --LINKS GUI && ./init.sh --SETUP GUI
