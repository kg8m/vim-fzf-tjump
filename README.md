vim-fzf-tjump
==================================================

A Vim plugin aiming to be an alternative to Vim's built-in `:tjump`.

* Filter tag candidates and select a one by fzf
* Show selected tag candidate's code preview

![Kapture 2020-03-13 at 23 55 53](https://user-images.githubusercontent.com/694547/76632254-43753800-6586-11ea-8794-bb992bc53bed.gif)


Functions
--------------------------------------------------

### `fzf#tjump`

Show tag candidates matched with given tag name and go to selected tag. Go directly if matched tag is only 1.

Use current word (`<cword>`) as given tag name if no argument is given or given tag name is an empty string.

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

Note: Specifying option `"merged": 0` may help you if you get some troubles using dein.vim.


Requirements
--------------------------------------------------

* [fzf](https://github.com/junegunn/fzf) 0.22+
  * fzf 0.22 supports preview window option for setting the initial scroll offset
* [fzf.vim](https://github.com/junegunn/fzf.vim)
* Tag file with line numbers of tag definitions
  * You can probably create it by `ctags --fields=n` command
* Newer Vim
* Linux or Mac
