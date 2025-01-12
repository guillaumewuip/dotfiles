return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local icons = LazyVim.config.icons

      opts.options = {
        theme = "tokyonight-night",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = " ", right = " " },
        globalstatus = true,
      }

      -- remove some items opts.sections.lualine_x
      -- @see https://www.lazyvim.org/plugins/ui#lualinenvim
      table.remove(opts.sections.lualine_x, 1)
      table.remove(opts.sections.lualine_x, 2)
      table.remove(opts.sections.lualine_x, 4)

      opts.sections.lualine_z = {
        { "filetype" },
      }
    end,
  },

  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        preview = false,
      },
      options = {
        use_as_default_explorer = true,
      },
    },
    keys = {
      {
        "-",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
    },
  },

  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    keys = {
      { "]b", false },
      { "]b", false },
      { "<s-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<s-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<c-l>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "<c-h>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
      { "<C-x>", "<cmd>bdelete<cr>", desc = "Close buffer" },
    },
  },

  {
    "echasnovski/mini.move",
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<",
        right = ">",
        down = "<S-j>",
        up = "<S-k>",

        -- Move current line in Normal mode
        line_left = "",
        line_right = "",
        line_down = "",
        line_up = "",
      },
    },
  },

  {
    "petertriho/nvim-scrollbar",
    event = "LazyFile",
    opts = {},
  },

  {
    "saghen/blink.compat",
    lazy = true,
    opts = {},
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        config = function(_, opts)
          require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })

          local luasnip = require("luasnip")
          luasnip.filetype_set("javascriptreact", { "javascript" })
          luasnip.filetype_set("typescript", { "javascript" })
          luasnip.filetype_set("typescriptreact", { "javascript" })
        end,
      },
    },
    opts = {
      snippets = { preset = "luasnip" },

      completion = {
        menu = { border = "single" },
        documentation = { window = { border = "single" } },
      },
      signature = { window = { border = "single" } },
      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {
          "emoji",
        },
        default = { "snippets", "lsp", "path", "buffer" },
        cmdline = {},
      },
      keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept" },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "eslint_d" } },
  },

  {
    "mg979/vim-visual-multi",
    event = "LazyFile",
    init = function()
      vim.g.VM_theme = "sand"
      vim.g.VM_custom_remaps = {
        ["<C-c>"] = "<Esc>",
      }
    end,
  },

  {
    "kevinhwang91/nvim-hlslens",
    event = "BufEnter",
    config = function(_, opts)
      require("hlslens").setup(opts)
    end,
  },

  {
    "ecthelionvi/NeoColumn.nvim",
    event = "BufEnter",
    opts = {
      always_on = true,
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    enabled = true,
    opts = {
      signcolumn = false,
      numhl = true,
      current_line_blame = true,
    },
  },

  {
    "akinsho/git-conflict.nvim",
    event = "BufEnter",
    version = "*",
    config = {
      default_mappings = false,
    },
    keys = {
      { "<leader>gco", ":GitConflictChooseOurs<CR>", { desc = "Git conflict - choose ours" } },
      { "<leader>gct", ":GitConflictChooseTheirs<CR>", { desc = "Git conflict - choose theirs" } },
      { "<leader>gcb", ":GitConflictChooseBoth<CR>", { desc = "Git conflict - choose both" } },
      { "<leader>gc0", ":GitConflictChooseNone<CR>", { desc = "Git conflict - choose none" } },
      { "<leader>gcn", ":GitConflictNextConflict<CR>", { desc = "Git conflict - move to next conflict" } },
      { "<leader>gcp", ":GitConflictPrevConflict<CR>", { desc = "Git conflict - move to previous conflict" } },
    },
  },
}
