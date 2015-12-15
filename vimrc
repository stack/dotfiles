set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself
Plugin 'gmarik/Vundle.vim'

" Plugins
if !has("win32")
  Plugin 'Valloric/YouCompleteMe'
endif

Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'elzr/vim-json'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-signify'
Plugin 'scrooloose/nerdcommenter'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'

" Color schemes
Plugin 'altercation/vim-colors-solarized'

" Finalize Vundle
call vundle#end()
filetype plugin indent on

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif


augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Line Numbers
set number
set numberwidth=5

" Always show the status bar
set laststatus=2

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,w,t

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

"*** Modifications by me ***

" Set up Nerd Tree for comma + d
let mapleader = ","
map <leader>d :execute 'NERDTreeToggle'<CR>

let NERDTreeIgnore = [ 'ar-lib', 'compile', 'config.guess', 'config.status', 'config.sub', 'configure', 'depcomp', 'install-sh', 'libtool', 'ltmain.sh', 'missing', 'stamp-h1', 'test-driver', '\.a$', '\.la$', '\.in$', '\.o$', '\.lo$', '\~$' ]

" Set up Marked for comma + m
map <leader>m :silent !open -a "Marked 2.app" '%:p'<CR>

" Enable the arrow keys because this is future!
unmap <Left>
unmap <Right>
unmap <Up>
unmap <Down>

" Use solarized for the color
if has('gui_running')
  set background=light
  colorscheme solarized
  set guioptions=egmrt
else
  colorscheme default
endif

" Fonts
silent! set guifont=monospace
if &guifont != 'monospace'
  silent set guifont="Menlo 11"
endif

" Tagbar
nmap <leader>b :TagbarToggle<CR>

" Fugitive
set statusline+=%{fugitive#statusline()}

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Gundo
nnoremap <F5> :GundoToggle<CR>

" Local config
function! LoadLocal(path)
  let fullPath = expand(a:path)
  if filereadable(fullPath)
    execute 'source '.fullPath
  endif
endfunction

call LoadLocal("~/.vimrc.local")
call LoadLocal("~/_vimrc.local")

