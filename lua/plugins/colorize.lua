return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-highlight-colors").setup {
      render = "background", -- or 'foreground' / 'virtual'
      enable_tailwind = true,
    }

    require("lib.light_switch").register {
      code = "co",
      desc = "Colorizor",
      default = "on",
      enable = "HighlightColors On",
      disable = "HighlightColors Off",
    }
  end,
}
