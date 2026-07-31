-- Loaded on first use. Keys are declared here rather than in config so lazy
-- can register the triggers without pulling telescope in at startup.

local function builtin(name, opts)
  return function() require("telescope.builtin")[name](opts) end
end

local function extension(ext, name)
  return function() require("telescope").extensions[ext][name]() end
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "princejoogie/dir-telescope.nvim",
    "danielvolchek/tailiscope.nvim",
    "ThePrimeagen/git-worktree.nvim",
    "folke/noice.nvim",
  },
  cmd = "Telescope",
  keys = {
    { "<C-t>", builtin "git_files", desc = "Fuzzy Find Files (git)" },
    { "<C-g>", extension("live_grep_args", "live_grep_args"), desc = "[t]elescope [g]rep (with args)" },

    { "ta", builtin "autocommands", desc = "[t]elescope search in [a]utocommands" },
    { "tb", builtin "buffers", desc = "[t]elescope search in [b]uffers" },
    { "tc", builtin "command_history", desc = "[t]elescope search [c]ommand history" },
    { "td", extension("dir", "live_grep"), desc = "[t]elescope search in [d]irectories" },
    { "tf", builtin "find_files", desc = "[t]elescope search for [f]iles (all)" },
    { "tg", extension("live_grep_args", "live_grep_args"), desc = "[t]elescope [g]rep (with args)" },
    { "th", builtin "help_tags", desc = "[t]elescope search [h]elp tags" },
    { "tj", builtin "jumplist", desc = "[t]elescope search [j]umplist" },
    { "tk", builtin "keymaps", desc = "[t]elescope search [k]ey maps" },
    { "tl", builtin "highlights", desc = "[t]elescope search high[l]ights" },
    { "tn", "<cmd>Noice telescope<CR>", desc = "[t]elescope search in [n]otifications" },
    { "to", builtin("live_grep", { grep_open_files = true }), desc = "[t]elescope grep in [o]pen buffers" },
    { "tr", builtin "resume", desc = "[t]elescope [r]esume search" },
    { "tt", "<cmd>Telescope tailiscope<CR>", desc = "[t]elescope [t]ailwind search" },
    { "tw", builtin "grep_string", desc = "[t]elescope search for current [w]ord in working directory" },
    { "tR", builtin "registers", desc = "[t]elescope [R]egisters" },
  },
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"

    telescope.setup {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        mappings = {
          i = {
            ["<PageDown>"] = actions.preview_scrolling_down,
            ["<PageUp>"] = actions.preview_scrolling_up,
          },
          n = {
            ["<C-c>"] = "close",
            ["<PageDown>"] = actions.preview_scrolling_down,
            ["<PageUp>"] = actions.preview_scrolling_up,
          },
        },
      },
      pickers = {
        buffers = {
          mappings = {
            i = {
              ["<C-x>"] = "delete_buffer",
            },
          },
        },
      },
    }

    telescope.load_extension "dir"
    telescope.load_extension "git_worktree"
    telescope.load_extension "live_grep_args"
    telescope.load_extension "tailiscope"
    telescope.load_extension "noice"
  end,
}
