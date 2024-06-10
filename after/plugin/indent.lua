require("ibl").setup({
  scope = {
    enabled = false
  }
})

vim.api.nvim_set_hl(0, "@ibl.indent.char.1", { fg = "#313b4e" })
