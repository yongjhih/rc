" Vim syntax file
" Language: logcat (Log of Android)
" Version: 0.1.2
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

let s:levels = [
\   'Verbose',
\   'Debug',
\   'Info',
\   'Warning',
\   'Error',
\   'Fatal',
\ ]

function! s:define_color()
  if &background is 'dark'
    highlight default logcatLevelVerbose guifg=Gray   ctermfg=Gray
    highlight default logcatLevelDebug   guifg=Cyan   ctermfg=Cyan
    highlight default logcatLevelInfo    guifg=Green  ctermfg=Green
    highlight default logcatLevelWarning guifg=Yellow ctermfg=Yellow
    highlight default logcatLevelError   guifg=Red    ctermfg=Red
  else
    highlight default logcatLevelVerbose guifg=DarkGray   ctermfg=DarkGray
    highlight default logcatLevelDebug   guifg=DarkCyan   ctermfg=DarkCyan
    highlight default logcatLevelInfo    guifg=DarkGreen  ctermfg=DarkGreen
    highlight default logcatLevelWarning guifg=DarkYellow ctermfg=DarkYellow
    highlight default logcatLevelError   guifg=DarkRed    ctermfg=DarkRed
  endif
  highlight default logcatLevelFatal guifg=White ctermfg=White guibg=Red ctermbg=Red
endfunction

function! s:define_level(pattern)
  for level in s:levels
    execute printf('syntax match logcatLevel%s @%s@ contains=@logcatItem',
    \              level, printf(a:pattern, level[0]))
  endfor
endfunction

function! s:detect_format()
  if exists('b:logcat_format')
    return b:logcat_format
  endif
  let line = getline(1)
  if line =~# '^--------- beginning of'
    let line = getline(2)
  endif
  if line =~# '^\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d\s\+\d\+\s\+\d\+'
    return 'threadtime'
  elseif line =~# '^\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d'
    return 'time'
  elseif line =~# '^\[.*\]$'
    return 'long'
  elseif line =~# '^[VDIWEF]([0-9 ]\{5})'
    return 'process'
  elseif line =~# '^[VDIWEF]([0-9 ]\{5}:0x\x\+)'
    return 'thread'
  elseif line =~# '^[VDIWEF]/[^(]\+([0-9 ]\{5}):'
    return 'brief'
  elseif line =~# '^[VDIWEF]/[^:]\+:'
    return 'tag'
  elseif line =~# '\S'
    return 'raw'
  endif
  return 'brief'
endfunction

let b:logcat_format = s:detect_format()


syntax match logcatTime /\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d/ contained skipwhite nextgroup=@logcatTimeNext
syntax match logcatProcess /([0-9 ]\{5}\%(:0x\x\+\)\?)/ contained

syntax cluster logcatItem add=logcatTag

if b:logcat_format ==# 'brief'
  call s:define_level('^%s/.*$')
  syntax match logcatTag '[VDIWEF]/[^:(]\+('ms=s+2,me=e-1 contained nextgroup=logcatProcess
elseif b:logcat_format ==# 'process'
  call s:define_level('^%s.*$')
  syntax cluster logcatItem add=logcatLevelLetter
  syntax match logcatTag '  (\S*)$'ms=s+2 contained
  syntax match logcatLevelLetter /^[VDIWEF]/ contained nextgroup=logcatProcess transparent
elseif b:logcat_format ==# 'tag'
  call s:define_level('^%s/.*$')
  syntax match logcatTag '^[VDIWEF]/[^:]\+:'ms=s+2,me=e-1 contained
elseif b:logcat_format ==# 'thread'
  call s:define_level('^%s.*$')
  syntax cluster logcatItem add=logcatLevelLetter
  syntax match logcatLevelLetter /^[VDIWEF]/ contained nextgroup=logcatProcess transparent
elseif b:logcat_format ==# 'raw'
  " Can not highlight...
elseif b:logcat_format ==# 'time'
  call s:define_level('^\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d %s/.*$')
  syntax cluster logcatItem add=logcatLineHead
  syntax match logcatLineHead /^/ contained nextgroup=logcatTime
  syntax match logcatTag '[VDIWEF]/[^:]\+:'ms=s+2,me=e-1 contained contains=logcatProcess
elseif b:logcat_format ==# 'threadtime'
  call s:define_level('^\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d\s\+\d\+\s\+\d\+ %s .*$')
  syntax cluster logcatItem add=logcatLineHead
  syntax cluster logcatTimeNext add=logcatProcess
  syntax match logcatLineHead /^/ contained nextgroup=logcatTime
  syntax match logcatProcess /\s\+\d\+\s\+\d\+/ contained skipwhite nextgroup=logcatTag
  syntax match logcatTag '\<[VDIWEF] [^:]\+:'ms=s+2,me=e-1 contained
elseif b:logcat_format ==# 'long'
  call s:define_level('^\[.* %s/.*\]\n\_.\{-}\n\n')
  syntax cluster logcatItem add=logcatMetaLine
  syntax match logcatMetaLine /^\[.*\]$/ contained contains=logcatTime,logcatProcess,logcatTag transparent
  syntax match logcatProcess /[0-9 ]\{5}:0x\x\+/ contained
  syntax match logcatTag '[VDIWEF]/[^:]\+ \]$'ms=s+2,me=e-2 contained
  syntax sync minlines=2
endif

syntax match logcatBeginningOf '^--------- beginning of.*$'

if exists('b:logcat_no_metainfo') ? b:logcat_no_metainfo :
\  exists('g:logcat_no_metainfo') && g:logcat_no_metainfo
  syntax clear logcatTag logcatProcess logcatTime
endif


call s:define_color()
augroup syntax-logcat
  autocmd! ColorScheme * call s:define_color()
augroup END

highlight default link logcatTag Tag
highlight default link logcatTime Label
highlight default link logcatProcess Number
highlight default link logcatBeginningOf Delimiter


let b:current_syntax = 'logcat'

let &cpo = s:cpo_save
unlet s:cpo_save

finish

python <<EOP  " to highlight
"""
Samples of output:

brief
V/LockPatternKeyguardView( 2710): *** dispatchDraw() time: 334858746

process
V( 2710) *** dispatchDraw() time: 334858746  (LockPatternKeyguardView)

tag
V/LockPatternKeyguardView: *** dispatchDraw() time: 334858746

thread
V( 2710:0xad2) *** dispatchDraw() time: 334858746

raw
*** dispatchDraw() time: 334858746

time
09-01 17:14:12.260 V/LockPatternKeyguardView( 2710): *** dispatchDraw() time: 334858746

threadtime
09-01 17:14:12.260  2710  2770 V LockPatternKeyguardView: *** dispatchDraw() time: 334858746

long
[ 09-01 17:14:12.260  2710:0xad2 V/LockPatternKeyguardView ]
*** dispatchDraw() time: 334858746

