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
Plug 'rust-lang/rust.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'uarun/vim-protobuf'
Plug 'vim-ruby/vim-ruby'

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
if has("win32")
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'powershell --executionpolicy bypass -File install.ps1'
        \ }
else
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh'
        \ }
endif

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Snippets
Plug 'SirVer/ultisnips'

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
au FileType ruby setl softtabstop=2 shiftwidth=2 expandtab

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

" LSP
set hidden

let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<cr>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<cr>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<cr>

" Deoplete
let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
    \ 'auto_complete_delay': 200,
    \ 'max_list': 10,
    \ })

" Markdown
let g:vim_markdown_folding_disabled = 1

" Snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-tab>"

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
