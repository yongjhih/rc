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

"set shiftwidth=8
set shiftwidth=4
set expandtab
"set tabstop=8
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
"scriptencoding utf-8
"set termencoding=utf-8
" 預設儲存編碼
set fileencoding=utf-8
"set spell spelllang=en_us
set number
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

" fy {{{
map <C-K> viwy:!fy <C-R>"<CR>
"set keywordprg=fy
" fy }}}
"
"map <C-L> viw:s/_\(\w\)/\U\1/\%V
map <C-,> viw:s/_\(\w\)/\U\1/g<CR>
map <C-.> viw:s/\(\u\w\)/_\L\1/g<CR>

" grep {{{
" http://fourdollars.blogspot.com/2008/06/help-new-vimgrep.html
" grep }}}

" {{{ tab
"map th :tabnext<CR>
"map tl :tabprev<CR>
"map tn :tabnew<CR>
"map td :tabclose<CR>
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
    "highlight Comment ctermfg=gray ctermbg=darkblue
else
    "highlight Normal guifg=white guibg=black
    "set guifont=Droid\ Sans\ Mono\ 12
    "set guifont=Monaco\ for\ Powerline:h10
    set guifont=Monaco\ for\ Powerline\ 10
endif
"set guifont=Monaco\ for\ Powerline:h12

"" set term=bold
"" set gui=bold
"let g:Powerline_theme="skwp"
"let g:Powerline_colorscheme="skwp"
let g:Powerline_symbols = 'fancy'
"colorscheme solarized
"set t_Co=256
" {{{ statusline
set laststatus=2
"set statusline=%4*%<\ %1*[%F]
"set statusline+=%4*\ %5*[%{&encoding}, " encoding
"set statusline+=%{&fileformat}%{\"\".((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\").\"\"}]%m
"set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>
"highlight User1 ctermfg=red
"highlight User2 term=underline cterm=underline ctermfg=green
"highlight User3 term=underline cterm=underline ctermfg=yellow
"highlight User4 term=underline cterm=underline ctermfg=white
"highlight User5 ctermfg=cyan
"highlight User6 ctermfg=white
" }}}

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
"if has("cscope")
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
    "set cscopetag
    "set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-
"endif

" make sure ~/.viminfo writable
if has("autocmd")
   autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal g'\"" |
      \ endif
