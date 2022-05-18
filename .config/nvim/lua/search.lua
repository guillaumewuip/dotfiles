local set = vim.opt
local use = require('packer').use

-- Ignore case when searching
set.ignorecase = true

-- Disable highlight
vim.keymap.set('n', '<leader><cr>', ':noh<cr>', { silent = true })

-- next search result
vim.keymap.set('', '<leader>n', ':cn<cr>')
-- prev search result
vim.keymap.set('', '<leader>p', ':cp<cr>')

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

use {
  'nvim-telescope/telescope.nvim',
  requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'nvim-treesitter/nvim-treesitter', run = 'TSUpdate' },
    { 'kyazdani42/nvim-web-devicons' },
    { 'xiyaowong/telescope-emoji.nvim' },
    { "nvim-telescope/telescope-live-grep-raw.nvim" }
  },
  config = function()
    require("telescope").load_extension("emoji")
    require("telescope").load_extension("live_grep_raw")

    require('telescope').setup {
      defaults = {
        sorting_strategy = "ascending",
        layout_strategy = 'flex',
        layout_config = {
          prompt_position = "top"
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      }
    }

    local keymapOptions = { noremap = true, silent = true }

    vim.keymap.set('', ')', require('telescope.builtin').buffers, keymapOptions)

    vim.keymap.set('', '+', function()
      local ok = pcall(require"telescope.builtin".git_files)
      if not ok then require"telescope.builtin".find_files() end
    end, keymapOptions)

    vim.keymap.set('', '=', require('telescope.builtin').find_files, keymapOptions)

    vim.keymap.set('n', '<Leader>g', function ()
      require("telescope").extensions.live_grep_raw.live_grep_raw()
    end, keymapOptions)
    vim.keymap.set('v', '<Leader>g', function()
	    local text = vim.getVisualSelection()
      require("telescope").extensions.live_grep_raw.live_grep_raw({ default_text = text })
    end, keymapOptions)

    vim.keymap.set('', '!', require('telescope.builtin').git_status, keymapOptions)
    vim.keymap.set('', '@', require('telescope.builtin').git_bcommits, keymapOptions)
  end
}

use {
  'windwp/nvim-spectre',
  requires = {
    { 'nvim-lua/plenary.nvim' },
  },
  config = function()
    require('spectre').setup{}

    vim.keymap.set('n', '<Leader>G', require('spectre').open)
    vim.keymap.set('v', '<Leader>G', function()
      require('spectre').open_visual({ select_word = true })
    end)
  end
}

use {
  'kevinhwang91/rnvimr',

  setup = function()
    vim.g.rnvimr_edit_cmd = 'drop'
    vim.g.rnvimr_enable_picker = true
    vim.g.rnvimr_enable_bw = true
    vim.g.rnvimr_draw_border = false
    vim.g.rnvimr_hide_gitignore = false

    vim.cmd [[
      highlight link RnvimrNormal CursorLine
    ]]

    vim.keymap.set('n', '-', ':RnvimrToggle<CR>')

  end,
}


use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
