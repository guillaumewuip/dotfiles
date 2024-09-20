return {
  {
    "NvChad/nvterm",
    enabled = false,
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },

  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "creativenull/efmls-configs-nvim",
        version = "v1.x.x",
        dependencies = { "neovim/nvim-lspconfig" },
      },

      "b0o/schemastore.nvim",

      {
        "RishabhRD/lspactions",
        dependencies = {
          "nvim-lua/popup.nvim",
        },
      },

      {
        "yioneko/nvim-vtsls",
        opts = {
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true, -- not working?
              experimental = {
                enableProjectDiagnostics = true,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
              enableMoveToFileCodeAction = true,
            },
            typescript = {
              tsdk = "./node_modules/typescript/lib",
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              referencesCodeLens = { enabled = true },
              format = { enable = false },
              suggest = {
                completeFunctionCalls = true,
              },
              preferGoToSourceDefinition = true,
              experimental = {
                aiCodeActions = {
                  extractInterface = true,
                  missingFunctionDeclaration = true,
                  extractType = true,
                  inferAndAddTypes = true,
                  extractFunction = true,
                  extractConstant = true,
                  classIncorrectlyImplementsInterface = true,
                  classDoesntImplementInheritedAbstractMember = true,
                  addNameToNamelessParameter = true,
                },
                enableProjectDiagnostics = true,
              },
            },
            javascript = {
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              referencesCodeLens = { enabled = true },
              format = { enable = false },
              suggest = {
                completeFunctionCalls = true,
              },
              preferGoToSourceDefinition = true,
            },
          },
        },
        config = function(_, opts)
          require("lspconfig").vtsls.setup(opts)
        end,
      },
    },
    config = function()
      local configs = require "nvchad.configs.lspconfig"

      local on_attach = configs.on_attach
      local capabilities = configs.capabilities
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local lspconfig = require "lspconfig"

      local servers = {
        "html",
        "cssls",
        "vtsls",
        "lua_ls",
        "dockerls",
        "jsonls",
        "html",
        "bashls",
        "terraformls",
        "vimls",
        "yamlls",
        "helm_ls",
        "eslint",
      }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      lspconfig.eslint.setup {
        on_attach = function(config, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        capabilities = capabilities,
      }

      local luacheck = require "efmls-configs.linters.luacheck"
      local stylua = require "efmls-configs.formatters.stylua"

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      lspconfig.efm.setup {
        on_attach = function(client, bufnr)
          if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end
        end,
        capabilities = capabilities,
        filetypes = {
          "lua",
          "html",
          "css",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "sh",
          "docker",
          "markdown",
        },
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
          hover = true,
          documentSymbol = true,
          codeAction = true,
          completion = true,
        },
        settings = {
          rootMarkers = {
            ".git",
            "package.json",
            "node_modules",
            "tsconfig.json",
          },
          languages = {
            lua = { luacheck, stylua },
          },
        },
      }

      local lspactions = require "lspactions"
      vim.ui.select = lspactions.select
      vim.ui.input = lspactions.input
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "yaml-language-server",
        "bash-language-server",
        "dockerfile-language-server",
        "vim-language-server",
        "vtsls",
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "terraform-ls",
        "helm-ls",
        "efm",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = "all",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "1.*",
        build = "make install_jsregexp",
        config = function(_, opts)
          require("luasnip.loaders.from_lua").lazy_load { paths = "~/.config/nvim/snippets" }

          local luasnip = require "luasnip"
          luasnip.filetype_set("javascriptreact", { "javascript" })
          luasnip.filetype_set("typescript", { "javascript" })
          luasnip.filetype_set("typescriptreact", { "javascript" })
        end,
      },

      "hrsh7th/cmp-nvim-lsp-signature-help",
      "petertriho/cmp-git",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-emoji",
      "zbirenbaum/copilot.lua",
      "zbirenbaum/copilot-cmp",
    },
    opts = function()
      local compare = require "cmp.config.compare"

      local cmp_ui = require("nvconfig").ui.cmp

      local nvchadOptions = require "nvchad.configs.cmp"
      local customOptions = {
        sources = {
          {
            name = "luasnip",
          },
          {
            name = "nvim_lsp_signature_help",
            keyword_length = 1,
          },
          {
            name = "nvim_lsp",
            keyword_length = 1,
          },
          {
            name = "path",
          },
          {
            name = "git",
            keyword_length = 1,
          },
          {
            name = "emoji",
            keyword_length = 1,
          },
          {
            name = "copilot",
          },
          {
            name = "treesitter",
            keyword_length = 3,
          },
          {
            name = "buffer",
            keyword_length = 3,
          },
          {
            name = "nvim_lua",
          },
        },

        window = {
          completion = {
            scrollbar = true,
          },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            local icons = require "nvchad.icons.lspkind"
            local icon = (cmp_ui.icons and icons[item.kind]) or ""

            icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
            item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
            item.menu = entry.source.name

            return item
          end,
        },
        mapping = {
          ["<Esc>"] = require("cmp").mapping.close(),
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            require("copilot_cmp.comparators").prioritize,
            compare.offset,
            -- compare.scopes, --this is commented in nvim-cmp too
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.locality,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
          },
        },
        experimental = {
          ghost_text = true,
        },
      }

      return vim.tbl_deep_extend("force", nvchadOptions, customOptions)
    end,
    config = function(_, opts)
      require("copilot").setup {
        suggestion = { enabled = false },
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "right", -- | top | left | right
            ratio = 0.4,
          },
        },
        filetypes = {
          ["."] = true,
          --["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
          sh = function()
            if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
              -- disable for .env files
              return false
            end
            return true
          end,
        },
        copilot_node_command = "node", -- Node.js version must be > 16.x
        server_opts_overrides = {
          trace = "verbose",
          settings = {
            advanced = {
              listCount = 6, -- #completions for panel
              inlineSuggestCount = 5, -- #completions for getCompletions
            },
          },
        },
      }

      require("copilot_cmp").setup()

      require("cmp").setup(opts)
    end,
  },

  {
    "RRethy/vim-illuminate",
    event = "BufEnter",
    config = function()
      require("illuminate").configure {
        delay = 50,
      }
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = false,
      numhl = true,
      current_line_blame = true,
    },
  },

  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },

  {
    "max397574/better-escape.nvim",
    event = "BufEnter",
  },

  {
    "fedepujol/move.nvim",
    event = "BufEnter",
    opts = {},
  },

  {
    "kevinhwang91/rnvimr",
    cmd = { "RnvimrToggle" },
    -- commit after introduce an issue with refresh inside ranger when changing directory
    -- @see https://github.com/kevinhwang91/rnvimr/commit/cd0311d65cb3b8f8737b52f3294eb77d2fcec826
    config = function()
      vim.g.rnvimr_edit_cmd = "drop"
      vim.g.rnvimr_enable_picker = true
      vim.g.rnvimr_enable_bw = true
      vim.g.rnvimr_hide_gitignore = false
    end,
  },

  {
    "ruifm/gitlinker.nvim",
    keys = { "<leader>b" },
    opts = {
      mappings = nil,
    },
  },

  {
    "petertriho/nvim-scrollbar",
    event = "BufEnter",
    config = function(_, opts)
      require("scrollbar").setup(opts)
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      {
        "arkav/lualine-lsp-progress",
      },
    },
    config = function()
      require("lualine").setup {
        options = {
          theme = "ayu_dark",
          component_separators = { left = "|", right = "|" },
          section_separators = { left = " ", right = " " },
          globalstatus = true,
        },

        sections = {
          lualine_a = { "mode" },
          lualine_b = { "diff", "diagnostics" },
          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = {
                modified = "+",
                readonly = "-",
                unnamed = "[No Name]",
              },
            },
          },
          lualine_x = {
            "lsp_progress",
            require "plugins.codecompanion.lualine",
            {
              function()
                return "A..."
              end,
              color = { fg = "#BF616A" }, -- red
              cond = function()
                return _G.aider_background_status == "working"
              end,
            },
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },

        tabline = {
          lualine_a = {
            {
              "buffers",
              show_filename_only = false,
              max_length = vim.o.columns,
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },

        windbar = {},

        extensions = {
          "quickfix",
        },
      }
    end,
  },

  {
    "vladdoster/remember.nvim",
    event = "BufEnter",
    config = function()
      require "remember"
    end,
  },

  {
    "mg979/vim-visual-multi",
    event = "BufEnter",
    init = function()
      vim.g.VM_custom_remaps = {
        ["<C-c>"] = "<Esc>",
      }
    end,
  },

  {
    "nvim-pack/nvim-spectre",
    keys = { "<leader>g" },
    config = function()
      require("spectre").setup {
        find_engine = {
          -- rg is map with finder_cmd
          ["rg"] = {
            cmd = "rg",
            -- default args
            args = {
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--hidden",
              "--column",
              "--glob",
              "!**/.git/*",
              "--glob",
              "!**/node_modules/*",
            },
            options = {
              ["ignore-case"] = {
                value = "--ignore-case",
                icon = "[I]",
                desc = "ignore case",
              },
              ["hidden"] = {
                value = "--hidden",
                desc = "hidden file",
                icon = "[H]",
              },
              -- you can put any rg search option you want here it can toggle with
              -- show_option function
            },
          },
        },
        replace_engine = {
          ["sed"] = {
            cmd = "sed",
            args = {
              "-i",
              "",
              "-E",
            },
          },
        },
      }
    end,
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = false,
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        lazy = false,
      },
    },
    config = function()
      local telescope = require "telescope"
      telescope.load_extension "live_grep_args"
      telescope.load_extension "themes"
      telescope.load_extension "terms"

      local actions = require "telescope.actions"

      require("telescope").setup {
        pickers = {
          find_files = {
            follow = true,
          },
        },
        defaults = {
          initial_mode = "insert",
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            mirror = true,
            prompt_position = "top",
          },
          vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob",
            "!**/.git/*",
            "--glob",
            "!**/node_modules/*",
          },
          file_sorter = require("telescope.sorters").get_fuzzy_file,
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
          path_display = { "truncate" },
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
          mappings = {
            i = {
              ["<C-o>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-a>"] = actions.select_all,
              ["<C-z>"] = actions.drop_all,
              ["<M-Down>"] = actions.cycle_history_next,
              ["<M-Up>"] = actions.cycle_history_prev,
              ["<C-q>"] = require("telescope-live-grep-args.actions").quote_prompt(),
              ["<C-g>"] = require("telescope-live-grep-args.actions").quote_prompt {
                postfix = ' --iglob ""',
              },
            },
            n = {
              ["<C-o>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-a>"] = actions.select_all,
              ["<C-z>"] = actions.drop_all,
              ["<M-Down>"] = actions.cycle_history_next,
              ["<M-Up>"] = actions.cycle_history_prev,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }
    end,
  },

  {
    "ecthelionvi/NeoColumn.nvim",
    event = "BufEnter",
    opts = {
      always_on = true,
    },
    config = function(_, opts)
      require("NeoColumn").setup(opts)
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
    "luukvbaal/statuscol.nvim",
    event = "BufReadPost",
    opts = function()
      local builtin = require "statuscol.builtin"
      return {
        setopt = true,
        relculright = true,
        segments = {
          -- { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          { sign = { name = { "Diagnostic" } }, click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
          -- { sign = { name = { ".*" } }, click = "v:lua.ScSa" },
        },
      }
    end,
  },

  {
    "joshuavial/aider.nvim",
    event = "VeryLazy",
    config = function()
      require("aider").setup {
        default_bindings = false,
      }

      vim.api.nvim_create_user_command("AiderOpen", function()
        AiderOpen()
      end, { nargs = 0 })
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      {
        "stevearc/dressing.nvim",
        opts = {},
      },
    },
    config = {
      strategies = {
        chat = {
          adapter = "copilot",
          roles = {
            llm = "Copilot",
            user = "Me",
          },
        },
        inline = {
          adapter = "copilot",
        },
        agent = {
          adapter = "copilot",
        },
      },
    },
  },
}
