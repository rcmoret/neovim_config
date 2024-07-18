local db_connections = require("config/private").db_connections

vim.keymap.set("n", "<Leader>Q", "<cmd>DBUIToggle<CR>", { desc = "S[Q]L client" })

vim.g.dbs = db_connections
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_disable_progress_bar = 1
