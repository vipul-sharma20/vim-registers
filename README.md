vim-registers
=============

Vim plugin to fetch, select and search all the vim registers.

Installation
============

| Plugin Manager | Install with... |
| ------------- | ------------- |
| [Pathogen][1] | `git clone https://github.com/vipul-sharma20/vim-registers ~/.vim/bundle/vim-registers`<br/>Remember to run `:Helptags` to generate help tags |
| [NeoBundle][2] | `NeoBundle 'vipul-sharma20/vim-registers'` |
| [Vundle][3] | `Plugin 'vipul-sharma20/vim-registers'` |
| [Plug][4] | `Plug 'vipul-sharma20/vim-registers'` |
| [VAM][5] | `call vam#ActivateAddons([ 'vim-registers' ])` |
| [Dein][6] | `call dein#add('vipul-sharma20/vim-registers')` |
| [minpac][7] | `call minpac#add('vipul-sharma20/vim-registers')` |
| manual | copy all of the files into your `~/.vim` directory |

Configuration
=============

* This plugin mandatorily requires [fzf.vim](https://github.com/junegunn/fzf.vim). Please find the installation instruction for it [here](https://github.com/junegunn/fzf.vim#installation)

* Window layout for browser tab list result. Can be 'default' or 'floating'

  `let g:vim_registers_window_layout='floating'`

**Note: Floating window layout support is only possible in Neovim version >= 0.4.x.**

Documentation
=============

`:h vim-registers`

or check [here][9]

Commands
========

| Command              | List                                         |
| ---                  | ---                                          |
| `GetRegisters`       | Fetches all the registers                    |

I recommend you to check documentation for better understanding

Screenshots
===========

### Floating window view

![floating](https://i.imgur.com/ZUmIS9I.png)

### Default view

![default](https://i.imgur.com/UXVwXKd.png)

License
=======

MIT

[1]: https://github.com/tpope/vim-pathogen
[2]: https://github.com/Shougo/neobundle.vim
[3]: https://github.com/VundleVim/Vundle.vim
[4]: https://github.com/junegunn/vim-plug
[5]: https://github.com/MarcWeber/vim-addon-manager
[6]: https://github.com/Shougo/dein.vim
[7]: https://github.com/k-takata/minpac/
[8]: https://cricbuzz.com
[9]: doc/vim-registers.txt
