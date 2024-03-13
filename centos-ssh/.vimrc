nnoremap <space> <nop>
let mapleader=' '
inoremap fd <ESC>
vnoremap fd <ESC>
cnoremap fd <ESC>
map Q :bd<CR><C-l>
nmap fq :q<CR>
nmap <leader>q :bd!<CR><C-l>
nmap FQ :qa<CR>
noremap <leader>nl :nohl<CR>
map S :w<CR>
map R :source ~/.config/nvim/init.vim<CR>
map K 4k
map J 4j
map L $
map H 0
map cw ciw
inoremap kl <Esc>la
inoremap kj <Esc>i
inoremap jl <Esc>A;<Esc>
nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>
map ss ~<ESC>h
map sb gUl
map sm gul
map <leader>w <C-w>
map <leader>c :! 
syntax on
" 光标停留在上次编辑到地方
au BufReadPost * if line("'\"") > 0 | if line("'\"") <= line("$") | exe("norm '\"") | else |exe "norm $"| endif | endif     
set expandtab
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set number
set cursorline
set scrolloff=15
set termguicolors

