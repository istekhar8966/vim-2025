" --- Plugins (Lazy Load) ---
call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/vim-lsp'                  " LSP client
Plug 'mattn/vim-lsp-settings'                 " Auto LSP config
Plug 'prabirshrestha/asyncomplete.vim'        " Async completion
Plug 'prabirshrestha/asyncomplete-lsp.vim'    " LSP completion source
Plug 'jiangmiao/auto-pairs'                   " Auto brackets
Plug 'tpope/vim-commentary'
call plug#end()

" --- Core Settings (Fast Load) ---
let mapleader = " "                          " Leader = Space
set mouse=a
set clipboard=unnamedplus                     " System clipboard
set encoding=utf-8                            " UTF-8 encoding
set hidden                                    " Unsaved buffer switching
set noswapfile                                " No swap files
set undofile                                  " Persistent undo
set undodir=~/.vim/undodir                    " Undo files location
if !isdirectory(&undodir) | call mkdir(&undodir, "p", 0700) | endif

" --- UI (Minimal Impact) ---
colorscheme pablo
syntax enable                                 " Syntax highlighting
set number relativenumber                     " Line numbers
set splitright splitbelow                     " Split behavior

" --- Editing (Performance Optimized) ---
filetype plugin indent on                     " Filetype detection
set tabstop=4 shiftwidth=4 expandtab          " 4-space tabs
set autoindent smartindent                    " Smart indentation

" --- Search ---
set hlsearch incsearch                        " Search highlighting
set ignorecase smartcase                      " Smart case search
nnoremap <Esc> :nohlsearch<CR>                " Clear search
nnoremap <leader>t :vert terminal<CR>             
" --- File Explorer ---
nnoremap <leader>e :Ex<CR>                    " Quick file access


" --- LSP & Completion (Grouped) ---
set completeopt=menu,menuone,noselect,preview
let g:asyncomplete_auto_popup = 1             " Auto-show completions
let g:asyncomplete_min_chars = 1              " Trigger after 1 char

" Tab Navigation (Helix-style)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"
imap <C-Space> <Plug>(asyncomplete_force_refresh)

" LSP Diagnostics (Minimal)
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_settings_auto_detect = 1           " Auto LSP setup

" LSP Keymaps (Essential Only)
function! s:on_lsp_buffer_enabled() abort
    nmap <buffer> gd <plug>(lsp-definition)           " Go to definition
    nmap <buffer> gr <plug>(lsp-references)           " Find references
    nmap <buffer> <leader>rn <plug>(lsp-rename)       " Rename
    nmap <buffer> K <plug>(lsp-hover)                  " Hover info
    nmap <buffer> <leader>ca <plug>(lsp-code-action)   " Code actions
    nmap <buffer> <leader>f <plug>(lsp-document-format) " Format
endfunction
augroup lsp_install | au! | autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled() | augroup END

" Auto-format on save (LSP)
"autocmd BufWritePre * if exists(':LspDocumentFormatSync') | execute 'LspDocumentFormatSync' | endif

" --- Statusline (Minimal) ---
set laststatus=2
set statusline=%f\ %=                               " Filename (left)
set statusline+=\ %l:%c\ %p%%\ %y                  " Line:col % filetype (right)
"hi StatusLine ctermbg=Black ctermfg=DarkGray          " Colors
