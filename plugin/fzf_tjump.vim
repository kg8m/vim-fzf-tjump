let s:command_name = get(g:, "fzf_command_prefix", "") . "Tjump"
execute "command! -nargs=? -complete=tag " . s:command_name . " call fzf#tjump(<q-args>)"

execute "nnoremap <Plug>(fzf-tjump) :<C-u>" . s:command_name . "<Cr>"
execute 'vnoremap <Plug>(fzf-tjump) "gy:<C-u>' . s:command_name .  ' <C-r>"<Cr>'
