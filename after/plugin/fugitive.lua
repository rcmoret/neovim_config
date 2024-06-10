require("which-key").register({ g = { name = "[g]it helpers" } }, { prefix = "<Leader>" })

vim.keymap.set("n", "<Leader>gb", "<cmd>:Git blame<CR>", { desc = "[g]it [b]lame" })
vim.keymap.set("n", "<Leader>gd", "<cmd>:Gdiffsplit<CR>", { desc = "[g]it split [d]iff" })
vim.keymap.set("n", "<Leader>go", "<cmd>:GBrowse<CR>", { desc = "[g]it [o]pen in browser" })
vim.keymap.set("n", "<Leader>gw", "<cmd>:Gwrite<CR>", { desc = "[g]it [w]rite" })
vim.keymap.set("n", "<Leader>gm", function()
  local filename = vim.fn.input({ prompt = "new path > ", completion = "dir" })

  vim.cmd(string.format("GMove %s", filename))
  vim.cmd.echon('""')
end, { desc = "[g]it [m]ove" })

vim.keymap.set("n", "<Leader>gr", function()
  local filename = vim.fn.input({ prompt = "new name > " })

  vim.cmd(string.format("GRename %s", filename))
  vim.cmd.echon('""')
end, { desc = "[g]it [r]ename" })

vim.keymap.set("n", "<Leader>gc", function()
  local cmd = string.format("Gedit %s:%%", vim.fn.input("commit/ref > "))
  vim.cmd(cmd)
  vim.cmd.echon('""')
end, { desc = "[g]it [c]heckout file @" })
