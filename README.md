# vim-fzf-tjump

**vim-fzf-tjump** is a Vim plugin designed as an alternative to Vim’s built-in `:tjump` command. It leverages fzf to filter tag candidates interactively, allowing you to quickly jump to the desired tag with ease.

https://user-images.githubusercontent.com/694547/119252206-e4796d00-bbe5-11eb-8e3e-6a99765a33e0.mp4

## Features

- **Interactive Filtering**: Use fzf to filter tag candidates in real-time.
- **Code Preview**: Preview the code of the selected tag before jumping.
- **Efficient Navigation**: Automatically jump directly if only one matching tag is found.

## Functions

### `fzf_tjump#jump()`

```vim
" Call without any arguments
call fzf_tjump#jump()

" Call with a tag name
call fzf_tjump#jump(some_tag_name)

" Call with a tag name and an exit callback
call fzf_tjump#jump(some_tag_name, { "exit": { status -> execute(...) } })
```

Displays tag candidates that match the given tag name and jumps to the selected tag. If only one matching tag is found, it jumps directly.

- **Arguments**:
    - If no argument is provided or the given tag name is an empty string, the current word (`<cword>`) is used as the tag name.
    - You can specify an `exit` option for the exit callback. The callback is called when the fzf window is closed.
- **Preview**: Shows a code preview of the selected tag.

## Commands

### `:Tjump`

A wrapper for the `fzf_tjump#jump()` function.

- Respects the `g:fzf_command_prefix` setting. For example, the command name becomes `:FzfTjump` if you configure as following:

```vim
let g:fzf_command_prefix = "Fzf"
```

## Mappings

vim-fzf-tjump adds no default mappings. You can add your own mappings as needed.

### Mapping example

```vim
" Press `g]` in normal mode to call `fzf_tjump#jump`.
" Press `g]` in visual mode to call `fzf_tjump#jump` with the selected word.
map g] <Plug>(fzf-tjump)
```

## Configuration

For more information on available configuration options, execute:

```vim
:h vim-fzf-tjump-variables
```

## Installation

If you use [dein.vim](https://github.com/Shougo/dein.vim):

```vim
call dein#add("kg8m/vim-fzf-tjump")
```

## Requirements

- [fzf](https://github.com/junegunn/fzf) 0.22+
    - fzf 0.22 supports preview window option for setting the initial scroll offset
- [fzf.vim](https://github.com/junegunn/fzf.vim)
- Tag file with line numbers of tag definitions
    - You can probably create it by `ctags --fields=n` command
- Newer Vim
- Linux or Mac
