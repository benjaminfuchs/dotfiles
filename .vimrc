"" No need to be compatible with vi and lose features.
set nocompatible
            
"" Set textwidth to 80, this implies word wrap.
set textwidth=80

"" Show line numbers.
set nu

"" Automatic C-style indenting.
set autoindent

"" When inserting TABs replace them with the appropriate number of spaces
set expandtab

"" But TABs are needed in Makefiles
au BufNewFile,BufReadPost Makefile se noexpandtab

"" Show matching braces.
set showmatch

"" Choose the right syntax highlightning per TAB-completion :-)
"" map <F2> :source $VIM/syntax/

"" Syntax highlightning, but only for color terminals.
if &t_Co > 1
  syntax on
endif

"" Set update time to 1 second (default is 4 seconds), convenient vor taglist.vim.
set updatetime=500

"" Toggle between .h and .C with F4.
function! ToggleBetweenHeaderAndSourceFile()
  let bufname = bufname("%")
  let ext = fnamemodify(bufname, ":e")
  if ext == "h"
    let ext = "C"
  elseif ext == "C"
    let ext = "h"
  else
    return
  endif
  let bufname_new = fnamemodify(bufname, ":r") . "." . ext
  let bufname_alt = bufname("#")
  if bufname_new == bufname_alt
    execute ":e#"
  else
    execute ":e " . bufname_new
  endif
endfunction
map <silent> <F4> :call ToggleBetweenHeaderAndSourceFile()<CR>

"" Keep the horizontal cursor position when moving vertically.
set nostartofline

"" Reformat comment on current line. TODO: explain how.
map <silent> hc ==I  <ESC>:.s/\/\/ */\/\//<CR>:nohlsearch<CR>j

"" Make sure == also indents #ifdef etc.
noremap <silent> == IX<ESC>==:.s/X//<CR>:nohlsearch<CR>

"" Toggle encoding with F12.
function! ToggleEncoding()
  if &encoding == "latin1"
    set encoding=utf-8
  elseif &encoding == "utf-8"
    set encoding=latin1
  endif
endfunction
map <silent> <F12> :call ToggleEncoding()<CR>

"" Do not break long lines.
set nowrap
set listchars=eol:$,extends:>

"" After this many msecs do not imap.
set timeoutlen=500

"" Always show the name of the file being edited.
set ls=2

"" Show the mode (insert,replace,etc.)
set showmode
 
"" No blinking cursor please.
set gcr=a:blinkon0

"" Cycle through completions with TAB (and SHIFT-TAB cycles backwards).
function! InsertTabWrapper(direction) 
    let col = col('.') - 1 
    if !col || getline('.')[col - 1] !~ '\k' 
        return "\<tab>" 
    elseif "backward" == a:direction 
        return "\<c-p>" 
    else 
        return "\<c-n>" 
    endif 
endfunction 
inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>

"" Cycling through Windows quicker.
map <C-M> <C-W>j<C-W>_ 
map <C-K> <C-W>k<C-W>_ 
map <A-Down>  <C-W><Down><C-W>_
map <A-Up>    <C-W><Up><C-W>_
map <A-Left>  <C-W><Left><C-W>|
map <A-Right> <C-W><Right><C-W>|

"" Do not show any line of minimized windows
set wmh=0

"" Make it easy to update/reload _vimrc.
:nmap ,s :source $HOME/.vimrc 
:nmap ,v :sp $HOME/.vimrc 

"" set guifont=Courier10_BT/Roman/10
set gfn=Courier\ 10\ Pitch\ 10
set gfw=
set go=agimrLtT

"" easy navigation after grep search
map <F9> :cnext<CR>
map <F8> :make \| copen<CR> 
map <F7> :cprev<CR>

"" search word under curser in current file
map <F10> :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%') <Bar> cw<CR>

"" search word under curser in current directory and subdirectorys
map <C-F10> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

"" Turn on highlighting search matches 
set hlsearch

"" set indent to 4 WS
set smartindent
set tabstop=4
set shiftwidth=4
        
set foldmethod=syntax
set foldlevel=20

match Ignore /\r$/

set pastetoggle=<F2>
