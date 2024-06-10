require("which-key").register({
  m = { name = "[m]ason commands" },
  prefix = "<Leader>"
})

local mason_update = function()
  vim.cmd("MasonUpdate")
end

vim.keymap.set("n", "<Leader>mm", "<cmd>Mason<CR>", { desc = "[m]ason [m]enu" })
vim.keymap.set("n", "<Leader>mu", mason_update, { desc = "[m]ason [u]pdate" })
