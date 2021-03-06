vim-fzf-tjump
==================================================

A Vim plugin aiming to be an alternative to Vim's built-in `:tjump`.

* Filter tag candidates and select a one by fzf
* Show selected tag candidate's code preview

https://user-images.githubusercontent.com/694547/119252206-e4796d00-bbe5-11eb-8e3e-6a99765a33e0.mp4


Functions
--------------------------------------------------

### `fzf_tjump#jump`

Show tag candidates matched with given tag name and go to selected tag. Go directly if matched tag is only 1.

Use current word (`<cword>`) as given tag name if no argument is given or given tag name is an empty string.

Show selected tag's code preview.


Commands
--------------------------------------------------

### `:Tjump`

A wrapper of `fzf_tjump#jump`.

`g:fzf_command_prefix` is respected. The command name is `:FzfTjump` if you configure as following:

```vim
let g:fzf_command_prefix = "Fzf"
```


Mappings
--------------------------------------------------

vim-fzf-tjump adds no mappings. You can add mappings.


### Mapping example

```vim
" Press `g]` in normal mode to call `fzf_tjump#jump`.
" Press `g]` in visual mode to call `fzf_tjump#jump` with selected word.
map g] <Plug>(fzf-tjump)
```


Configurations
--------------------------------------------------

Let's execute as following for more information:

```vim
:h vim-fzf-tjump-variables
```


Installation
--------------------------------------------------

If you use [dein.vim](https://github.com/Shougo/dein.vim):

```vim
call dein#add("kg8m/vim-fzf-tjump")
```


Requirements
--------------------------------------------------

* [fzf](https://github.com/junegunn/fzf) 0.22+
  * fzf 0.22 supports preview window option for setting the initial scroll offset
* [fzf.vim](https://github.com/junegunn/fzf.vim)
* Tag file with line numbers of tag definitions
  * You can probably create it by `ctags --fields=n` command
* Newer Vim
* Linux or Mac
