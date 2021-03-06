Owl Cmder Tools
===============

Support tools for cmder 🦉


Prerequirements
---------------

* [Cmder](http://cmder.net/)
* Use `cmd.exe` (Not bash!)


Amazing powerline
-----------------

![Image](./docs/powerline.png)

### Prerequirements

* [AmrEldib/cmder-powerline-prompt](https://github.com/AmrEldib/cmder-powerline-prompt)

### Install

Copy `config/powerline_git.lua` to `%cmder_root%/config/`


Always show home directory as `~`
---------------------------------

### Install

Copy `config/powerline_prompt.lua` to `%cmder_root%/config/`


Useful commands
---------------

### Prerequirements

* Add `bin` to your Path environment variable
* Install some tools

| Command |       Required Tools        |                Advanced settings                |
| ------- | --------------------------- | ----------------------------------------------- |
| cdg     | [fzf], [gowl]               |                                                 |
| cdr     | [fzf], [fd]                 |                                                 |
| cdz     | [fzf]                       | Copy `config/cdz.lua` to `%cmder_root%/config/` |
| gc      | [fzf]                       |                                                 |
| gcr     | [fzf]                       |                                                 |
| r       | [fzf]                       |                                                 |
| vimd    | [fzf], [fd]                 |                                                 |
| vimf    | [fzf], [fd]                 |                                                 |
| iresize | [IrfanView] (64bit version) |                                                 |

[fd]: https://github.com/sharkdp/fd
[fzf]: https://github.com/junegunn/fzf
[gowl]: https://github.com/tadashi-aikawa/gowl
[IrfanView]: https://www.irfanview.net

### cdg

Move to git repositories with interactive fzf interface.

![Image](./docs/cdg.gif)


### cdr

Move to under the current directory with interactive fzf interface.

![Image](./docs/cdr.gif)


### cdz

Move to the directory visited recently with interactive fzf interface.

![Image](./docs/cdz.gif)


### gc

Checkout local branch with interactive fzf interface. (git)

![Image](./docs/gc.gif)


### gcr

Checkout remote branch with interactive fzf interface. (git)

### r

Search history with interactive fzf interface.

### vimd

Open a directory under the current ones by vim with interactive fzf interface.

### vimf

Open files under the current directory by vim with interactive fzf interface.

### iresize

Resize images.

When you have `sample1.png` and `sample2.png` which sizes are `w480*h360`, and if you execute the following commands... then

|          Command          |                               Result                               |
| ------------------------- | ------------------------------------------------------------------ |
| `iresize 240 sample1.png` | Change size of `sample1.png`to `w240*h180`                         |
| `iresize 240 *.png`       | Change size both of `sample1.png` and `sample2.png` to `w240*h180` |
| `iresize 1280 *.png`      | Nothing to change                                                  |
