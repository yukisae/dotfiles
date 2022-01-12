" for vim-plug {{{
" We need following command before use this rc.
" curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
let s:vim_home = stdpath('config')

let mapleader = ","

call plug#begin(expand(s:vim_home.'/plugged'))
Plug 'shougo/unite.vim'
Plug 'shougo/unite-outline'

Plug 'itchyny/lightline.vim'

Plug 'shougo/tabpagebuffer.vim'
Plug 'kana/vim-submode'

Plug 'shougo/vimfiler'

Plug 'elzr/vim-json'

call plug#end()
"}}}


" Visual preferences {{{
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

colorscheme darkblue

syntax on
set title

set number
set list
set listchars=tab:»\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set showmatch

set wildmenu
"}}}

" Search Preferences {{{
set ignorecase
set smartcase

nmap <C-L> :nohl<CR>
"}}}

" Edit preferences {{{
set shiftwidth=4
set tabstop=4
set smartindent

set mouse=a
" }}}

set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp
set fileformats=unix,dos,mac

let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ }

nnoremap <leader>uo : <C-u>Unite -no-quit -vertical -winwidth=30 outline<CR>


" Split {{{
nnoremap [Split] <Nop>
nmap s [Split]
nnoremap [Split]j <C-w>j
nnoremap [Split]k <C-w>k
nnoremap [Split]l <C-w>l
nnoremap [Split]h <C-w>h
nnoremap [Split]J <C-w>J
nnoremap [Split]K <C-w>K
nnoremap [Split]L <C-w>L
nnoremap [Split]H <C-w>H
nnoremap [Split]n gt
nnoremap [Split]p gT
nnoremap [Split]r <C-w>r
nnoremap [Split]= <C-w>=
nnoremap [Split]w <C-w>w
nnoremap [Split]o <C-w>_<C-w>|
nnoremap [Split]O <C-w>=
nnoremap [Split]N :<C-u>bn<CR>
nnoremap [Split]P :<C-u>bp<CR>
nnoremap [Split]t :<C-u>tabnew<CR>
nnoremap [Split]T :<C-u>Unite tab<CR>
nnoremap [Split]s :<C-u>sp<CR>
nnoremap [Split]v :<C-u>vs<CR>
nnoremap [Split]q :<C-u>q<CR>
nnoremap [Split]Q :<C-u>bd<CR>
nnoremap [Split]b :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap [Split]B :<C-u>Unite buffer -buffer-name=file<CR>

call submode#enter_with('bufmove', 'n', '', '[Split]>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', '[Split]<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', '[Split]+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', '[Split]-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
"}}}


" VimFilerTree {{{
nnoremap <F2> :VimFilerTree<CR>
command! VimFilerTree call VimFilerTree(<f-args>)
function VimFilerTree(...)
    let l:h = expand(a:0 > 0 ? a:1 : '%:p:h')
    let l:path = isdirectory(l:h) ? l:h : ''
    exec ':VimFiler -buffer-name=explorer -split -simple -winwidth=25 -toggle -no-quit ' . l:path
    wincmd t
    setl winfixwidth
endfunction
autocmd! FileType vimfiler call s:my_vimfiler_settings()
function! s:my_vimfiler_settings()
    nmap     <buffer><expr><CR> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
    nnoremap <buffer>s          :call vimfiler#mappings#do_action(b:vimfiler, 'my_split')<CR>
    nnoremap <buffer>v          :call vimfiler#mappings#do_action(b:vimfiler, 'my_vsplit')<CR>
endfunction

let s:my_action = {'is_selectable' : 1}
function! s:my_action.func(candidates)
    wincmd p
    exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', s:my_action)

let s:my_action = {'is_selectable' : 1}
function! s:my_action.func(candidates)
    wincmd p
    exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', s:my_action)
" }}}

" -------------------
" Json Options {{{1

let g:vim_json_syntax_conceal = 0


" vim:set foldmethod=marker:
" vim:foldcolumn=3:
" vim:foldlevel=0: