---@type MappingsTable
local M = {}

M.disabled = {
  i = {
    ["<C-b>"] = "",
    ["<C-e>"] = "",
  },

  n = {
    ["<C-s>"] = "",
    ["<C-c>"] = "",

    ["<leader>n"] = "",
    ["<leader>rn"] = "",
    ["<leader>b"] = "",

    ["<tab>"] = "",
    ["<S-tab>"] = "",
    ["<leader-x>"] = "",
    ["<leader>D"] = "",

    ["<leader>ls"] = "",
    ["<leader>ra"] = "",
    ["<leader>ca"] = "",
    ["[d"] = "",
    ["]d"] = "",
    ["<leader>wa"] = "",
    ["<leader>wr"] = "",
    ["<leader>wl"] = "",
  },

  v = {
    ["<C-k>"] = "",
    ["<C-j>"] = "",
  },
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    ["<C-k>"] = { ":MoveLine(-1)<CR>", "Move line up", opts = { nowait = true, noremap = true, silent = true } },
    ["<C-j>"] = { ":MoveLine(1)<CR>", "Move line down", opts = { nowait = true, noremap = true, silent = true } },

    ["-"] = { ":RnvimrToggle<cr>", "Open Ranger", opts = { nowait = true } },

    ["<C-z>"] = { "<C-x>", "Decrement number" },

    ["<leader>b"] = {
      function()
        require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser })
      end,
      "Open repository url",
      { silent = true },
    },

    ["L"] = {
      function()
        vim.opt.relativenumber = not vim.opt.relativenumber:get()
      end,
      "Toggle relative line number",
    },

    ["H"] = {
      function()
        local lineHighlight = vim.api.nvim_exec("hi CursorLine", true)

        if string.match(lineHighlight, "cleared") then
          vim.cmd [[
            hi CursorLine guibg=#20282e
          ]]
        else
          vim.cmd [[
            hi clear CursorLine
          ]]
        end
      end,
      "Toggle cursorline highlight",
    },

    ["<leader>l"] = { ":diffget //3<CR>", "Choose right git diff" },
    ["<leader>h"] = { ":diffget //2<CR>", "Choose left git diff" },

    ["<C-l>"] = { ":TablineBufferNext<CR>", "Goto next buffer", opts = { nowait = true } },

    ["<C-h>"] = { ":TablineBufferPrevious<CR>", "Goto prev buffer", opts = { nowait = true } },

    ["<C-x>"] = { ":bdelete<CR>", "Close buffer", opts = { nowait = true } },

    ["<leader>g"] = {
      require("spectre").open,
      "Open Spectre Search/Replace",
    },

    ["+"] = {
      function()
        require("telescope.builtin").find_files {
          hidden = true,
          no_ignore = false,
        }
      end,
      "Open Telescope find_files",
    },
    ["<leader>+"] = {
      require('telescope.builtin').buffers,
      "Open Telescope find_files",
    },
    ["<leader>!"] = {
      require('telescope.builtin').git_status,
      "Open Telescope find_files",
    },


    ["<leader>f"] = {
      function()
        require("telescope").extensions.live_grep_args.live_grep_raw()
      end,
      "Open Telescope find_files",
    },
  },

  v = {
    ["<C-k>"] = { ":MoveBlock(-1)<CR>", "Move block up", opts = { nowait = true, noremap = true, silent = true } },
    ["<C-j>"] = { ":MoveBlock(1)<CR>", "Move block down", opts = { nowait = true, noremap = true, silent = true } },

    ["<leader>b"] = {
      function()
        require("gitlinker").get_buf_range_url("v", { action_callback = require("gitlinker.actions").open_in_browser })
      end,
      "Open repository url",
      {},
    },

    ["<leader>g"] = {
      require("spectre").open_visual,
      "Open Spectre Search/Replace",
    },

    ["<leader>f"] = {
      function()
        local text = vim.getVisualSelection()
        require("telescope").extensions.live_grep_args.live_grep_raw { default_text = text }
      end,
      "Open Spectre Search/Replace",
    },
  },
}

M.lspconfig = {
  plugin = true,

  n = {
    ["gt"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["gs"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>rn"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>a"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["<leader>ap"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["<leader>an"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },
  },
}

return M
