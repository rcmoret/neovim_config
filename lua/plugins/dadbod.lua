return {
  "tpope/vim-dadbod",
  dependencies = {
    "kristijanhusak/vim-dadbod-completion",
    "kristijanhusak/vim-dadbod-ui",
  },
  cmd = { "DBUI", "DBUIToggle", "DB" },
  keys = {
    { "<Leader>Q", "<cmd>DBUIToggle<CR>", desc = "S[Q]L client" },
  },
  init = function()
    -- vim.g.* has to be set before dadbod-ui loads
    vim.g.dbs = require("private").db_connections
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_disable_progress_bar = 1
  end,
}
