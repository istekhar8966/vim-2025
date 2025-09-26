" Define polyglot disabled languages BEFORE plugin loading
let g:polyglot_disabled = ['autoindent']

call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'morhetz/gruvbox'

" UI
Plug 'itchyny/lightline.vim'

" Language support
Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot'
" LSP & Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

" Editing enhancements
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()


" Highlight yanked text
au TextYankPost * silent! lua vim.highlight.on_yank {timeout=200}


"==============================================================================
" Basic Settings
"==============================================================================
set clipboard=unnamedplus
set mouse=a
syntax enable
filetype plugin indent on

" Performance optimizations
set lazyredraw
set ttyfast
set updatetime=300
set timeoutlen=500

" UI
set number relativenumber
set cursorline
set scrolloff=8
set sidescrolloff=8
set cmdheight=1
set signcolumn=yes
set laststatus=2

" Completion
set wildmenu
set wildmode=longest:full,full

" Wrapping
set wrap
set linebreak
set breakindent

"==============================================================================
" Indentation
"==============================================================================
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set smartindent

"==============================================================================
" File Handling
"==============================================================================
set noswapfile
set undofile
set undodir=~/.vim/undodir
set undolevels=10000
set undoreload=10000

"==============================================================================
" Search
"==============================================================================
set hlsearch
set incsearch
set ignorecase
set smartcase

" Clear search with Esc
nnoremap <silent> <Esc> :nohlsearch<CR>

"==============================================================================
" Colors & Theme
"==============================================================================
set termguicolors
set background=dark
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

"==============================================================================
" Plugin Configurations
"==============================================================================

" Lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype' ],
      \              [ 'cocstatus' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" rust.vim
let g:rustfmt_autosave = 1

"==============================================================================
" Coc.nvim Configuration (Optimized Tab Completion)
"==============================================================================
let g:coc_global_extensions = [
      \ 'coc-rust-analyzer',
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ 'coc-pyright',
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-css'
      \ ]

" Smart Tab completion - Fixed issue with starting from second option
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Better Enter key behavior for completion
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>"

" Coc mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"==============================================================================
" Key Mappings
"==============================================================================
let mapleader = " "

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" File explorer
nnoremap <C-n> :Lexplore<CR>

" Buffer management
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Save/quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

"==============================================================================
" Auto Commands
"==============================================================================
augroup vimrc
  autocmd!
  " Create undo directory
  autocmd VimEnter * if !isdirectory(&undodir) | call mkdir(&undodir, 'p') | endif

  " Source vimrc on save
  autocmd BufWritePost $MYVIMRC source $MYVIMRC

  " Remove trailing whitespace
  autocmd BufWritePre * %s/\s\+$//e

  " Filetype-specific settings
  autocmd FileType python setlocal shiftwidth=4 tabstop=4
  autocmd FileType javascript,typescript,html,css setlocal shiftwidth=2 tabstop=2
  autocmd FileType rust setlocal commentstring=//\ %s
augroup END

"==============================================================================
" Netrw Configuration (file explorer)
"==============================================================================
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25

"==============================================================================
" Additional Quality of Life Improvements
"==============================================================================

" Better split opening
set splitright
set splitbelow

" Persistent undo
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undodir
endif

" Terminal mode escape
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" Quickfix list navigation
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>
