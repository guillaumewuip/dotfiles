local set = vim.opt
local use = require('packer').use

-- Allow vim clipboad <-> host clipboard to share data
-- @see https://ploegert.gitbook.io/til/tools/vim/allow-neovim-to-copy-paste-with-system-clipboard
-- don't know why not working with set.clipboard
vim.cmd [[
  set clipboard=unnamedplus
]]

set.mouse = a

-- Maximum width of text that is being inserted.
-- A longer line will be broken after white space to get this width.
set.textwidth = 80
set.linebreak = true

-- Use spaces instead of tabs
set.expandtab = true

-- 1 tab == 2 spaces
set.shiftwidth = 2
set.tabstop = 2
set.softtabstop = 2

set.smartindent = true

set.foldmethod = 'syntax'
set.foldlevelstart = 99
set.foldcolumn = '0'

-- decrement number with ctrl+z
vim.keymap.set('n', '<C-z>', '<C-x>')

-- Move a line of text using Ctrl+[jk]
vim.g.move_key_modifier = 'C'
vim.g.move_key_modifier_visualmode = 'C'
use 'matze/vim-move'

use {
  'ntpeters/vim-better-whitespace',
  config = function()
    vim.g.strip_whitespace_on_save = 1
  end
}

use {
  'preservim/nerdcommenter',
  config = function()
    vim.g.NERDSpaceDelims = 1
  end
}

use {
  'terryma/vim-multiple-cursors',
  config = function()
    vim.g.multi_cursor_select_all_word_key = '<C-y>'
  end
}

vim.g.lexima_enable_basic_rules = true
vim.g.lexima_enable_newlines_rules = true

use 'cohama/lexima.vim'

use 'machakann/vim-sandwich'
