#!/bin/bash

# Return value
rval=0

# Calculate total seconds in time
function seconds {
	rval=$(( $(expr $1 : '\([0-9]*\):')*60 + $(expr $1 : '.*:0\?\([0-9]*\)' ) ))
}

# Elapsed time
seconds $(deadbeef --nowplaying "%e")
e=$rval

# Total length
seconds $(deadbeef --nowplaying "%l")
l=$rval

# Divide time elapsed by total length
echo $(bc <<< "scale=2; 100*$e/$l" )
