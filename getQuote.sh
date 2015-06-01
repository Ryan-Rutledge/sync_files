#!/bin/bash

if [[ $((${RANDOM} % 6)) -eq 0 ]]; then
	cowthink $(shuf -n 1 /usr/share/dict/words)
else
	name=$(ls ~/extra/quotes/ | shuf -n 1)
	quote=$(shuf -n 1 "${HOME}/extra/quotes/${name}")

	echo -e "${quote}\n\n-${name}" | cowsay -W 36
fi
