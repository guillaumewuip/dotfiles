local set = vim.opt
local use = require('packer').use

set.foldmethod = 'syntax'
set.foldlevelstart = 99
set.foldcolumn = '0'

use {
  'mg979/vim-visual-multi',

  setup = function()
    vim.g.VM_set_statusline = 0
    vim.g.VM_reselect_first = 0
  end,
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

use {
  'ggandor/lightspeed.nvim',
  config = function ()
    require('lightspeed').setup({
      jump_to_unique_chars = { safety_timeout = 400 }
    })
  end
}

use {
  'karb94/neoscroll.nvim',
  config = function ()
    require('neoscroll').setup({
      easing_function = "quintic",
      hide_cursor = false,
    })
  end
}
