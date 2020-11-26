let s:script_path = expand("<sfile>")
let s:bin_paths   = {}

function! fzf_tjump#jump(tagname = "") abort  " {{{
  let tagname = empty(a:tagname) ? expand("<cword>") : a:tagname
  let options = #{
    \   source:  s:taglist(tagname),
    \   sink:    function("s:handler"),
    \   options: [
    \     "--select-1",
    \     "--no-multi",
    \     "--prompt", "Tjump> ",
    \     "--delimiter", "[:\t]",
    \     "--preview-window", s:get_preview_options(),
    \     "--preview", s:command_to_preview(),
    \   ] + get(g:, "fzf_tjump_command_options", []),
    \ }

  call fzf#run(fzf#wrap("tjump", options))
endfunction  " }}}

function! s:get_preview_options() abort  " {{{
  if !has_key(s:, "preview_options")
    call system("echo | fzf --select-1 --preview-window 'nohidden:+1-/2'")

    if v:shell_error ==# 0
      let s:preview_options = "right:50%:wrap:nohidden:+{3}-/2"
    else
      let s:preview_options = "right:50%:wrap:+{3}-15"
    endif
  endif

  return s:preview_options
endfunction  " }}}

function! s:taglist(tagname) abort  " {{{
  return map(
       \   taglist("^" . a:tagname . "$", expand("%")),
       \   { _, tag -> join([tag.name, fnamemodify(tag.filename, ":~:.") . ":" . get(tag, "line"), tag.cmd], "\t") }
       \ )
endfunction  " }}}

function! s:handler(item) abort  " {{{
  let parts    = split(a:item, "\t")
  let filepath = split(parts[1], ":")[0]
  let excmd    = join(parts[2:-1], "")[:-2]

  execute "edit " . filepath

  try
    silent execute excmd
  catch
    let line = split(parts[1], ":")[1]
    silent execute line
  endtry
endfunction  " }}}

function! s:command_to_preview() abort  " {{{
  " `{2}`: filepath, e.g., `app/models/user.rb`
  " `{3}`: line number
  " Don't use double quotation marks like `bash -c "..."` because `$` can be contained in command and cause errors
  return "bash -c '" . s:path_to_preview_bin() . " " .s:escape_placeholder("{2}") . ":{3}'"
endfunction  " }}}

function! s:escape_placeholder(placeholder) abort  " {{{
  " Escape single-quoted placeholders, e.g., `'{}'` to `'\''{}'\''`
  " Note: Non-escaped single quotation marks are inserted by fzf
  return "'\\'" . a:placeholder . "\\''"
endfunction  " }}}

function! s:path_to_preview_bin() abort  " {{{
  if !has_key(s:bin_paths, "preview")
    if has_key(g:, "fzf_tjump_path_to_preview_bin")
      let s:bin_paths.preview = g:fzf_tjump_path_to_preview_bin
    else
      for path in split(&runtimepath, ",")
        if filereadable(path . "/plugin/fzf.vim") && filereadable(path . "/bin/preview.sh")
          let s:bin_paths.preview = path . "/bin/preview.sh"
          break
        endif
      endfor
    endif
  endif

  if has_key(s:bin_paths, "preview") && filereadable(s:bin_paths.preview)
    return s:bin_paths.preview
  else
    throw "Can't detect the path to fzf.vim's preview.sh. Check if fzf.vim is in `&runtimepath` or Specify `g:fzf_tjump_path_to_preview_bin`."
  endif
endfunction  " }}}
