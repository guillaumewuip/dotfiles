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
    "echasnovski/mini.files",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      windows = {
        preview = false,
      },
      options = {
        use_as_default_explorer = true,
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
      { "<c-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<c-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "[b", false },
      { "]b", false },
      { "<c-y>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "<c-o>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
      { "<C-x>", "<cmd>bdelete<cr>", desc = "Close buffer" },
    },
  },

  {
    "echasnovski/mini.move",
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<S-h>",
        right = "<S-l>",
        down = "<S-j>",
        up = "<S-k>",

        -- Move current line in Normal mode
        line_left = "<S-h>",
        line_right = "<S-l>",
        line_down = "<S-j>",
        line_up = "<S-k>",
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
    },
    opts = {
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
        default = { "lsp", "path", "snippets", "buffer" },
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
    "akinsho/git-conflict.nvim",
    event = "BufEnter",
    version = "*",
    config = {
      default_mappings = false,
    },
  },
}
