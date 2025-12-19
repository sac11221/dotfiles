syntax enable
set lazyredraw

nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
" ctrl + backspace deletes word in normal mode
inoremap <C-BS> <C-W>
" alternative for one above
inoremap <C-H> <C-W>

" Normal mode
nnoremap <ScrollWheelUp>   <C-Y><C-Y>
nnoremap <ScrollWheelDown> <C-E><C-E>
nnoremap <S-ScrollWheelUp>   <C-Y><C-Y><C-Y><C-Y>
nnoremap <S-ScrollWheelDown> <C-E><C-E><C-E><C-E>

" Visual mode (optional, scroll while selecting)
vnoremap <ScrollWheelUp>   <C-Y><C-Y>
vnoremap <ScrollWheelDown> <C-E><C-E>

nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <expr> <Up> v:count ? '<Up>' : 'g<Up>'
nnoremap <expr> <Down> v:count ? '<Down>' : 'g<Down>'

vnoremap <expr> j v:count ? 'j' : 'gj'
vnoremap <expr> k v:count ? 'k' : 'gk'
vnoremap <expr> <Up> v:count ? '<Up>' : 'g<Up>'
vnoremap <expr> <Down> v:count ? '<Down>' : 'g<Down>'

set mouse=a

function! SayHello(timer)
  set mouse=a
endfunction

function! ToggleMouse()
  set mouse=
  call timer_start(350, 'SayHello')
endfunction

nnoremap <C-ScrollWheelUp> :call ToggleMouse()<CR>
nnoremap <C-ScrollWheelDown> :call ToggleMouse()<CR>

" nnoremap <C-E> :call ToggleMouse()<CR>

set clipboard=unnamedplus
set number
set relativenumber
if has("termguicolors")
    set termguicolors
endif

set tabstop=4       " Number of spaces a tab counts for
set shiftwidth=4    " Number of spaces for each indentation level
set noexpandtab     " Don't convert tabs to spaces

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

autocmd BufWinEnter * normal! zz

autocmd InsertEnter * set cursorline norelativenumber
autocmd InsertLeave * set nocursorline relativenumber

filetype plugin indent on

set laststatus=2
set noshowmode

let maplocalleader = " "
nnoremap <localleader>w :w<CR>

" Visual mode pressing * or # searches for the current selection
xnoremap * y/\V<C-R>=escape(@", '/\')<CR><CR>
xnoremap # y?\V<C-R>=escape(@", '/\')<CR><CR>

" Automatic vim plug install

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'lervag/vimtex'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'

call plug#end()

" theme

let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_light = 'soft'

set background=dark
colorscheme gruvbox

" vimtex

let g:vimtex_view_method = 'zathura'
" set conceallevel=1
" let g:tex_conceal='abdmg'

" nerdtree

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
nnoremap <C-t> :NERDTreeToggle<CR>

" lightline

"     
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      "\ 'separator': { 'left': '', 'right': '' },
      \ 'separator': { 'left': '', 'right': '' },
	  \ 'subseparator': { 'left': '', 'right': '' },
      \ 'active': {
      \   'left': [ ['mode'], ['filename'], ['size'] ],
      \   'right': [ ['percentage'], ['linenumber'], ['lines'] ]
      \ },
      \ 'component': {
      \   'lines': '%L lines',
      \   'linenumber': '%l:%c',
      \   'percentage': '%p%%',
      \ },
      \ 'component_function': {
      \   'mymode': 'LightlineMyMode',
      \   'size': 'LightlineBufferSize',
      \   'filename': 'LightlineFilename'
      \ },
      \ }

function! LightlineBufferSize()
  let wc = wordcount()
  let size = wc['bytes']
  if size == 0
    return ''
  endif
  let units = ['B', 'KB', 'MB', 'GB']
  let i = 0
  while size >= 1024 && i < len(units) - 1
    let size /= 1024.0
    let i += 1
  endwhile
  return printf('%.1f%s', size, units[i])
endfunction
function! LightlineMyMode()
  return lightline#mode() . " "
endfunction
function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let readonly = &readonly ? ' [readonly]' : ''
  let modified = &modified ? ' [+]' : ''
  return filename . readonly . modified
endfunction
