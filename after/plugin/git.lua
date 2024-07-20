require("which-key").add({ { "<Leader>g", group = "[g]it helpers" } })

-- FUGITIVE SETUP
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

-- GITSIGNS SETUP
require("gitsigns").setup {
  signs = {
    add          = { text = "┃" },
    change       = { text = "┃" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1
  },
}

local gitsigns = require("gitsigns")

vim.keymap.set("n", "<Leader>gB", function()
  gitsigns.toggle_current_line_blame()
end, { desc = "Toggle single line [B]lame" })


-- GIT-WORKTREE SETUP
local git_worktree = require("git-worktree")

local switch_worktree = function()
  local treename = vim.fn.input("tree >")
  git_worktree.switch_worktree(treename)
end

vim.keymap.set("n", "<Leader>gts", switch_worktree, { desc = "[g]it work[t]ree [s]witch" })

-- local add_worktree = function()
--   local 
-- end
