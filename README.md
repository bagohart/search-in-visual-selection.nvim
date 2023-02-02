# search-in-visual-selection.nvim
This Neovim plugin provides an expression-mapping that restricts search to the current visual selection.

## Why?
Vim/Neovim lets you search in the visual selection by adding the `%V` pattern element to the search pattern.
This has a little problem: as soon as you use visual mode again, the matches will disappear, which is annoying if your workflow relies on seeing the matches and using the `gn` text object to change them.

This plugin solves that by problem by instead using the `%l` and `%v` pattern elements to restrict the search to the current visual selection.

## Mappings
This plugin does not create any mappings. Add one yourself:
```lua
vim.keymap.set('x', 'g/', '<Plug>(search-in-visual-selection)')
```

## Usage
Use visual mode to choose the selection in which you want to search. Press `g/`. The `/` command-line will appear and be prepopulated with a very ugly looking string such as
```vim
\v%\>19l%\<22l%\>9v%\<32v
```
Note that this uses very magic mode and in particular this way of doing it enables incsearch.

## Requirements
Developed and tested on Neovim `0.8.1`.

## Bugs
- If the blockwise visual selection goes to the end of the line (using `$`), then this is not always recognized correctly, since Vim for some reason does not expose this information.
- Character-wise visual mode for more than one line is treated like visual line mode.

## Credits
I got the basic idea from [vis](https://github.com/vim-scripts/vis), but I wanted something in lua that supports `incsearch` and doesn't try to hide the pattern from me.
