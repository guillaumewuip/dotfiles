local set = vim.opt
local use = require('packer').use

-- Allow vim clipboad <-> host clipboard to share data
-- @see https://ploegert.gitbook.io/til/tools/vim/allow-neovim-to-copy-paste-with-system-clipboard
set.clipboard = unnamedplus

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
-- Normal mode
vim.keymap.set('n', '<C-j>', ":m .+1<CR>==", { noremap = true })
vim.keymap.set('n', '<C-k>', ":m .-2<CR>==", { noremap = true })
-- Insert mode
vim.keymap.set('i', '<C-j>', "<ESC>:m .+1<CR>==gi", { noremap = true })
vim.keymap.set('i', '<C-k>', "<ESC>:m .-2<CR>==gi", { noremap = true })
-- Visual mode
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true })

use {
  'Yggdroot/indentLine',
  config = function()
    vim.g.indentLine_char = '┆'
    vim.g.indentLine_enabled = 1
    vim.g.indentLine_concealcursor = 'nc'
    vim.g.indentLine_conceallevel = 2
  end
}

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
