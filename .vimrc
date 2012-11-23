" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

source ~/.vim/vdb.vim

filetype on
filetype indent on
filetype plugin on

syntax on

let g:DoxygenToolkit_compactOneLineDoc="yes"
let g:DoxygenToolkit_commentType="C++"

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
set mouse=nv

autocmd! bufwritepost .vimrc source ~/.vimrc
autocmd BufRead,BufNewFile *.h set filetype=c
let g:C_SourceCodeExtensions = 'h c cc cp cxx cpp CPP c++ i ii'

"if has("gui_running")
   "colorscheme oceandeep
   colorscheme molokai
   "colorscheme wombat256mod
   "colorscheme asmanian_blood
   "colorscheme desert
   "colorscheme gentooish
   set linespace=3
   set t_Co=256 	" 256 color mode
   set cursorline 	" hightlight current line
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
  set softtabstop=4
  set shiftwidth=4
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
let g:SuperTabDefaultCompletionType="context"
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


" --- BufExpl
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 

" --- ctags
"set tags=~/.vim/tags
"set tags+=tags

" ---cscope
if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    set csto=0
    set cst
    set csverb
endif

" --- Source Explorer
let g:SrcExpl_winHeight = 8
let g:SrcExpl_refreshTime = 100
let g:SrcExpl_jumpKey = "<ENTER>"
let g:SrcExpl_gobackKey = "<SPACE>"
let g:SrcExpl_searchLocalDef = 1
let g:SrcExpl_isUpdateTags = 0

let g:SrcExpl_pluginList=[
    \"__Tag_List__",
    \"_NERD_tree_",
    \"Source_Explorer"
    \]

" --- clang_complete
"let g:clang_snippets=1
"let g:clang_snippets_engine='snipmate'
let g:clean_complete_auto = 0
let g:clang_complete_copen = 1
let g:clang_use_library = 1
let g:clang_libary_path = "/usr/lib"
set completeopt=menu,longest

" ENCODING SETTING
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

" QUICKFIX WINDOW
command -bang -nargs=? QFix call QFixToggle(<bang>0)

function! QFixToggle(forced)
if exists("g:qfix_win") && a:forced == 0
cclose
unlet g:qfix_win
else
copen 10
let g:qfix_win = bufnr("$")
endif
endfunction

let g:usingDgb=0

function! UseDebugToggle()
    if(g:usingDgb == 1)
        call NormalMapping()
        let g:usingDgb = 0
    else
        call DbgMapping()
        let g:usingDgb = 1
    endif
endfunction

function! NormalMapping()
    map <silent> <F2> :TrinityToggleNERDTree<CR>
    map <silent> <F5> :TrinityToggleTagList<CR>
    map <silent> <F6> :QFix <CR>
    map <silent> <F7> :Grep <CR>
    map <silent> <F8> :TrinityToggleAll <CR>
    map <silent> <F9> :TrinityToggleSourceExplorer<CR>
    map <silent> <F12> :call UseDebugToggle() <CR>
endfunction

function! DbgMapping()
    "map <silent> <F4> :GdbFromVimRun <CR>
    "map <silent> <F5> :GdbFromVimStep <CR>
    "map <silent> <F6> :GdbFromVimNext <CR>
    "map <silent> <F7> :GdbFromVimAddBreakpoint <CR>
    "map <silent> <F8> :GdbFromFromDeleteBreakpoint <CR>
    "map <silent> <F9> :GdbFromVimClear <CR>
    call VDBMapDefaults()
    map <silent> <F12> :call UseDebugToggle() <CR>
endfunction

call NormalMapping()