endif

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
map <C-j> :vim /<C-R>=expand("<cword>")<CR>/ **/*.*<CR>

set grepprg=ack-grep\ --cpp\ --cc\ --perl\ --python\ --make\ --java\ --xml
nmap _g :grep <C-R>=expand("<cword>")<CR><CR>

set hidden

" Vundle {{{
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" My Bundles here:
"
" original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"Plugin 'tpope/vim-rails.git'
" vim-scripts repos
Plugin 'L9'
"Plugin 'FuzzyFinder'
"Plugin 'taglist.vim'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/syntastic'
"Plugin 'VisIncr'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'Align'
"Plugin 'YankRing.vim'

" snipmate
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
"Plugin 'honza/snipmate-snippets'
"Plugin 'garbas/vim-snipmate'
"Plugin 'othree/vim-autocomplpop'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'honza/vim-snippets'
"Plugin 'SirVer/ultisnips'
Plugin 'sjl/gundo.vim'
"Plugin 'snipmate-snippets'
"Plugin 'Lokaltog/vim-powerline'
"Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'} "/home/andrew/.local/lib/python3.4/site-packages/powerline/bindings/vim/
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
"Plugin 'python.vim'
"Plugin 'pyflakes.vim'
"Plugin 'kchmck/vim-coffee-script'
Plugin 'flazz/vim-colorschemes'
"Plugin 'ap/vim-css-color'
"Plugin 'matchit.zip'
"Plugin 'cscope.vim'
"Plugin 'cscope_macros.vim'
"Plugin 'cscope_map'
"Plugin 'autoload_cscope.vim'
"Plugin 'autotags'
"Plugin 'nelson/cscope_maps'
"Plugin 'cscope-quickfix'
"Plugin 'log.vim'
"Plugin 'naseer/logcat'
Plugin 'kelwin/vim-smali'
Plugin 'junegunn/vim-easy-align'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'tfnico/vim-gradle'
Plugin 'sealemar/vtl'
"Plugin 'Yggdroot/indentLine'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'keith/swift.vim'

" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" ...

" All of your Plugins must be added before the following line, required
call vundle#end()

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
" }}}
"
let g:vundle_default_git_proto = 'https'
" {{{ colorscheme
"colorscheme devbox-dark-256
" light background selection
colorscheme holokai
"colorscheme molokai-dark-yu
"set background=dark
"colorscheme c9s
" }}} colorscheme

set fileformats+=dos
let g:acp_behaviorSnipmateLength = 1
"imap <C-J> <Plug>snipMateNextOrTrigger
"smap <C-J> <Plug>snipMateNextOrTrigger
"set clipboard=unnamedplus
vnoremap <silent> <Enter> :EasyAlign<cr>

function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>

" Buffergator {{{
let g:buffergator_suppress_keymaps = 1
let g:buffergator_autodismiss_on_select = 0
"let g:buffergator_autoupdate = 1
nnoremap <Leader>b :BuffergatorToggle<CR>
" }}}

set wildmenu
set wildmode=list:longest

"cnoremap tabe e

" Reselect visual block after indent/outdent {{{
"vnoremap < <gv
"vnoremap > >gv
" }}}

" Make Y behave like other capitals {{{
map Y y$
" }}}

" Improve up/down movement on wrapped lines {{{
nnoremap j gj
nnoremap k gk
" }}}

" Toggling search highlights {{{
noremap <silent><Leader>/ :nohls<CR>
" }}}

" Tagbar configs {{{
let g:tagbar_left = 1
let g:tagbar_width = 30
noremap <Leader>t :TagbarToggle<CR>
" }}}

" Toggle invisibles (list) {{{
noremap <Leader>i :set list!<CR>
" }}}

" Paste mode toggling configs {{{
" Toggling paste mode outside insert mode "
map <Leader>v :set invpaste<CR>:set paste?<CR>
" Toggling paste mode inside insert mode "
set pastetoggle=<Leader>v
" Turning off paste mode when leaving insert
autocmd InsertLeave * set nopaste
" }}}

" NERD Commenter configs {{{
" let NERDSpaceDelims=1
" }}}

" UltiSnips configs {{{
"let g:UltiSnipsExpandTrigger="<c-j>"
" }}}

" Gundo configs {{{
nnoremap U :GundoToggle<CR>
" }}}

" CtrlP configs {{{
" Press F5 in CtrlP to clear the cache
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_max_files = 0
let g:buffergator_viewport_split_policy = 'R'
" }}}

" syntastic {{{
let g:syntastic_java_checkers=['checkstyle']
" }}}

nnoremap gt :bn<CR>
nnoremap gT :bp<CR>
"nnoremap [b :bp<CR>
"nnoremap ]b :bn<CR>

" airline powerline
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline_powerline_fonts = 1

" indentLine {{{
" | ¦ ┆ │
" default
"let g:indentLine_char = '¦'
"let g:indentLine_char = '︙'
" 3 v-dash
"let g:indentLine_char = '┆'
"let g:indentLine_char = '|'
"let g:indentLine_char = '│'
" }}}

set ttimeout
set ttimeoutlen=0
set matchtime=0

" vim-jsx {{{
Plugin 'mxw/vim-jsx'
let g:jsx_ext_required = 0
" }}}
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

" You may also want luarocks:
"   brew install luarocks
" ==> perl
" By default non-brewed cpan modules are installed to the Cellar. If you wish
" for your modules to persist across updates we recommend using `local::lib`.
" 
" You can set that up like this:
"   PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
"   echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"' >> ~/.bash_profile
" ==> ruby
" By default, binaries installed by gem will be placed into:
"   /usr/local/lib/ruby/gems/2.6.0/bin
" 
" You may want to add this to your PATH.
" 
" ruby is keg-only, which means it was not symlinked into /usr/local,
" because macOS already provides this software and installing another version in
" parallel can cause all kinds of trouble.
" 
" If you need to have ruby first in your PATH run:
"   echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.bash_profile
" 
" For compilers to find ruby you may need to set:
"   export LDFLAGS="-L/usr/local/opt/ruby/lib"
"   export CPPFLAGS="-I/usr/local/opt/ruby/include"
" 
" -bash: __git_ps1: command not found
