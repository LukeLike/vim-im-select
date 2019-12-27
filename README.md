# Vim IM Select

## Introduction

The functionality of this plugin is to automatically switch the input method to
english layout when entering normal mode, and restore to original layout when
leaving normal mode.

The implementation is based on the commandline utility [im-select][].

## Activation
As the use case of this plugin is very limited, the plugin is disabled by
default. To enable the plugin, do the following steps:

1. Install [im-select][] following its instruction.
2. `let g:im_select_enable = 1`

**Note**: you **do not** need this plugin when you are using GVim or MacVim
(check the `imdisable` option)

## Configuration

The configuration options are set according to [im-select][]

* `g:im_select_enable`: whether this plugin is enabled
* `g:im_select_default_im`: the default layout of input method
* `g:im_select_obtain_im_cmd`: the command to obtain the current layout of
  input method
* `g:im_select_switch_im_cmd`: the command to switch the layout of input
  method, and use `{im}` as a placeholder for the target layout
* `g:im_select_timeout`: if the command `im-select` takes longer than
  `g:im_select_timeout` before returns, just make no change (prevent blocking
  caused by running `im-select`, default to be `'1s'`)

<!-- Links {{{-->
[im-select]: https://github.com/daipeihust/im-select
<!-- }}} -->

<!-- vim:set fdm=marker:-->
