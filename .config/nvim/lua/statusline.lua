local cmd = vim.cmd

cmd[[
  function! StatusLine()
    let cocinfo = get(b:, 'coc_diagnostic_info', {})

    let msgs = []

    if get(cocinfo, 'error', 0)
      call add(msgs, '%#ErrorMsg#' . cocinfo['error'] . ' errors')
    endif

    if get(cocinfo, 'warning', 0)
      call add(msgs, '%#Search#' . cocinfo['warning'] . ' warnings')
    endif


    let base = '%#PmenuSel#%f%#ErrorMsg#%r%#Pmenu#%=%y %#PmenuSel# %p%% %l:%c'

    return base . '%#Pmenu# ' . join(msgs, '%#Pmenu# ')
  endfunction

  set statusline=%!StatusLine()

  let s:tab_hi_modified = '%#TabLineCellModified#'
  let s:tab_hi_selected_modified = '%#TabLineCellSelectedModified#'
  let s:tab_hi_selected = '%#TabLineCellSelected#'
  let s:tab_hi_non_selected = '%#TabLineCell#'
  let s:tab_hi_cwd = '%#TabLine#'

  function! s:GetFormattedBuffer(buf) abort
    let buf_name = pathshorten(fnamemodify(bufname(a:buf), ':.'))

    if empty(buf_name)
      let buf_name = '[No Name]'
    endif

    let modified = getbufvar(a:buf, '&modified')

    let selected = a:buf is# bufnr('%')

    if modified
      let buf_name = buf_name . '+'
    endif

    if modified && selected
      return printf('%s %s', s:tab_hi_selected_modified, buf_name)
    elseif modified
      return printf('%s %s', s:tab_hi_modified, buf_name)
    elseif selected
      return printf('%s %s', s:tab_hi_selected, buf_name)
    else
      return printf('%s %s', s:tab_hi_non_selected, buf_name)
    endif
  endfunction

  function! TabLine() abort
      let bl = []
      let current_nr = bufnr('%')

      let bufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
      let bufs_count = len(bufs)

      " Show 3 buffers maximum when the joined buffer's list string is bigger
      " than the window's width.
      if strlen(join(map(copy(bufs), 'pathshorten(fnamemodify(bufname(v:val), ":."))'))) ># &columns
          let bl += [s:tab_hi_cwd, '[' . bufs_count . ']']
          let current_i = index(bufs, current_nr)
          let prev_nr = current_i - 1 >=# 0 ? bufs[current_i - 1] : bufs[0]
          let next_nr = current_i + 1 <# len(bufs) - 1
                      \ ? bufs[current_i + 1]
                      \ : bufs[-1]
          let current = s:tab_hi_selected . s:GetFormattedBuffer(current_nr)
          let prev = prev_nr isnot# current_nr
                      \ ? s:GetFormattedBuffer(prev_nr)
                      \ : ''
          let next = next_nr isnot# current_nr
                      \ ? s:GetFormattedBuffer(next_nr)
                      \ : ''
          let bl += [prev, current, next]
      else
          for b in bufs
              call add(bl, s:GetFormattedBuffer(b))
          endfor
      endif

      let bl += [s:tab_hi_cwd]

      return join(bl)
  endfunction

  set showtabline=2
  set tabline=%!TabLine()
]]
