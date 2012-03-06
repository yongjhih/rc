" Language: logcat (Log of Android)
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

autocmd BufReadPost,BufNewFile *.logcat setlocal filetype=logcat
autocmd BufReadPost,BufNewFile * if getline(1) =~# '^-\{9} beginning of.*$'
\                              |   setfiletype logcat
\                              | endif
