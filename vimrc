" Comma is the map leader
let mapleader = ","

" Install Plug if it isn't installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Define all of the plugins
call plug#begin('~/.vim/plugged')

" Nerd tree for file browsing
Plug 'scrooloose/nerdtree'

" Specific languages
Plug 'cespare/vim-toml'
Plug 'davidoc/taskpaper.vim'
Plug 'fatih/vim-go'
Plug 'keith/swift.vim'
Plug 'plasticboy/vim-markdown'
Plug 'rust-lang/rust.vim'
Plug 'uarun/vim-protobuf'
Plug 'vim-ruby/vim-ruby'

" Pretty status bars
Plug 'bling/vim-airline'

" Color schemes
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline-themes'

" Matching braces
Plug 'jiangmiao/auto-pairs'

" Better commenting
Plug 'scrooloose/nerdcommenter'

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
Plug 'junegunn/vim-easy-align'

" LSP
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh'
    \ }

" Previous plugins
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'elixir-lang/vim-elixir'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'majutsushi/tagbar'
"Plug 'sareyko/neat.vim'
"Plug 'scrooloose/syntastic'
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-sensible'
"Plug 'SirVer/ultisnips'
call plug#end()

" Color scheme
if has('gui_running')
    set background=light
    colorscheme solarized
    set guioptions=egmrt
else
    colorscheme default
endif

" Display hidden characters
"set list
"set listchars=tab:▸\ ,eol: 

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

" Tab settings
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab

au FileType html setl softtabstop=2 shiftwidth=2 expandtab
au FileType ruby setl softtabstop=2 shiftwidth=2 expandtab

" Automatic indentation
set autoindent

" Stip all trailing whitespace
nnoremap <leader>f :StripWhitespace<cr>

" Toggle NerdTree
nnoremap <leader>d :NERDTreeToggle<cr>

" No more write typos
cmap Wq wq

" Matching brackets settings
let g:AutoPairsMultilineClose=0
let g:AutoPairsMapSpace=0

" Column limits
set textwidth=110
set colorcolumn=110

nnoremap <leader>c :call ToggleColumnWidth()<cr>

let g:wide_column = 1

function! ToggleColumnWidth()
    if g:wide_column
        set textwidth=80
        set colorcolumn=80
        let g:wide_column = 0
    else
        set textwidth=110
        set colorcolumn=110
        let g:wide_column = 1
    endif
endfunction

" FZF
if executable('fzf')
    nnoremap <C-p> :FZF<cr>
endif

" Ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" LSP
let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<cr>

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
