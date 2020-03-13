vim-fzf-tjump
==================================================

A Vim plugin to be an alternative to Vim's builtin `:tjump`.

  * Can filter and select tag candidates by fzf
  * Can show selected tag candidate's code preview


Functions
--------------------------------------------------

### `fzf#tjump`

Show taglist matched with given word and go to selected tag. Go directly if matched tag is only 1.

Use current word (`<cword>`) as given word if no argument is given or given word is an empty string.

Show selected tag's code preview.


Commands
--------------------------------------------------

### `:Tjump`

A wrapper of `fzf#tjump`.

`g:fzf_command_prefix` is respected. The command name is `:FzfTjump` if you configure as following:

```vim
let g:fzf_command_prefix = "Fzf"
```


Mappings
--------------------------------------------------

vim-fzf-tjump adds no mappings. You can add mappings.


### Mapping example

```vim
" Press `g]` in normal mode to call `fzf#tjump`.
" Press `g]` in visual mode to call `fzf#tjump` with selected word.
map g] <Plug>(fzf-tjump)
```


Installation
--------------------------------------------------

If you use [dein.vim](https://github.com/Shougo/dein.vim):

```vim
call dein#add("kg8m/vim-fzf-tjump")
```


Requirements
--------------------------------------------------

  * [fzf.vim](https://github.com/junegunn/fzf.vim)
  * Linux or Mac
