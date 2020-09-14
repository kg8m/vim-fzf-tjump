let s:is_called = v:false

function! fzf#tjump(tagname = "") abort  " {{{
  if !s:is_called
    let s:is_called = v:true
    call s:echo_error("`fzf#tjump` is deprecated. Use `fzf_tjump#jump` instead.")
  endif

  call fzf_tjump#jump(tagname)
endfunction  " }}}

function! s:echo_error(message) abort  " {{{
  echohl ErrorMsg
  echomsg a:message
  echohl None
endfunction  " }}}
