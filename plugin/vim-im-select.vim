" vim-im-select.vim: Switch input method to english layout when entering
"                    normal mode, and restore to original layout when leaving
"                    normal mode
" Maintainer: Luke <luke_13@sjtu.edu.cn>
" Licence: DWTFYWTPL

if exists('g:loaded_vim_im_select') && g:loaded_vim_im_select
  finish
endif

let g:loaded_vim_im_select = 1

" check for existence of commands for ime selection and enable this
if !exists('g:im_select_enable')
  let g:im_select_enable = 0
endif
if has('unix') || has('mac')
  if has('mac')
    " for MacOS
    if !exists('g:im_select_default_im')
      let g:im_select_default_im = "com.apple.keylayout.ABC"
    endif
    if !exists('g:im_select_obtain_im_cmd')
      let g:im_select_obtain_im_cmd = '/usr/local/bin/im-select'
    endif
    if !exists('g:im_select_switch_im_cmd')
      let g:im_select_switch_im_cmd = '/usr/local/bin/im-select {im}'
    endif
  elseif has('unix')
    " for Linux
    if !exists('g:im_select_default_im')
      let g:im_select_default_im = '1'
    endif
    if !exists('g:im_select_obtain_im_cmd')
      let g:im_select_obtain_im_cmd = '/usr/bin/fcitx-remote'
    endif
    if !exists('g:im_select_switch_im_cmd')
      let g:im_select_switch_im_cmd = '/usr/bin/fcitx-remote -t {im}'
    endif
  endif
  augroup im_select
    autocmd!
    autocmd InsertLeave * :call <SID>CloseIME()
    autocmd InsertEnter * :call <SID>RestoreIME()
  augroup end
endif

let g:insert_ime_mode_ = g:im_select_default_im

" add a timeout in case of blocking
let g:im_select_timeout = '1s'
function! s:system_wait(cmd)
  return system('timeout '.g:im_select_timeout.' '.a:cmd)
endfunction

function! s:CloseIME()
  " echom g:im_select_enable
  if !g:im_select_enable
    return
  endif
  let g:insert_ime_mode_ = s:system_wait(g:im_select_obtain_im_cmd)
  " nothing return before timeout, so do nothing
  if v:shell_error != 0
      return
  endif
  let l:cmd_ = substitute(
              \ g:im_select_switch_im_cmd,
              \ '{im}',
              \ g:im_select_default_im, 'g')
  " echom l:cmd_
  if g:insert_ime_mode_ != g:im_select_default_im
    call s:system_wait(cmd_)
  endif
endfunction

function! s:RestoreIME()
    " echom g:im_select_enable
  if !g:im_select_enable
    return
  endif
  let l:cmd_ = substitute(
                \ g:im_select_switch_im_cmd,
                \ '{im}',
                \ g:insert_ime_mode_, 'g')
  " echom l:cmd_
  if g:insert_ime_mode_ != g:im_select_default_im
    call s:system_wait(l:cmd_)
    let g:insert_ime_mode_ = g:im_select_default_im
  endif
endfunction

