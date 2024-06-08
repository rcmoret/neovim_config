local builtin = require("telescope.builtin")

local telescope = require("telescope")
telescope.load_extension("live_grep_args")
telescope.load_extension("dir")
telescope.load_extension("tailiscope")


vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Fuzzy Find Files (git)" })

vim.keymap.set("n", "<Leader>ta", builtin.autocommands, { desc = "[t]elescope search in [a]utocommands" })
vim.keymap.set("n", "<Leader>tb", builtin.buffers, { desc = "[t]elescope search in [b]uffers" })
vim.keymap.set("n", "<Leader>tc", builtin.command_history, { desc = "[t]elescope search [c]ommand history" })
vim.keymap.set("n", "<Leader>td", telescope.extensions.dir.live_grep, { desc = "[t]elescope search in [d]irectories" })
vim.keymap.set("n", "<Leader>tf", builtin.find_files, { desc = "[t]elescope search for [f]iles (all)" })
vim.keymap.set(
  "n",
  "<leader>tg",
  telescope.extensions.live_grep_args.live_grep_args,
  { desc = "[t]elescope [g]rep (with args)" }
)
vim.keymap.set(
  "n",
  "<C-g>",
  telescope.extensions.live_grep_args.live_grep_args,
  { desc = "[t]elescope [g]rep (with args)" }
)
vim.keymap.set("n", "<Leader>th", builtin.help_tags, { desc = "[t]elescope search [h]elp tags" })
vim.keymap.set("n", "<Leader>tj", builtin.jumplist, { desc = "[t]elescope search [j]umplist" })
vim.keymap.set("n", "<Leader>tk", builtin.keymaps, { desc = "[t]elescope search [k]ey maps" })
vim.keymap.set("n", "<Leader>tl", builtin.highlights, { desc = "[t]elescope search high[l]ights" })
vim.keymap.set("n", "<Leader>to", function()
  builtin.live_grep({ grep_open_files = true })
end , { desc = "[t]elescope grep in [o]pen buffers" })
vim.keymap.set("n", "<Leader>tr", builtin.resume, { desc = "[t]elescope [r]esume search" })
vim.keymap.set("n", "<Leader>tt", "<cmd>Telescope tailiscope<CR>", { desc = "[t]elescope [t]ailwind search" })
vim.keymap.set("n", "<Leader>tR", builtin.registers, { desc = "[t]elescope [R]egisters" })
vim.keymap.set("n", "<Leader>tw", builtin.grep_string, { desc = "[t]elescope search for current [w]ord in working directory" })

local select_highlight_notify = function(msg)
  vim.notify("[Telescope]: " .. msg)
end

vim.g.telescope_select_highlight_mode = "default"
local toggle_selectbar = function()
  if vim.g.telescope_select_highlight_mode == "default" then
    select_highlight_notify("switching to light select bar")
    vim.g.telescope_select_highlight_mode = "light"
    vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.white, fg = colors.dark_purple, bold = true })
    vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = colors.dark_purple })
  else
    select_highlight_notify("switching to default select bar")
    vim.g.telescope_select_highlight_mode = "default"
    vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.dark_gray, fg = colors.teal, bold = true })
    vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = colors.teal })
  end
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    vimgrep_arguments = {
       "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column"
    },
    mappings = {
      i = {
        ["<C-s>"] = toggle_selectbar,
        ["<PageDown>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
      },
      n = {
        ["<C-c>"] = "close",
        ["<PageDown>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
      },
    }
  }
})

require("which-key").register({ t = { name = "[t]elescope search" } }, { prefix = "<Leader>" })

vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = colors.float_bg, fg = colors.pale })
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = colors.teal })
vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.dark_gray, fg = colors.teal, bold = true })
