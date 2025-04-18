return {
  {
    "LazyVim/LazyVim",
    version = "v14.14.0",
    opts = {
      colorscheme = "onedark",
    },
  },

  {
    "navarasu/onedark.nvim",
    opts = {
      style = "darker",
      transparent = true,
      lualine = {
        transparent = true, -- lualine center bar transparency
      },
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = false, -- use background color for virtual text
      },
      highlights = {
        NormalFloat = { bg = "none" },
        Pmenu = { bg = "none" },
        FloatBorder = { bg = "none" },

        MiniFilesNormal = { bg = "none" },
        MiniFilesBorder = { bg = "none" },
      },
    },
  },
}
