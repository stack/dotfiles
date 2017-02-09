set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/_vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'davidoc/taskpaper.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'keith/swift.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'neomake/neomake'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-ruby/vim-ruby'

" Color schemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline-themes'

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

" Allow backspacing everywhere
set backspace=indent,eol,start " backspace over everything in insert mode

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

"*** Modifications by me ***

" Set up Nerd Tree for comma + d
let mapleader = ","
map <leader>d :execute 'NERDTreeToggle'<CR>

let NERDTreeIgnore = [ 'ar-lib', 'compile', 'config.guess', 'config.status', 'config.sub', 'configure', 'depcomp', 'install-sh', 'libtool', 'ltmain.sh', 'missing', 'stamp-h1', 'test-driver', '\.a$', '\.la$', '\.in$', '\.o$', '\.lo$', '\~$' ]

" Set up Marked for comma + m
map <leader>m :silent !open -a "Marked 2.app" '%:p'<CR>

" Arrow keys are fine to use
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

" Ctag Generation
command! MakeTags !ctags -R .

" Ctrl-P
let g:ctrlp_working_path_mode = ''
nnoremap <leader>. :CtrlPTag<cr>

if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command =
    \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" Airline
let g:airlinetheme = "solarized"

" Tagbar
nmap <leader>b :TagbarToggle<CR>

let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'f:functions',
        \ 'functions:functions',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 'm:modules',
        \ 'p:protocols',
        \ 'r:records'
    \ ]
\ }

let g:tagbar_type_swift = {
  \ 'ctagstype': 'swift',
  \ 'kinds' : [
    \ 'n:Enums',
    \ 't:Typealiases',
    \ 'p:Protocols',
    \ 's:Structs',
    \ 'c:Classes',
    \ 'f:Functions',
    \ 'v:Variables',
    \ 'e:Extensions'
  \ ],
  \ 'sort' : 0
\ }

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

let g:syntastic_html_tidy_ignore_errors=['proprietary attribute "ng-']

" Gundo
nnoremap <F5> :GundoToggle<CR>

" ACK/Ag
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

nmap <leader>a :Ack<Space>

" Vim Easy Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Gutentags
let g:gutentags_cache_dir = '~/.tags_cache'

" Neomake
autocmd! BufWritePost * Neomake

" Tab widths
:set softtabstop=4 shiftwidth=4 expandtab
au FileType html setl softtabstop=2 shiftwidth=2 expandtab
au FileType ruby setl softtabstop=2 shiftwidth=2 expandtab

" Local config
function! LoadLocal(path)
  let fullPath = expand(a:path)
  if filereadable(fullPath)
    execute 'source '.fullPath
  endif
endfunction

call LoadLocal("~/.vimrc.local")
call LoadLocal("~/_vimrc.local")
call LoadLocal(".vimrc.local")
