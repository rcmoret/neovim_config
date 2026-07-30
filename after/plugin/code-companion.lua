require("codecompanion").setup({
  file_access = {
    allow_paths = { '/Users/ryanmoret/repos' },
  },
  strategies = {
    chat = {
      adapter = "anthropic",
      model = "claude-opus-4-5",
    },
    inline = {
      model = "claude-opus-4-5",
      adapter = "anthropic",
    },
  },
})

local chat_promt = function ()
  local prompt = vim.fn.input(">")
  local cmd = "CodeCompanion " .. prompt
  vim.cmd(cmd)
end

vim.keymap.set({ "n", "v" }, "<Leader>a", chat_promt)
vim.keymap.set({ "n", "v" }, "<Leader>A", require("codecompanion").toggle)
vim.keymap.set("v", "<Leader>ac", "<cmd>CodeCompanionChat Add<cr>")
vim.keymap.set("n", "<Leader>ab", "<cmd>CodeCompanionChat Add<cr>")
