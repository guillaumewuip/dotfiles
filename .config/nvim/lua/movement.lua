local set = vim.opt
local use = require('packer').use

set.foldmethod = 'syntax'
set.foldlevelstart = 99
set.foldcolumn = '0'

use {
  'terryma/vim-multiple-cursors',
  config = function()
    vim.g.multi_cursor_select_all_word_key = '<C-y>'
  end
}

-- Move a line of text using Ctrl+[jk]
use {
  'matze/vim-move',

  setup = function()
    vim.g.move_map_keys = 0
  end,

  config = function()
    vim.keymap.set('n', '<C-k>', '<Plug>MoveLineUp', { noremap = false })
    vim.keymap.set('n', '<C-j>', '<Plug>MoveLineDown', { noremap = false })
    vim.keymap.set('v', '<C-k>', '<Plug>MoveBlockUp', { noremap = false })
    vim.keymap.set('v', '<C-j>', '<Plug>MoveBlockDown', { noremap = false })
  end
}

use 'wellle/targets.vim'
