local wk = require("which-key")

wk.add({ "<Leader>k", group = "pac[k]er pkg manager" })

vim.keymap.set("n", "<Leader>kc", "<cmd>PackerClean<CR>", { desc = "pac[k]er [c]lean" })
vim.keymap.set("n", "<Leader>kC", "<cmd>PackerCompile<CR>", { desc = "pac[k]er [C]ompile" })
vim.keymap.set("n", "<Leader>ki", "<cmd>PackerInstall<CR>", { desc = "pac[k]er [i]nstall" })
vim.keymap.set("n", "<Leader>ks", "<cmd>PackerSync<CR>", { desc = "pac[k]er [s]ync" })
vim.keymap.set("n", "<Leader>kS", "<cmd>PackerStatus<CR>", { desc = "pac[k]er [S]tatus" })
