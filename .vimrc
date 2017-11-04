" Plugins
call plug#begin('~/.vim/plugged')
	Plug 'tpope/vim-fugitive'
	Plug 'vim-airline/vim-airline'
	Plug 'airblade/vim-gitgutter'
	Plug 'joshdick/onedark.vim'
	Plug 'scrooloose/nerdtree', {'on': 'NERDTReeToggle' }
call plug#end()

" let g:airline_powerline_fonts=1
let g:airline_detect_spell=1
let g:airline_detect_spelllang=1
let g:airline_symbols_ascii=1
let g:airline_skip_empty_sections=1
let g:airline_theme='onedark'
let g:airline_section_y = airline#section#create_right(['%-2.B ', 'ffenc'])

set encoding=utf-8
set term=screen-256color
set t_ut=
syntax on
filetype plugin on
au BufRead,BufNewFile bash-fc-* set filetype=sh

" Colorscheme
colorscheme onedark
set background=dark

hi cursorLine   cterm=bold
hi CursorLineNr cterm=bold
hi cursorColumn cterm=bold

" Add < and > to list of match characters
set mps+=\<:\>

" General
set backspace=indent,eol,start
set guicursor=c-i:ver20,a:blinkon800-blinkoff200-blinkwait8000,r:hor10
set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 11
set lazyredraw
set linebreak
set mouse=a
set noshowmatch
set nowrap
set number
set scrolloff=7
set showcmd
set splitright
set splitbelow
set wildmenu
set wildmode=longest:full,full
set whichwrap=<,>,h,l

" Swap files
	" set backupdir=~/.vim/backups
	" set directory=~/.vim/swapfiles
	set nowritebackup
	set noswapfile

" Pressing <leader>ss will toggle and untoggle spell checking
nnoremap <leader>ss :set spell!<CR>

" Folding
	set foldmethod=indent
	set foldlevelstart=99
	nnoremap <space> za

" Indentation
	set autoindent
	set cindent
	set cinkeys-=0#
	set indentkeys-=0#

" Searching
	set incsearch
	set ignorecase
	set smartcase
	set hlsearch

" Highlighting
	set cursorline
	set cursorcolumn

" Make options
	set autowrite

" Abbreviations
	" Print current date
	iabbrev <expr> {DATE} strftime("%d/%m/%Y")
	" Print current time
	iabbrev <expr> {TIME} strftime("%H:%M:%S")

" Key mappings
	let mapleader = '\'

	" Movement
		inoremap jk <ESC>
		nnoremap j gj
		nnoremap k gk
		nnoremap gj j
		nnoremap gk k

	" Selection
		set virtualedit=block

	" Yanking
		" Yank to end of line
		nnoremap Y y$

		" Yank all
		nnoremap <leader>y gg"+yG


	" Use U as redo
		nnoremap U <C-r>

	" Remove search highlight shortcut
		nnoremap <leader>h :nohlsearch<CR>

	" Directions
		noremap <Up> k<C-y>
		noremap <Down> j<C-e>
		noremap <Left> hz<Left>
		noremap <Right> lz<Right>

	" Viewports
		" Moving between viewports
			nnoremap <C-j> <C-W>j
			nnoremap <C-k> <C-W>k
			nnoremap <C-h> <C-W>h
			nnoremap <C-l> <C-W>l

		" Resizing viewports
			nnoremap <C-UP> <C-W>+
			nnoremap <C-DOWN> <C-W>-
			nnoremap <C-LEFT> <C-W><
			nnoremap <C-RIGHT> <C-W>>

	" Tabs
		set tabpagemax=100

		" Next
			nnoremap <leader>n :tabnext<CR>
			nnoremap <C-tab> :tabnext<CR>
			inoremap <C-tab> <Esc>:tabnext<CR>
			nnoremap <leader>tn :tabnext<CR>
		" Prev
			nnoremap <leader>p :tabprevious<CR>
			nnoremap <C-S-tab> :tabprevious<CR>
			inoremap <C-S-tab> <Esc>:tabprevious<CR>
			nnoremap <leader>tp :tabprevious<CR>
		" New
			inoremap <C-t> <Esc>:tabnew<CR>
			nnoremap <C-t> :tabnew<CR>

	" Special Characters
		" Ctrl-k <letter><diagraph>
		" Ctrl-v u<hex unicode value>

	" Auto-complete
		inoremap <Left> <C-X><C-P>
		inoremap <Right> <C-X><C-N>

" Toggle between relative and normal line numbers
function! NumberToggle()
	if (&relativenumber == 1)
		set number
		set norelativenumber
	else
		set relativenumber
	endif
endfunc

nnoremap <leader>l :call NumberToggle()<CR>

function! Tab4(...)
	set shiftwidth=4
	set softtabstop=4
	set tabstop=4
	set noexpandtab
endfunction
command! Tab4 call Tab4()

function! Tab2(...)
	set shiftwidth=2
	set softtabstop=2
	set tabstop=2
	set expandtab
endfunction
command! Tab2 call Tab2()

Tab4
