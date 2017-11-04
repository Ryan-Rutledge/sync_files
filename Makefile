username=$(whoami)
cmd: # Commandline setup
	./init.sh --INSTALL && ./init.sh --LINKS && ./init.sh --SETUP

gui: # GUI setup
	./init.sh --INSTALL GUI && ./init.sh --LINKS GUI && ./init.sh --SETUP GUI
