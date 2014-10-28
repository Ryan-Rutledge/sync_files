HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -v

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

zstyle :compinstall filename ~/.zshrc
zstyle ':completion:*:descriptions' format '%U%B%d%b%u' 
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

autoload -U colors && colors autoload -U promptinit
autoload -Uz compinit
compinit

setopt auto_cd
setopt correct_all
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt prompt_subst

if [ -f ~/.shell_aliases ]; then
	. ~/.shell_aliases
fi

if [ -f ~/.extra_aliases ]; then
	. ~/.extra_aliases
fi

# Appearance ------------------------------------------------------------
if [[ "$TERM" = "linux" ]]; then
	setfont /usr/share/kbd/consolefonts/ter-u16b.psf.gz
fi

function precmd {
	RPROMPT='%(2L.%{$fg_no_bold[cyan]%}%L%{$fg_bold[black]%}%)┤.%{$fg_bold[black]%}│)%{$fg_bold[white]%}%D{%T}%{$reset_color%}'
	local TERMWIDTH
	(( TERMWIDTH = ${COLUMNS} - 1 ))

	local terminal_info=`tty`
	local promptsize=$(( 17 + ${#${PWD}} + ${#${terminal_info##/dev/}} ))

	FILLBAR=""
	for i in `seq $(( $TERMWIDTH - $promptsize ))`; do
	FILLBAR+='─'
		done
		}

PROMPT='%{$fg_no_bold[red]%}┌%{$fg_bold[black]%}(%{$fg_bold[green]%}%d%{$fg_bold[black]%})%{$fg_no_bold[red]%}─%{${FILLBAR}%}%{$fg_bold[black]%}(%{$fg_no_bold[magenta]%}%y%{$fg_bold[black]%})%{$fg_no_bold[red]%}──%{$fg_bold[black]%}┤%{$fg_no_bold[white]%}%W
%{$fg_no_bold[red]%}└─%{$fg_bold[black]%}┤%{$fg_no_bold[cyan]%}%n%{$fg_bold[black]%}@%{$fg_no_bold[cyan]%}%M%{$fg_bold[black]%}%(?..%{$fg_bold[black]%}│%{$fg_bold[yellow]%}%?)%{$fg_bold[black]%}├%{$fg_no_bold[red]%}─%{$fg_bold[red]%}┤%{$reset_color%} '


# show history on exit
function zle-line-finish {
	RPROMPT='%(2L.%{$fg_no_bold[cyan]%}%L%{$fg_bold[black]%}%)┤.%{$fg_bold[black]%}│)%{$fg_bold[white]%}%D{%T}%{$reset_color%}'

	zle reset-prompt
}

# vim flag
function zle-keymap-select {
	VIM_PROMPT='%{$fg_bold[yellow]%}[COMMAND MODE] '
	RPROMPT="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}%(2L.%{$fg_no_bold[cyan]%}%L%{$fg_bold[black]%}%)┤.%{$fg_bold[black]%}│)%{$fg_bold[white]%}%D{%T}%{$reset_color%}"

	zle reset-prompt
}

zle -N zle-line-finish
zle -N zle-keymap-select
export KEYTIMEOUT=1

clear
