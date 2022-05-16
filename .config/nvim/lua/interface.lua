local set = vim.opt
local cmd = vim.cmd
local use = require('packer').use

vim.cmd('colorscheme desert')

set.background = 'dark'

cmd [[highlight CursorLine cterm=NONE ctermbg=236]]

cmd [[highlight Search cterm=NONE ctermfg=15 ctermbg=172]]
cmd [[highlight CocHighlightText ctermfg=15 ctermbg=136]]
cmd [[highlight CocHighlightRead ctermfg=15 ctermbg=136]]
cmd [[highlight CocHighlightWrite ctermfg=15 ctermbg=136]]

cmd [[highlight Pmenu       cterm=NONE ctermfg=255 ctermbg=236]]
cmd [[highlight PmenuSel    cterm=NONE ctermfg=15 ctermbg=240]]
cmd [[highlight CocFloating cterm=NONE ctermfg=255 ctermbg=236]]

cmd [[highlight TabLine                     cterm=NONE ctermfg=255 ctermbg=236]]
cmd [[highlight TabLineCell                 cterm=NONE ctermfg=255 ctermbg=236]]
cmd [[highlight TabLineCellSelected         cterm=NONE ctermfg=15 ctermbg=172]]
cmd [[highlight TabLineCellModified         cterm=NONE ctermfg=255 ctermbg=244]]
cmd [[highlight TabLineCellSelectedModified cterm=NONE ctermfg=15 ctermbg=160]]
cmd [[highlight FloatermBorder              ctermfg=black]]

-- always show current position
set.ruler = true

-- height of the command bar
set.cmdheight = 2

-- always show signcolumns
set.signcolumn = 'yes'
cmd [[highlight clear SignColumn]]

-- Show matching brackets when text indicator is over them
set.showmatch = true
-- How many tenths of a second to blink when matching brackets
set.matchtime = 2

-- Display relative line numbers and absolute line number for the current line
set.number = true

-- Not highlight the screen line of the cursor
set.cursorline = false
set.cursorcolumn = false
-- Highlight the screen line of the cursor with H
vim.keymap.set('n', 'H', ':set cursorline!')

-- Always show x lines around cursor
set.scrolloff = 7
set.sidescrolloff = 7
set.sidescroll = 1

-- add 80 caracter column
set.colorcolumn = '80'

-- treat long lines as break lines (useful when moving around in them)
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('', '<ScrollWheelUp>', 'k')
vim.keymap.set('', '<ScrollWheelDown>', 'j')

-- move among buffers
vim.keymap.set('', '<C-L>', ':bnext<CR>')
vim.keymap.set('', '<C-H>', ':bprev<CR>')
-- close buffer
vim.keymap.set('', '<C-X>', ':bd<CR>')

-- Specify the behavior when switching between buffers
set.switchbuf = 'useopen'

-- open file under cursor in new tab
vim.keymap.set('n', 't', '<c-w>gf', { noremap = true })

use {
  'lewis6991/gitsigns.nvim',
  tag = 'release',
  config = function()
    require('gitsigns').setup {
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '-' },
        topdelete    = { text = '-' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
    }
  end
}

cmd [[ highlight GitSignsCurrentLineBlame ctermfg=244 ctermbg=NONE cterm=nocombine ]]

use {
  'ruifm/gitlinker.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require("gitlinker").setup{
      mappings = nil
    }

    vim.keymap.set('n', '<leader>b', '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', {silent = true})
    vim.keymap.set('v', '<leader>b', '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', {})
  end
}

vim.g.indent_blankline_char = '┆'
vim.g.indent_blankline_space_char_blankline = ' '

cmd [[ highlight IndentBlanklineChar ctermfg=238 ctermbg=NONE cterm=nocombine ]]

use {
  "lukas-reineke/indent-blankline.nvim",
  requires = {
    {
      'nvim-treesitter/nvim-treesitter',
      cmd = 'TSUpdate'
    },
  },
  config = function ()
    require("indent_blankline").setup()
  end
}

