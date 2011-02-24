" Author: Andrew Chen <yongjhih@gmail.com>
" CC, Creative Commons
" {{{ For Win32
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
" }}} For Win32
syntax on
filetype on
filetype plugin on
filetype indent on

set shiftwidth=8
"set tabstop=2
set foldmethod=marker
" highlighted search results
set hlsearch
" Use incremental searching
set incsearch
" 自動偵測編碼
set fileencodings=utf-8,big5,gbk,cp936,iso-2022-jp,sjis,euc-jp,euc-kr,utf-bom,iso8859-1
"set encoding=utf-8
"set termencoding=utf-8
" 預設儲存編碼 
set fileencoding=utf-8
"set spell spelllang=en_us 
set number
"set expandtab
" {{{ colorscheme
set background=dark
"colorscheme c9s
" }}} colorscheme

" {{{ indentation
set autoindent
set smartindent
set cindent
" {{{ tab
" http://c9s.blogspot.com/2007/10/vim-tips.html
" 在確認過 normal mode 下的 <tab> 在 vim7 並無其他特別作用下採用
"nmap <tab> V>
"nmap <s-tab> V<
"xmap <tab> >gv
"xmap <s-tab> <gv
" }}} tab
" }}} indentation

" {{{ asignment
" http://c9s.blogspot.com/2007/09/vim-tip.html
nmap cr=    $F=lcf;
nmap cl=    $F=hc^
" }}} asignment

" {{{ Completion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
" {{{ Slippery Snippet
" http://c9s.blogspot.com/2007/06/vim-snippet.html
"set runtimepath+=~/.vim/textmateOnly
"set runtimepath+=~/.vim/textmateOnly/after
" http://c9s.blogspot.com/2007/09/slippery-snippet-tag.html
let g:snip_start_tag = "«"
let g:snip_end_tag = "»"
" }}} Slippery Snippet
" }}} Completion

" {{{ Doxygen
" http://www.vim.org/scripts/script.php?script_id=5
"autocmd BufNewFile,BufRead *.doxygen setfiletype doxygen
" }}} Doxygen

" indent line {{{
set list
set listchars=tab:\|\ ,eol:$,trail:_
" indent line }}}

" ydict {{{
map <C-K> viwy:!ydict <C-R>"<CR>
"set keywordprg=ydict
" ydict }}}

" grep {{{
" http://fourdollars.blogspot.com/2008/06/help-new-vimgrep.html
" grep }}}

" {{{ tab
map th :tabnext<CR>
map tl :tabprev<CR>
map tn :tabnew<CR>
map td :tabclose<CR>
" }}}

" {{{ xml-plugin, xmledit, xml.vim
let xml_use_xhtml = 1
"augroup filetypedetect
"  autocmd BufNewFile,BufRead *.svg setfiletype xml
"  autocmd BufNewFile,BufRead *.xhtml setfiletype xml
"  autocmd BufNewFile,BufRead *.html setfiletype xml
"  autocmd BufNewFile,BufRead *.php setfiletype xml
"augroup END

" }}}

" {{{ 2html
let html_use_css = 1
"let html_number_lines = 0
"let html_no_pre = 1
let use_xhtml = 1 
" }}}

" couple symbol
inoremap "" ""<ESC>i
inoremap '' ''<ESC>i
inoremap <> <><ESC>i
inoremap () ()<ESC>i
inoremap [] []<ESC>i
inoremap {} {}<ESC>i

if ! has('gui')
    highlight Comment ctermfg=gray ctermbg=darkblue
endif


set laststatus=2
set statusline=%4*%<\ %1*[%F]
set statusline+=%4*\ %5*[%{&encoding}, " encoding
set statusline+=%{&fileformat}%{\"\".((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\").\"\"}]%m
set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>
highlight User1 ctermfg=red
highlight User2 term=underline cterm=underline ctermfg=green
highlight User3 term=underline cterm=underline ctermfg=yellow
highlight User4 term=underline cterm=underline ctermfg=white
highlight User5 ctermfg=cyan
highlight User6 ctermfg=white 

"au Filetype html,xml,xsl source ~/.vim/scripts/closetag.vim 

imap jj <ESC>
imap ,, -><C-X><C-O>

" missing below, add back
autocmd BufReadPost * :DetectIndent
highlight Normal guifg=white guibg=black

