if exists('did_macdown_loaded') || v:version < 700
  finish
endif
let did_macdown_loaded = 1
let s:save_cpo = &cpo
set cpo&vim

let s:marked = expand('<sfile>:p:h:h') . '/bin/marked'

function! s:Preview()
  if get(b:, 'macdown_auto_preview', 0) == 0
    return
  endif
  let dest = get(b:, 'macdown_dest', tempname())
  let marked = get(g:, 'macdown_marked_programme', s:marked)
  silent call macdown#preview(marked, dest)
endfunction

function! s:AutoPreview()
  if get(b:, 'macdown_auto_preview', 0)
    let b:macdown_auto_preview = 0
    echohl MoreMsg | echon 'auto preview disabled' | echohl None
  else
    let b:macdown_auto_preview = 1
    call s:Preview()
    echohl MoreMsg | echon 'auto preview enabled' | echohl None
  endif
endfunction

function! s:VisualPreview(start, end)
  let dest = get(b:, 'macdown_dest', tempname())
  let marked = get(g:, 'macdown_marked_programme', s:marked)
  call macdown#preview(marked, dest, a:start, a:end)
endfunction

function! s:OnVimLeave()
  for buf in range(1, bufnr('$'))
    if bufloaded(buf)
      if getbufvar(buf, '&ft') ==# 'markdown'
        call macdown#closeTab(buf)
      endif
    endif
  endfor
endfunction

function! s:SetMarkdownCommand()
  command! -buffer -range=% -nargs=0 Preview :call s:VisualPreview(<line1>, <line2>)
  command! -buffer -nargs=0 PreviewAuto :call s:AutoPreview()
endfunction

augroup macdown
  autocmd!
  autocmd FileType markdown call s:SetMarkdownCommand()
  autocmd BufWrite *.md,*.markdown,*.mkd call s:Preview()
  autocmd CursorHold,CursorHoldI *.md,*.markdown,*.mkd call s:Preview()
  autocmd BufDelete *.md,*.markdown,*.mkd call macdown#closeTab(+expand('<abuf>'))
  autocmd VimLeave * call s:OnVimLeave()
augroup end

let &cpo = s:save_cpo