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
filetype plugin indent on

set shiftwidth=8
set tabstop=8
"set softtab=8
"set expandtab
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
" {{{ colorscheme
set background=dark
"colorscheme c9s
" }}} colorscheme

" {{{ indentation
"set autoindent
"set smartindent
"set cindent
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
"nmap cr=    $F=lcf;
"nmap cl=    $F=hc^
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
"inoremap "" ""<ESC>i
"inoremap '' ''<ESC>i
"inoremap <> <><ESC>i
"inoremap () ()<ESC>i
"inoremap [] []<ESC>i
"inoremap {} {}<ESC>i

if ! has('gui')
    highlight Comment ctermfg=gray ctermbg=darkblue
else
    highlight Normal guifg=white guibg=black
    set guifont=Droid\ Sans\ Mono\ 12
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

"imap jj <ESC>
"imap ,, -><C-X><C-O>

" missing below, add back
"autocmd BufReadPost * :DetectIndent
set cursorcolumn
set cursorline
"hi CursorLine   cterm=underline ctermbg=darkred ctermfg=white guibg=darkred guifg=white
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
"nnoremap <LEADER>cr :set cursorline! cursorcolumn!<CR>
"nnoremap <LEADER>cr :set cursorline!<CR>
"nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>
"nnoremap <silent> <Leader>v :execute 'match Search /\%'.virtcol('.').'v/'<CR>

" xmledit {{{
"let g:xml_syntax_folding=1
"au FileType xml setlocal foldmethod=syntax
" xmledit }}}

" undo-persistence {{{
"set undofile
"set undodir=/tmp/undos
" undo-persistence }}}

"The Control+R mechanism is very useful:-) (in insert mode)
"" the unnamed register, containing the text of the last delete or yank
"% the current file name
"# the alternate file name
"* the clipboard contents (X11: primary selection)
"+ the clipboard contents
"/ the last search pattern
": the last command-line
". the last inserted text
"- the last small (less than a line) delete
"=5*5 insert 25 into text (mini-calculator)
if has("cscope")
    "set csprg=/usr/bin/cscope
    "set csto=0
    "set cst
    "set nocsverb
    " add any database in current directory
    "if filereadable("cscope.out")
	"cs add cscope.out
	"" else add database pointed to by environment
    "elseif $CSCOPE_DB != ""
	"cs add $CSCOPE_DB
    "endif
    "set csverb
    set cscopetag
    "set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-
endif

"if has("autocmd")
   "autocmd BufReadPost *
      "\ if line("'\"") > 0 && line ("'\"") <= line("$") |
      "\   exe "normal g'\"" |
      "\ endif
"endif

" OmniCppComplete {{{
" configure tags - add additional tags here or comment out not-used ones
"set tags+=~/.vim/tags/cpp
"set tags+=tags
" build tags of your own project with Ctrl-F12
"map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview
" OmniCppComplete }}}

" Screen fix {{{
" http://blog.othree.net/log/2010/01/07/screen_vim_f1f4_map/
"if &term =~ '^screen'
"    set t_k1=^[[11~
"    set t_k2=^[[12~
"    set t_k3=^[[13~
"    set t_k4=^[[14~
"endif
" Screen fix }}}

" http://vim.wikia.com/wiki/Su-write
"command W w !sudo tee % > /dev/null
command W w !sudo tee % > /dev/null
"
"autocmd BufWritePost *.rst !rst2s5 % %<.html
"
"set cinoptions=l1

"map <C-L> viwy:vim /<C-R>"/ **/*.*<CR>
map <C-L> :vim /<C-R>=expand("<cword>")<CR>/ **/*.*<CR>

set grepprg=ack-grep\ --cpp\ --cc\ --perl\ --python\ --make\ --java\ --xml
nmap _g :grep <C-R>=expand("<cword>")<CR><CR>

