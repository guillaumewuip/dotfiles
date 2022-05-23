local set = vim.opt
local use = require('packer').use

vim.cmd [[
  " Given a path, return the directory name for that path, with no trailing
  " slashes. If the argument is empty(), return an empty string.
  " @see ale
  function! Dirname(path) abort
    if empty(a:path)
        return ''
    endif

    " For /foo/bar/ we need :h:h to get /foo
    if a:path[-1:] is# '/' || (has('win32') && a:path[-1:] is# '\')
      return fnamemodify(a:path, ':h:h')
    endif

    return fnamemodify(a:path, ':h')
  endfunction

  " Given a buffer and a directory name, find the nearest directory by searching upwards
  " through the paths relative to the given buffer.
  " @see ale
  function! FindNearestDirectory(buffer, directory_name) abort
    let l:buffer_filename = fnamemodify(bufname(a:buffer), ':p')
    let l:buffer_filename = fnameescape(l:buffer_filename)

    let l:relative_path = finddir(a:directory_name, l:buffer_filename . ';')

    if !empty(l:relative_path)
      return fnamemodify(l:relative_path, ':p')
    endif

    return ''
  endfunction

  function! TestRoot()
    let s:dir = Dirname(FindNearestDirectory(bufnr(''), 'node_modules'))

    if !empty(s:dir)
      return s:dir
    endif

    return ''
  endfunction

  function! SetupTestRoot()
    let g:test#project_root = TestRoot()
  endfunction

  function! KittyNewTabStrategy(cmd) abort
    let cwd = TestRoot()
    let cmd = join(['~/.config/kitty/kitty_new_tab_runner', cwd, shellescape(a:cmd), getpid()])
    execute 'silent !'.cmd
  endfunction

  let g:test#custom_strategies = {
      \ 'kitty_new_tab': function('KittyNewTabStrategy')
      \ }

  let g:test#strategy = "kitty_new_tab"

  let g:test#enabled_runners = ["javascript#jest"]

  let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test|unit))\.(js|jsx|coffee|ts|tsx|iced)$'
  let g:test#javascript#runner = 'jest'
  let g:test#javascript#jest#executable = 'npm run test:unit:jest'
  let g:test#javascript#jest#options = "-- --no-cache --color=always"

  let g:ultest_running_sign = "●"
  let g:ultest_summary_width = 80
  let g:ultest_output_on_run = 1
  let g:ultest_output_on_line = 1
  let g:ultest_max_threads = 4

  nnoremap <silent> <leader>t :w \| UltestNearest<cr>
  nnoremap <silent> <leader>to :w \| UltestOutput<cr>
  nnoremap <silent> <leader>y :w \| Ultest<cr>
  nnoremap <silent> <leader>u :w \| TestFile --watch<cr>

  autocmd BufEnter *.ts,*.tsx call SetupTestRoot()
]]

use {
  "rcarriga/vim-ultest",
  requires = {
    "vim-test/vim-test"
  },
  run = ":UpdateRemotePlugins"
}

