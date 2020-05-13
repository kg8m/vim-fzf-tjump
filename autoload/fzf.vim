let s:script_path = expand("<sfile>")
let s:bin_paths   = {}

function! fzf#tjump(tagname = "") abort  " {{{
  let tagname = empty(a:tagname) ? expand("<cword>") : a:tagname
  let options = #{
    \   source:  s:taglist(tagname),
    \   sink:    function("s:handler"),
    \   options: ["--select-1", "--no-multi", "--prompt", "Tjump> ", "--preview-window", "right:wrap", "--preview", s:command_to_preview()],
    \ }

  call fzf#run(fzf#wrap("tjump", options))
endfunction  " }}}

function! s:taglist(tagname) abort  " {{{
  return map(
       \   taglist("^" . a:tagname . "$", expand("%")),
       \   { _, tag -> join([tag.name, fnamemodify(tag.filename, ":~:."), tag.cmd, "line:" . get(tag, "line")], "\t") }
       \ )
endfunction  " }}}

function! s:handler(item) abort  " {{{
  let parts    = split(a:item, "\t")
  let filepath = parts[1]
  let excmd    = join(parts[2:-2], "")[:-2]

  execute "edit " . filepath

  try
    silent execute excmd
  catch
    let line = matchstr(parts[-1], '\v^line:\zs\d+\ze$')
    silent execute line
  endtry
endfunction  " }}}

function! s:command_to_preview() abort  " {{{
  " `{2}`: filepath, e.g., `app/models/user.rb`
  return "bash -c \"" . s:path_to_preview_bin() . " {2}:\\\"\\$( " . s:command_to_detect_tag_line() . " )\\\"\""
endfunction  " }}}

function! s:command_to_detect_tag_line() abort  " {{{
  " `{2}`: filepath, e.g., `app/models/user.rb`
  " `{}`:  whole tag line, e.g., `User\tapp/models/user.rb\t/^class User < ApplicationRecord$/\tline:1`
  return s:path_to_detect_tag_line_bin() . " {2} {}"
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

function! s:path_to_detect_tag_line_bin() abort  " {{{
  if !has_key(s:bin_paths, "detect_tag_line")
    let s:bin_paths.detect_tag_line = fnamemodify(s:script_path, ":h:h") . "/bin/detect_tag_line"
  endif

  return s:bin_paths.detect_tag_line
endfunction  " }}}
