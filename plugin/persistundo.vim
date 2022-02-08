" vim-persistundo - Keep your undo history across sessions or closing a file
" Maintainer:   Jer Wilson <superjer@superjer.com>
" URL:          https://github.com/superjer/vim-persistundo
" Version:      0.1
"
" License:
" Copyright Jer Wilson. Distributed under the same terms as Vim itself.
" See :help license
"
" Installation:
" Put this file in your ~/.vim/plugin dir or, if you use a bundler, clone
" https://github.com/superjer/vim-persistundo to your bundles dir.
"
" Description:

if exists("g:loaded_persistundo")
  finish
endif
let g:loaded_persistundo = 1

" when does wundo and rundo become available?
if version >= 703
  set undodir=~/.vim/undo " location to store undofiles

  " Always write undo history, but only read it on command
  " use <leader>u to load old undo info!
  " modified from example in :help undo-persistence
  nnoremap <leader>u :call ReadUndo()<CR>
  au BufWritePost * call WriteUndo()
  func! ReadUndo()
    let undofile = undofile(expand('%'))
    if filereadable(undofile)
      let undofile = escape(undofile,'% ')
      exec "rundo " . undofile
    endif
  endfunc
  func! WriteUndo()
    let undofile = escape(undofile(expand('%')),'% ')
    exec "wundo " . undofile
  endfunc
endif
