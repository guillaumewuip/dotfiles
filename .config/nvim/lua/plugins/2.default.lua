return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local icons = LazyVim.config.icons

      opts.options = {
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
    "nvim-mini/mini.files",
    opts = {
      windows = {
        preview = false,
      },
      options = {
        use_as_default_explorer = true,
      },
      mappings = {
        close = "<ESC>",
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
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        override_vim_notify = true,
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    keys = {
      { "]b", false },
      { "]b", false },
      { "<s-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<s-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<c-h>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "<c-l>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = {
      highlights = {
        fill = {
          bg = "black", -- "none" does not work
        },
      },
    },
  },

  {
    "nvim-mini/mini.move",
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
      "moyiz/blink-emoji.nvim",
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
        list = {
          selection = { preselect = true, auto_insert = true },
        },
      },

      signature = { window = { border = "single" } },

      cmdline = {},

      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        default = { "snippets", "copilot", "lsp", "path", "buffer", "emoji" },

        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            opts = { insert = true }, -- Insert emoji (default) or complete its name
          },
          snippets = {
            -- score_offset = 100,
          },
        },
      },

      -- @see https://cmp.saghen.dev/configuration/keymap.html#presets
      keymap = {
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },

        ["<C-e>"] = { "hide", "fallback" },

        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<c-y>"] = { "select_and_accept" },

        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },
      },
    },
  },

  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
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
    event = "LazyFile",
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

  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    opts = function(_, opts)
      local nls = require("null-ls")

      opts.sources = vim.list_extend(opts.sources or {}, {
        require("none-ls.diagnostics.eslint_d"),
        -- require("none-ls.formatting.eslint_d"),
        require("none-ls.code_actions.eslint_d"),
        nls.builtins.formatting.biome,
      })
    end,
  },

  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        layouts = {
          custom = {
            reverse = false,
            layout = {
              box = "vertical",
              backdrop = false,
              row = 0,
              width = 0,
              height = 0.5,
              border = "rounded",
              title = "{source} {live}",
              title_pos = "left",
              { win = "input", height = 1, border = "bottom" },
              {
                box = "horizontal",
                { win = "list", border = "none" },
                { win = "preview", width = 0.4, border = "none" },
              },
            },
          },
        },
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    optional = true,
    opts = {
      copilot_model = "gpt-4o-copilot",
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = { "CopilotChat", "CopilotChatToggle" },
    opts = {
      model = "gpt-4o",
    },
  },
}
