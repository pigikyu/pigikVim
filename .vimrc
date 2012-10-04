" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

filetype on
filetype indent on
filetype plugin on

syntax on

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set laststatus=2        " Always show the statusline
set nu
set bs=2
set history=1000
set ruler
set autoread
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set autoindent
set copyindent
set ignorecase
set smartcase
set smarttab
set hlsearch            " search highlighting
set clipboard+=unnamed
set formatoptions=tcrqn

autocmd! bufwritepost .vimrc source ~/.vimrc

"if has("gui_running")
   set background=dark
   set t_Co=256 	" 256 color mode
   set cursorline 	" hightlight current line
   highlight CursorLine guibg=26 ctermbg=17 gui=none cterm=none
   highlight Normal ctermfg=250  ctermbg=232
"endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" TAB setting {
  set expandtab 	"replace <TAB> with spaces
  set softtabstop=3
  set shiftwidth=3
  au FileType Makefile set noexpandtab
"}
"
"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" set leader to ,
let mapleader=","
let g:mapleader=","

" --- superTab
let g:SuperTabDefaultCompletionType="Context"
let g:SuperTabCompletionContexts=['s:ContextText', 's:ContextDiscover']

" --- Command-T
let g:CommandTMaxHeight=15

" --- AutoClose
"if !has("gui_running")
"   set term=linux
   imap OA <ESC>ki
   imap OB <ESC>ji
   imap OC <ESC>li
   imap OD <ESC>hi

   nmap OA k
   nmap OB j
   nmap OC l
   nmap OD h
"endif

" ENCODING SETTING
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1
