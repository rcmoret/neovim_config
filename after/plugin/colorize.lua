require("nvim-highlight-colors").setup({
  enable_named_colors = false,
  enable_tailwind = true
})

vim.keymap.set("n", "[oC", "<cmd>HighlightColors On<CR>", { desc = "enable highlight [c]olors" })
vim.keymap.set("n", "]oC", "<cmd>HighlightColors Off<CR>", { desc = "disable highlight [c]olors" })
