"=================================================
" File: virb.vim
" Description: A Vim shell for irb and rails console
" Author: Daniel Choi <dhchoi@gmail.com>
" ================================================

if exists("g:loaded_virb") || &cp
    finish
endif
let g:loaded_virb = 1

let s:fifo = ".virb/fifo"

" split into two windows: a session buffer and a interactive buffer

function! s:focus_virb_output_window()
  if bufwinnr(s:virb_output_bufnr) == winnr()
    return
  end
  let winnr = bufwinnr(s:virb_output_bufnr)
  if winnr == -1
    " create window
    split! .virb/session
    exec "buffer" . s:virb_output_bufnr
  else
    exec winnr . "wincmd w"
  endif
endfunc

function! VirbStatusLine()
  let line =  "%<*virb interactive buffer*   %r%=%-14.(%l,%c%V%)\ %P"
  return line
endfunc

" main execution function
func! Virb() range
  let s:mtime = getftime(".virb/session")
  let cmd = ":".a:firstline.",".a:lastline."w >> .virb/fifo"
  exec cmd
  if $VIRB == 'pry'
    " a little slower
    :sleep 600m
  else
    :sleep 400m
  endif
  :call VirbRefresh()
endfunc

func! VirbRefresh()
  :call s:focus_virb_output_window()
  ":exec ":checktime ".s:virb_output_bufnr
  :e!
  :normal G
  syn match irbprompt /^irb\S\+\(>\|\*\).*$/ 
  " [2] pry(main)>
  syn match irbprompt /^\[\d\+\] pry.*$/ 
  hi def link irbprompt         Comment
  :wincmd p
endfunc

func VirbInterrupt()
  " this kill -INT is overbroad, sending INT to all virb processes but we can improve it later
  let cmd = "ps | grep bin\/virb$ | awk '{ print $1}' | xargs kill -INT"
  call system(cmd)
  sleep 400m
  call VirbRefresh()
endfunc 

function! VirbInteractive()
  setlocal nu
  command! -bar -range Virb :<line1>,<line2>call Virb()
  set ft=ruby
  nnoremap <buffer> <cr> :call Virb()<cr>
  vnoremap <buffer> <cr> :call Virb()<cr>
  nnoremap <buffer> <space> :checkt<CR>
  nnoremap <buffer> <c-c> :call VirbInterrupt()<CR>
endfunc

split! .virb/session
setlocal autoread
let s:virb_output_bufnr = bufnr('%')
setlocal nomodifiable
setlocal nu

" set up interactive buffer
wincmd p
call VirbInteractive()
" just in the first buffer window
setlocal statusline=%!VirbStatusLine()

:au BufNewFile,BufRead *.rb call VirbInteractive()

