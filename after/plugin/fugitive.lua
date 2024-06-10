vim.keymap.set("n", "<Leader>gb", "<cmd>:Git blame<CR>", { desc = "Git blame" })
vim.keymap.set("n", "<Leader>gd", "<cmd>:Gdiffsplit<CR>", { desc = "Git split diff" })
vim.keymap.set("n", "<Leader>go", "<cmd>:GBrowse<CR>", { desc = "Git open in browser" })
vim.keymap.set("n", "<Leader>gw", "<cmd>:Gwrite<CR>", { desc = "Git write" })
vim.keymap.set("n", "<Leader>gm", function()
  local filename = vim.fn.input({ prompt = "new path > ", completion = "dir" })

  vim.cmd(string.format("GMove %s", filename))
  vim.cmd.echon('""')
end, { desc = "Git move" })

vim.keymap.set("n", "<Leader>gr", function()
  local filename = vim.fn.input({ prompt = "new name > " })

  vim.cmd(string.format("GRename %s", filename))
  vim.cmd.echon('""')
end, { desc = "Git rename" })

vim.keymap.set("n", "<Leader>gc", function()
  local cmd = string.format("Gedit %s:%%", vim.fn.input("commit/ref > "))
  vim.cmd(cmd)
  vim.cmd.echon('""')
end, { desc = "Git checkout file @" })
