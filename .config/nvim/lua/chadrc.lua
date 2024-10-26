---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",
  theme_toggle = {},
  transparency = true,

  hl_override = {
    IlluminatedWordText = {},
    IlluminatedWordRead = {},
    IlluminatedWordWrite = {},
    Folded = {
      bg = "#353b45",
    },
  },

  hl_add = {},

}

M.ui = {
  lsp_semantic_tokens = true,

  statusline = {
    enabled = false,
  },

  tabufline = {
    enabled = false,
  },

  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default",           -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "grey_fg",    -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "simple", -- colored / simple
  },

  telescope = { style = "borderless" }, -- borderless / bordered
}

return M
