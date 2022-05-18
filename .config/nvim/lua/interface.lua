local set = vim.opt
local cmd = vim.cmd
local use = require('packer').use

-- usefull to test new themes:
-- use 'chxuan/change-colorscheme'
-- cmd [[
--   nnoremap <silent> T :PreviousColorScheme<cr>
--   nnoremap <silent> Y :NextColorScheme<cr>
-- ]]

set.termguicolors = true

-- @see colors/ayu.vim
cmd [[
  let ayucolor="darker" " for darker version of theme
  colorscheme ayu

  highlight FloatermBorder              ctermfg=black
]]

use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'ayu_dark',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = ' ', right = ' '},
        globalstatus = true,
      },
      extensions = {
        'quickfix'
      }
    })
  end
}

use {
  'kdheepak/tabline.nvim',
  after = 'lualine.nvim',
  config = function()
    require'tabline'.setup {
      -- Defaults configuration options
      enable = true,

      options = {
        section_separators = {' ', ' '},
        component_separators = {'|', '|'},
        max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
        modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
      }
    }

    vim.cmd[[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
    ]]

    -- move among sbuffer
    vim.keymap.set('', '<C-l>', ':TablineBufferNext<CR>')
    vim.keymap.set('', '<C-h>', ':TablineBufferPrevious<CR>')
    -- close buffer
    vim.keymap.set('', '<C-X>', ':bdelete<CR>')
  end,
  requires = {
    { 'hoob3rt/lualine.nvim' },
    {'kyazdani42/nvim-web-devicons' }
  }
}

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
vim.keymap.set('n', 'H', ':set cursorline!<CR>')

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
