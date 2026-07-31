-- Editor-level autocommands. Plugin-specific autocmds belong with their spec
-- in lua/plugins/.

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("Quick Fix Override", { clear = false }),
  desc = "allow customization of the quickfix window",
  pattern = "quickfix",
  callback = function() vim.opt.relativenumber = false end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("Highlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  desc = "Re-read files changed outside of nvim",
  group = vim.api.nvim_create_augroup("Checktime", { clear = true }),
  callback = function() vim.api.nvim_command "checktime" end,
})

vim.api.nvim_create_autocmd("FocusLost", {
  desc = "Leave insert mode and write everything when nvim loses focus",
  group = vim.api.nvim_create_augroup("FocusLostStuff", { clear = true }),
  callback = function()
    vim.cmd.stopinsert()
    vim.cmd.wall { mods = { silent = true } }
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Fall back to html syntax for svelte files",
  group = vim.api.nvim_create_augroup("SvelteSyntax", { clear = true }),
  pattern = "*.svelte",
  command = "set syntax=html",
})
