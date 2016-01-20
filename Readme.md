# Macdown.vim

A simplified and flexible markdown preview for vim user on Mac.

Using applescript instead of a server to enhance the exprience of live preview.

## Features

* Works out of box, all dependencies are optional.
* Preview in Chrome with range and auto reload support.
* Auto close Chrome tab on buffer delete and vim exit.
* Async markdown parse.
* Tables, GFM enabled, code highlight and footnote enabled by default.

## Install

Take [vundle](https://github.com/VundleVim/Vundle.vim) as example:

    Plugin 'chemzqm/macdown.vim'

If you need async markdown parse, just install
[vimproc.vim](https: //github.com/Shougo/vimproc.vim)

    Plugin 'Shougo/vimproc.vim'

## Usage

To preview current markdown file, type:

    :Preview

Preview with range, eg:

    :1,10Preview

Or visual select a range, and use:

    :'<,'>Preview

To toggle auto preview for current file, type:

    :PreviewAuto

The corresponding chrome tab would be activated and refreshed on CursorHold and
BufWrite

## Configuration

By default `macdown.vim` using [markit](https://github.com/lepture/markit) for
markdown parsing, it's already copied inside this repository, but if need speed,
you can use [misaka](https://github.com/FSX/misaka) by set global variable:

    let g:macdown_marked_programme = 'misaka'

It's almost 4 times faster than markit, but you need to install python
dependencies:

    pip install houdini misaka pygments

`sudo` might be required.

You can also make your own parser, it's just create a excutable file inside
`macdown.vim/bin` which accept markdown content from stdin and output html to
stdout.

## TODO

* Scrollbind for vim and Chrome
