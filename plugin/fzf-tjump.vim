let s:command_name = get(g:, "fzf_command_prefix", "") . "Tjump"
execute "command! -nargs=? -complete=tag " . s:command_name . " call fzf_tjump#jump(<q-args>)"

execute "nnoremap <Plug>(fzf-tjump) :<C-u>"    . s:command_name . "<CR>"
execute 'xnoremap <Plug>(fzf-tjump) "zy:<C-u>' . s:command_name . ' <C-r>"<CR>'
