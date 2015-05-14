set encoding=utf8
syntax on
filetype plugin on
au BufRead,BufNewFile bash-fc-* set filetype=sh

" Colorscheme
colorscheme desert
set background=dark

highlight cursorLine   cterm=bold guibg=#444444
highlight CursorLineNr cterm=bold guibg=#444444
highlight cursorColumn cterm=bold guibg=#444444

" Add < and > to list of match characters
set mps+=\<:\>

" General
set backspace=indent,eol,start
set guicursor+=a:blinkon0
set guifont=Ubuntu\ Mono\ 11
set lazyredraw
set linebreak
set mouse=a
set number
set showcmd
set noshowmatch
set scrolloff=7
set splitright
set splitbelow
set wildmenu
set wildmode=longest:full,full
set whichwrap=<,>,h,l
set wrap

" statusline
hi User1 ctermbg=black ctermfg=blue  guibg=#222222 guifg=#0088FF
hi User2 ctermbg=black ctermfg=green guibg=#222222 guifg=#00AA00
hi User3 ctermbg=black ctermfg=gray  guibg=#222222 guifg=#CCCCCC
hi User4 ctermbg=black ctermfg=red   guibg=#111111 guifg=#AA0000

set noruler
set laststatus=2

set statusline=
set statusline+=%2*
set statusline+=%m
set statusline+=%4*
set statusline+=%-5.r
set statusline+=%1*
set statusline+=%F
set statusline+=%2*
set statusline+=\ %y\ 
set statusline+=%1*
set statusline+=%-6.B
set statusline+=%3*
set statusline+=:%-30.{@:}\ 
set statusline+=%{@q}\ 
set statusline+=%=
set statusline+=%1*
set statusline+=%4.c%V,\ 
set statusline+=%2.l\ /\ %L

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
	set shiftwidth=4
	set softtabstop=4
	set tabstop=4
	set autoindent
	set cindent

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

	" Set up makeprg
		" Bash
			autocmd FileType sh nnoremap <F5> :!./"%:p"<CR>
		" C
			autocmd FileType c nnoremap <F5> :!gcc --o "%:p:r" "%:p" && "%:p:r.out"<CR>
		" C++
			autocmd FileType cpp nnoremap <F5> :!g++ --o "%:p:r" "%:p" && "%:p:r.out"<CR>
		" HTML
			autocmd FileType html nnoremap <F5> :!google-chrome "%:p"<CR>
		" Java
			autocmd FileType java nnoremap <F5> :!javac "%:p" && java -cp "%:p:h" "%:t:r"<CR>
		" Python
			autocmd FileType python nnoremap <F5> :!python3 "%:p"<CR>
			autocmd FileType python set expandtab
		" Sass
			autocmd FileType sass nnoremap <F5> :!sass "%:p" > "%:p:r.css"<CR>

	" Disable automatic comments
		 autocmd FileType * setlocal formatoptions=""

" Abbreviations
	" Print current date
	iabbrev <expr> DATE strftime("%d/%m/%Y")
	" Print current time
	iabbrev <expr> TIME strftime("%H:%M:%S")

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
		nnoremap Y y$

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
			nnoremap <leader>to :tabonly<cr>
			nnoremap <leader>tc :tabclose<cr>
			nnoremap <leader>tm :tabmove 

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

" Macros
	" Yank all
	let @y='ggVG"+Y``'

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

" Increment replace
" Add argument (can be negative, default 1) to global variable i.
" Return value of i before change.
" Usage : let i=0|%s//\=Inc(1, i)/g
function Inc(...)
	let result = g:i
	let g:i += a:0 > 0 ? a:1 : 1
	return result
endfunction
