" Comma is the map leader
let mapleader = ","

" Force UTF-8
set encoding=utf-8

" Install Plug if it isn't installed
if has("win32")
    if empty(glob("$HOME\\vimfiles\\autoload\\plug.vim"))
      silent !curl -fLo "$HOME\\vimfiles\\autoload\\plug.vim" --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

" Define all of the plugins
call plug#begin('~/.vim/plugged')

" Nerd tree for file browsing
Plug 'scrooloose/nerdtree'

" Specific languages
Plug 'tikhomirov/vim-glsl'
Plug 'cespare/vim-toml'
Plug 'davidoc/taskpaper.vim'
Plug 'fatih/vim-go'
Plug 'keith/swift.vim'
Plug 'plasticboy/vim-markdown'
Plug 'posva/vim-vue'
Plug 'rust-lang/rust.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'uarun/vim-protobuf'
Plug 'vim-ruby/vim-ruby'
Plug 'ziglang/zig.vim'

" Pretty status bars
Plug 'bling/vim-airline'

" Color schemes
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline-themes'

" Better commenting
Plug 'tpope/vim-commentary'

" Find dangling whitespace
Plug 'ntpeters/vim-better-whitespace'

" Git inspection
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Yank detection
Plug 'machakann/vim-highlightedyank'

" Fuzzy finding
Plug 'junegunn/fzf'

" Better searching
Plug 'mileszs/ack.vim'

" Alignment
Plug 'tommcdo/vim-lion'

" LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'

call plug#end()

" Color scheme
if has('gui_running')
    set background=light
    colorscheme solarized
    set guioptions=egmrt
else
    colorscheme default
endif

" Fonts
if has('gui_gtk2')
    set guifont=DejaVu\ Sans\ Mono\ 10
elseif has('gui_gtk3')
    set guifont=DejaVu\ Sans\ Mono\ 10
elseif has('gui_win32')
    set guifont=Consolas:h12
elseif has('gui_macvim')
    set guifont=SFMono-Regular:h11
endif

" Numbers
set number

" Allow the mouse in most cases
set mouse=a

" Searching
noremap / /\v
vnoremap / /\v
set ignorecase
set smartcase

" Highlight the current line
set cursorline

" Always show the cursor position
set ruler

" Allow proper backspacing
set backspace=indent,eol,start

" Read / write when changing buffers
set autowrite
set autoread

" Split right / bottom
set splitright
set splitbelow

nmap <silent> <A-Up> :wincmd k<cr>
nmap <silent> <A-Down> :wincmd j<cr>
nmap <silent> <A-Left> :wincmd h<cr>
nmap <silent> <A-Right> :wincmd l<cr>

nmap <silent> <M-}> :tabnext<cr>
nmap <silent> <M-{> :tabprevious<cr>

" Tab settings
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab

au FileType html setl softtabstop=2 shiftwidth=2 expandtab
au FileType javascript setl softtabstop=2 shiftwidth=2 expandtab
au FileType ruby setl softtabstop=2 shiftwidth=2 expandtab
au FileType vue setl softtabstop=2 shiftwidth=2 expandtab

" Automatic indentation
set autoindent

" Strip all trailing whitespace
nnoremap <leader>f :StripWhitespace<cr>

" NerdTree
nnoremap <leader>d :NERDTreeToggle<cr>
let NERDTreeIgnore = ['\.a$', '\.la$', '\.lo$', '\.o']

" No more write typos
cmap Wq wq

" Matching brackets settings
let g:AutoPairsMultilineClose=0
let g:AutoPairsMapSpace=0

" Column limits per file type
autocmd Filetype gitcommit setlocal textwidth=72
autocmd Filetype gitcommit setlocal colorcolumn=72

autocmd Filetype markdown setlocal textwidth=120
autocmd Filetype markdown setlocal colorcolumn=120

autocmd Filetype text setlocal textwidth=120
autocmd Filetype text setlocal colorcolumn=120

" Automatic spell checking
autocmd Filetype gitcommit setlocal spell
autocmd Filetype markdown setlocal spell
autocmd Filetype text setlocal spell

" FZF
if executable('fzf')
    nnoremap <C-p> :FZF<cr>
endif

" Ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" Alignment
let g:lion_squeeze_spaces = 1

" Markdown
let g:vim_markdown_folding_disabled = 1

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


" Completion
let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Local config
function! LoadLocal(path)
  let fullPath = expand(a:path)
  if filereadable(fullPath)
    execute 'source '.fullPath
  endif
endfunction

call LoadLocal("~/.vimrc.local")
call LoadLocal("$HOME\\_vimrc.local")
call LoadLocal(".vimrc.local")
