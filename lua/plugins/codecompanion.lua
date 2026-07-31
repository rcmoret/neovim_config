return {
  "olimorris/codecompanion.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  keys = {
    { "<Leader>a", mode = { "n", "v" }, desc = "code companion prompt" },
    { "<Leader>A", mode = { "n", "v" }, desc = "code companion toggle" },
    { "<Leader>ac", mode = "v", desc = "code companion add selection" },
    { "<Leader>ab", mode = "n", desc = "code companion add buffer" },
  },
  config = function()
    local codecompanion = require "codecompanion"

    codecompanion.setup {
      file_access = {
        allow_paths = { vim.fn.expand "~/repos" },
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
    }

    local chat_prompt = function()
      local prompt = vim.fn.input ">"
      vim.cmd("CodeCompanion " .. prompt)
    end

    vim.keymap.set({ "n", "v" }, "<Leader>a", chat_prompt, { desc = "code companion prompt" })
    vim.keymap.set({ "n", "v" }, "<Leader>A", codecompanion.toggle, { desc = "code companion toggle" })
    vim.keymap.set("v", "<Leader>ac", "<cmd>CodeCompanionChat Add<cr>", { desc = "code companion add selection" })
    vim.keymap.set("n", "<Leader>ab", "<cmd>CodeCompanionChat Add<cr>", { desc = "code companion add buffer" })
  end,
}
