require("nvim-highlight-colors").setup {
  render = "background", -- or 'foreground' / 'virtual'
  enable_tailwind = true,
}

-- require("nvim-highlight-colors").setup({
--   enable_named_colors = false,
--   enable_tailwind = true
-- })

require("plugin.light_switch").register {
  code = "co",
  desc = "Colorizor",
  default = "on",
  enable = "HighlightColors On",
  disable = "HighlightColors Off",
}
