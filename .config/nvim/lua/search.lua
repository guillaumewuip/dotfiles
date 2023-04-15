local set = vim.opt
local use = require('packer').use

-- Ignore case when searching
set.ignorecase = true
set.smartcase = true

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
    { 'nvim-treesitter/nvim-treesitter' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'xiyaowong/telescope-emoji.nvim' },
    { "nvim-telescope/telescope-live-grep-args.nvim" }
  },
  config = function()
    require("telescope").load_extension("emoji")
    require("telescope").load_extension("live_grep_args")

    local actions = require "telescope.actions"

    require('telescope').setup {
      defaults = {
        sorting_strategy = "ascending",
        layout_strategy = 'vertical',
        layout_config = {
          mirror = true,
          prompt_position = "top"
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob",
          "!**/.git/*",
          '--ignore-file',
          '.gitignore'
        },
        mappings = {
          i = {
            ["<C-o>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<M-Down>"] = actions.cycle_history_next,
            ["<M-Up>"] = actions.cycle_history_prev,
          },
          n = {
            ["<C-o>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<M-Down>"] = actions.cycle_history_next,
            ["<M-Up>"] = actions.cycle_history_prev,
          }
        }
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

    vim.keymap.set('n', ')', require('telescope.builtin').buffers, keymapOptions)

    vim.keymap.set('n', '+', function()
      -- local ok = pcall(require('telescope.builtin').git_files)
      -- if not ok then require('telescope.builtin').find_files() end
      require('telescope.builtin').find_files {
        hidden = true,
        no_ignore = false,
      }
    end, keymapOptions)

    vim.keymap.set('n', '=', require('telescope.builtin').find_files, keymapOptions)
    vim.keymap.set('n', '(', function ()
      require('telescope.builtin').keymaps({
        modes = { "n", "i", "c", "x", "v" }
      })
    end, keymapOptions)

    vim.keymap.set('n', '<leader>f', function ()
      require("telescope").extensions.live_grep_args.live_grep_raw()
    end, keymapOptions)
    vim.keymap.set('v', '<leader>f', function()
	    local text = vim.getVisualSelection()
      require("telescope").extensions.live_grep_args.live_grep_raw({ default_text = text })
    end, keymapOptions)

  end
}

use {
  'nvim-pack/nvim-spectre',
  requires = {
    { 'nvim-lua/plenary.nvim' },
  },
  config = function()
    require('spectre').setup{}

    vim.keymap.set('n', '<leader>g', require('spectre').open)
    vim.keymap.set('v', '<leader>g', function()
      require('spectre').open_visual({ select_word = true })
    end)
  end
}

use {
  'kevinhwang91/rnvimr',
  -- commit after introduce an issue with refresh inside ranger when changing directory
  -- @see https://github.com/kevinhwang91/rnvimr/commit/cd0311d65cb3b8f8737b52f3294eb77d2fcec826
  commit = '40b4e0b',
  config = function()
    vim.g.rnvimr_edit_cmd = 'drop'
    vim.g.rnvimr_enable_picker = true
    vim.g.rnvimr_enable_bw = true
    -- vim.g.rnvimr_draw_border = false
    -- vim.g.rnvimr_shadow_winblend = 100
    vim.g.rnvimr_hide_gitignore = false

    vim.keymap.set('n', '-', ':RnvimrToggle<CR>')
  end,
}

use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
