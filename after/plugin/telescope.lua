local builtin = require("telescope.builtin")

local telescope = require("telescope")
telescope.load_extension("live_grep_args")

vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Fuzzy Find Files (git)" })

vim.keymap.set("n", "<Leader>ta", builtin.autocommands, { desc = "[t]elescope search in [a]utocommands" })
vim.keymap.set("n", "<Leader>tb", builtin.buffers, { desc = "[t]elescope search in [b]uffers" })
vim.keymap.set("n", "<Leader>tc", builtin.command_history, { desc = "[t]elescope search [c]ommand history" })
vim.keymap.set("n", "<Leader>tf", builtin.find_files, { desc = "[t]elescope search for [f]iles (all)" })
vim.keymap.set(
  "n",
  "<leader>tg",
  ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = "[t]elescope [g]rep (with args)" }
)
vim.keymap.set("n", "<Leader>th", builtin.help_tags, { desc = "[t]elescope search [h]elp tags" })
vim.keymap.set("n", "<Leader>tj", builtin.jumplist, { desc = "[t]elescope search [j]umplist" })
vim.keymap.set("n", "<Leader>tk", builtin.keymaps, { desc = "[t]elescope search [k]ey maps" })
vim.keymap.set("n", "<Leader>tr", builtin.resume, { desc = "[t]elescope [r]esume search" })
vim.keymap.set("n", "<Leader>tR", builtin.registers, { desc = "[t]elescope [R]egisters" })
vim.keymap.set("n", "<Leader>tw", builtin.grep_string, { desc = "[t]elescope search for current [w]ord in working directory" })

telescope.setup({
  defaults = {
    -- I can't stand smartcase.
    -- I want grep to work like grep.
    -- I want to be able choose when I want to ignore case.
    vimgrep_arguments = {
       "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column"
    }
  }
})
