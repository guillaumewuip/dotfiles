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

-- decrement number with ctrl+z
vim.keymap.set('n', '<C-z>', '<C-x>')

-- highlight the region that just yanked
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

use {
  'ntpeters/vim-better-whitespace',
  config = function()
    vim.g.strip_whitespace_on_save = 1
    vim.g.strip_whitespace_confirm = 0
  end
}

use {
  'preservim/nerdcommenter',
  config = function ()
    vim.g.NERDSpaceDelims = true
    vim.g.NERDCommentEmptyLines = true
  end
}

-- auto open/close parentheses and stuff
use {
  'windwp/nvim-autopairs',
  rpt = 'lua', -- need to go inside the lua/ dir
  config = function()
    require('nvim-autopairs').setup({
      check_ts = true,
      fast_wrap = false,
    })
  end
}

use 'machakann/vim-sandwich'

use {
  'windwp/nvim-ts-autotag',
  setup = function ()
    require('nvim-treesitter.configs').setup {
      autotag = {
        enable = true,
      }
    }
  end
}

use {
  "lukas-reineke/indent-blankline.nvim",

  setup = function ()
    vim.g.indent_blankline_char = '┆'
    vim.g.indent_blankline_space_char_blankline = ' '
  end,

  requires = {
    {
      'nvim-treesitter/nvim-treesitter',
      -- cmd = 'TSUpdate'
    },
  },
  config = function ()
    require("indent_blankline").setup()
  end
}
