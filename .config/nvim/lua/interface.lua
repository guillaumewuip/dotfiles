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
]]

use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'ayu_dark',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = ' ', right = ' '},
        globalstatus = true,
      },

    sections = {
      lualine_a = {'mode'},
      lualine_b = {'diff', 'diagnostics'},
      lualine_c = {
        {
          'filename',
          path = 1,
          symbols = {
            modified = '+',
            readonly = '-',
            unnamed = '[No Name]',
          }
        }
      },
      lualine_x = {
        'filetype',
      },
      lualine_y = {'progress'},
      lualine_z = {'location'}
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
    { 'nvim-tree/nvim-web-devicons' }
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
set.relativenumber = true

vim.keymap.set('n', 'L', function ()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { noremap = true })


-- Not highlight the screen line of the cursor
set.cursorline = true
set.cursorcolumn = false

vim.keymap.set('n', 'H', function ()
  local lineHighlight = vim.api.nvim_exec('hi CursorLine', true)

  if string.match(lineHighlight, 'cleared') then
    vim.cmd[[
      hi CursorLine guibg=#20282e
    ]]
  else
    vim.cmd[[
      hi clear CursorLine
    ]]
  end
end, { noremap = true })

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
  'petertriho/nvim-scrollbar',
  config = function ()
    require("scrollbar").setup()
  end
}

use {
  'nvim-treesitter/nvim-treesitter-context',
  requires = {
    'nvim-treesitter/nvim-treesitter',
  },
  after = "nvim-treesitter",

  config = function()
    require("treesitter-context").setup {
      enable = true,
    }
  end,
}
