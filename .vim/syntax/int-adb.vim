if exists('b:interactive') && b:interactive.args[1] ==# 'logcat'
  let s:index = index(b:interactive.args, '-v')
  if 0 <= s:index && s:index + 1 < len(b:interactive.args)
    let b:logcat_format = b:interactive.args[s:index + 1]
  endif
  unlet s:index
  runtime syntax/logcat.vim
endif
